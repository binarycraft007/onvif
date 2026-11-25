const std = @import("std");
const onvif = @import("../root.zig");
const gen = onvif.spec;
const schema = gen.schema;
const codec = onvif.codec;
const soap = onvif.soap;
const Router = onvif.transport.Router;
const xml = onvif.xml;

fn verifyService(comptime Service: type) usize {
    var count: usize = 0;
    inline for (@typeInfo(Service).@"struct".decl_names) |decl_name| {
        const Op = @field(Service, decl_name);
        if (@TypeOf(Op) == type and
            @typeInfo(Op) == .@"struct" and
            @hasDecl(Op, "soap_action") and
            @hasDecl(Op, "Request") and
            @hasDecl(Op, "Response"))
        {
            count += 1;
            const req: Op.Request = .{};
            _ = req;
            const resp: Op.Response = .{};
            _ = resp;
        }
    }
    return count;
}

test "all generated service operations can default initialize" {
    const dev_count = verifyService(gen.Device);
    const med_count = verifyService(gen.Media);
    const ptz_count = verifyService(gen.PTZ);
    const img_count = verifyService(gen.Imaging);
    const evt_count = verifyService(gen.Event);
    const dio_count = verifyService(gen.DeviceIO);

    try std.testing.expectEqual(@as(usize, 103), dev_count);
    try std.testing.expectEqual(@as(usize, 79), med_count);
    try std.testing.expectEqual(@as(usize, 29), ptz_count);
    try std.testing.expectEqual(@as(usize, 11), img_count);
    try std.testing.expectEqual(@as(usize, 10), evt_count);
    try std.testing.expectEqual(@as(usize, 29), dio_count);
    try std.testing.expectEqual(@as(usize, 261), dev_count + med_count + ptz_count + img_count + evt_count + dio_count);
}

test "codec encode/decode Device.GetDeviceInformation" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const Op = gen.Device.GetDeviceInformation;
    const original: Op.Response = .{
        .Manufacturer = "Antigravity Cam Corp",
        .Model = "AG-PTZ-8K",
        .FirmwareVersion = "v2.1.0-alpha",
        .SerialNumber = "SN-9876543210",
        .HardwareId = "HW-REV-B",
    };

    var out: std.Io.Writer.Allocating = .init(alloc);
    defer out.deinit();
    var writer = xml.Writer.init(alloc, &out.writer);
    defer writer.deinit();

    try codec.encode(Op.Response, original, &writer, Op.response_name, Op.namespace);
    try writer.flush();
    try out.writer.flush();
    const xml_text = out.written();

    var reader_st = std.Io.Reader.fixed(xml_text);
    var reader = xml.Reader.init(alloc, &reader_st);
    defer reader.deinit();

    const decoded = try codec.decode(Op.Response, &reader, alloc);

    try std.testing.expectEqualStrings(original.Manufacturer, decoded.Manufacturer);
    try std.testing.expectEqualStrings(original.Model, decoded.Model);
    try std.testing.expectEqualStrings(original.FirmwareVersion, decoded.FirmwareVersion);
    try std.testing.expectEqualStrings(original.SerialNumber, decoded.SerialNumber);
    try std.testing.expectEqualStrings(original.HardwareId, decoded.HardwareId);
}

test "codec encode/decode Media.GetProfiles" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const Op = gen.Media.GetProfiles;
    const profiles = [_]schema.Profile{
        .{
            .token = "ProfileToken_1",
            .fixed = true,
            .Name = "MainStream_4K",
            .VideoEncoderConfiguration = .{
                .token = "VEC_Token_1",
                .Name = "H264_4K",
                .UseCount = 1,
                .Encoding = .H264,
                .Resolution = .{
                    .Width = 3840,
                    .Height = 2160,
                },
                .Quality = 5.0,
                .RateControl = .{
                    .FrameRateLimit = 60,
                    .EncodingInterval = 1,
                    .BitrateLimit = 16384,
                },
            },
        },
        .{
            .token = "ProfileToken_2",
            .fixed = false,
            .Name = "SubStream_720p",
            .VideoEncoderConfiguration = .{
                .token = "VEC_Token_2",
                .Name = "H264_720p",
                .UseCount = 1,
                .Encoding = .H264,
                .Resolution = .{
                    .Width = 1280,
                    .Height = 720,
                },
                .Quality = 3.0,
            },
        },
    };

    const original: Op.Response = .{
        .Profiles = &profiles,
    };

    var out: std.Io.Writer.Allocating = .init(alloc);
    defer out.deinit();
    var writer = xml.Writer.init(alloc, &out.writer);
    defer writer.deinit();

    try codec.encode(Op.Response, original, &writer, Op.response_name, Op.namespace);
    try writer.flush();
    try out.writer.flush();
    const xml_text = out.written();

    var reader_st = std.Io.Reader.fixed(xml_text);
    var reader = xml.Reader.init(alloc, &reader_st);
    defer reader.deinit();

    const decoded = try codec.decode(Op.Response, &reader, alloc);

    try std.testing.expectEqual(@as(usize, 2), decoded.Profiles.len);
    try std.testing.expectEqualStrings("ProfileToken_1", decoded.Profiles[0].token);
    try std.testing.expectEqual(true, decoded.Profiles[0].fixed);
    try std.testing.expectEqualStrings("MainStream_4K", decoded.Profiles[0].Name);
    try std.testing.expect(decoded.Profiles[0].VideoEncoderConfiguration != null);
    const vec1 = decoded.Profiles[0].VideoEncoderConfiguration.?;
    try std.testing.expectEqual(@as(i32, 3840), vec1.Resolution.Width);
    try std.testing.expectEqual(@as(i32, 2160), vec1.Resolution.Height);
    try std.testing.expect(vec1.RateControl != null);
    try std.testing.expectEqual(@as(i32, 60), vec1.RateControl.?.FrameRateLimit);

    try std.testing.expectEqualStrings("ProfileToken_2", decoded.Profiles[1].token);
    try std.testing.expectEqual(false, decoded.Profiles[1].fixed);
    try std.testing.expectEqualStrings("SubStream_720p", decoded.Profiles[1].Name);
    try std.testing.expect(decoded.Profiles[1].VideoEncoderConfiguration != null);
    const vec2 = decoded.Profiles[1].VideoEncoderConfiguration.?;
    try std.testing.expectEqual(@as(i32, 1280), vec2.Resolution.Width);
    try std.testing.expectEqual(@as(i32, 720), vec2.Resolution.Height);
}

