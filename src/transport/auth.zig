const std = @import("std");

pub const Algorithm = enum {
    md5,
    sha256,
};

pub const DigestChallenge = struct {
    realm: []const u8,
    nonce: []const u8,
    qop: ?[]const u8 = null, // "auth"
    @"opaque": ?[]const u8 = null,
    algorithm: Algorithm = .md5,

    pub fn parse(header_value: []const u8) ?DigestChallenge {
        const trimmed = std.mem.trim(u8, header_value, " \t\r\n");
        if (trimmed.len < 7) return null;
        if (!std.ascii.startsWithIgnoreCase(trimmed, "digest")) return null;
        if (trimmed[6] != ' ' and trimmed[6] != '\t') return null;
        if (hasControlChars(trimmed)) return null;

        var rest = std.mem.trim(u8, trimmed[6..], " \t\r\n");
        var realm: ?[]const u8 = null;
        var nonce: ?[]const u8 = null;
        var qop: ?[]const u8 = null;
        var opaque_val: ?[]const u8 = null;
        var algo: Algorithm = .md5;

        while (rest.len > 0) {
            rest = std.mem.trimStart(u8, rest, " \t\r\n,");
            if (rest.len == 0) break;

            const eq_idx = std.mem.indexOfScalar(u8, rest, '=') orelse break;
            const key = std.mem.trim(u8, rest[0..eq_idx], " \t\r\n");
            if (key.len == 0) return null;
            rest = std.mem.trim(u8, rest[eq_idx + 1 ..], " \t\r\n");

            var val: []const u8 = "";
            if (rest.len > 0 and rest[0] == '"') {
                rest = rest[1..];
                const close_quote = findClosingQuote(rest) orelse return null;
                val = rest[0..close_quote];
                rest = rest[close_quote + 1 ..];
                if (std.mem.indexOfScalar(u8, val, '\\') != null) return null;
            } else {
                const comma = std.mem.indexOfScalar(u8, rest, ',') orelse rest.len;
                val = std.mem.trim(u8, rest[0..comma], " \t\r\n");
                rest = if (comma < rest.len) rest[comma + 1 ..] else "";
            }

            if (std.ascii.eqlIgnoreCase(key, "realm")) {
                realm = val;
            } else if (std.ascii.eqlIgnoreCase(key, "nonce")) {
                nonce = val;
            } else if (std.ascii.eqlIgnoreCase(key, "qop")) {
                qop = selectQopAuth(val) orelse return null;
            } else if (std.ascii.eqlIgnoreCase(key, "opaque")) {
                opaque_val = val;
            } else if (std.ascii.eqlIgnoreCase(key, "algorithm")) {
                if (std.ascii.eqlIgnoreCase(val, "SHA-256") or std.ascii.eqlIgnoreCase(val, "SHA256")) {
                    algo = .sha256;
                } else if (std.ascii.eqlIgnoreCase(val, "MD5")) {
                    algo = .md5;
                } else {
                    return null;
                }
            }
        }

        if (realm != null and nonce != null) {
            return .{
                .realm = realm.?,
                .nonce = nonce.?,
                .qop = qop,
                .@"opaque" = opaque_val,
                .algorithm = algo,
            };
        }
        return null;
    }

    fn findClosingQuote(s: []const u8) ?usize {
        var i: usize = 0;
        while (i < s.len) : (i += 1) {
            if (s[i] == '\\') {
                i += 1;
                continue;
            }
            if (s[i] == '"') return i;
        }
        return null;
    }

    fn selectQopAuth(qop_list: []const u8) ?[]const u8 {
        var it = std.mem.splitScalar(u8, qop_list, ',');
        while (it.next()) |raw| {
            const tok = std.mem.trim(u8, raw, " \t");
            if (std.ascii.eqlIgnoreCase(tok, "auth")) return "auth";
        }
        return null;
    }
};

fn hasControlChars(s: []const u8) bool {
    for (s) |ch| {
        if (ch == '\r' or ch == '\n' or ch == 0) return true;
    }
    return false;
}

fn writeQuoted(w: *std.Io.Writer, s: []const u8) !void {
    try w.writeByte('"');
    for (s) |ch| {
        if (ch == '"' or ch == '\\') try w.writeByte('\\');
        try w.writeByte(ch);
    }
    try w.writeByte('"');
}

