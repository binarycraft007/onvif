const std = @import("std");
const xml = @import("xml/Reader.zig");
const xml_writer = @import("xml/Writer.zig");
const xml_any = @import("xml/Any.zig");
const xsd = @import("xsd_types.zig");

pub const SOAP12_NS = "http://www.w3.org/2003/05/soap-envelope";
pub const SOAP11_NS = "http://schemas.xmlsoap.org/soap/envelope/";
pub const WSA_NS = "http://www.w3.org/2005/08/addressing";
pub const WSSE_NS = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
pub const WSU_NS = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd";
pub const PASSWORD_DIGEST_TYPE = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordDigest";
pub const BASE64_ENCODING_TYPE = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary";

pub const SoapVersion = enum {
    soap12,
    soap11,
};

pub const UsernameToken = struct {
    username: []const u8,
    password_digest: []const u8,
    nonce_base64: []const u8,
    created: []const u8,

    pub fn deinit(self: UsernameToken, gpa: std.mem.Allocator) void {
        gpa.free(self.username);
        gpa.free(self.password_digest);
        gpa.free(self.nonce_base64);
        gpa.free(self.created);
    }
};

pub const SoapFault = struct {
    code: []const u8,
    subcode: ?[]const u8 = null,
    reason: []const u8,
    detail: ?[]const u8 = null,

    pub fn deinit(self: SoapFault, gpa: std.mem.Allocator) void {
        gpa.free(self.code);
        if (self.subcode) |s| gpa.free(s);
        gpa.free(self.reason);
        if (self.detail) |d| gpa.free(d);
    }
};

pub fn computePasswordDigest(
    nonce_raw: []const u8,
    created_str: []const u8,
    password: []const u8,
    out: *[28]u8,
) []const u8 {
    var sha1 = std.crypto.hash.Sha1.init(.{});
    sha1.update(nonce_raw);
    sha1.update(created_str);
    sha1.update(password);
    var digest: [std.crypto.hash.Sha1.digest_length]u8 = undefined;
    sha1.final(&digest);

    return std.base64.standard.Encoder.encode(out, &digest);
}

pub fn verifyUsernameToken(
    io: std.Io,
    header: SoapHeader,
    expected_password: []const u8,
    max_skew_seconds: i64,
) bool {
    if (header.username == null) return false;
    const got_digest = header.password_digest orelse return false;
    const nonce_b64 = header.nonce orelse return false;
    const created_str = header.created orelse return false;

    if (header.password_type) |ptype| {
        if (!std.mem.eql(u8, ptype, PASSWORD_DIGEST_TYPE)) return false;
    }

    const decoder = std.base64.standard.Decoder;
    const decoded_len = decoder.calcSizeForSlice(nonce_b64) catch return false;
    if (decoded_len == 0 or decoded_len > 128) return false;
    var nonce_buf: [128]u8 = undefined;
    decoder.decode(nonce_buf[0..decoded_len], nonce_b64) catch return false;

    const created_dt = xsd.DateTime.parse(created_str) catch return false;
    const created_s: i64 = @intCast(@divFloor(created_dt.toTimestamp().toNanoseconds(), std.time.ns_per_s));
    const now_s: i64 = @intCast(@divFloor(std.Io.Clock.real.now(io).toNanoseconds(), std.time.ns_per_s));
    if (@abs(now_s - created_s) > max_skew_seconds) return false;

    if (got_digest.len != 28) return false;
    var expected_buf: [28]u8 = undefined;
    _ = computePasswordDigest(nonce_buf[0..decoded_len], created_str, expected_password, &expected_buf);

    return std.crypto.timing_safe.eql([28]u8, expected_buf, got_digest[0..28].*);
}