test "codec encode/decode PTZ.ContinuousMove" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const Op = gen.PTZ.ContinuousMove;
    const original: Op.Request = .{
        .ProfileToken = "Profile_PTZ_1",
        .Velocity = .{
            .PanTilt = .{
                .x = 0.75,
                .y = -0.5,
                .space = "http://www.onvif.org/ver10/tptz/PanTiltSpaces/VelocityGenericSpace",
            },
            .Zoom = .{
                .x = 0.25,
            },
        },
    };

    var out: std.Io.Writer.Allocating = .init(alloc);
    defer out.deinit();
    var writer = xml.Writer.init(alloc, &out.writer);
    defer writer.deinit();

    try codec.encode(Op.Request, original, &writer, Op.request_name, Op.namespace);
    try writer.flush();
    try out.writer.flush();
    const xml_text = out.written();

    var reader_st = std.Io.Reader.fixed(xml_text);
    var reader = xml.Reader.init(alloc, &reader_st);
    defer reader.deinit();

    const decoded = try codec.decode(Op.Request, &reader, alloc);

    try std.testing.expectEqualStrings("Profile_PTZ_1", decoded.ProfileToken);
    try std.testing.expect(decoded.Velocity.PanTilt != null);
    try std.testing.expectApproxEqAbs(@as(f32, 0.75), decoded.Velocity.PanTilt.?.x, 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, -0.5), decoded.Velocity.PanTilt.?.y, 0.0001);
    try std.testing.expectEqualStrings("http://www.onvif.org/ver10/tptz/PanTiltSpaces/VelocityGenericSpace", decoded.Velocity.PanTilt.?.space.?);
    try std.testing.expect(decoded.Velocity.Zoom != null);
    try std.testing.expectApproxEqAbs(@as(f32, 0.25), decoded.Velocity.Zoom.?.x, 0.0001);
}

test "Router dispatch with generated Device and Media services" {
    const MockHandler = struct {
        pub fn GetDeviceInformation(
            _: *@This(),
            arena: std.mem.Allocator,
            _: gen.Device.GetDeviceInformation.Request,
        ) !gen.Device.GetDeviceInformation.Response {
            _ = arena;
            return .{
                .Manufacturer = "Antigravity Systems",
                .Model = "AG-PTZ-Camera",
                .FirmwareVersion = "v3.0.0",
                .SerialNumber = "AG-8888-9999",
                .HardwareId = "HW-001-A",
            };
        }

        pub fn GetProfiles(
            _: *@This(),
            arena: std.mem.Allocator,
            _: gen.Media.GetProfiles.Request,
        ) !gen.Media.GetProfiles.Response {
            _ = arena;
            return .{
                .Profiles = &.{
                    .{
                        .token = "MainProfile",
                        .Name = "MainStream",
                    },
                },
            };
        }
    };

    var handler: MockHandler = .{};
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const R = Router(MockHandler, &.{ gen.Device, gen.Media });

    // 1. Dispatch GetDeviceInformation
    const dev_info_req =
        \\<tds:GetDeviceInformation xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
    ;
    const dev_info_resp = try R.dispatch(
        &handler,
        arena.allocator(),
        "http://www.onvif.org/ver10/device/wsdl/GetDeviceInformation",
        dev_info_req,
    );

    try std.testing.expect(std.mem.indexOf(u8, dev_info_resp, "GetDeviceInformationResponse") != null);
    try std.testing.expect(std.mem.indexOf(u8, dev_info_resp, "Antigravity Systems") != null);
    try std.testing.expect(std.mem.indexOf(u8, dev_info_resp, "AG-PTZ-Camera") != null);

    // 2. Dispatch GetProfiles
    const profiles_req =
        \\<trt:GetProfiles xmlns:trt="http://www.onvif.org/ver10/media/wsdl" />
    ;
    const profiles_resp = try R.dispatch(
        &handler,
        arena.allocator(),
        "http://www.onvif.org/ver10/media/wsdl/GetProfiles",
        profiles_req,
    );

    try std.testing.expect(std.mem.indexOf(u8, profiles_resp, "GetProfilesResponse") != null);
    try std.testing.expect(std.mem.indexOf(u8, profiles_resp, "MainProfile") != null);
    try std.testing.expect(std.mem.indexOf(u8, profiles_resp, "MainStream") != null);
}

