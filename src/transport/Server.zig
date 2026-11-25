const std = @import("std");
const soap = @import("../soap.zig");
const codec = @import("../codec.zig");
const auth = @import("auth.zig");
const xml = struct {
    pub const Reader = @import("../xml/Reader.zig").Reader;
    pub const Writer = @import("../xml/Writer.zig").Writer;
};

pub fn Router(comptime Handler: type, comptime Services: []const type) type {
    return struct {
        pub fn dispatch(
            handler: *Handler,
            arena: std.mem.Allocator,
            action_header: ?[]const u8,
            body_xml: []const u8,
        ) ![]u8 {
            // Find root element in body XML if action_header is null
            var root_local: []const u8 = "";
            var root_ns: []const u8 = "";
            {
                var body_reader: std.Io.Reader = .fixed(body_xml);
                var r = xml.Reader.init(arena, &body_reader);
                defer r.deinit();
                while (true) {
                    const tok = r.next() catch break;
                    switch (tok) {
                        .start_element => |se| {
                            root_local = se.name;
                            root_ns = se.ns_uri orelse "";
                            break;
                        },
                        .eof => break,
                        else => {},
                    }
                }
            }

            inline for (Services) |Service| {
                inline for (@typeInfo(Service).@"struct".decl_names) |decl_name| {
                    const Op = @field(Service, decl_name);
                    if (@TypeOf(Op) == type and
                        @typeInfo(Op) == .@"struct" and
                        @hasDecl(Op, "name") and
                        @hasDecl(Op, "soap_action") and
                        @hasDecl(Op, "request_name") and
                        @hasDecl(Op, "response_name") and
                        @hasDecl(Op, "namespace") and
                        @hasDecl(Op, "namespace_uri") and
                        @hasDecl(Op, "Request") and
                        @hasDecl(Op, "Response"))
                    {
                        const effective_action = if (action_header) |act|
                            (if (act.len > 0) act else null)
                        else
                            null;

                        var matched = false;
                        if (effective_action) |act| {
                            if (std.mem.eql(u8, act, Op.soap_action)) {
                                matched = true;
                            }
                        } else if (root_local.len > 0) {
                            if (std.mem.eql(u8, root_local, Op.request_name)) {
                                if (root_ns.len == 0 or std.mem.eql(u8, root_ns, Op.namespace_uri)) {
                                    matched = true;
                                }
                            }
                        }

                        if (matched) {
                            return try dispatchOp(Op, handler, arena, body_xml);
                        }
                    }
                }
            }

            return error.ActionNotSupported;
        }

        fn dispatchOp(
            comptime Op: type,
            handler: *Handler,
            arena: std.mem.Allocator,
            body_xml: []const u8,
        ) ![]u8 {
            if (!@hasDecl(Handler, Op.name)) {
                return error.ActionNotImplemented;
            }

            var body_reader: std.Io.Reader = .fixed(body_xml);
            var r = xml.Reader.init(arena, &body_reader);
            defer r.deinit();

            const req = try codec.decode(Op.Request, &r, arena);
            const resp = try @field(Handler, Op.name)(handler, arena, req);

            var out: std.Io.Writer.Allocating = .init(arena);
            defer out.deinit();

            var writer = xml.Writer.init(arena, &out.writer);
            defer writer.deinit();

            try codec.encode(Op.Response, resp, &writer, Op.response_name, Op.namespace);
            try writer.flush();
            const resp_body_xml = out.written();

            return try soap.buildEnvelope(arena, resp_body_xml, .{ .version = .soap12 });
        }
    };
}

pub const AuthConfig = struct {
    server_auth: *const auth.ServerAuth,
    ctx: ?*anyopaque = null,
    lookup_password: *const fn (ctx: ?*anyopaque, username: []const u8) ?[]const u8,
    allow_http_digest: bool = true,
    allow_ws_security: bool = true,
    is_public_op: ?*const fn (action: ?[]const u8, body_xml: []const u8) bool = null,

    pub fn defaultIsPublicOp(action: ?[]const u8, _: []const u8) bool {
        const act = action orelse return false;
        return std.mem.endsWith(u8, act, "/GetSystemDateAndTime") or
            std.mem.endsWith(u8, act, "/GetServices") or
            std.mem.endsWith(u8, act, "/GetCapabilities") or
            std.mem.endsWith(u8, act, "/GetWsdlUrl");
    }
};

