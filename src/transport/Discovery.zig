const std = @import("std");
const xml = @import("../xml/Reader.zig");
const xml_writer = @import("../xml/Writer.zig");

pub const WS_DISCOVERY_NS = "http://schemas.xmlsoap.org/ws/2005/04/discovery";
pub const WSA_2004_NS = "http://schemas.xmlsoap.org/ws/2004/08/addressing";
pub const PROBE_ACTION = "http://schemas.xmlsoap.org/ws/2005/04/discovery/Probe";
pub const PROBE_MATCHES_ACTION = "http://schemas.xmlsoap.org/ws/2005/04/discovery/ProbeMatches";
pub const MULTICAST_IPV4 = "239.255.255.250";
pub const MULTICAST_PORT = 3702;

pub const DiscoveredDevice = struct {
    endpoint_reference: []const u8,
    types: []const u8,
    scopes: []const u8,
    xaddrs: []const []const u8,
    metadata_version: u32 = 1,
};

pub const DiscoveryOptions = struct {
    timeout_ms: u32 = 2000,
    types_filter: ?[]const u8 = null, // null matches all devices per WS-Discovery Section 5.2
    scopes_filter: ?[]const u8 = null,
    bind_ip: ?[]const u8 = null, // Specific local interface IP to bind (e.g. "192.168.140.3")
    target_ip: ?[]const u8 = null, // Specific target camera IP for directed unicast probe
    target_port: u16 = MULTICAST_PORT,
};

pub fn buildProbe(
    arena: std.mem.Allocator,
    message_id: []const u8,
    types_filter: ?[]const u8,
) ![]u8 {
    return buildProbeWithScopes(arena, message_id, types_filter, null);
}

pub fn buildProbeWithScopes(
    arena: std.mem.Allocator,
    message_id: []const u8,
    types_filter: ?[]const u8,
    scopes_filter: ?[]const u8,
) ![]u8 {
    var out: std.Io.Writer.Allocating = .init(arena);
    defer out.deinit();

    var w = xml_writer.Writer.init(arena, &out.writer);
    defer w.deinit();

    try w.startElementNs("http://www.w3.org/2003/05/soap-envelope", "Envelope", "s");
    try w.attributePrefix("xmlns", "dn", "http://www.onvif.org/ver10/network/wsdl");
    try w.attributePrefix("xmlns", "tds", "http://www.onvif.org/ver10/device/wsdl");

    // Header
    try w.startElementNs("http://www.w3.org/2003/05/soap-envelope", "Header", "s");

    try w.startElementNs(WSA_2004_NS, "Action", "wsa");
    try w.writeCharacters(PROBE_ACTION);
    try w.endElement();

    try w.startElementNs(WSA_2004_NS, "MessageID", "wsa");
    try w.writeCharacters(message_id);
    try w.endElement();

    try w.startElementNs(WSA_2004_NS, "To", "wsa");
    try w.writeCharacters("urn:schemas-xmlsoap-org:ws:2005:04:discovery");
    try w.endElement();

    try w.endElement(); // </s:Header>

    // Body
    try w.startElementNs("http://www.w3.org/2003/05/soap-envelope", "Body", "s");

    try w.startElementNs(WS_DISCOVERY_NS, "Probe", "d");
    if (types_filter) |tf| {
        if (tf.len > 0) {
            try w.startElementNs(WS_DISCOVERY_NS, "Types", "d");
            try w.writeCharacters(tf);
            try w.endElement();
        }
    }
    if (scopes_filter) |sf| {
        if (sf.len > 0) {
            try w.startElementNs(WS_DISCOVERY_NS, "Scopes", "d");
            try w.writeCharacters(sf);
            try w.endElement();
        }
    }
    try w.endElement(); // </d:Probe>

    try w.endElement(); // </s:Body>
    try w.endElement(); // </s:Envelope>

    try w.flush();
    return try out.toOwnedSlice();
}

pub fn parseProbeMatches(arena: std.mem.Allocator, xml_bytes: []const u8) ![]DiscoveredDevice {
    return parseProbeMatchesForProbe(arena, xml_bytes, null);
}