pub fn createUsernameToken(
    io: std.Io,
    gpa: std.mem.Allocator,
    username: []const u8,
    password: []const u8,
) !UsernameToken {
    var nonce: [16]u8 = undefined;
    io.random(&nonce);

    var nonce_b64_buf: [24]u8 = undefined;
    const nonce_b64 = std.base64.standard.Encoder.encode(&nonce_b64_buf, &nonce);

    const now_ts = std.Io.Clock.real.now(io);
    const dt = xsd.DateTime.fromTimestamp(now_ts);
    const created_str = try dt.formatAlloc(gpa);
    errdefer gpa.free(created_str);

    var digest_buf: [28]u8 = undefined;
    const digest = computePasswordDigest(&nonce, created_str, password, &digest_buf);

    const uname = try gpa.dupe(u8, username);
    errdefer gpa.free(uname);

    const pdigest = try gpa.dupe(u8, digest);
    errdefer gpa.free(pdigest);

    const nb64 = try gpa.dupe(u8, nonce_b64);

    return .{
        .username = uname,
        .password_digest = pdigest,
        .nonce_base64 = nb64,
        .created = created_str,
    };
}

pub const EnvelopeOptions = struct {
    version: SoapVersion = .soap12,
    action: ?[]const u8 = null,
    message_id: ?[]const u8 = null,
    to: ?[]const u8 = null,
    security: ?UsernameToken = null,
};

pub fn buildEnvelope(
    gpa: std.mem.Allocator,
    body_xml: []const u8,
    options: EnvelopeOptions,
) ![]u8 {
    var out: std.Io.Writer.Allocating = .init(gpa);
    defer out.deinit();

    var w = xml_writer.Writer.init(gpa, &out.writer);
    defer w.deinit();

    const soap_ns = if (options.version == .soap12) SOAP12_NS else SOAP11_NS;
    try w.startElementNs(soap_ns, "Envelope", "s");

    // Header
    const has_header = options.action != null or options.message_id != null or options.to != null or options.security != null;
    if (has_header) {
        try w.startElementNs(soap_ns, "Header", "s");

        if (options.action) |act| {
            try w.startElementNs(WSA_NS, "Action", "wsa");
            try w.writeCharacters(act);
            try w.endElement();
        }

        if (options.message_id) |mid| {
            try w.startElementNs(WSA_NS, "MessageID", "wsa");
            try w.writeCharacters(mid);
            try w.endElement();
        }

        if (options.to) |to_uri| {
            try w.startElementNs(WSA_NS, "To", "wsa");
            try w.writeCharacters(to_uri);
            try w.endElement();
        }

        if (options.security) |sec| {
            try w.startElementNs(WSSE_NS, "Security", "wsse");
            try w.startElementNs(WSSE_NS, "UsernameToken", "wsse");

            try w.startElementNs(WSSE_NS, "Username", "wsse");
            try w.writeCharacters(sec.username);
            try w.endElement();

            try w.startElementNs(WSSE_NS, "Password", "wsse");
            try w.attribute("Type", PASSWORD_DIGEST_TYPE);
            try w.writeCharacters(sec.password_digest);
            try w.endElement();

            try w.startElementNs(WSSE_NS, "Nonce", "wsse");
            try w.attribute("EncodingType", BASE64_ENCODING_TYPE);
            try w.writeCharacters(sec.nonce_base64);
            try w.endElement();

            try w.startElementNs(WSU_NS, "Created", "wsu");
            try w.writeCharacters(sec.created);
            try w.endElement();

            try w.endElement(); // </UsernameToken>
            try w.endElement(); // </Security>
        }

        try w.endElement(); // </Header>
    }

    // Body
    try w.startElementNs(soap_ns, "Body", "s");
    try w.writeRaw(body_xml);
    try w.endElement(); // </Body>

    try w.endElement(); // </Envelope>
    try w.flush();

    return try out.toOwnedSlice();
}