pub fn computeDigestResponse(
    algo: Algorithm,
    username: []const u8,
    realm: []const u8,
    password: []const u8,
    method: []const u8,
    uri: []const u8,
    nonce: []const u8,
    nc: []const u8,
    cnonce: []const u8,
    qop: ?[]const u8,
    out_hex: []u8,
) void {
    switch (algo) {
        .md5 => computeWithHash(std.crypto.hash.Md5, username, realm, password, method, uri, nonce, nc, cnonce, qop, out_hex),
        .sha256 => computeWithHash(std.crypto.hash.sha2.Sha256, username, realm, password, method, uri, nonce, nc, cnonce, qop, out_hex),
    }
}

fn computeWithHash(
    comptime Hash: type,
    username: []const u8,
    realm: []const u8,
    password: []const u8,
    method: []const u8,
    uri: []const u8,
    nonce: []const u8,
    nc: []const u8,
    cnonce: []const u8,
    qop: ?[]const u8,
    out_hex: []u8,
) void {
    const digest_len = Hash.digest_length;
    std.debug.assert(out_hex.len >= digest_len * 2);

    // HA1 = H(username:realm:password)
    var ha1_bytes: [digest_len]u8 = undefined;
    {
        var h = Hash.init(.{});
        h.update(username);
        h.update(":");
        h.update(realm);
        h.update(":");
        h.update(password);
        h.final(&ha1_bytes);
    }
    const ha1_hex = std.fmt.bytesToHex(ha1_bytes, .lower);

    // HA2 = H(method:uri)
    var ha2_bytes: [digest_len]u8 = undefined;
    {
        var h = Hash.init(.{});
        h.update(method);
        h.update(":");
        h.update(uri);
        h.final(&ha2_bytes);
    }
    const ha2_hex = std.fmt.bytesToHex(ha2_bytes, .lower);

    // Response = H(HA1:nonce:nc:cnonce:qop:HA2) or H(HA1:nonce:HA2)
    var resp_bytes: [digest_len]u8 = undefined;
    {
        var h = Hash.init(.{});
        h.update(&ha1_hex);
        h.update(":");
        h.update(nonce);
        if (qop) |q| {
            h.update(":");
            h.update(nc);
            h.update(":");
            h.update(cnonce);
            h.update(":");
            h.update(q);
        }
        h.update(":");
        h.update(&ha2_hex);
        h.final(&resp_bytes);
    }
    const resp_hex = std.fmt.bytesToHex(resp_bytes, .lower);
    @memcpy(out_hex[0 .. digest_len * 2], &resp_hex);
}

pub fn createAuthorizationHeader(
    gpa: std.mem.Allocator,
    challenge: DigestChallenge,
    username: []const u8,
    password: []const u8,
    method: []const u8,
    uri: []const u8,
    nc_val: u32,
    cnonce: []const u8,
) ![]u8 {
    if (hasControlChars(username) or hasControlChars(challenge.realm) or
        hasControlChars(challenge.nonce) or hasControlChars(uri) or
        hasControlChars(cnonce) or (challenge.@"opaque" != null and hasControlChars(challenge.@"opaque".?)))
    {
        return error.InvalidHeaderValue;
    }

    var out: std.Io.Writer.Allocating = .init(gpa);
    defer out.deinit();

    var nc_buf: [8]u8 = undefined;
    const nc_str = std.fmt.bufPrint(&nc_buf, "{x:0>8}", .{nc_val}) catch unreachable;

    var resp_buf: [64]u8 = undefined;
    const resp_len: usize = if (challenge.algorithm == .md5) 32 else 64;
    computeDigestResponse(
        challenge.algorithm,
        username,
        challenge.realm,
        password,
        method,
        uri,
        challenge.nonce,
        nc_str,
        cnonce,
        challenge.qop,
        resp_buf[0..resp_len],
    );

    try out.writer.writeAll("Digest username=");
    try writeQuoted(&out.writer, username);
    try out.writer.writeAll(", realm=");
    try writeQuoted(&out.writer, challenge.realm);
    try out.writer.writeAll(", nonce=");
    try writeQuoted(&out.writer, challenge.nonce);
    try out.writer.writeAll(", uri=");
    try writeQuoted(&out.writer, uri);
    try out.writer.print(", response=\"{s}\"", .{resp_buf[0..resp_len]});

    if (challenge.qop) |q| {
        try out.writer.print(", qop={s}, nc={s}, cnonce=", .{ q, nc_str });
        try writeQuoted(&out.writer, cnonce);
    }

    if (challenge.@"opaque") |op| {
        try out.writer.writeAll(", opaque=");
        try writeQuoted(&out.writer, op);
    }

    if (challenge.algorithm == .sha256) {
        try out.writer.writeAll(", algorithm=SHA-256");
    }

    return try out.toOwnedSlice();
}