test "Client to Server end-to-end GetDeviceInformation over HTTP" {
    const io = std.testing.io;
    const gpa = std.testing.allocator;

    const MockHandler = struct {
        pub fn GetDeviceInformation(
            _: *@This(),
            arena: std.mem.Allocator,
            _: gen.Device.GetDeviceInformation.Request,
        ) !gen.Device.GetDeviceInformation.Response {
            _ = arena;
            return .{
                .Manufacturer = "Antigravity Systems",
                .Model = "AG-PTZ-Camera",
                .FirmwareVersion = "v3.0.0",
                .SerialNumber = "AG-8888-9999",
                .HardwareId = "HW-001-A",
            };
        }
    };

    var handler: MockHandler = .{};
    const ServerType = onvif.transport.Server(MockHandler, &.{gen.Device});
    var server = ServerType.init(io, gpa, &handler, std.Io.net.IpAddress{ .ip4 = std.Io.net.Ip4Address.loopback(0) });
    defer server.deinit();

    try server.listen();
    const bound = server.getBoundAddress().?;
    const port = bound.ip4.port;

    const Worker = struct {
        fn run(s: *ServerType) void {
            const stream = s.accept() catch return;
            s.handleConnection(stream) catch {};
        }
    };

    const thread = try std.Thread.spawn(.{}, Worker.run, .{&server});
    defer thread.join();

    var client = onvif.transport.Client.init(gpa, io);
    defer client.deinit();

    var uri_buf: [128]u8 = undefined;
    const uri_str = try std.fmt.bufPrint(&uri_buf, "http://127.0.0.1:{d}/onvif/device_service", .{port});
    const device_uri = try std.Uri.parse(uri_str);

    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();

    const info = try client.call(
        gen.Device.GetDeviceInformation,
        arena.allocator(),
        device_uri,
        .{},
        .{
            .timeout_ms = 5000,
            .credentials = .{
                .username = "admin",
                .password = "pass1234",
                .auth_mode = .ws_security,
            },
        },
    );

    try std.testing.expectEqualStrings("Antigravity Systems", info.Manufacturer);
    try std.testing.expectEqualStrings("AG-PTZ-Camera", info.Model);
    try std.testing.expectEqualStrings("v3.0.0", info.FirmwareVersion);
    try std.testing.expectEqualStrings("AG-8888-9999", info.SerialNumber);
}

test "Client to Server end-to-end SOAP 1.1 with SOAPAction" {
    const io = std.testing.io;
    const gpa = std.testing.allocator;

    const MockHandler = struct {
        pub fn GetProfiles(
            _: *@This(),
            arena: std.mem.Allocator,
            _: gen.Media.GetProfiles.Request,
        ) !gen.Media.GetProfiles.Response {
            _ = arena;
            return .{
                .Profiles = &.{
                    .{
                        .token = "Profile_SOAP11",
                        .Name = "SOAP11_Stream",
                    },
                },
            };
        }
    };

    var handler: MockHandler = .{};
    const ServerType = onvif.transport.Server(MockHandler, &.{gen.Media});
    var server = ServerType.init(io, gpa, &handler, std.Io.net.IpAddress{ .ip4 = std.Io.net.Ip4Address.loopback(0) });
    defer server.deinit();

    try server.listen();
    const bound = server.getBoundAddress().?;
    const port = bound.ip4.port;

    const Worker = struct {
        fn run(s: *ServerType) void {
            const stream = s.accept() catch return;
            s.handleConnection(stream) catch {};
        }
    };

    const thread = try std.Thread.spawn(.{}, Worker.run, .{&server});
    defer thread.join();

    var client = onvif.transport.Client.init(gpa, io);
    defer client.deinit();

    var uri_buf: [128]u8 = undefined;
    const uri_str = try std.fmt.bufPrint(&uri_buf, "http://127.0.0.1:{d}/onvif/media_service", .{port});
    const media_uri = try std.Uri.parse(uri_str);

    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();

    const resp = try client.call(
        gen.Media.GetProfiles,
        arena.allocator(),
        media_uri,
        .{},
        .{
            .soap_version = .soap11,
            .timeout_ms = 5000,
        },
    );

    try std.testing.expectEqual(@as(usize, 1), resp.Profiles.len);
    try std.testing.expectEqualStrings("Profile_SOAP11", resp.Profiles[0].token);
    try std.testing.expectEqualStrings("SOAP11_Stream", resp.Profiles[0].Name);
}