pub const SoapHeader = struct {
    action: ?[]const u8 = null,
    message_id: ?[]const u8 = null,
    to: ?[]const u8 = null,
    username: ?[]const u8 = null,
    password_digest: ?[]const u8 = null,
    password_type: ?[]const u8 = null,
    nonce: ?[]const u8 = null,
    created: ?[]const u8 = null,

    pub fn deinit(self: SoapHeader, gpa: std.mem.Allocator) void {
        if (self.action) |a| gpa.free(a);
        if (self.message_id) |m| gpa.free(m);
        if (self.to) |t| gpa.free(t);
        if (self.username) |u| gpa.free(u);
        if (self.password_digest) |p| gpa.free(p);
        if (self.password_type) |pt| gpa.free(pt);
        if (self.nonce) |n| gpa.free(n);
        if (self.created) |c| gpa.free(c);
    }
};

pub const ParsedEnvelope = struct {
    header: SoapHeader = .{},
    body: []const u8,
    is_fault: bool = false,
    fault: ?SoapFault = null,

    pub fn deinit(self: ParsedEnvelope, gpa: std.mem.Allocator) void {
        gpa.free(self.body);
        self.header.deinit(gpa);
        if (self.fault) |f| {
            var fault_mut = f;
            fault_mut.deinit(gpa);
        }
    }
};

pub const ExtractedBody = struct {
    body_xml: []u8,
    is_fault: bool,
    fault: ?SoapFault = null,

    pub fn deinit(self: ExtractedBody, gpa: std.mem.Allocator) void {
        gpa.free(self.body_xml);
        if (self.fault) |f| {
            var fault_mut = f;
            fault_mut.deinit(gpa);
        }
    }
};

pub fn parseEnvelope(gpa: std.mem.Allocator, r_stream: *std.Io.Reader) !ParsedEnvelope {
    var r = xml.Reader.init(gpa, r_stream);
    defer r.deinit();

    var header = SoapHeader{};
    errdefer header.deinit(gpa);

    var body_empty = false;
    var in_body = false;

    while (true) {
        const tok = try r.next();
        switch (tok) {
            .start_element => |se| {
                if (std.mem.eql(u8, se.name, "Header")) {
                    try parseHeader(gpa, &r, se, &header);
                } else if (std.mem.eql(u8, se.name, "Body")) {
                    in_body = true;
                    body_empty = se.is_empty;
                    break;
                }
            },
            .eof => return error.UnexpectedEof,
            else => {},
        }
    }

    if (!in_body) return error.MalformedXml;

    if (body_empty) {
        const end_tok = try r.next();
        if (end_tok != .end_element) return error.UnexpectedToken;
        return .{
            .header = header,
            .body = try gpa.dupe(u8, ""),
            .is_fault = false,
            .fault = null,
        };
    }

    // Inside Body, look for first start_element or </Body>
    while (true) {
        const body_tok = try r.next();
        switch (body_tok) {
            .start_element => |se| {
                if (std.mem.eql(u8, se.name, "Fault")) {
                    const fault = try parseFault(gpa, &r, se);
                    return .{
                        .header = header,
                        .body = try gpa.dupe(u8, ""),
                        .is_fault = true,
                        .fault = fault,
                    };
                } else {
                    const node = try xml_any.readNodeFromStartElement(&r, gpa, se);
                    defer node.deinit(gpa);

                    var out: std.Io.Writer.Allocating = .init(gpa);
                    defer out.deinit();
                    var w = xml_writer.Writer.init(gpa, &out.writer);
                    defer w.deinit();
                    try node.writeTo(&w);
                    try w.flush();

                    return .{
                        .header = header,
                        .body = try out.toOwnedSlice(),
                        .is_fault = false,
                        .fault = null,
                    };
                }
            },
            .end_element => {
                return .{
                    .header = header,
                    .body = try gpa.dupe(u8, ""),
                    .is_fault = false,
                    .fault = null,
                };
            },
            .comment => {},
            .eof => return error.UnexpectedEof,
            else => {},
        }
    }
}

fn replaceHeaderText(gpa: std.mem.Allocator, slot: *?[]const u8, r: *xml.Reader) !void {
    const val = try r.readElementTextAlloc(gpa);
    if (slot.*) |old| gpa.free(old);
    slot.* = val;
}