pub const DigestAuthorization = struct {
    username: []const u8,
    realm: []const u8,
    nonce: []const u8,
    uri: []const u8,
    response: []const u8,
    qop: ?[]const u8 = null,
    nc: ?[]const u8 = null,
    cnonce: ?[]const u8 = null,
    algorithm: Algorithm = .md5,

    pub fn parse(header_value: []const u8) ?DigestAuthorization {
        const trimmed = std.mem.trim(u8, header_value, " \t\r\n");
        if (trimmed.len < 7) return null;
        if (!std.ascii.startsWithIgnoreCase(trimmed, "digest")) return null;
        if (trimmed[6] != ' ' and trimmed[6] != '\t') return null;
        if (hasControlChars(trimmed)) return null;

        var rest = std.mem.trim(u8, trimmed[6..], " \t\r\n");
        var username: ?[]const u8 = null;
        var realm: ?[]const u8 = null;
        var nonce: ?[]const u8 = null;
        var uri: ?[]const u8 = null;
        var response: ?[]const u8 = null;
        var qop: ?[]const u8 = null;
        var nc: ?[]const u8 = null;
        var cnonce: ?[]const u8 = null;
        var algo: Algorithm = .md5;

        while (rest.len > 0) {
            rest = std.mem.trimStart(u8, rest, " \t\r\n,");
            if (rest.len == 0) break;

            const eq_idx = std.mem.indexOfScalar(u8, rest, '=') orelse break;
            const key = std.mem.trim(u8, rest[0..eq_idx], " \t\r\n");
            if (key.len == 0) return null;
            rest = std.mem.trim(u8, rest[eq_idx + 1 ..], " \t\r\n");

            var val: []const u8 = "";
            if (rest.len > 0 and rest[0] == '"') {
                rest = rest[1..];
                const close_quote = DigestChallenge.findClosingQuote(rest) orelse return null;
                val = rest[0..close_quote];
                rest = rest[close_quote + 1 ..];
                if (std.mem.indexOfScalar(u8, val, '\\') != null) return null;
            } else {
                const comma = std.mem.indexOfScalar(u8, rest, ',') orelse rest.len;
                val = std.mem.trim(u8, rest[0..comma], " \t\r\n");
                rest = if (comma < rest.len) rest[comma + 1 ..] else "";
            }

            if (std.ascii.eqlIgnoreCase(key, "username")) {
                username = val;
            } else if (std.ascii.eqlIgnoreCase(key, "realm")) {
                realm = val;
            } else if (std.ascii.eqlIgnoreCase(key, "nonce")) {
                nonce = val;
            } else if (std.ascii.eqlIgnoreCase(key, "uri")) {
                uri = val;
            } else if (std.ascii.eqlIgnoreCase(key, "response")) {
                response = val;
            } else if (std.ascii.eqlIgnoreCase(key, "qop")) {
                qop = val;
            } else if (std.ascii.eqlIgnoreCase(key, "nc")) {
                nc = val;
            } else if (std.ascii.eqlIgnoreCase(key, "cnonce")) {
                cnonce = val;
            } else if (std.ascii.eqlIgnoreCase(key, "algorithm")) {
                if (std.ascii.eqlIgnoreCase(val, "SHA-256") or std.ascii.eqlIgnoreCase(val, "SHA256")) {
                    algo = .sha256;
                } else if (std.ascii.eqlIgnoreCase(val, "MD5")) {
                    algo = .md5;
                } else {
                    return null;
                }
            }
        }

        if (username != null and realm != null and nonce != null and uri != null and response != null) {
            return .{
                .username = username.?,
                .realm = realm.?,
                .nonce = nonce.?,
                .uri = uri.?,
                .response = response.?,
                .qop = qop,
                .nc = nc,
                .cnonce = cnonce,
                .algorithm = algo,
            };
        }
        return null;
    }
};