pub fn parseProbeMatchesForProbe(
    arena: std.mem.Allocator,
    xml_bytes: []const u8,
    expected_msg_id: ?[]const u8,
) ![]DiscoveredDevice {
    const ActiveField = enum {
        none,
        relates_to,
        address,
        types,
        scopes,
        xaddrs,
        metadata_version,
    };

    var r_stream: std.Io.Reader = .fixed(xml_bytes);
    var r = xml.Reader.init(arena, &r_stream);
    defer r.deinit();

    var list: std.ArrayList(DiscoveredDevice) = .empty;
    defer list.deinit(arena);

    var text_buf: std.ArrayList(u8) = .empty;
    defer text_buf.deinit(arena);

    var in_header = false;
    var in_probe_match = false;
    var in_epr = false;
    var active_field: ActiveField = .none;

    var current_epr: ?[]const u8 = null;
    var current_types: ?[]const u8 = null;
    var current_scopes: ?[]const u8 = null;
    var current_xaddrs_str: ?[]const u8 = null;
    var current_meta: u32 = 1;

    while (true) {
        const ev = try r.next();
        switch (ev) {
            .eof => break,
            .start_element => |se| {
                active_field = .none;
                if (std.mem.eql(u8, se.name, "Header")) {
                    in_header = true;
                } else if (in_header and std.mem.eql(u8, se.name, "RelatesTo")) {
                    active_field = .relates_to;
                    text_buf.clearRetainingCapacity();
                } else if (std.mem.eql(u8, se.name, "ProbeMatch")) {
                    in_probe_match = true;
                    in_epr = false;
                } else if (in_probe_match) {
                    if (std.mem.eql(u8, se.name, "EndpointReference")) {
                        in_epr = true;
                    } else if (in_epr and std.mem.eql(u8, se.name, "Address")) {
                        active_field = .address;
                        text_buf.clearRetainingCapacity();
                    } else if (std.mem.eql(u8, se.name, "Types")) {
                        active_field = .types;
                        text_buf.clearRetainingCapacity();
                    } else if (std.mem.eql(u8, se.name, "Scopes")) {
                        active_field = .scopes;
                        text_buf.clearRetainingCapacity();
                    } else if (std.mem.eql(u8, se.name, "XAddrs")) {
                        active_field = .xaddrs;
                        text_buf.clearRetainingCapacity();
                    } else if (std.mem.eql(u8, se.name, "MetadataVersion")) {
                        active_field = .metadata_version;
                        text_buf.clearRetainingCapacity();
                    }
                }
            },
            .end_element => |ee| {
                switch (active_field) {
                    .relates_to => {
                        if (expected_msg_id) |exp| {
                            const rel = std.mem.trim(u8, text_buf.items, " \t\r\n");
                            if (rel.len > 0 and !std.mem.eql(u8, rel, exp)) {
                                return &.{};
                            }
                        }
                    },
                    .address => {
                        current_epr = try arena.dupe(u8, std.mem.trim(u8, text_buf.items, " \t\r\n"));
                    },
                    .types => {
                        current_types = try arena.dupe(u8, std.mem.trim(u8, text_buf.items, " \t\r\n"));
                    },
                    .scopes => {
                        current_scopes = try arena.dupe(u8, std.mem.trim(u8, text_buf.items, " \t\r\n"));
                    },
                    .xaddrs => {
                        current_xaddrs_str = try arena.dupe(u8, text_buf.items);
                    },
                    .metadata_version => {
                        current_meta = std.fmt.parseInt(u32, std.mem.trim(u8, text_buf.items, " \t\r\n"), 10) catch 1;
                    },
                    .none => {},
                }
                active_field = .none;

                if (std.mem.eql(u8, ee.name, "Header")) {
                    in_header = false;
                } else if (std.mem.eql(u8, ee.name, "EndpointReference")) {
                    in_epr = false;
                } else if (std.mem.eql(u8, ee.name, "ProbeMatch")) {
                    in_probe_match = false;
                    in_epr = false;

                    var xaddrs_list: std.ArrayList([]const u8) = .empty;
                    defer xaddrs_list.deinit(arena);

                    if (current_xaddrs_str) |xstr| {
                        var it = std.mem.tokenizeAny(u8, xstr, " \t\r\n");
                        while (it.next()) |url| {
                            try xaddrs_list.append(arena, try arena.dupe(u8, url));
                        }
                    }

                    try list.append(arena, .{
                        .endpoint_reference = current_epr orelse "",
                        .types = current_types orelse "",
                        .scopes = current_scopes orelse "",
                        .xaddrs = try xaddrs_list.toOwnedSlice(arena),
                        .metadata_version = current_meta,
                    });

                    current_epr = null;
                    current_types = null;
                    current_scopes = null;
                    current_xaddrs_str = null;
                    current_meta = 1;
                }
            },
            .characters => |chars| {
                if (active_field != .none) {
                    try text_buf.appendSlice(arena, chars);
                }
            },
            else => {},
        }
    }

    return try list.toOwnedSlice(arena);
}