fn parseHeader(gpa: std.mem.Allocator, r: *xml.Reader, header_se: xml.StartElement, header: *SoapHeader) !void {
    if (header_se.is_empty) {
        const end_tok = try r.next();
        if (end_tok != .end_element) return error.UnexpectedToken;
        return;
    }

    while (true) {
        const tok = try r.next();
        switch (tok) {
            .start_element => |se| {
                if (std.mem.eql(u8, se.name, "Action")) {
                    try replaceHeaderText(gpa, &header.action, r);
                } else if (std.mem.eql(u8, se.name, "MessageID")) {
                    try replaceHeaderText(gpa, &header.message_id, r);
                } else if (std.mem.eql(u8, se.name, "To")) {
                    try replaceHeaderText(gpa, &header.to, r);
                } else if (std.mem.eql(u8, se.name, "Security")) {
                    try parseSecurity(gpa, r, se, header);
                } else {
                    try r.skipElement();
                }
            },
            .end_element => break,
            .comment => {},
            .eof => return error.UnexpectedEof,
            else => {},
        }
    }
}

fn parseSecurity(gpa: std.mem.Allocator, r: *xml.Reader, sec_se: xml.StartElement, header: *SoapHeader) !void {
    if (sec_se.is_empty) {
        const end_tok = try r.next();
        if (end_tok != .end_element) return error.UnexpectedToken;
        return;
    }

    var in_username_token = false;

    while (true) {
        const tok = try r.next();
        switch (tok) {
            .start_element => |se| {
                if (!in_username_token) {
                    if (std.mem.eql(u8, se.name, "UsernameToken")) {
                        if (se.is_empty) {
                            const end_tok = try r.next();
                            if (end_tok != .end_element) return error.UnexpectedToken;
                        } else {
                            in_username_token = true;
                        }
                    } else {
                        try r.skipElement();
                    }
                } else {
                    if (std.mem.eql(u8, se.name, "Username")) {
                        try replaceHeaderText(gpa, &header.username, r);
                    } else if (std.mem.eql(u8, se.name, "Password")) {
                        if (se.getAttribute("Type")) |ptype| {
                            const duped_type = try gpa.dupe(u8, ptype);
                            if (header.password_type) |old| gpa.free(old);
                            header.password_type = duped_type;
                        }
                        try replaceHeaderText(gpa, &header.password_digest, r);
                    } else if (std.mem.eql(u8, se.name, "Nonce")) {
                        try replaceHeaderText(gpa, &header.nonce, r);
                    } else if (std.mem.eql(u8, se.name, "Created")) {
                        try replaceHeaderText(gpa, &header.created, r);
                    } else {
                        try r.skipElement();
                    }
                }
            },
            .end_element => |ee| {
                if (in_username_token and std.mem.eql(u8, ee.name, "UsernameToken")) {
                    in_username_token = false;
                } else {
                    break;
                }
            },
            .comment => {},
            .eof => return error.UnexpectedEof,
            else => {},
        }
    }
}

pub fn extractBody(gpa: std.mem.Allocator, envelope_xml: []const u8) !ExtractedBody {
    var r_impl: std.Io.Reader = .fixed(envelope_xml);
    const parsed = try parseEnvelope(gpa, &r_impl);
    parsed.header.deinit(gpa);
    return .{
        .body_xml = @constCast(parsed.body),
        .is_fault = parsed.is_fault,
        .fault = parsed.fault,
    };
}

