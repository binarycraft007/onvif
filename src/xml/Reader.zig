const std = @import("std");

pub const Attribute = struct {
    name: []const u8,
    prefix: ?[]const u8 = null,
    ns_uri: ?[]const u8 = null,
    value: []const u8,
};

pub const StartElement = struct {
    name: []const u8,
    prefix: ?[]const u8 = null,
    ns_uri: ?[]const u8 = null,
    attributes: []const Attribute,
    is_empty: bool = false,

    pub fn getAttribute(self: StartElement, local_name: []const u8) ?[]const u8 {
        for (self.attributes) |attr| {
            if (std.mem.eql(u8, attr.name, local_name)) return attr.value;
        }
        return null;
    }

    pub fn getAttributeNs(self: StartElement, ns_uri: []const u8, local_name: []const u8) ?[]const u8 {
        for (self.attributes) |attr| {
            if (attr.ns_uri) |u| {
                if (std.mem.eql(u8, u, ns_uri) and std.mem.eql(u8, attr.name, local_name)) {
                    return attr.value;
                }
            }
        }
        return null;
    }
};

pub const EndElement = struct {
    name: []const u8,
    prefix: ?[]const u8 = null,
    ns_uri: ?[]const u8 = null,
};

pub const Token = union(enum) {
    start_element: StartElement,
    end_element: EndElement,
    characters: []const u8,
    comment: []const u8,
    eof: void,
};

pub const Error = error{
    UnexpectedEof,
    MalformedXml,
    NamespacePrefixNotFound,
    MaxDepthExceeded,
    MaxAttributesExceeded,
    BufferTooSmall,
    OutOfMemory,
} || std.Io.Reader.Error;