pub fn dupeDevice(gpa: std.mem.Allocator, dev: DiscoveredDevice) !DiscoveredDevice {
    const epr = try gpa.dupe(u8, dev.endpoint_reference);
    errdefer gpa.free(epr);
    const types = try gpa.dupe(u8, dev.types);
    errdefer gpa.free(types);
    const scopes = try gpa.dupe(u8, dev.scopes);
    errdefer gpa.free(scopes);

    var xaddrs = try gpa.alloc([]const u8, dev.xaddrs.len);
    errdefer gpa.free(xaddrs);

    var initialized: usize = 0;
    errdefer for (xaddrs[0..initialized]) |x| gpa.free(x);

    for (dev.xaddrs) |x| {
        xaddrs[initialized] = try gpa.dupe(u8, x);
        initialized += 1;
    }

    return .{
        .endpoint_reference = epr,
        .types = types,
        .scopes = scopes,
        .xaddrs = xaddrs,
        .metadata_version = dev.metadata_version,
    };
}

pub fn freeDevice(gpa: std.mem.Allocator, dev: DiscoveredDevice) void {
    gpa.free(dev.endpoint_reference);
    gpa.free(dev.types);
    gpa.free(dev.scopes);
    for (dev.xaddrs) |x| {
        gpa.free(x);
    }
    gpa.free(dev.xaddrs);
}

pub fn discover(
    io: std.Io,
    gpa: std.mem.Allocator,
    options: DiscoveryOptions,
) ![]DiscoveredDevice {
    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();
    const aa = arena.allocator();

    // Generate RFC 4122/9562 UUIDv4 MessageID
    var rand_bytes: [16]u8 = undefined;
    io.random(&rand_bytes);
    rand_bytes[6] = (rand_bytes[6] & 0x0f) | 0x40;
    rand_bytes[8] = (rand_bytes[8] & 0x3f) | 0x80;

    const msg_id = try std.fmt.allocPrint(
        aa,
        "urn:uuid:{x:0>8}-{x:0>4}-{x:0>4}-{x:0>4}-{x:0>12}",
        .{
            std.mem.readInt(u32, rand_bytes[0..4], .big),
            std.mem.readInt(u16, rand_bytes[4..6], .big),
            std.mem.readInt(u16, rand_bytes[6..8], .big),
            std.mem.readInt(u16, rand_bytes[8..10], .big),
            std.mem.readInt(u48, rand_bytes[10..16], .big),
        },
    );

    const probe_xml = try buildProbeWithScopes(aa, msg_id, options.types_filter, options.scopes_filter);

    const local_addr: std.Io.net.IpAddress = if (options.bind_ip) |bip|
        try std.Io.net.IpAddress.parseIp4(bip, 0)
    else
        .{ .ip4 = std.Io.net.Ip4Address.unspecified(0) };

    const dest_addr: std.Io.net.IpAddress = if (options.target_ip) |tip|
        try std.Io.net.IpAddress.parseIp4(tip, options.target_port)
    else
        .{ .ip4 = .{ .bytes = .{ 239, 255, 255, 250 }, .port = options.target_port } };

    const socket = try local_addr.bind(io, .{ .mode = .dgram, .allow_broadcast = true });
    defer socket.close(io);

    if (options.bind_ip != null and
        comptime (@hasDecl(std.posix, "IP") and @hasDecl(std.posix.IP, "MULTICAST_IF") and @hasDecl(std.posix, "IPPROTO")))
    {
        const in_addr_bytes = local_addr.ip4.bytes;
        std.posix.setsockopt(
            socket.handle,
            std.posix.IPPROTO.IP,
            std.posix.IP.MULTICAST_IF,
            &in_addr_bytes,
        ) catch {};
    }

    // Send probe twice with a short gap to mitigate UDP packet loss
    try socket.send(io, &dest_addr, probe_xml);
    try io.sleep(std.Io.Duration.fromMilliseconds(30), .awake);
    socket.send(io, &dest_addr, probe_xml) catch {};

    var results: std.ArrayList(DiscoveredDevice) = .empty;
    defer results.deinit(gpa);
    errdefer for (results.items) |d| freeDevice(gpa, d);

    var recv_buf: [8192]u8 = undefined;

    const timeout_dur = std.Io.Duration.fromMilliseconds(@intCast(options.timeout_ms));
    const deadline: std.Io.Timeout = .{
        .deadline = std.Io.Clock.Timestamp.fromNow(io, .{
            .clock = .awake,
            .raw = timeout_dur,
        }),
    };

    while (true) {
        const msg = socket.receiveTimeout(io, &recv_buf, deadline) catch |err| switch (err) {
            error.Timeout => break,
            error.Canceled => return error.Canceled,
            else => break,
        };

        const dev_list = parseProbeMatchesForProbe(aa, msg.data, msg_id) catch continue;
        for (dev_list) |dev| {
            var already = false;
            for (results.items) |existing| {
                if (dev.endpoint_reference.len > 0 and std.mem.eql(u8, existing.endpoint_reference, dev.endpoint_reference)) {
                    already = true;
                    break;
                }
            }
            if (!already) {
                const duped = try dupeDevice(gpa, dev);
                errdefer freeDevice(gpa, duped);
                try results.append(gpa, duped);
            }
        }
    }

    return try results.toOwnedSlice(gpa);
}

