const std = @import("std");
const soap = @import("../soap.zig");
const auth = @import("auth.zig");
const codec = @import("../codec.zig");
const xml = struct {
    pub const Reader = @import("../xml/Reader.zig").Reader;
    pub const Writer = @import("../xml/Writer.zig").Writer;
};
const xml_any = @import("../xml/Any.zig");

pub const Credentials = struct {
    username: []const u8,
    password: []const u8,
    auth_mode: AuthMode = .ws_security,

    pub const AuthMode = enum {
        ws_security,
        http_digest,
        both,
    };
};

pub const CallOptions = struct {
    timeout_ms: u32 = 10000,
    soap_version: soap.SoapVersion = .soap12,
    credentials: ?Credentials = null,
    ws_addressing: bool = true,
};

pub const ClientError = error{
    Timeout,
    HttpError,
    SoapFault,
    InvalidResponse,
    AuthenticationFailed,
    ConnectionFailed,
    InvalidHeaderValue,
    Canceled,
} || std.mem.Allocator.Error || std.Io.Reader.Error || std.Io.Writer.Error || codec.CodecError;

pub const Client = struct {
    allocator: std.mem.Allocator,
    io: std.Io,
    http_client: std.http.Client,

    pub fn init(allocator: std.mem.Allocator, io: std.Io) Client {
        return .{
            .allocator = allocator,
            .io = io,
            .http_client = .{
                .allocator = allocator,
                .io = io,
            },
        };
    }

    pub fn deinit(self: *Client) void {
        self.http_client.deinit();
    }

    /// Calls a typed ONVIF operation `Op`.
    /// `Op` must declare:
    /// - `pub const soap_action = "..."`
    /// - `pub const request_name = "..."`
    /// - `pub const namespace = "..."`
    /// - `pub const Request = struct { ... }`
    /// - `pub const Response = struct { ... }`
    pub fn call(
        self: *Client,
        comptime Op: type,
        arena: std.mem.Allocator,
        endpoint: std.Uri,
        req: Op.Request,
        opts: CallOptions,
    ) ClientError!Op.Response {
        if (opts.timeout_ms == 0) {
            return self.callDirect(Op, arena, endpoint, req, opts);
        }

        const Runner = struct {
            fn run(
                c: *Client,
                a: std.mem.Allocator,
                ep: std.Uri,
                r: Op.Request,
                o: CallOptions,
                done: *std.Io.Event,
            ) ClientError!Op.Response {
                defer done.set(c.io);
                return c.callDirect(Op, a, ep, r, o);
            }
        };

        var done: std.Io.Event = .unset;
        var fut = self.io.concurrent(Runner.run, .{ self, arena, endpoint, req, opts, &done }) catch |err| switch (err) {
            error.ConcurrencyUnavailable => return self.callDirect(Op, arena, endpoint, req, opts),
        };

        done.waitTimeout(self.io, .{
            .duration = .{ .clock = .awake, .raw = .fromMilliseconds(opts.timeout_ms) },
        }) catch |err| switch (err) {
            error.Timeout => {
                return fut.cancel(self.io) catch return error.Timeout;
            },
            error.Canceled => {
                _ = fut.cancel(self.io) catch {};
                return error.Canceled;
            },
        };

        return fut.await(self.io);
    }

    fn callDirect(
        self: *Client,
        comptime Op: type,
        arena: std.mem.Allocator,
        endpoint: std.Uri,
        req: Op.Request,
        opts: CallOptions,
    ) ClientError!Op.Response {
        // 1. Serialize request struct to XML
        var req_xml_out: std.Io.Writer.Allocating = .init(arena);
        defer req_xml_out.deinit();

        var xml_w = xml.Writer.init(arena, &req_xml_out.writer);
        defer xml_w.deinit();

        try codec.encode(Op.Request, req, &xml_w, Op.request_name, Op.namespace);
        try xml_w.flush();
        const req_body_xml = req_xml_out.written();

        // 2. Prepare SOAP envelope options
        var env_opts: soap.EnvelopeOptions = .{
            .version = opts.soap_version,
        };

        if (opts.ws_addressing) {
            env_opts.action = Op.soap_action;
            // Format endpoint URI to string
            var to_out: std.Io.Writer.Allocating = .init(arena);
            defer to_out.deinit();
            try endpoint.format(&to_out.writer);
            env_opts.to = try arena.dupe(u8, to_out.written());
        }

        if (opts.credentials) |creds| {
            if (creds.auth_mode == .ws_security or creds.auth_mode == .both) {
                env_opts.security = try soap.createUsernameToken(self.io, arena, creds.username, creds.password);
            }
        }

        const envelope_bytes = try soap.buildEnvelope(arena, req_body_xml, env_opts);

        // 3. Perform HTTP request (with optional Digest Auth retry)
        return try self.executeHttpRequest(Op, arena, endpoint, envelope_bytes, opts);
    }

    fn executeHttpRequest(
        self: *Client,
        comptime Op: type,
        arena: std.mem.Allocator,
        endpoint: std.Uri,
        payload: []const u8,
        opts: CallOptions,
    ) ClientError!Op.Response {
        const content_type = if (opts.soap_version == .soap12)
            try std.fmt.allocPrint(arena, "application/soap+xml; charset=utf-8; action=\"{s}\"", .{Op.soap_action})
        else
            "text/xml; charset=utf-8";

        var auth_header: ?[]const u8 = null;
        var retried_auth = false;
        var retried_stale = false;

        while (true) {
            var extra_headers_list: std.ArrayList(std.http.Header) = .empty;
            defer extra_headers_list.deinit(arena);

            if (opts.soap_version == .soap11) {
                const soap_action_header = try std.fmt.allocPrint(arena, "\"{s}\"", .{Op.soap_action});
                try extra_headers_list.append(arena, .{ .name = "SOAPAction", .value = soap_action_header });
            }

            if (auth_header) |ah| {
                try extra_headers_list.append(arena, .{ .name = "Authorization", .value = ah });
            }

            const req_opts: std.http.Client.RequestOptions = .{
                .headers = .{
                    .content_type = .{ .override = content_type },
                    .accept_encoding = .omit,
                },
                .extra_headers = extra_headers_list.items,
            };

            var request = self.http_client.request(.POST, endpoint, req_opts) catch |err| switch (err) {
                error.Canceled => return error.Canceled,
                error.ConnectionRefused, error.NetworkUnreachable, error.HostUnreachable => return error.ConnectionFailed,
                else => return error.HttpError,
            };
            defer request.deinit();

            request.sendBodyComplete(@constCast(payload)) catch |err| switch (err) {
                error.WriteFailed => {
                    if (request.connection) |conn| {
                        if (conn.stream_writer.err) |e| if (e == error.Canceled) return error.Canceled;
                    }
                    if (!retried_stale) {
                        retried_stale = true;
                        continue;
                    }
                    return error.WriteFailed;
                },
            };

            var redirect_buf: [1024]u8 = undefined;
            var response = request.receiveHead(&redirect_buf) catch |err| switch (err) {
                error.ReadFailed => {
                    if (request.connection) |conn| {
                        if (conn.getReadError()) |e| if (e == error.Canceled) return error.Canceled;
                    }
                    if (!retried_stale) {
                        retried_stale = true;
                        continue;
                    }
                    return error.HttpError;
                },
                error.WriteFailed => {
                    if (request.connection) |conn| {
                        if (conn.stream_writer.err) |e| if (e == error.Canceled) return error.Canceled;
                    }
                    if (!retried_stale) {
                        retried_stale = true;
                        continue;
                    }
                    return error.HttpError;
                },
                error.HttpConnectionClosing => {
                    if (!retried_stale) {
                        retried_stale = true;
                        continue;
                    }
                    return error.HttpError;
                },
                else => return error.HttpError,
            };

            const status = response.head.status;

            // Check for 401 Unauthorized -> HTTP Digest Retry
            if (status == .unauthorized and !retried_auth and opts.credentials != null) {
                const creds = opts.credentials.?;
                if (creds.auth_mode == .http_digest or creds.auth_mode == .both) {
                    var parsed_challenge: ?auth.DigestChallenge = null;
                    var it = response.head.iterateHeaders();
                    while (it.next()) |h| {
                        if (std.ascii.eqlIgnoreCase(h.name, "WWW-Authenticate")) {
                            const duped = try arena.dupe(u8, h.value);
                            if (auth.DigestChallenge.parse(duped)) |challenge| {
                                parsed_challenge = challenge;
                                break;
                            }
                        }
                    }

                    if (parsed_challenge) |challenge| {
                        const path = if (endpoint.path.percent_encoded.len > 0)
                            endpoint.path.percent_encoded
                        else
                            "/";
                        const digest_uri = if (endpoint.query) |q|
                            try std.fmt.allocPrint(arena, "{s}?{s}", .{ path, q.percent_encoded })
                        else
                            path;

                        var cnonce_bytes: [8]u8 = undefined;
                        self.io.random(&cnonce_bytes);
                        const cnonce_hex = std.fmt.bytesToHex(cnonce_bytes, .lower);

                        auth_header = auth.createAuthorizationHeader(
                            arena,
                            challenge,
                            creds.username,
                            creds.password,
                            "POST",
                            digest_uri,
                            1,
                            &cnonce_hex,
                        ) catch |err| switch (err) {
                            error.InvalidHeaderValue => return error.AuthenticationFailed,
                            else => |e| return e,
                        };
                        retried_auth = true;
                        continue;
                    }
                }
                return error.AuthenticationFailed;
            }
            if (status == .unauthorized) return error.AuthenticationFailed;

            // Read response body
            var transfer_buf: [4096]u8 = undefined;
            const body_reader = response.reader(&transfer_buf);

            const body_bytes = body_reader.allocRemaining(arena, .limited(10 * 1024 * 1024)) catch |err| switch (err) {
                error.ReadFailed => {
                    if (request.connection) |conn| {
                        if (conn.getReadError()) |e| if (e == error.Canceled) return error.Canceled;
                    }
                    return error.ReadFailed;
                },
                else => return error.InvalidResponse,
            };

            var body_stream: std.Io.Reader = .fixed(body_bytes);
            // Parse SOAP Envelope
            const parsed_envelope = soap.parseEnvelope(arena, &body_stream) catch {
                return error.InvalidResponse;
            };

            // If Fault returned
            if (parsed_envelope.is_fault or parsed_envelope.fault != null) {
                return error.SoapFault;
            }

            if (status != .ok) {
                return error.HttpError;
            }

            // Decode Op.Response from envelope body
            var body_xml_reader_stream: std.Io.Reader = .fixed(parsed_envelope.body);
            var body_xml_reader = xml.Reader.init(arena, &body_xml_reader_stream);
            defer body_xml_reader.deinit();

            return try codec.decode(Op.Response, &body_xml_reader, arena);
        }

        unreachable;
    }
};

test "Client initialization and deinitialization" {
    const io = std.testing.io;
    const gpa = std.testing.allocator;

    var client = Client.init(gpa, io);
    defer client.deinit();
}