fn parseFault(gpa: std.mem.Allocator, r: *xml.Reader, fault_se: xml.StartElement) !SoapFault {
    var code: ?[]u8 = null;
    errdefer if (code) |c| gpa.free(c);
    var subcode: ?[]u8 = null;
    errdefer if (subcode) |s| gpa.free(s);
    var reason: ?[]u8 = null;
    errdefer if (reason) |re| gpa.free(re);
    var detail: ?[]u8 = null;
    errdefer if (detail) |d| gpa.free(d);

    if (fault_se.is_empty) {
        const end_tok = try r.next();
        if (end_tok != .end_element) return error.UnexpectedToken;
        return .{
            .code = try gpa.dupe(u8, "Receiver"),
            .subcode = null,
            .reason = try gpa.dupe(u8, "Unknown SOAP Fault"),
            .detail = null,
        };
    }

    while (true) {
        const tok = try r.next();
        switch (tok) {
            .start_element => |cse| {
                if (std.mem.eql(u8, cse.name, "Code")) {
                    try parseFaultCode(gpa, r, cse, &code, &subcode);
                } else if (std.mem.eql(u8, cse.name, "faultcode")) {
                    const val = try r.readElementTextAlloc(gpa);
                    if (code) |old| gpa.free(old);
                    code = val;
                } else if (std.mem.eql(u8, cse.name, "Subcode")) {
                    try parseFaultSubcode(gpa, r, cse, &subcode);
                } else if (std.mem.eql(u8, cse.name, "Reason")) {
                    try parseFaultReason(gpa, r, cse, &reason);
                } else if (std.mem.eql(u8, cse.name, "faultstring")) {
                    const val = try r.readElementTextAlloc(gpa);
                    if (reason) |old| gpa.free(old);
                    reason = val;
                } else if (std.mem.eql(u8, cse.name, "Detail") or std.mem.eql(u8, cse.name, "detail")) {
                    const val = try parseFaultDetail(gpa, r, cse);
                    if (detail) |old| gpa.free(old);
                    detail = val;
                } else {
                    try r.skipElement();
                }
            },
            .end_element => break,
            .comment => {},
            .eof => return error.UnexpectedEof,
            else => {},
        }
    }

    return .{
        .code = code orelse try gpa.dupe(u8, "Receiver"),
        .subcode = subcode,
        .reason = reason orelse try gpa.dupe(u8, "Unknown SOAP Fault"),
        .detail = detail,
    };
}

fn parseFaultCode(
    gpa: std.mem.Allocator,
    r: *xml.Reader,
    se: xml.StartElement,
    code_out: *?[]u8,
    subcode_out: *?[]u8,
) !void {
    if (se.is_empty) {
        const end_tok = try r.next();
        if (end_tok != .end_element) return error.UnexpectedToken;
        return;
    }

    var text_acc: std.ArrayList(u8) = .empty;
    defer text_acc.deinit(gpa);

    while (true) {
        const tok = try r.next();
        switch (tok) {
            .characters => |chars| try text_acc.appendSlice(gpa, chars),
            .start_element => |cse| {
                if (std.mem.eql(u8, cse.name, "Value")) {
                    const val = try r.readElementTextAlloc(gpa);
                    if (code_out.*) |old| gpa.free(old);
                    code_out.* = val;
                } else if (std.mem.eql(u8, cse.name, "Subcode")) {
                    try parseFaultSubcode(gpa, r, cse, subcode_out);
                } else {
                    try r.skipElement();
                }
            },
            .end_element => break,
            .comment => {},
            .eof => return error.UnexpectedEof,
        }
    }

    if (code_out.* == null) {
        const trimmed = std.mem.trim(u8, text_acc.items, " \t\r\n");
        if (trimmed.len > 0) {
            code_out.* = try gpa.dupe(u8, trimmed);
        }
    }
}

fn parseFaultSubcode(
    gpa: std.mem.Allocator,
    r: *xml.Reader,
    se: xml.StartElement,
    subcode_out: *?[]u8,
) !void {
    if (se.is_empty) {
        const end_tok = try r.next();
        if (end_tok != .end_element) return error.UnexpectedToken;
        return;
    }

    var text_acc: std.ArrayList(u8) = .empty;
    defer text_acc.deinit(gpa);

    while (true) {
        const tok = try r.next();
        switch (tok) {
            .characters => |chars| try text_acc.appendSlice(gpa, chars),
            .start_element => |cse| {
                if (std.mem.eql(u8, cse.name, "Value")) {
                    const val = try r.readElementTextAlloc(gpa);
                    if (subcode_out.*) |old| gpa.free(old);
                    subcode_out.* = val;
                } else {
                    try r.skipElement();
                }
            },
            .end_element => break,
            .comment => {},
            .eof => return error.UnexpectedEof,
        }
    }

    if (subcode_out.* == null) {
        const trimmed = std.mem.trim(u8, text_acc.items, " \t\r\n");
        if (trimmed.len > 0) {
            subcode_out.* = try gpa.dupe(u8, trimmed);
        }
    }
}