test "Client to Server error handling and SOAP Fault" {
    const io = std.testing.io;
    const gpa = std.testing.allocator;

    const MockHandler = struct {
        pub fn GetDeviceInformation(
            _: *@This(),
            arena: std.mem.Allocator,
            _: gen.Device.GetDeviceInformation.Request,
        ) !gen.Device.GetDeviceInformation.Response {
            _ = arena;
            return error.ActionNotSupported;
        }
    };

    var handler: MockHandler = .{};
    const ServerType = onvif.transport.Server(MockHandler, &.{gen.Device});
    var server = ServerType.init(io, gpa, &handler, std.Io.net.IpAddress{ .ip4 = std.Io.net.Ip4Address.loopback(0) });
    defer server.deinit();

    try server.listen();
    const bound = server.getBoundAddress().?;
    const port = bound.ip4.port;

    const Worker = struct {
        fn run(s: *ServerType) void {
            const stream = s.accept() catch return;
            s.handleConnection(stream) catch {};
        }
    };

    const thread = try std.Thread.spawn(.{}, Worker.run, .{&server});
    defer thread.join();

    var client = onvif.transport.Client.init(gpa, io);
    defer client.deinit();

    var uri_buf: [128]u8 = undefined;
    const uri_str = try std.fmt.bufPrint(&uri_buf, "http://127.0.0.1:{d}/onvif/device_service", .{port});
    const device_uri = try std.Uri.parse(uri_str);

    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();

    const result = client.call(
        gen.Device.GetDeviceInformation,
        arena.allocator(),
        device_uri,
        .{},
        .{ .timeout_ms = 5000 },
    );

    try std.testing.expectError(error.SoapFault, result);
}

test "Client timeout handling" {
    const io = std.testing.io;
    const gpa = std.testing.allocator;

    const socket = try (std.Io.net.IpAddress{ .ip4 = std.Io.net.Ip4Address.loopback(0) }).listen(io, .{ .mode = .stream });
    const bound = socket.socket.address;
    const port = bound.ip4.port;

    const DelayWorker = struct {
        fn run(srv: *std.Io.net.Server, srv_io: std.Io) void {
            var stream = srv.accept(srv_io) catch return;
            defer stream.close(srv_io);
            const dur = std.Io.Duration.fromMilliseconds(500);
            _ = srv_io.sleep(dur, .awake) catch {};
        }
    };

    var srv_copy = socket;
    defer srv_copy.deinit(io);

    const thread = try std.Thread.spawn(.{}, DelayWorker.run, .{ &srv_copy, io });
    defer thread.join();

    var client = onvif.transport.Client.init(gpa, io);
    defer client.deinit();

    var uri_buf: [128]u8 = undefined;
    const uri_str = try std.fmt.bufPrint(&uri_buf, "http://127.0.0.1:{d}/onvif/device_service", .{port});
    const device_uri = try std.Uri.parse(uri_str);

    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();

    const result = client.call(
        gen.Device.GetDeviceInformation,
        arena.allocator(),
        device_uri,
        .{},
        .{ .timeout_ms = 50 },
    );

    try std.testing.expectError(error.Timeout, result);
}

test "Client callDirect with timeout_ms = 0" {
    const io = std.testing.io;
    const gpa = std.testing.allocator;

    const MockHandler = struct {
        pub fn GetDeviceInformation(
            _: *@This(),
            arena: std.mem.Allocator,
            _: gen.Device.GetDeviceInformation.Request,
        ) !gen.Device.GetDeviceInformation.Response {
            _ = arena;
            return .{
                .Manufacturer = "DirectCall-Mfr",
                .Model = "DirectCall-Model",
            };
        }
    };

    var handler: MockHandler = .{};
    const ServerType = onvif.transport.Server(MockHandler, &.{gen.Device});
    var server = ServerType.init(io, gpa, &handler, std.Io.net.IpAddress{ .ip4 = std.Io.net.Ip4Address.loopback(0) });
    defer server.deinit();

    try server.listen();
    const bound = server.getBoundAddress().?;
    const port = bound.ip4.port;

    const Worker = struct {
        fn run(s: *ServerType) void {
            const stream = s.accept() catch return;
            s.handleConnection(stream) catch {};
        }
    };

    const thread = try std.Thread.spawn(.{}, Worker.run, .{&server});
    defer thread.join();

    var client = onvif.transport.Client.init(gpa, io);
    defer client.deinit();

    var uri_buf: [128]u8 = undefined;
    const uri_str = try std.fmt.bufPrint(&uri_buf, "http://127.0.0.1:{d}/onvif/device_service", .{port});
    const device_uri = try std.Uri.parse(uri_str);

    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();

    const info = try client.call(
        gen.Device.GetDeviceInformation,
        arena.allocator(),
        device_uri,
        .{},
        .{ .timeout_ms = 0 },
    );

    try std.testing.expectEqualStrings("DirectCall-Mfr", info.Manufacturer);
    try std.testing.expectEqualStrings("DirectCall-Model", info.Model);
}

