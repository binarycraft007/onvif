const std = @import("std");
const onvif = @import("onvif");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const gpa = init.gpa;

    var stderr_file = std.Io.File.stderr();
    var stderr_writer = stderr_file.writer(io, &.{});
    const log = &stderr_writer.interface;

    var target_ip: ?[]const u8 = null;
    var bind_ip: ?[]const u8 = null;
    var types_filter: ?[]const u8 = null;
    var timeout_ms: u32 = 2500;

    // Parse command line arguments
    var it = try std.process.Args.Iterator.initAllocator(init.minimal.args, gpa);
    defer it.deinit();

    _ = it.skip(); // skip executable name

    while (it.next()) |arg| {
        if (std.mem.eql(u8, arg, "-h") or std.mem.eql(u8, arg, "--help")) {
            try log.print(
                \\Usage: discover_and_probe [options] [target_ip]
                \\
                \\Options:
                \\  [target_ip]             Direct unicast probe to camera IP (e.g. 192.168.140.112)
                \\  --target, -t <ip>       Direct unicast probe to camera IP
                \\  --interface, -i <ip>    Local interface IP to bind (e.g. 192.168.140.3)
                \\  --timeout <ms>          Discovery timeout in ms (default: 2500)
                \\  --types <types>         Filter by types (default: all devices)
                \\  --nvt                   Filter for NetworkVideoTransmitter only
                \\  --help, -h              Display this help message
                \\
                \\Examples:
                \\  discover_and_probe
                \\  discover_and_probe 192.168.140.112
                \\  discover_and_probe --interface 192.168.140.3
                \\  discover_and_probe --interface 192.168.140.3 --target 192.168.140.112
                \\
            , .{});
            try log.flush();
            return;
        } else if (std.mem.eql(u8, arg, "--nvt")) {
            types_filter = "dn:NetworkVideoTransmitter";
        } else if (std.mem.eql(u8, arg, "-t") or std.mem.eql(u8, arg, "--target")) {
            target_ip = it.next();
        } else if (std.mem.eql(u8, arg, "-i") or std.mem.eql(u8, arg, "--interface")) {
            bind_ip = it.next();
        } else if (std.mem.eql(u8, arg, "--types")) {
            types_filter = it.next();
        } else if (std.mem.eql(u8, arg, "--timeout")) {
            if (it.next()) |val| {
                timeout_ms = std.fmt.parseInt(u32, val, 10) catch 2500;
            }
        } else if (!std.mem.startsWith(u8, arg, "-") and target_ip == null) {
            target_ip = arg;
        }
    }

    try log.print("=== ONVIF WS-Discovery & Probe Tool ===\n", .{});
    if (target_ip) |tip| {
        try log.print("Sending directed unicast probe to {s}:3702...\n", .{tip});
    } else {
        try log.print("Searching for ONVIF devices via multicast (239.255.255.250:3702)...\n", .{});
    }

    if (bind_ip) |bip| {
        try log.print("Binding local socket to interface {s}\n", .{bip});
    }

    const devices = try onvif.transport.Discovery.discover(io, gpa, .{
        .timeout_ms = timeout_ms,
        .types_filter = types_filter,
        .bind_ip = bind_ip,
        .target_ip = target_ip,
    });
    defer {
        for (devices) |dev| {
            onvif.transport.Discovery.freeDevice(gpa, dev);
        }
        gpa.free(devices);
    }

    try log.print("Discovery completed. Found {d} device(s).\n", .{devices.len});

    for (devices, 0..) |dev, idx| {
        try log.print("\nDevice #{d}:\n", .{idx + 1});
        try log.print("  Endpoint: {s}\n", .{dev.endpoint_reference});
        try log.print("  Types:    {s}\n", .{dev.types});
        try log.print("  Scopes:   {s}\n", .{dev.scopes});
        for (dev.xaddrs) |xaddr| {
            try log.print("  XAddr:    {s}\n", .{xaddr});
        }
    }

    if (devices.len == 0) {
        try log.print("\n[Tips for zero devices found]:\n", .{});
        if (target_ip == null and bind_ip == null) {
            try log.print("  1. Multi-homed PC: If your PC has multiple network adapters (e.g. WiFi, corporate LAN,\n", .{});
            try log.print("     and direct camera Ethernet), Windows sends multicast out the default gateway interface.\n", .{});
            try log.print("     Specify the camera subnet interface: --interface <your_adapter_ip>\n", .{});
            try log.print("     Or probe camera directly: discover_and_probe <camera_ip>\n", .{});
        }
        try log.print("  2. Firewall: Ensure inbound UDP port 3702 is allowed in Windows Firewall.\n", .{});
    }

    try log.print("\nProbe tool finished.\n", .{});
    try log.flush();
}