test "buildProbe and parseProbeMatches test" {
    const alloc = std.testing.allocator;

    const probe = try buildProbeWithScopes(
        alloc,
        "urn:uuid:12345",
        "dn:NetworkVideoTransmitter",
        "onvif://www.onvif.org/type/video_encoder",
    );
    defer alloc.free(probe);

    try std.testing.expect(std.mem.indexOf(u8, probe, "Probe") != null);
    try std.testing.expect(std.mem.indexOf(u8, probe, "dn:NetworkVideoTransmitter") != null);
    try std.testing.expect(std.mem.indexOf(u8, probe, "onvif://www.onvif.org/type/video_encoder") != null);
    try std.testing.expect(std.mem.indexOf(u8, probe, "xmlns:dn") != null);

    const sample_matches =
        \\<?xml version="1.0" encoding="utf-8"?>
        \\<s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope"
        \\            xmlns:wsa="http://schemas.xmlsoap.org/ws/2004/08/addressing"
        \\            xmlns:d="http://schemas.xmlsoap.org/ws/2005/04/discovery">
        \\  <s:Header>
        \\    <wsa:RelatesTo>urn:uuid:probe-1</wsa:RelatesTo>
        \\    <wsa:From><wsa:Address>urn:uuid:should-be-ignored</wsa:Address></wsa:From>
        \\  </s:Header>
        \\  <s:Body>
        \\    <d:ProbeMatches>
        \\      <d:ProbeMatch>
        \\        <wsa:EndpointReference>
        \\          <wsa:Address>urn:uuid:camera-1</wsa:Address>
        \\        </wsa:EndpointReference>
        \\        <d:Types>dn:NetworkVideoTransmitter tds:Device</d:Types>
        \\        <d:Scopes>onvif://www.onvif.org/type/video_encoder</d:Scopes>
        \\        <d:XAddrs>http://192.168.1.100:80/onvif/device_service?a=1&amp;b=2</d:XAddrs>
        \\        <d:MetadataVersion>1</d:MetadataVersion>
        \\      </d:ProbeMatch>
        \\    </d:ProbeMatches>
        \\  </s:Body>
        \\</s:Envelope>
    ;

    var aa = std.heap.ArenaAllocator.init(alloc);
    defer aa.deinit();

    // Mismatched RelatesTo is ignored
    const ignored = try parseProbeMatchesForProbe(aa.allocator(), sample_matches, "urn:uuid:other-probe");
    try std.testing.expectEqual(@as(usize, 0), ignored.len);

    // Matching RelatesTo parses cleanly, preserves &amp; entity, and ignores Header Address
    const devices = try parseProbeMatchesForProbe(aa.allocator(), sample_matches, "urn:uuid:probe-1");
    try std.testing.expectEqual(@as(usize, 1), devices.len);
    try std.testing.expectEqualStrings("urn:uuid:camera-1", devices[0].endpoint_reference);
    try std.testing.expectEqual(@as(usize, 1), devices[0].xaddrs.len);
    try std.testing.expectEqualStrings("http://192.168.1.100:80/onvif/device_service?a=1&b=2", devices[0].xaddrs[0]);

    // Test dupeDevice and freeDevice
    const duped = try dupeDevice(alloc, devices[0]);
    defer freeDevice(alloc, duped);
    try std.testing.expectEqualStrings(duped.endpoint_reference, devices[0].endpoint_reference);
    try std.testing.expectEqualStrings(duped.xaddrs[0], devices[0].xaddrs[0]);
}