test "Client to Server end-to-end HTTP Digest Auth 401 challenge and retry" {
    const io = std.testing.io;
    const gpa = std.testing.allocator;

    const socket = try (std.Io.net.IpAddress{ .ip4 = std.Io.net.Ip4Address.loopback(0) }).listen(io, .{ .mode = .stream });
    const bound = socket.socket.address;
    const port = bound.ip4.port;

    const DigestAuthWorker = struct {
        fn run(srv: *std.Io.net.Server, srv_io: std.Io) void {
            // First request: return 401 Unauthorized with WWW-Authenticate
            {
                var stream1 = srv.accept(srv_io) catch return;
                defer stream1.close(srv_io);

                var r_buf: [2048]u8 = undefined;
                var w_buf: [2048]u8 = undefined;
                var r = stream1.reader(srv_io, &r_buf);
                var w = stream1.writer(srv_io, &w_buf);
                var http_srv = std.http.Server.init(&r.interface, &w.interface);

                var req = http_srv.receiveHead() catch return;
                var body_buf: [1024]u8 = undefined;
                _ = req.readerExpectNone(&body_buf).discardRemaining() catch {};

                req.respond("Unauthorized", .{
                    .status = .unauthorized,
                    .extra_headers = &.{
                        .{ .name = "WWW-Authenticate", .value = "Digest realm=\"onvif\", nonce=\"testnonce1234\", qop=\"auth\"" },
                    },
                    .keep_alive = true,
                }) catch return;
            }

            // Second request: client retries with Authorization: Digest ...
            {
                var stream2 = srv.accept(srv_io) catch return;
                defer stream2.close(srv_io);

                var r_buf: [2048]u8 = undefined;
                var w_buf: [2048]u8 = undefined;
                var r = stream2.reader(srv_io, &r_buf);
                var w = stream2.writer(srv_io, &w_buf);
                var http_srv = std.http.Server.init(&r.interface, &w.interface);

                var req = http_srv.receiveHead() catch return;
                var auth_found = false;
                var it = req.iterateHeaders();
                while (it.next()) |h| {
                    if (std.ascii.eqlIgnoreCase(h.name, "Authorization")) {
                        if (std.mem.indexOf(u8, h.value, "Digest") != null and
                            std.mem.indexOf(u8, h.value, "testnonce1234") != null)
                        {
                            auth_found = true;
                        }
                    }
                }

                var body_buf: [1024]u8 = undefined;
                _ = req.readerExpectNone(&body_buf).discardRemaining() catch {};

                if (auth_found) {
                    const resp_body =
                        \\<s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope" xmlns:tds="http://www.onvif.org/ver10/device/wsdl">
                        \\  <s:Body>
                        \\    <tds:GetDeviceInformationResponse>
                        \\      <tds:Manufacturer>DigestAuthMfr</tds:Manufacturer>
                        \\      <tds:Model>DigestAuthModel</tds:Model>
                        \\      <tds:FirmwareVersion>v1.0</tds:FirmwareVersion>
                        \\      <tds:SerialNumber>SN-DIGEST</tds:SerialNumber>
                        \\      <tds:HardwareId>HW-DIGEST</tds:HardwareId>
                        \\    </tds:GetDeviceInformationResponse>
                        \\  </s:Body>
                        \\</s:Envelope>
                    ;
                    req.respond(resp_body, .{
                        .status = .ok,
                        .extra_headers = &.{
                            .{ .name = "Content-Type", .value = "application/soap+xml; charset=utf-8" },
                        },
                    }) catch return;
                } else {
                    req.respond("Forbidden", .{ .status = .forbidden }) catch return;
                }
            }
        }
    };

    var srv_copy = socket;

    const thread = try std.Thread.spawn(.{}, DigestAuthWorker.run, .{ &srv_copy, io });
    // LIFO: thread.join() runs AFTER srv_copy.deinit(io) unblocks accept()
    defer thread.join();
    defer srv_copy.deinit(io);

    var client = onvif.transport.Client.init(gpa, io);
    defer client.deinit();

    var uri_buf: [128]u8 = undefined;
    const uri_str = try std.fmt.bufPrint(&uri_buf, "http://127.0.0.1:{d}/onvif/device_service", .{port});
    const device_uri = try std.Uri.parse(uri_str);

    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();

    const info = try client.call(
        gen.Device.GetDeviceInformation,
        arena.allocator(),
        device_uri,
        .{},
        .{
            .timeout_ms = 5000,
            .credentials = .{
                .username = "admin",
                .password = "secret",
                .auth_mode = .http_digest,
            },
        },
    );

    try std.testing.expectEqualStrings("DigestAuthMfr", info.Manufacturer);
    try std.testing.expectEqualStrings("DigestAuthModel", info.Model);
}