pub const Reader = struct {
    const NsBinding = struct {
        prefix: []const u8, // "" for default xmlns
        uri: []const u8,
        depth: usize,
    };

    const TagRecord = struct {
        name: []const u8,
        prefix: ?[]const u8,
        ns_uri: ?[]const u8,
    };

    r: *std.Io.Reader,
    arena: std.heap.ArenaAllocator,
    ns_stack: std.ArrayList(NsBinding) = .empty,
    tag_stack: std.ArrayList(TagRecord) = .empty,

    // Reusable per-token buffers (invalidated on next `next()` call)
    attr_list: std.ArrayList(Attribute) = .empty,
    text_buf: std.ArrayList(u8) = .empty,
    token_buf: std.ArrayList(u8) = .empty,

    // If previous element was self-closing (<tag/>), synthesize an end_element on the next call
    pending_end_element: ?EndElement = null,

    max_depth: usize = 128,
    max_attributes: usize = 128,

    pub fn init(allocator: std.mem.Allocator, r: *std.Io.Reader) Reader {
        return .{
            .r = r,
            .arena = std.heap.ArenaAllocator.init(allocator),
        };
    }

    pub fn deinit(self: *Reader) void {
        self.arena.deinit();
    }

    fn alloc(self: *Reader) std.mem.Allocator {
        return self.arena.allocator();
    }

    fn clearAttrs(self: *Reader) void {
        self.attr_list.clearRetainingCapacity();
    }

    fn peekByteOrEof(self: *Reader) Error!u8 {
        return self.r.peekByte() catch |err| switch (err) {
            error.EndOfStream => error.UnexpectedEof,
            else => |e| e,
        };
    }

    fn takeByteOrEof(self: *Reader) Error!u8 {
        return self.r.takeByte() catch |err| switch (err) {
            error.EndOfStream => error.UnexpectedEof,
            else => |e| e,
        };
    }

    pub fn resolvePrefix(self: *const Reader, prefix: []const u8) ?[]const u8 {
        var i = self.ns_stack.items.len;
        while (i > 0) {
            i -= 1;
            const b = self.ns_stack.items[i];
            if (std.mem.eql(u8, b.prefix, prefix)) return b.uri;
        }
        if (std.mem.eql(u8, prefix, "xml")) return "http://www.w3.org/XML/1998/namespace";
        if (std.mem.eql(u8, prefix, "xmlns")) return "http://www.w3.org/2000/xmlns/";
        return null;
    }

    pub fn currentDefaultNs(self: *const Reader) ?[]const u8 {
        return self.resolvePrefix("");
    }

    pub fn next(self: *Reader) Error!Token {
        if (self.pending_end_element) |pe| {
            self.pending_end_element = null;
            return .{ .end_element = pe };
        }

        while (true) {
            const b = self.r.peekByte() catch |err| switch (err) {
                error.EndOfStream => {
                    if (self.tag_stack.items.len > 0) return error.UnexpectedEof;
                    return .eof;
                },
                else => |e| return e,
            };

            if (b == '<') {
                _ = try self.takeByteOrEof(); // consume '<'
                const next_b = try self.peekByteOrEof();

                if (next_b == '?') {
                    // Processing instruction: <?xml ... ?>
                    _ = try self.takeByteOrEof();
                    try self.skipUntil("?>");
                    continue;
                } else if (next_b == '!') {
                    // Comment, CDATA, or DOCTYPE
                    _ = try self.takeByteOrEof();
                    const b2 = try self.peekByteOrEof();
                    if (b2 == '-') {
                        _ = try self.takeByteOrEof();
                        const b3 = try self.takeByteOrEof();
                        if (b3 != '-') return error.MalformedXml;
                        self.token_buf.clearRetainingCapacity();
                        try self.readUntilTokenBuf("-->");
                        return .{ .comment = self.token_buf.items };
                    } else if (b2 == '[') {
                        _ = try self.takeByteOrEof();
                        var cdata_hdr: [6]u8 = undefined;
                        self.r.readSliceAll(&cdata_hdr) catch |err| switch (err) {
                            error.EndOfStream => return error.UnexpectedEof,
                            else => |e| return e,
                        };
                        if (!std.mem.eql(u8, &cdata_hdr, "CDATA[")) return error.MalformedXml;
                        self.token_buf.clearRetainingCapacity();
                        try self.readUntilTokenBuf("]]>");
                        return .{ .characters = self.token_buf.items };
                    } else {
                        try self.skipUntil(">");
                        continue;
                    }
                } else if (next_b == '/') {
                    _ = try self.takeByteOrEof();
                    return try self.parseEndElement();
                } else {
                    return try self.parseStartElement();
                }
            } else {
                // Characters until '<'
                self.text_buf.clearRetainingCapacity();
                while (true) {
                    const ch = self.r.peekByte() catch |err| switch (err) {
                        error.EndOfStream => {
                            if (self.tag_stack.items.len > 0) return error.UnexpectedEof;
                            break;
                        },
                        else => |e| return e,
                    };
                    if (ch == '<') break;
                    _ = try self.takeByteOrEof();
                    if (ch == '&') {
                        try self.decodeEntityInto(&self.text_buf);
                    } else {
                        try self.text_buf.append(self.alloc(), ch);
                    }
                }

                const trimmed = std.mem.trim(u8, self.text_buf.items, " \t\r\n");
                if (trimmed.len == 0) {
                    continue;
                }
                return .{ .characters = self.text_buf.items };
            }
        }
    }

    fn skipUntil(self: *Reader, delim: []const u8) Error!void {
        std.debug.assert(delim.len >= 1 and delim.len <= 3);
        var ring: [3]u8 = undefined;
        var count: usize = 0;

        while (true) {
            const b = try self.takeByteOrEof();
            if (count < delim.len) {
                ring[count] = b;
                count += 1;
            } else {
                for (0..delim.len - 1) |i| {
                    ring[i] = ring[i + 1];
                }
                ring[delim.len - 1] = b;
            }
            if (count == delim.len and std.mem.eql(u8, ring[0..delim.len], delim)) {
                return;
            }
        }
    }

    fn readUntilTokenBuf(self: *Reader, delim: []const u8) Error!void {
        std.debug.assert(delim.len >= 1);
        const a = self.alloc();
        while (true) {
            const b = try self.takeByteOrEof();
            try self.token_buf.append(a, b);
            if (self.token_buf.items.len >= delim.len and
                std.mem.endsWith(u8, self.token_buf.items, delim))
            {
                self.token_buf.items.len -= delim.len;
                return;
            }
        }
    }

    fn decodeEntityInto(self: *Reader, buf: *std.ArrayList(u8)) Error!void {
        const a = self.alloc();
        var entity_name: [16]u8 = undefined;
        var len: usize = 0;
        while (true) {
            const b = try self.takeByteOrEof();
            if (b == ';') break;
            if (len >= entity_name.len) return error.MalformedXml;
            entity_name[len] = b;
            len += 1;
        }
        const name = entity_name[0..len];
        if (std.mem.eql(u8, name, "amp")) {
            try buf.append(a, '&');
        } else if (std.mem.eql(u8, name, "lt")) {
            try buf.append(a, '<');
        } else if (std.mem.eql(u8, name, "gt")) {
            try buf.append(a, '>');
        } else if (std.mem.eql(u8, name, "quot")) {
            try buf.append(a, '"');
        } else if (std.mem.eql(u8, name, "apos")) {
            try buf.append(a, '\'');
        } else if (name.len > 1 and name[0] == '#') {
            var codepoint: u21 = 0;
            if (name.len > 2 and (name[1] == 'x' or name[1] == 'X')) {
                const hex = name[2..];
                for (hex) |ch| {
                    if (!std.ascii.isHex(ch)) return error.MalformedXml;
                }
                codepoint = std.fmt.parseInt(u21, hex, 16) catch return error.MalformedXml;
            } else {
                const dec = name[1..];
                for (dec) |ch| {
                    if (!std.ascii.isDigit(ch)) return error.MalformedXml;
                }
                codepoint = std.fmt.parseInt(u21, dec, 10) catch return error.MalformedXml;
            }
            if (codepoint == 0) return error.MalformedXml;
            var utf8_buf: [4]u8 = undefined;
            const utf8_len = std.unicode.utf8Encode(codepoint, &utf8_buf) catch return error.MalformedXml;
            try buf.appendSlice(a, utf8_buf[0..utf8_len]);
        } else {
            return error.MalformedXml;
        }
    }

    fn skipWhitespace(self: *Reader) Error!usize {
        var skipped: usize = 0;
        while (true) {
            const b = self.r.peekByte() catch |err| switch (err) {
                error.EndOfStream => return skipped,
                else => |e| return e,
            };
            if (b == ' ' or b == '\t' or b == '\r' or b == '\n') {
                _ = try self.takeByteOrEof();
                skipped += 1;
            } else {
                return skipped;
            }
        }
    }

    fn parseQName(raw: []const u8) struct { prefix: ?[]const u8, local: []const u8 } {
        if (std.mem.indexOfScalar(u8, raw, ':')) |colon| {
            return .{
                .prefix = raw[0..colon],
                .local = raw[colon + 1 ..],
            };
        }
        return .{ .prefix = null, .local = raw };
    }

    fn parseStartElement(self: *Reader) Error!Token {
        if (self.tag_stack.items.len >= self.max_depth) return error.MaxDepthExceeded;

        const a = self.alloc();
        self.token_buf.clearRetainingCapacity();
        while (true) {
            const b = try self.peekByteOrEof();
            if (b == ' ' or b == '\t' or b == '\r' or b == '\n' or b == '/' or b == '>') {
                break;
            }
            _ = try self.takeByteOrEof();
            try self.token_buf.append(a, b);
        }
        if (self.token_buf.items.len == 0) return error.MalformedXml;

        const raw_tag_name = try a.dupe(u8, self.token_buf.items);

        const current_depth = self.tag_stack.items.len + 1;
        self.clearAttrs();

        var is_empty = false;
        var need_attr_ws = true;

        while (true) {
            const ws_count = try self.skipWhitespace();
            const b = try self.peekByteOrEof();
            if (b == '>') {
                _ = try self.takeByteOrEof();
                break;
            } else if (b == '/') {
                _ = try self.takeByteOrEof();
                const b2 = try self.takeByteOrEof();
                if (b2 != '>') return error.MalformedXml;
                is_empty = true;
                break;
            }

            if (!need_attr_ws or ws_count == 0) return error.MalformedXml;
            if (self.attr_list.items.len >= self.max_attributes) return error.MaxAttributesExceeded;

            // Read attribute name
            self.token_buf.clearRetainingCapacity();
            while (true) {
                const ab = try self.peekByteOrEof();
                if (ab == '=' or ab == ' ' or ab == '\t' or ab == '\r' or ab == '\n' or ab == '/' or ab == '>') {
                    break;
                }
                _ = try self.takeByteOrEof();
                try self.token_buf.append(a, ab);
            }
            if (self.token_buf.items.len == 0) return error.MalformedXml;
            const attr_raw_name = try a.dupe(u8, self.token_buf.items);

            _ = try self.skipWhitespace();
            const eq = try self.takeByteOrEof();
            if (eq != '=') return error.MalformedXml;
            _ = try self.skipWhitespace();

            const quote = try self.takeByteOrEof();
            if (quote != '"' and quote != '\'') return error.MalformedXml;

            self.text_buf.clearRetainingCapacity();
            while (true) {
                const vb = try self.takeByteOrEof();
                if (vb == quote) break;
                if (vb == '<') return error.MalformedXml;
                if (vb == '&') {
                    try self.decodeEntityInto(&self.text_buf);
                } else {
                    try self.text_buf.append(a, vb);
                }
            }
            const attr_val = try a.dupe(u8, self.text_buf.items);
            need_attr_ws = true;

            const q = parseQName(attr_raw_name);
            if (q.prefix) |p| {
                if (std.mem.eql(u8, p, "xmlns")) {
                    try self.ns_stack.append(a, .{
                        .prefix = try a.dupe(u8, q.local),
                        .uri = try a.dupe(u8, attr_val),
                        .depth = current_depth,
                    });
                }
            } else if (std.mem.eql(u8, q.local, "xmlns")) {
                try self.ns_stack.append(a, .{
                    .prefix = try a.dupe(u8, ""),
                    .uri = try a.dupe(u8, attr_val),
                    .depth = current_depth,
                });
            }

            try self.attr_list.append(a, .{
                .name = attr_raw_name,
                .prefix = null,
                .ns_uri = null,
                .value = attr_val,
            });
        }

        // Resolve namespaces for attributes
        for (self.attr_list.items) |*attr| {
            const aq = parseQName(attr.name);
            if (aq.prefix) |ap| {
                if (std.mem.eql(u8, ap, "xmlns")) {
                    attr.prefix = try a.dupe(u8, "xmlns");
                    attr.ns_uri = try a.dupe(u8, "http://www.w3.org/2000/xmlns/");
                    attr.name = try a.dupe(u8, aq.local);
                } else {
                    const resolved = self.resolvePrefix(ap);
                    attr.prefix = try a.dupe(u8, ap);
                    if (resolved) |r_uri| {
                        attr.ns_uri = try a.dupe(u8, r_uri);
                    }
                    attr.name = try a.dupe(u8, aq.local);
                }
            } else if (std.mem.eql(u8, aq.local, "xmlns")) {
                attr.ns_uri = try a.dupe(u8, "http://www.w3.org/2000/xmlns/");
            }
        }

        // Resolve namespace for the start element
        const tq = parseQName(raw_tag_name);
        var elem_prefix: ?[]const u8 = null;
        var elem_ns_uri: ?[]const u8 = null;
        if (tq.prefix) |tp| {
            if (tp.len == 0 or tq.local.len == 0) return error.MalformedXml;
            elem_prefix = try a.dupe(u8, tp);
            if (self.resolvePrefix(tp)) |uri| {
                elem_ns_uri = try a.dupe(u8, uri);
            }
        } else {
            if (self.currentDefaultNs()) |uri| {
                if (uri.len > 0) {
                    elem_ns_uri = try a.dupe(u8, uri);
                }
            }
        }

        const local_name = try a.dupe(u8, tq.local);

        if (!is_empty) {
            try self.tag_stack.append(a, .{
                .name = local_name,
                .prefix = elem_prefix,
                .ns_uri = elem_ns_uri,
            });
        } else {
            self.pending_end_element = .{
                .name = local_name,
                .prefix = elem_prefix,
                .ns_uri = elem_ns_uri,
            };
        }

        return .{
            .start_element = .{
                .name = local_name,
                .prefix = elem_prefix,
                .ns_uri = elem_ns_uri,
                .attributes = self.attr_list.items,
                .is_empty = is_empty,
            },
        };
    }

    fn popNamespacesForDepth(self: *Reader, depth: usize) void {
        while (self.ns_stack.items.len > 0) {
            const top = self.ns_stack.items[self.ns_stack.items.len - 1];
            if (top.depth >= depth) {
                _ = self.ns_stack.pop().?;
            } else {
                break;
            }
        }
    }

    fn parseEndElement(self: *Reader) Error!Token {
        const a = self.alloc();
        self.token_buf.clearRetainingCapacity();
        while (true) {
            const b = try self.peekByteOrEof();
            if (b == ' ' or b == '\t' or b == '\r' or b == '\n' or b == '>') break;
            _ = try self.takeByteOrEof();
            try self.token_buf.append(a, b);
        }
        if (self.token_buf.items.len == 0) return error.MalformedXml;

        _ = try self.skipWhitespace();
        const gt = try self.takeByteOrEof();
        if (gt != '>') return error.MalformedXml;

        const q = parseQName(self.token_buf.items);
        if (self.tag_stack.items.len == 0) return error.MalformedXml;

        const top = self.tag_stack.pop().?;

        if (!std.mem.eql(u8, top.name, q.local)) return error.MalformedXml;
        if ((top.prefix == null) != (q.prefix == null)) return error.MalformedXml;
        if (top.prefix) |tp| {
            if (!std.mem.eql(u8, tp, q.prefix.?)) return error.MalformedXml;
        }

        const depth = self.tag_stack.items.len + 1;
        self.popNamespacesForDepth(depth);

        return .{
            .end_element = .{
                .name = top.name,
                .prefix = top.prefix,
                .ns_uri = top.ns_uri,
            },
        };
    }

    pub fn skipElement(self: *Reader) Error!void {
        var depth: usize = 1;
        while (depth > 0) {
            const tok = try self.next();
            switch (tok) {
                .start_element => {
                    depth += 1;
                },
                .end_element => {
                    depth -= 1;
                },
                .eof => return error.UnexpectedEof,
                else => {},
            }
        }
    }

    pub fn readElementTextAlloc(self: *Reader, gpa: std.mem.Allocator) Error![]u8 {
        var buf: std.ArrayList(u8) = .empty;
        errdefer buf.deinit(gpa);

        while (true) {
            const tok = try self.next();
            switch (tok) {
                .characters => |chars| {
                    try buf.appendSlice(gpa, chars);
                },
                .end_element => break,
                .start_element => {
                    try self.skipElement();
                },
                .comment => {},
                .eof => return error.UnexpectedEof,
            }
        }
        return try buf.toOwnedSlice(gpa);
    }
};

