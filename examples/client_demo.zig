const std = @import("std");
const onvif = @import("onvif");
const spec = onvif.spec;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const gpa = init.gpa;
    const arena = init.arena;

    var target_ip: []const u8 = "192.168.140.112";
    var username: []const u8 = "admin";
    var password: []const u8 = "pass1234";

    var it = try std.process.Args.Iterator.initAllocator(init.minimal.args, gpa);
    defer it.deinit();

    _ = it.skip(); // skip executable
    if (it.next()) |ip| target_ip = ip;
    if (it.next()) |u| username = u;
    if (it.next()) |p| password = p;

    var client = onvif.transport.Client.init(gpa, io);
    defer client.deinit();

    var uri_buf: [128]u8 = undefined;
    const uri_str = try std.fmt.bufPrint(&uri_buf, "http://{s}/onvif/device_service", .{target_ip});
    const device_uri = try std.Uri.parse(uri_str);

    std.debug.print("Calling GetDeviceInformation on {s} (user: {s})...\n", .{ uri_str, username });

    // Call GetDeviceInformation with WS-Security credentials
    const info = try client.call(
        spec.Device.GetDeviceInformation,
        arena.allocator(),
        device_uri,
        .{},
        .{
            .timeout_ms = 5000,
            .credentials = .{
                .username = username,
                .password = password,
                .auth_mode = .ws_security,
            },
        },
    );

    std.debug.print("\n=== Device Information ===\n", .{});
    std.debug.print("Manufacturer: {s}\n", .{info.Manufacturer});
    std.debug.print("Model:        {s}\n", .{info.Model});
    std.debug.print("Firmware:     {s}\n", .{info.FirmwareVersion});
    std.debug.print("Serial:       {s}\n", .{info.SerialNumber});
    std.debug.print("HardwareId:   {s}\n", .{info.HardwareId});
}