test "discover live loopback UDP test" {
    const io = std.testing.io;
    const gpa = std.testing.allocator;

    const mock_addr = std.Io.net.IpAddress{ .ip4 = std.Io.net.Ip4Address.loopback(0) };
    const mock_socket = try mock_addr.bind(io, .{ .mode = .dgram });
    defer mock_socket.close(io);

    const mock_port = mock_socket.address.ip4.port;

    const MockUdpResponder = struct {
        fn run(sock: *const std.Io.net.Socket, s_io: std.Io) void {
            var buf: [4096]u8 = undefined;
            const timeout_dur = std.Io.Duration.fromMilliseconds(1000);
            const deadline: std.Io.Timeout = .{
                .deadline = std.Io.Clock.Timestamp.fromNow(s_io, .{
                    .clock = .awake,
                    .raw = timeout_dur,
                }),
            };
            const msg = sock.receiveTimeout(s_io, &buf, deadline) catch return;

            if (std.mem.indexOf(u8, msg.data, "Probe") == null) return;

            const reply_xml =
                \\<?xml version="1.0" encoding="utf-8"?>
                \\<s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope"
                \\            xmlns:wsa="http://schemas.xmlsoap.org/ws/2004/08/addressing"
                \\            xmlns:d="http://schemas.xmlsoap.org/ws/2005/04/discovery">
                \\  <s:Body>
                \\    <d:ProbeMatches>
                \\      <d:ProbeMatch>
                \\        <wsa:EndpointReference>
                \\          <wsa:Address>urn:uuid:loopback-camera-42</wsa:Address>
                \\        </wsa:EndpointReference>
                \\        <d:Types>dn:NetworkVideoTransmitter tds:Device</d:Types>
                \\        <d:Scopes>onvif://www.onvif.org/name/LoopbackCam onvif://www.onvif.org/hardware/V1</d:Scopes>
                \\        <d:XAddrs>http://127.0.0.1:8080/onvif/device_service</d:XAddrs>
                \\        <d:MetadataVersion>2</d:MetadataVersion>
                \\      </d:ProbeMatch>
                \\    </d:ProbeMatches>
                \\  </s:Body>
                \\</s:Envelope>
            ;

            _ = sock.send(s_io, &msg.from, reply_xml) catch {};
        }
    };

    const thread = try std.Thread.spawn(.{}, MockUdpResponder.run, .{ &mock_socket, io });
    defer thread.join();

    const devices = try discover(io, gpa, .{
        .target_ip = "127.0.0.1",
        .target_port = mock_port,
        .bind_ip = "127.0.0.1",
        .timeout_ms = 400,
    });
    defer {
        for (devices) |d| freeDevice(gpa, d);
        gpa.free(devices);
    }

    try std.testing.expectEqual(@as(usize, 1), devices.len);
    try std.testing.expectEqualStrings("urn:uuid:loopback-camera-42", devices[0].endpoint_reference);
    try std.testing.expectEqualStrings("dn:NetworkVideoTransmitter tds:Device", devices[0].types);
    try std.testing.expectEqual(@as(usize, 1), devices[0].xaddrs.len);
    try std.testing.expectEqualStrings("http://127.0.0.1:8080/onvif/device_service", devices[0].xaddrs[0]);
    try std.testing.expectEqual(@as(u32, 2), devices[0].metadata_version);
}