test "xml.Reader basic parsing and namespaces" {
    const xml_text =
        \\<?xml version="1.0" encoding="UTF-8"?>
        \\<!-- comment here -->
        \\<s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope" xmlns:tt="http://www.onvif.org/ver10/schema">
        \\  <s:Body>
        \\    <tt:GetDeviceInformationResponse token="dev-123" enabled="true">
        \\      <tt:Manufacturer>ACME &amp; Co</tt:Manufacturer>
        \\      <tt:Model><![CDATA[Cam <HD> 4K [0]]]></tt:Model>
        \\      <tt:EmptyTag/>
        \\    </tt:GetDeviceInformationResponse>
        \\  </s:Body>
        \\</s:Envelope>
    ;

    var r_impl: std.Io.Reader = .fixed(xml_text);
    var reader = Reader.init(std.testing.allocator, &r_impl);
    defer reader.deinit();

    const t1 = try reader.next();
    try std.testing.expectEqual(Token.comment, std.meta.activeTag(t1));

    const t2 = try reader.next();
    try std.testing.expectEqual(Token.start_element, std.meta.activeTag(t2));
    const se1 = t2.start_element;
    try std.testing.expectEqualStrings("Envelope", se1.name);
    try std.testing.expectEqualStrings("http://www.w3.org/2003/05/soap-envelope", se1.ns_uri.?);

    const t3 = try reader.next();
    try std.testing.expectEqual(Token.start_element, std.meta.activeTag(t3));
    try std.testing.expectEqualStrings("Body", t3.start_element.name);

    const t4 = try reader.next();
    try std.testing.expectEqual(Token.start_element, std.meta.activeTag(t4));
    const se_dev = t4.start_element;
    try std.testing.expectEqualStrings("GetDeviceInformationResponse", se_dev.name);
    try std.testing.expectEqualStrings("http://www.onvif.org/ver10/schema", se_dev.ns_uri.?);
    try std.testing.expectEqualStrings("dev-123", se_dev.getAttribute("token").?);
    try std.testing.expectEqualStrings("true", se_dev.getAttribute("enabled").?);

    const t5 = try reader.next();
    try std.testing.expectEqual(Token.start_element, std.meta.activeTag(t5));
    try std.testing.expectEqualStrings("Manufacturer", t5.start_element.name);

    const t6 = try reader.next();
    try std.testing.expectEqual(Token.characters, std.meta.activeTag(t6));
    try std.testing.expectEqualStrings("ACME & Co", t6.characters);

    const t7 = try reader.next();
    try std.testing.expectEqual(Token.end_element, std.meta.activeTag(t7));
    try std.testing.expectEqualStrings("Manufacturer", t7.end_element.name);

    const t8 = try reader.next();
    try std.testing.expectEqual(Token.start_element, std.meta.activeTag(t8));
    try std.testing.expectEqualStrings("Model", t8.start_element.name);

    const t9 = try reader.next();
    try std.testing.expectEqual(Token.characters, std.meta.activeTag(t9));
    try std.testing.expectEqualStrings("Cam <HD> 4K [0]", t9.characters);

    const t10 = try reader.next();
    try std.testing.expectEqual(Token.end_element, std.meta.activeTag(t10));

    const t11 = try reader.next();
    try std.testing.expectEqual(Token.start_element, std.meta.activeTag(t11));
    try std.testing.expectEqualStrings("EmptyTag", t11.start_element.name);
    try std.testing.expect(t11.start_element.is_empty);

    const t12 = try reader.next();
    try std.testing.expectEqual(Token.end_element, std.meta.activeTag(t12));
    try std.testing.expectEqualStrings("EmptyTag", t12.end_element.name);

    const t13 = try reader.next();
    try std.testing.expectEqual(Token.end_element, std.meta.activeTag(t13));
    try std.testing.expectEqualStrings("GetDeviceInformationResponse", t13.end_element.name);

    const t14 = try reader.next();
    try std.testing.expectEqual(Token.end_element, std.meta.activeTag(t14));
    try std.testing.expectEqualStrings("Body", t14.end_element.name);

    const t15 = try reader.next();
    try std.testing.expectEqual(Token.end_element, std.meta.activeTag(t15));
    try std.testing.expectEqualStrings("Envelope", t15.end_element.name);

    const t16 = try reader.next();
    try std.testing.expectEqual(Token.eof, std.meta.activeTag(t16));
}