pub fn Server(comptime Handler: type, comptime Services: []const type) type {
    return struct {
        const Self = @This();
        const RouterType = Router(Handler, Services);

        io: std.Io,
        gpa: std.mem.Allocator,
        handler: *Handler,
        address: std.Io.net.IpAddress,
        listening_server: ?std.Io.net.Server = null,
        auth_config: ?AuthConfig = null,
        idle_timeout_ms: u32 = 30_000,
        stopped: std.atomic.Value(bool) = .init(false),
        socket_closed: std.atomic.Value(bool) = .init(false),

        pub fn init(
            io: std.Io,
            gpa: std.mem.Allocator,
            handler: *Handler,
            address: std.Io.net.IpAddress,
        ) Self {
            return .{
                .io = io,
                .gpa = gpa,
                .handler = handler,
                .address = address,
            };
        }

        pub fn listen(self: *Self) !void {
            self.stopped.store(false, .release);
            self.socket_closed.store(false, .release);
            self.listening_server = try self.address.listen(self.io, .{ .mode = .stream });
        }

        pub fn deinit(self: *Self) void {
            self.stop();
            self.listening_server = null;
        }

        pub fn stop(self: *Self) void {
            self.stopped.store(true, .seq_cst);
            if (self.listening_server) |*s| {
                if (!self.socket_closed.swap(true, .acq_rel)) {
                    s.socket.close(self.io);
                }
            }
        }

        pub fn getBoundAddress(self: *const Self) ?std.Io.net.IpAddress {
            if (self.listening_server) |s| {
                return s.socket.address;
            }
            return null;
        }

        pub fn accept(self: *Self) !std.Io.net.Stream {
            if (self.stopped.load(.acquire)) return error.SocketNotListening;
            if (self.listening_server) |*s| {
                return try s.accept(self.io);
            }
            return error.SocketNotListening;
        }

        pub fn serve(self: *Self) !void {
            if (self.listening_server == null) try self.listen();

            var group: std.Io.Group = .init;
            defer group.cancel(self.io);

            while (!self.stopped.load(.acquire)) {
                const stream = self.accept() catch |err| switch (err) {
                    error.SocketNotListening, error.Canceled => break,
                    else => continue,
                };
                group.concurrent(self.io, connectionWorker, .{ self, stream }) catch {
                    stream.close(self.io);
                };
            }
        }

        fn connectionWorker(self: *Self, stream: std.Io.net.Stream) void {
            if (self.idle_timeout_ms == 0) {
                self.handleConnection(stream) catch {};
                return;
            }
            const Runner = struct {
                fn run(s: *Self, st: std.Io.net.Stream, done: *std.Io.Event) void {
                    defer done.set(s.io);
                    s.handleConnection(st) catch {};
                }
            };
            var done: std.Io.Event = .unset;
            var fut = self.io.concurrent(Runner.run, .{ self, stream, &done }) catch {
                self.handleConnection(stream) catch {};
                return;
            };
            done.waitTimeout(self.io, .{
                .duration = .{ .clock = .awake, .raw = .fromMilliseconds(self.idle_timeout_ms) },
            }) catch |err| switch (err) {
                error.Timeout, error.Canceled => {},
            };
            fut.cancel(self.io);
        }

        pub fn handleConnection(self: *Self, stream: std.Io.net.Stream) !void {
            defer stream.close(self.io);

            var read_buf: [8192]u8 = undefined;
            var write_buf: [8192]u8 = undefined;

            var stream_reader = stream.reader(self.io, &read_buf);
            var stream_writer = stream.writer(self.io, &write_buf);

            try self.handleStream(&stream_reader.interface, &stream_writer.interface);
        }

        pub fn handleStream(self: *Self, in: *std.Io.Reader, out: *std.Io.Writer) !void {
            var http_server = std.http.Server.init(in, out);

            while (!self.stopped.load(.seq_cst)) {
                var req = http_server.receiveHead() catch return;

                var arena = std.heap.ArenaAllocator.init(self.gpa);
                defer arena.deinit();
                const aa = arena.allocator();

                if (req.head.method != .POST) {
                    try req.respond("Method Not Allowed", .{ .status = .method_not_allowed, .keep_alive = false });
                    return;
                }
                if (req.head.content_length == null and req.head.transfer_encoding != .chunked) {
                    try req.respond("Length Required", .{ .status = .length_required, .keep_alive = false });
                    return;
                }

                const req_target = try aa.dupe(u8, req.head.target);

                // Extract action from Content-Type or SOAPAction header
                // (Must happen BEFORE readerExpectContinue, which invalidates req.head strings)
                var action: ?[]const u8 = null;
                if (req.head.content_type) |ct| {
                    if (extractContentTypeAction(ct)) |act| {
                        action = try aa.dupe(u8, act);
                    }
                }

                var auth_header_val: ?[]const u8 = null;
                var it = req.iterateHeaders();
                while (it.next()) |h| {
                    if (action == null and std.ascii.eqlIgnoreCase(h.name, "SOAPAction")) {
                        const val = std.mem.trim(u8, h.value, " \t\"");
                        if (val.len > 0) action = try aa.dupe(u8, val);
                    } else if (auth_header_val == null and std.ascii.eqlIgnoreCase(h.name, "Authorization")) {
                        auth_header_val = try aa.dupe(u8, h.value);
                    }
                }

                // Read request body
                var body_transfer_buf: [2048]u8 = undefined;
                const body_reader = req.readerExpectContinue(&body_transfer_buf) catch |err| switch (err) {
                    error.HttpExpectationFailed => {
                        try req.respond("Expectation Failed", .{ .status = .expectation_failed, .keep_alive = false });
                        return;
                    },
                    error.WriteFailed => return error.WriteFailed,
                };

                const body_bytes = body_reader.allocRemaining(aa, .limited(1024 * 1024)) catch |err| switch (err) {
                    error.StreamTooLong => {
                        try req.respond("Payload Too Large", .{ .status = .payload_too_large, .keep_alive = false });
                        return;
                    },
                    else => {
                        try req.respond("Read body failed", .{ .status = .bad_request, .keep_alive = false });
                        return;
                    },
                };

                // Parse Envelope
                var body_stream: std.Io.Reader = .fixed(body_bytes);
                const env = soap.parseEnvelope(aa, &body_stream) catch {
                    try req.respond("Invalid SOAP Envelope", .{ .status = .bad_request, .keep_alive = false });
                    return;
                };

                const effective_action = if (action) |a| a else if (env.header.action) |ha| ha else null;

                if (self.auth_config) |auth_cfg| {
                    const public_fn = auth_cfg.is_public_op orelse AuthConfig.defaultIsPublicOp;
                    if (!public_fn(effective_action, env.body)) {
                        if (!self.verifyRequestAuth(auth_cfg, auth_header_val, req_target, env.header)) {
                            var c_sha_buf: [256]u8 = undefined;
                            var c_md5_buf: [256]u8 = undefined;
                            const chal_sha = auth_cfg.server_auth.formatChallenge(self.io, &c_sha_buf, .sha256);
                            const chal_md5 = auth_cfg.server_auth.formatChallenge(self.io, &c_md5_buf, .md5);
                            try req.respond("Unauthorized", .{
                                .status = .unauthorized,
                                .extra_headers = &.{
                                    .{ .name = "WWW-Authenticate", .value = chal_sha },
                                    .{ .name = "WWW-Authenticate", .value = chal_md5 },
                                },
                            });
                            if (!req.head.keep_alive) return;
                            continue;
                        }
                    }
                }

                // Dispatch to router
                const response_env_bytes = RouterType.dispatch(
                    self.handler,
                    aa,
                    effective_action,
                    env.body,
                ) catch |err| {
                    const fault_info = classifySoapFault(err);
                    const fault_xml = try std.fmt.allocPrint(
                        aa,
                        \\<s:Fault xmlns:s="http://www.w3.org/2003/05/soap-envelope">
                        \\  <s:Code>
                        \\    <s:Value>{s}</s:Value>
                        \\    {s}
                        \\  </s:Code>
                        \\  <s:Reason><s:Text xml:lang="en">{s}</s:Text></s:Reason>
                        \\</s:Fault>
                    ,
                        .{ fault_info.code, fault_info.subcode_xml, @errorName(err) },
                    );
                    const fault_env = try soap.buildEnvelope(aa, fault_xml, .{ .version = .soap12 });
                    try req.respond(fault_env, .{
                        .status = fault_info.http_status,
                        .extra_headers = &.{
                            .{ .name = "Content-Type", .value = "application/soap+xml; charset=utf-8" },
                        },
                    });
                    if (!req.head.keep_alive) return;
                    continue;
                };

                try req.respond(response_env_bytes, .{
                    .status = .ok,
                    .extra_headers = &.{
                        .{ .name = "Content-Type", .value = "application/soap+xml; charset=utf-8" },
                    },
                });

                if (!req.head.keep_alive) return;
            }
        }

        fn verifyRequestAuth(
            self: *Self,
            auth_cfg: AuthConfig,
            auth_header_val: ?[]const u8,
            req_target: []const u8,
            soap_header: soap.SoapHeader,
        ) bool {
            if (auth_cfg.allow_http_digest) {
                if (auth_header_val) |hdr| {
                    if (auth.DigestAuthorization.parse(hdr)) |parsed| {
                        if (auth_cfg.lookup_password(auth_cfg.ctx, parsed.username)) |pw| {
                            if (auth_cfg.server_auth.verifyDigest(self.io, parsed, "POST", req_target, pw)) {
                                return true;
                            }
                        }
                    }
                }
            }
            if (auth_cfg.allow_ws_security) {
                if (soap_header.username) |uname| {
                    if (auth_cfg.lookup_password(auth_cfg.ctx, uname)) |pw| {
                        if (soap.verifyUsernameToken(self.io, soap_header, pw, 300)) {
                            return true;
                        }
                    }
                }
            }
            return false;
        }

        const SoapFaultInfo = struct {
            http_status: std.http.Status,
            code: []const u8,
            subcode_xml: []const u8,
        };

        fn classifySoapFault(err: anyerror) SoapFaultInfo {
            return switch (err) {
                error.ActionNotSupported => .{
                    .http_status = .bad_request,
                    .code = "s:Sender",
                    .subcode_xml = "<s:Subcode><s:Value xmlns:wsa=\"http://www.w3.org/2005/08/addressing\">wsa:ActionNotSupported</s:Value></s:Subcode>",
                },
                error.ActionNotImplemented => .{
                    .http_status = .internal_server_error,
                    .code = "s:Receiver",
                    .subcode_xml = "",
                },
                error.MalformedXml, error.UnexpectedToken, error.MissingRequiredField, error.InvalidEnumValue, error.InvalidNumber => .{
                    .http_status = .bad_request,
                    .code = "s:Sender",
                    .subcode_xml = "",
                },
                else => .{
                    .http_status = .internal_server_error,
                    .code = "s:Receiver",
                    .subcode_xml = "",
                },
            };
        }

        fn extractContentTypeAction(ct: []const u8) ?[]const u8 {
            var parts = std.mem.splitScalar(u8, ct, ';');
            _ = parts.next(); // skip media-type
            while (parts.next()) |param| {
                const trimmed = std.mem.trim(u8, param, " \t");
                if (trimmed.len >= 7 and std.ascii.startsWithIgnoreCase(trimmed, "action=")) {
                    const raw_val = std.mem.trim(u8, trimmed[7..], " \t");
                    if (raw_val.len >= 2 and
                        ((raw_val[0] == '"' and raw_val[raw_val.len - 1] == '"') or
                            (raw_val[0] == '\'' and raw_val[raw_val.len - 1] == '\'')))
                    {
                        const unquoted = raw_val[1 .. raw_val.len - 1];
                        return if (unquoted.len > 0) unquoted else null;
                    }
                    return if (raw_val.len > 0) raw_val else null;
                }
            }
            return null;
        }
    };
}