pub const ServerAuth = struct {
    realm: []const u8 = "onvif",
    secret: [32]u8,
    nonce_ttl_seconds: i64 = 300,

    pub fn init(io: std.Io, realm: []const u8) ServerAuth {
        var secret: [32]u8 = undefined;
        io.random(&secret);
        return .{
            .realm = realm,
            .secret = secret,
        };
    }

    pub fn generateNonce(self: *const ServerAuth, io: std.Io) [48]u8 {
        const Hmac = std.crypto.auth.hmac.sha2.HmacSha256;
        const now_s: i64 = @intCast(@divFloor(std.Io.Clock.real.now(io).toNanoseconds(), std.time.ns_per_s));
        var ts_bytes: [8]u8 = undefined;
        std.mem.writeInt(i64, &ts_bytes, now_s, .big);

        var mac: [Hmac.mac_length]u8 = undefined;
        Hmac.create(&mac, &ts_bytes, &self.secret);

        var out: [48]u8 = undefined;
        const ts_hex = std.fmt.bytesToHex(ts_bytes, .lower);
        const mac_hex = std.fmt.bytesToHex(mac[0..16].*, .lower);
        @memcpy(out[0..16], &ts_hex);
        @memcpy(out[16..48], &mac_hex);
        return out;
    }

    pub fn verifyNonce(self: *const ServerAuth, io: std.Io, nonce: []const u8) bool {
        const Hmac = std.crypto.auth.hmac.sha2.HmacSha256;
        if (nonce.len != 48) return false;

        var ts_bytes: [8]u8 = undefined;
        var got_mac: [16]u8 = undefined;
        _ = std.fmt.hexToBytes(&ts_bytes, nonce[0..16]) catch return false;
        _ = std.fmt.hexToBytes(&got_mac, nonce[16..48]) catch return false;

        var expected_mac: [Hmac.mac_length]u8 = undefined;
        Hmac.create(&expected_mac, &ts_bytes, &self.secret);
        if (!std.crypto.timing_safe.eql([16]u8, expected_mac[0..16].*, got_mac)) return false;

        const ts_s = std.mem.readInt(i64, &ts_bytes, .big);
        const now_s: i64 = @intCast(@divFloor(std.Io.Clock.real.now(io).toNanoseconds(), std.time.ns_per_s));
        return (now_s - ts_s) >= -30 and (now_s - ts_s) <= self.nonce_ttl_seconds;
    }

    pub fn formatChallenge(self: *const ServerAuth, io: std.Io, buf: *[256]u8, algo: Algorithm) []const u8 {
        const nonce = self.generateNonce(io);
        const algo_str = if (algo == .sha256) "SHA-256" else "MD5";
        return std.fmt.bufPrint(buf, "Digest realm=\"{s}\", qop=\"auth\", nonce=\"{s}\", algorithm={s}", .{
            self.realm, nonce, algo_str,
        }) catch unreachable;
    }

    pub fn verifyDigest(
        self: *const ServerAuth,
        io: std.Io,
        auth_hdr: DigestAuthorization,
        method: []const u8,
        expected_target: []const u8,
        expected_password: []const u8,
    ) bool {
        if (!std.mem.eql(u8, auth_hdr.realm, self.realm)) return false;
        if (!self.verifyNonce(io, auth_hdr.nonce)) return false;
        if (!std.mem.eql(u8, auth_hdr.uri, expected_target)) return false;

        var qop_val: ?[]const u8 = null;
        if (auth_hdr.qop) |q| {
            if (!std.ascii.eqlIgnoreCase(q, "auth")) return false;
            if (auth_hdr.nc == null or auth_hdr.cnonce == null or auth_hdr.cnonce.?.len == 0) return false;
            qop_val = "auth";
        }

        const resp_len: usize = if (auth_hdr.algorithm == .md5) 32 else 64;
        if (auth_hdr.response.len != resp_len) return false;

        var got_lower: [64]u8 = undefined;
        for (auth_hdr.response, 0..) |ch, i| {
            got_lower[i] = std.ascii.toLower(ch);
        }

        var expected_hex: [64]u8 = undefined;
        computeDigestResponse(
            auth_hdr.algorithm,
            auth_hdr.username,
            auth_hdr.realm,
            expected_password,
            method,
            auth_hdr.uri,
            auth_hdr.nonce,
            auth_hdr.nc orelse "",
            auth_hdr.cnonce orelse "",
            qop_val,
            expected_hex[0..resp_len],
        );

        return if (resp_len == 32)
            std.crypto.timing_safe.eql([32]u8, expected_hex[0..32].*, got_lower[0..32].*)
        else
            std.crypto.timing_safe.eql([64]u8, expected_hex, got_lower);
    }
};