fn parseFaultReason(
    gpa: std.mem.Allocator,
    r: *xml.Reader,
    se: xml.StartElement,
    reason_out: *?[]u8,
) !void {
    if (se.is_empty) {
        const end_tok = try r.next();
        if (end_tok != .end_element) return error.UnexpectedToken;
        return;
    }

    var text_acc: std.ArrayList(u8) = .empty;
    defer text_acc.deinit(gpa);

    while (true) {
        const tok = try r.next();
        switch (tok) {
            .characters => |chars| try text_acc.appendSlice(gpa, chars),
            .start_element => |cse| {
                if (std.mem.eql(u8, cse.name, "Text") and reason_out.* == null) {
                    reason_out.* = try r.readElementTextAlloc(gpa);
                } else {
                    try r.skipElement();
                }
            },
            .end_element => break,
            .comment => {},
            .eof => return error.UnexpectedEof,
        }
    }

    if (reason_out.* == null) {
        const trimmed = std.mem.trim(u8, text_acc.items, " \t\r\n");
        if (trimmed.len > 0) {
            reason_out.* = try gpa.dupe(u8, trimmed);
        }
    }
}

fn parseFaultDetail(
    gpa: std.mem.Allocator,
    r: *xml.Reader,
    se: xml.StartElement,
) ![]u8 {
    const node = try xml_any.readNodeFromStartElement(r, gpa, se);
    defer node.deinit(gpa);

    if (node.children.len == 0) {
        return try gpa.dupe(u8, node.text orelse "");
    }

    var out: std.Io.Writer.Allocating = .init(gpa);
    defer out.deinit();
    var w = xml_writer.Writer.init(gpa, &out.writer);
    defer w.deinit();

    for (node.children) |child| {
        try child.writeTo(&w);
    }
    try w.flush();
    return try out.toOwnedSlice();
}

test "soap ws-security password digest vector" {
    const nonce: [16]u8 = @splat(0);
    const created = "2026-11-25T11:03:12Z";
    const password = "secretPassword123";

    var digest_buf: [28]u8 = undefined;
    const digest = computePasswordDigest(&nonce, created, password, &digest_buf);

    try std.testing.expectEqual(@as(usize, 28), digest.len);

    var digest_buf2: [28]u8 = undefined;
    const digest2 = computePasswordDigest(&nonce, created, password, &digest_buf2);
    try std.testing.expectEqualStrings(digest, digest2);
}

test "soap 1.2 nested fault decoding and structured detail" {
    const fault_xml =
        \\<s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope"
        \\            xmlns:ter="http://www.onvif.org/ver10/error"
        \\            xmlns:wsa="http://www.w3.org/2005/08/addressing">
        \\  <s:Header>
        \\    <wsa:Action>http://www.w3.org/2005/08/addressing/soap/fault</wsa:Action>
        \\  </s:Header>
        \\  <s:Body>
        \\    <s:Fault>
        \\      <s:Code>
        \\        <s:Value>s:Sender</s:Value>
        \\        <s:Subcode>
        \\          <s:Value>ter:InvalidArgVal</s:Value>
        \\        </s:Subcode>
        \\      </s:Code>
        \\      <s:Reason>
        \\        <s:Text xml:lang="en">Invalid argument</s:Text>
        \\      </s:Reason>
        \\      <s:Detail><ter:Error>Token not found</ter:Error></s:Detail>
        \\    </s:Fault>
        \\  </s:Body>
        \\</s:Envelope>
    ;

    const extracted = try extractBody(std.testing.allocator, fault_xml);
    defer extracted.deinit(std.testing.allocator);

    try std.testing.expect(extracted.is_fault);
    const fault = extracted.fault.?;
    try std.testing.expectEqualStrings("s:Sender", fault.code);
    try std.testing.expectEqualStrings("ter:InvalidArgVal", fault.subcode.?);
    try std.testing.expectEqualStrings("Invalid argument", fault.reason);
    try std.testing.expect(std.mem.indexOf(u8, fault.detail.?, "Token not found") != null);
}