test "Client to Server multiple sequential requests on same client" {
    const io = std.testing.io;
    const gpa = std.testing.allocator;

    const MockHandler = struct {
        pub fn GetDeviceInformation(
            _: *@This(),
            arena: std.mem.Allocator,
            _: gen.Device.GetDeviceInformation.Request,
        ) !gen.Device.GetDeviceInformation.Response {
            _ = arena;
            return .{
                .Manufacturer = "MultiSeqMfr",
                .Model = "MultiSeqModel",
            };
        }

        pub fn GetProfiles(
            _: *@This(),
            arena: std.mem.Allocator,
            _: gen.Media.GetProfiles.Request,
        ) !gen.Media.GetProfiles.Response {
            _ = arena;
            return .{
                .Profiles = &.{
                    .{ .token = "SeqProfile", .Name = "SeqStream" },
                },
            };
        }
    };

    var handler: MockHandler = .{};
    const ServerType = onvif.transport.Server(MockHandler, &.{ gen.Device, gen.Media });
    var server = ServerType.init(io, gpa, &handler, std.Io.net.IpAddress{ .ip4 = std.Io.net.Ip4Address.loopback(0) });
    defer server.deinit();

    try server.listen();
    const bound = server.getBoundAddress().?;
    const port = bound.ip4.port;

    const MultiWorker = struct {
        fn run(s: *ServerType) void {
            const stream = s.accept() catch return;
            s.handleConnection(stream) catch {};
        }
    };

    const thread = try std.Thread.spawn(.{}, MultiWorker.run, .{&server});

    var client = onvif.transport.Client.init(gpa, io);

    var uri_buf: [128]u8 = undefined;
    const uri_str = try std.fmt.bufPrint(&uri_buf, "http://127.0.0.1:{d}/onvif/device_service", .{port});
    const device_uri = try std.Uri.parse(uri_str);

    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();

    // Call 1
    const info1 = try client.call(gen.Device.GetDeviceInformation, arena.allocator(), device_uri, .{}, .{ .timeout_ms = 5000 });
    try std.testing.expectEqualStrings("MultiSeqMfr", info1.Manufacturer);

    // Call 2 (reusing existing keep-alive connection)
    const prof = try client.call(gen.Media.GetProfiles, arena.allocator(), device_uri, .{}, .{ .timeout_ms = 5000 });
    try std.testing.expectEqual(@as(usize, 1), prof.Profiles.len);

    // Call 3 (reusing existing keep-alive connection)
    const info2 = try client.call(gen.Device.GetDeviceInformation, arena.allocator(), device_uri, .{}, .{ .timeout_ms = 5000 });
    try std.testing.expectEqualStrings("MultiSeqMfr", info2.Manufacturer);

    // Close client to signal EOF to server worker
    client.deinit();
    thread.join();
}

test "codec encode/decode PTZ.AbsoluteMove and PTZ.Stop" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    // 1. AbsoluteMove
    const AbsMove = gen.PTZ.AbsoluteMove;
    const abs_req: AbsMove.Request = .{
        .ProfileToken = "Profile_PTZ_Abs_1",
        .Position = .{
            .PanTilt = .{
                .x = 0.85,
                .y = -0.42,
                .space = "http://www.onvif.org/ver10/tptz/PanTiltSpaces/PositionGenericSpace",
            },
            .Zoom = .{
                .x = 0.5,
                .space = "http://www.onvif.org/ver10/tptz/ZoomSpaces/PositionGenericSpace",
            },
        },
        .Speed = .{
            .PanTilt = .{
                .x = 0.9,
                .y = 0.9,
            },
            .Zoom = .{
                .x = 1.0,
            },
        },
    };

    var out1: std.Io.Writer.Allocating = .init(alloc);
    defer out1.deinit();
    var w1 = xml.Writer.init(alloc, &out1.writer);
    defer w1.deinit();

    try codec.encode(AbsMove.Request, abs_req, &w1, AbsMove.request_name, AbsMove.namespace);
    try w1.flush();
    try out1.writer.flush();

    var r1_stream = std.Io.Reader.fixed(out1.written());
    var r1 = xml.Reader.init(alloc, &r1_stream);
    defer r1.deinit();

    const decoded_abs = try codec.decode(AbsMove.Request, &r1, alloc);
    try std.testing.expectEqualStrings("Profile_PTZ_Abs_1", decoded_abs.ProfileToken);
    try std.testing.expect(decoded_abs.Position.PanTilt != null);
    try std.testing.expectApproxEqAbs(@as(f32, 0.85), decoded_abs.Position.PanTilt.?.x, 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, -0.42), decoded_abs.Position.PanTilt.?.y, 0.0001);
    try std.testing.expectEqualStrings("http://www.onvif.org/ver10/tptz/PanTiltSpaces/PositionGenericSpace", decoded_abs.Position.PanTilt.?.space.?);
    try std.testing.expect(decoded_abs.Position.Zoom != null);
    try std.testing.expectApproxEqAbs(@as(f32, 0.5), decoded_abs.Position.Zoom.?.x, 0.0001);
    try std.testing.expect(decoded_abs.Speed != null);
    try std.testing.expect(decoded_abs.Speed.?.PanTilt != null);
    try std.testing.expectApproxEqAbs(@as(f32, 0.9), decoded_abs.Speed.?.PanTilt.?.x, 0.0001);

    // 2. Stop
    const Stop = gen.PTZ.Stop;
    const stop_req: Stop.Request = .{
        .ProfileToken = "Profile_PTZ_Abs_1",
        .PanTilt = true,
        .Zoom = false,
    };

    var out2: std.Io.Writer.Allocating = .init(alloc);
    defer out2.deinit();
    var w2 = xml.Writer.init(alloc, &out2.writer);
    defer w2.deinit();

    try codec.encode(Stop.Request, stop_req, &w2, Stop.request_name, Stop.namespace);
    try w2.flush();
    try out2.writer.flush();

    var r2_stream = std.Io.Reader.fixed(out2.written());
    var r2 = xml.Reader.init(alloc, &r2_stream);
    defer r2.deinit();

    const decoded_stop = try codec.decode(Stop.Request, &r2, alloc);
    try std.testing.expectEqualStrings("Profile_PTZ_Abs_1", decoded_stop.ProfileToken);
    try std.testing.expectEqual(@as(?bool, true), decoded_stop.PanTilt);
    try std.testing.expectEqual(@as(?bool, false), decoded_stop.Zoom);
}