test "Router dispatch test" {
    const spec = @import("../spec/generated.zig");

    const MockHandler = struct {
        pub fn GetSystemDateAndTime(
            _: *@This(),
            arena: std.mem.Allocator,
            _: spec.Device.GetSystemDateAndTime.Request,
        ) !spec.Device.GetSystemDateAndTime.Response {
            return .{
                .SystemDateAndTime = .{
                    .DateTimeType = .NTP,
                    .DaylightSavings = false,
                    .TimeZone = .{ .TZ = try arena.dupe(u8, "UTC") },
                    .UTCDateTime = .{
                        .Time = .{ .Hour = 12, .Minute = 0, .Second = 0 },
                        .Date = .{ .Year = 2026, .Month = 11, .Day = 25 },
                    },
                },
            };
        }
    };

    var handler: MockHandler = .{};
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const R = Router(MockHandler, &.{spec.Device});

    const req_xml =
        \\<tds:GetSystemDateAndTime xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
    ;

    const resp_env = try R.dispatch(
        &handler,
        arena.allocator(),
        "http://www.onvif.org/ver10/device/wsdl/GetSystemDateAndTime",
        req_xml,
    );

    try std.testing.expect(std.mem.indexOf(u8, resp_env, "GetSystemDateAndTimeResponse") != null);
    try std.testing.expect(std.mem.indexOf(u8, resp_env, "NTP") != null);
}