test "soap envelope building and flat fault decoding" {
    const fault_xml =
        \\<s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope">
        \\  <s:Body>
        \\    <s:Fault>
        \\      <s:Code>s:Sender</s:Code>
        \\      <s:Subcode>ter:InvalidArgVal</s:Subcode>
        \\      <s:Reason>Invalid argument</s:Reason>
        \\      <s:Detail>Token not found</s:Detail>
        \\    </s:Fault>
        \\  </s:Body>
        \\</s:Envelope>
    ;

    const extracted = try extractBody(std.testing.allocator, fault_xml);
    defer extracted.deinit(std.testing.allocator);

    try std.testing.expect(extracted.is_fault);
    const fault = extracted.fault.?;
    try std.testing.expectEqualStrings("s:Sender", fault.code);
    try std.testing.expectEqualStrings("ter:InvalidArgVal", fault.subcode.?);
    try std.testing.expectEqualStrings("Invalid argument", fault.reason);
    try std.testing.expectEqualStrings("Token not found", fault.detail.?);
}

test "soap 1.1 fault decoding with faultcode and faultstring" {
    const fault11_xml =
        \\<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
        \\  <s:Body>
        \\    <s:Fault>
        \\      <faultcode>s:Client</faultcode>
        \\      <faultstring>Authentication Failed</faultstring>
        \\      <detail>Invalid username or password</detail>
        \\    </s:Fault>
        \\  </s:Body>
        \\</s:Envelope>
    ;

    const extracted = try extractBody(std.testing.allocator, fault11_xml);
    defer extracted.deinit(std.testing.allocator);

    try std.testing.expect(extracted.is_fault);
    const fault = extracted.fault.?;
    try std.testing.expectEqualStrings("s:Client", fault.code);
    try std.testing.expectEqualStrings("Authentication Failed", fault.reason);
    try std.testing.expectEqualStrings("Invalid username or password", fault.detail.?);
}

test "soap buildEnvelope and parseEnvelope with ws-security and trailing header" {
    const io = std.testing.io;
    const gpa = std.testing.allocator;

    const tok = try createUsernameToken(io, gpa, "admin", "secret");
    defer tok.deinit(gpa);

    const env_xml = try buildEnvelope(gpa, "<tds:GetSystemDateAndTime xmlns:tds=\"http://www.onvif.org/ver10/device/wsdl\"/>", .{
        .action = "http://www.onvif.org/ver10/device/wsdl/GetSystemDateAndTime",
        .to = "http://127.0.0.1/onvif/device_service",
        .security = tok,
    });
    defer gpa.free(env_xml);

    var r_stream: std.Io.Reader = .fixed(env_xml);
    const parsed = try parseEnvelope(gpa, &r_stream);
    defer parsed.deinit(gpa);

    try std.testing.expect(!parsed.is_fault);
    try std.testing.expectEqualStrings("admin", parsed.header.username.?);
    try std.testing.expectEqualStrings(PASSWORD_DIGEST_TYPE, parsed.header.password_type.?);
    try std.testing.expectEqualStrings(tok.password_digest, parsed.header.password_digest.?);
    try std.testing.expectEqualStrings("http://www.onvif.org/ver10/device/wsdl/GetSystemDateAndTime", parsed.header.action.?);
    try std.testing.expectEqualStrings("http://127.0.0.1/onvif/device_service", parsed.header.to.?);
    try std.testing.expect(std.mem.indexOf(u8, parsed.body, "GetSystemDateAndTime") != null);
}