test "codec encode/decode Media.GetStreamUri" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const Op = gen.Media.GetStreamUri;

    // Request
    const req: Op.Request = .{
        .StreamSetup = .{
            .Stream = .@"RTP-Unicast",
            .Transport = .{
                .Protocol = .RTSP,
            },
        },
        .ProfileToken = "Profile_Main_RTSP",
    };

    var out_req: std.Io.Writer.Allocating = .init(alloc);
    defer out_req.deinit();
    var w_req = xml.Writer.init(alloc, &out_req.writer);
    defer w_req.deinit();

    try codec.encode(Op.Request, req, &w_req, Op.request_name, Op.namespace);
    try w_req.flush();
    try out_req.writer.flush();

    var r_req_stream = std.Io.Reader.fixed(out_req.written());
    var r_req = xml.Reader.init(alloc, &r_req_stream);
    defer r_req.deinit();

    const decoded_req = try codec.decode(Op.Request, &r_req, alloc);
    try std.testing.expectEqualStrings("Profile_Main_RTSP", decoded_req.ProfileToken);
    try std.testing.expectEqual(schema.StreamType.@"RTP-Unicast", decoded_req.StreamSetup.Stream);
    try std.testing.expectEqual(schema.TransportProtocol.RTSP, decoded_req.StreamSetup.Transport.Protocol);

    // Response
    const dur = try onvif.xsd.Duration.parse("PT60S");
    const resp: Op.Response = .{
        .MediaUri = .{
            .Uri = "rtsp://192.168.1.100:554/live/ch0",
            .InvalidAfterConnect = false,
            .InvalidAfterReboot = true,
            .Timeout = dur,
        },
    };

    var out_resp: std.Io.Writer.Allocating = .init(alloc);
    defer out_resp.deinit();
    var w_resp = xml.Writer.init(alloc, &out_resp.writer);
    defer w_resp.deinit();

    try codec.encode(Op.Response, resp, &w_resp, Op.response_name, Op.namespace);
    try w_resp.flush();
    try out_resp.writer.flush();

    var r_resp_stream = std.Io.Reader.fixed(out_resp.written());
    var r_resp = xml.Reader.init(alloc, &r_resp_stream);
    defer r_resp.deinit();

    const decoded_resp = try codec.decode(Op.Response, &r_resp, alloc);
    try std.testing.expectEqualStrings("rtsp://192.168.1.100:554/live/ch0", decoded_resp.MediaUri.Uri);
    try std.testing.expectEqual(false, decoded_resp.MediaUri.InvalidAfterConnect);
    try std.testing.expectEqual(true, decoded_resp.MediaUri.InvalidAfterReboot);
    try std.testing.expectEqual(@as(u32, 60), decoded_resp.MediaUri.Timeout.seconds);
}

test "codec encode/decode Imaging.GetImagingSettings and SetImagingSettings" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const Op = gen.Imaging.GetImagingSettings;

    // Response
    const resp: Op.Response = .{
        .ImagingSettings = .{
            .Brightness = 48.5,
            .ColorSaturation = 65.0,
            .Contrast = 52.0,
            .Sharpness = 80.0,
            .Exposure = .{
                .Mode = .AUTO,
                .MinExposureTime = 100.0,
                .MaxExposureTime = 40000.0,
                .MinGain = 0.0,
                .MaxGain = 36.0,
            },
        },
    };

    var out: std.Io.Writer.Allocating = .init(alloc);
    defer out.deinit();
    var w = xml.Writer.init(alloc, &out.writer);
    defer w.deinit();

    try codec.encode(Op.Response, resp, &w, Op.response_name, Op.namespace);
    try w.flush();
    try out.writer.flush();

    var r_stream = std.Io.Reader.fixed(out.written());
    var r = xml.Reader.init(alloc, &r_stream);
    defer r.deinit();

    const decoded = try codec.decode(Op.Response, &r, alloc);
    try std.testing.expectApproxEqAbs(@as(f32, 48.5), decoded.ImagingSettings.Brightness.?, 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 65.0), decoded.ImagingSettings.ColorSaturation.?, 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 52.0), decoded.ImagingSettings.Contrast.?, 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 80.0), decoded.ImagingSettings.Sharpness.?, 0.001);
    try std.testing.expect(decoded.ImagingSettings.Exposure != null);
    const exp = decoded.ImagingSettings.Exposure.?;
    try std.testing.expectEqual(schema.ExposureMode.AUTO, exp.Mode);
    try std.testing.expectApproxEqAbs(@as(f32, 100.0), exp.MinExposureTime.?, 0.001);
    try std.testing.expectApproxEqAbs(@as(f32, 40000.0), exp.MaxExposureTime.?, 0.001);

    // SetImagingSettings Request
    const SetOp = gen.Imaging.SetImagingSettings;
    const set_req: SetOp.Request = .{
        .VideoSourceToken = "VS_Token_0",
        .ImagingSettings = resp.ImagingSettings,
        .ForcePersistence = true,
    };

    var out_set: std.Io.Writer.Allocating = .init(alloc);
    defer out_set.deinit();
    var w_set = xml.Writer.init(alloc, &out_set.writer);
    defer w_set.deinit();

    try codec.encode(SetOp.Request, set_req, &w_set, SetOp.request_name, SetOp.namespace);
    try w_set.flush();
    try out_set.writer.flush();

    var r_set_stream = std.Io.Reader.fixed(out_set.written());
    var r_set = xml.Reader.init(alloc, &r_set_stream);
    defer r_set.deinit();

    const decoded_set = try codec.decode(SetOp.Request, &r_set, alloc);
    try std.testing.expectEqualStrings("VS_Token_0", decoded_set.VideoSourceToken);
    try std.testing.expectEqual(@as(?bool, true), decoded_set.ForcePersistence);
    try std.testing.expectApproxEqAbs(@as(f32, 48.5), decoded_set.ImagingSettings.Brightness.?, 0.001);
}