test "xml.Reader skipElement with nested self-closing tags and error cases" {
    const xml_text =
        \\<Root>
        \\  <SkipMe><EmptyChild/><Nested><AlsoEmpty/></Nested><After>text</After></SkipMe>
        \\  <Keep>ok</Keep>
        \\</Root>
    ;
    var r_impl: std.Io.Reader = .fixed(xml_text);
    var reader = Reader.init(std.testing.allocator, &r_impl);
    defer reader.deinit();

    _ = try reader.next(); // <Root>
    _ = try reader.next(); // <SkipMe>
    try reader.skipElement();

    const keep_se = try reader.next();
    try std.testing.expectEqualStrings("Keep", keep_se.start_element.name);
    const keep_txt = try reader.readElementTextAlloc(std.testing.allocator);
    defer std.testing.allocator.free(keep_txt);
    try std.testing.expectEqualStrings("ok", keep_txt);
    _ = try reader.next(); // </Root>
    try std.testing.expectEqual(Token.eof, std.meta.activeTag(try reader.next()));

    // Prefix mismatch and truncated XML must fail
    var r_bad_prefix: std.Io.Reader = .fixed("<s:Root xmlns:s=\"urn:a\"></Root>");
    var bad_prefix = Reader.init(std.testing.allocator, &r_bad_prefix);
    defer bad_prefix.deinit();
    _ = try bad_prefix.next();
    try std.testing.expectError(error.MalformedXml, bad_prefix.next());

    var r_trunc: std.Io.Reader = .fixed("<Root><Child/>");
    var trunc = Reader.init(std.testing.allocator, &r_trunc);
    defer trunc.deinit();
    _ = try trunc.next();
    _ = try trunc.next();
    _ = try trunc.next();
    try std.testing.expectError(error.UnexpectedEof, trunc.next());
}

test "xml.Reader entity decoding and numeric char refs" {
    const xml_text = "<data text=\"&quot;quotes&quot; &amp; &#x41;&#66;\"/>";
    var r_impl: std.Io.Reader = .fixed(xml_text);
    var reader = Reader.init(std.testing.allocator, &r_impl);
    defer reader.deinit();

    const t = try reader.next();
    try std.testing.expectEqual(Token.start_element, std.meta.activeTag(t));
    try std.testing.expectEqualStrings("\"quotes\" & AB", t.start_element.getAttribute("text").?);
}

test "xml.Reader malformed xml error handling" {
    const xml_text = "<open><unmatched></closed>";
    var r_impl: std.Io.Reader = .fixed(xml_text);
    var reader = Reader.init(std.testing.allocator, &r_impl);
    defer reader.deinit();

    _ = try reader.next();
    _ = try reader.next();
    try std.testing.expectError(error.MalformedXml, reader.next());
}