test "auth HTTP digest challenge parse and response generation" {
    const header = "Digest realm=\"testrealm@host.com\", qop=\"auth\", nonce=\"dcd98b7102dd2f0e8b11d0f600bfb0c093\", opaque=\"5ccc069c403ebaf9f0171e9517f40e41\"";
    const chal = DigestChallenge.parse(header).?;

    try std.testing.expectEqualStrings("testrealm@host.com", chal.realm);
    try std.testing.expectEqualStrings("dcd98b7102dd2f0e8b11d0f600bfb0c093", chal.nonce);
    try std.testing.expectEqualStrings("auth", chal.qop.?);
    try std.testing.expectEqualStrings("5ccc069c403ebaf9f0171e9517f40e41", chal.@"opaque".?);

    const auth_header = try createAuthorizationHeader(
        std.testing.allocator,
        chal,
        "Mufasa",
        "Circle Of Life",
        "GET",
        "/dir/index.html",
        1,
        "0a4f113b",
    );
    defer std.testing.allocator.free(auth_header);

    // RFC 2617 section 3.9 expected response for Mufasa: "6629fae49393a05397450978507c4ef1"
    try std.testing.expect(std.mem.indexOf(u8, auth_header, "response=\"6629fae49393a05397450978507c4ef1\"") != null);
}

test "auth RFC 7616 SHA-256, multi-qop, hex nc, and header validation" {
    const sha_header = "Digest realm=\"http-auth@example.org\", qop=\"auth, auth-int\", algorithm=SHA-256, nonce=\"7ypf/xlj9XXwfDPEoM4URrv/xwf94BcCAzFZH4GiTo0v\", opaque=\"FQhe/qaU925kfnzjCev0ciny7QMkPqMAFRtzCUYo5tdS\"";
    const chal = DigestChallenge.parse(sha_header).?;
    try std.testing.expectEqual(Algorithm.sha256, chal.algorithm);
    try std.testing.expectEqualStrings("auth", chal.qop.?);

    const auth_hdr = try createAuthorizationHeader(
        std.testing.allocator,
        chal,
        "Mufasa",
        "Circle of Life",
        "GET",
        "/dir/index.html",
        10,
        "f2/wE4q74E6zIJEtWaHKaf5wv/H5QzzpXusqGemxURZJ",
    );
    defer std.testing.allocator.free(auth_hdr);

    try std.testing.expect(std.mem.indexOf(u8, auth_hdr, "qop=auth, nc=0000000a,") != null);
    try std.testing.expect(std.mem.indexOf(u8, auth_hdr, "algorithm=SHA-256") != null);

    try std.testing.expect(DigestChallenge.parse("Digest realm=\"r\", nonce=\"n\", algorithm=SHA-512-256") == null);
    try std.testing.expect(DigestChallenge.parse("Digest realm=\"r\", nonce=\"n\", qop=\"auth-int\"") == null);
    try std.testing.expect(DigestChallenge.parse("Digestive realm=\"r\", nonce=\"n\"") == null);
    try std.testing.expect(DigestChallenge.parse("Digest realm=\"r\", nonce=\"unterminated") == null);
    try std.testing.expect(DigestChallenge.parse("Digest realm=\"bad\r\n\", nonce=\"n\"") == null);

    try std.testing.expectError(
        error.InvalidHeaderValue,
        createAuthorizationHeader(std.testing.allocator, chal, "user\r\nEvil: 1", "pw", "POST", "/", 1, "abc"),
    );
}