test "codec encode/decode Device.GetCapabilities" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const Op = gen.Device.GetCapabilities;
    const resp: Op.Response = .{
        .Capabilities = .{
            .Device = .{
                .XAddr = "http://192.168.1.50/onvif/device_service",
            },
            .Media = .{
                .XAddr = "http://192.168.1.50/onvif/media_service",
            },
            .PTZ = .{
                .XAddr = "http://192.168.1.50/onvif/ptz_service",
            },
            .Imaging = .{
                .XAddr = "http://192.168.1.50/onvif/imaging_service",
            },
        },
    };

    var out: std.Io.Writer.Allocating = .init(alloc);
    defer out.deinit();
    var w = xml.Writer.init(alloc, &out.writer);
    defer w.deinit();

    try codec.encode(Op.Response, resp, &w, Op.response_name, Op.namespace);
    try w.flush();
    try out.writer.flush();

    var r_stream = std.Io.Reader.fixed(out.written());
    var r = xml.Reader.init(alloc, &r_stream);
    defer r.deinit();

    const decoded = try codec.decode(Op.Response, &r, alloc);
    try std.testing.expect(decoded.Capabilities.Device != null);
    try std.testing.expectEqualStrings("http://192.168.1.50/onvif/device_service", decoded.Capabilities.Device.?.XAddr);
    try std.testing.expect(decoded.Capabilities.Media != null);
    try std.testing.expectEqualStrings("http://192.168.1.50/onvif/media_service", decoded.Capabilities.Media.?.XAddr);
    try std.testing.expect(decoded.Capabilities.PTZ != null);
    try std.testing.expectEqualStrings("http://192.168.1.50/onvif/ptz_service", decoded.Capabilities.PTZ.?.XAddr);
    try std.testing.expect(decoded.Capabilities.Imaging != null);
    try std.testing.expectEqualStrings("http://192.168.1.50/onvif/imaging_service", decoded.Capabilities.Imaging.?.XAddr);
}

test "codec forward compatibility with unknown elements and vendor extensions" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const xml_with_extensions =
        \\<tds:GetDeviceInformationResponse xmlns:tds="http://www.onvif.org/ver10/device/wsdl" xmlns:vendor="http://custom.vendor.com/ext" vendor:customVersion="1.0">
        \\  <!-- Hardware manufacturer name -->
        \\  <tds:Manufacturer>VendorExtMfr</tds:Manufacturer>
        \\  <vendor:CustomField>IgnoredValue</vendor:CustomField>
        \\  <vendor:NestedBlock>
        \\    <vendor:DeepItem id="123">Value</vendor:DeepItem>
        \\  </vendor:NestedBlock>
        \\  <tds:Model>VendorExtModel</tds:Model>
        \\  <tds:FirmwareVersion>v9.9.9</tds:FirmwareVersion>
        \\  <tds:SerialNumber>EXT-SN-001</tds:SerialNumber>
        \\  <tds:HardwareId>EXT-HW-001</tds:HardwareId>
        \\  <vendor:ExtraTrailer flag="true"/>
        \\</tds:GetDeviceInformationResponse>
    ;

    var r_stream = std.Io.Reader.fixed(xml_with_extensions);
    var r = xml.Reader.init(alloc, &r_stream);
    defer r.deinit();

    const Op = gen.Device.GetDeviceInformation;
    const decoded = try codec.decode(Op.Response, &r, alloc);

    try std.testing.expectEqualStrings("VendorExtMfr", decoded.Manufacturer);
    try std.testing.expectEqualStrings("VendorExtModel", decoded.Model);
    try std.testing.expectEqualStrings("v9.9.9", decoded.FirmwareVersion);
    try std.testing.expectEqualStrings("EXT-SN-001", decoded.SerialNumber);
    try std.testing.expectEqualStrings("EXT-HW-001", decoded.HardwareId);
}
