const std = @import("std");
const xsd = @import("xsd.zig");
const wsdl = @import("wsdl.zig");
const emitter = @import("emitter.zig");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const gpa = init.gpa;

    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();
    const alloc = arena.allocator();

    var stderr_file = std.Io.File.stderr();
    var stderr_writer = stderr_file.writer(io, &.{});

    // Determine WSDL/XSD base directory from CLI arguments or default to specs/wsdl
    var wsdl_dir: []const u8 = "specs/wsdl";
    const args = try init.minimal.args.toSlice(alloc);
    var i: usize = 1;
    while (i < args.len) : (i += 1) {
        const arg = args[i];
        if (std.mem.eql(u8, arg, "--wsdl-dir") and i + 1 < args.len) {
            i += 1;
            wsdl_dir = args[i];
        } else if (!std.mem.startsWith(u8, arg, "-")) {
            wsdl_dir = arg;
        }
    }

    _ = stderr_writer.interface.print("Using WSDL/XSD directory: {s}\n", .{wsdl_dir}) catch {};
    try stderr_writer.interface.flush();

    // 1. Parse common.xsd, onvif.xsd, and metadatastream.xsd (Profile M) into Schema
    var schema = xsd.Schema.init("");
    const common_path = try std.fs.path.join(alloc, &.{ wsdl_dir, "ver10/schema/common.xsd" });
    const common_bytes = try std.Io.Dir.cwd().readFileAlloc(io, common_path, alloc, .limited(2 * 1024 * 1024));
    try xsd.parseSchemaInto(alloc, common_bytes, &schema);

    const onvif_path = try std.fs.path.join(alloc, &.{ wsdl_dir, "ver10/schema/onvif.xsd" });
    const onvif_bytes = try std.Io.Dir.cwd().readFileAlloc(io, onvif_path, alloc, .limited(4 * 1024 * 1024));
    try xsd.parseSchemaInto(alloc, onvif_bytes, &schema);

    const meta_path = try std.fs.path.join(alloc, &.{ wsdl_dir, "ver10/schema/metadatastream.xsd" });
    if (std.Io.Dir.cwd().readFileAlloc(io, meta_path, alloc, .limited(4 * 1024 * 1024))) |meta_bytes| {
        try xsd.parseSchemaInto(alloc, meta_bytes, &schema);
    } else |err| switch (err) {
        error.FileNotFound => {
            _ = stderr_writer.interface.print("Optional schema not found (skipping): {s}\n", .{meta_path}) catch {};
            try stderr_writer.interface.flush();
        },
        else => return err,
    }

    // Resolve multi-level base type inheritance (e.g. ConfigurationEntity, DeviceEntity)
    try xsd.resolveInheritance(alloc, &schema, null);

    _ = stderr_writer.interface.print("Schema parsed: {d} complex types, {d} simple types\n", .{
        schema.complex_types.items.len,
        schema.simple_types.items.len,
    }) catch {};
    try stderr_writer.interface.flush();

    // 2. Ensure directories exist
    try std.Io.Dir.cwd().createDirPath(io, "src/spec/services");

    // 3. Emit schema.zig
    try emitter.emitSchema(alloc, io, schema, "src/spec/schema.zig");
    _ = stderr_writer.interface.writeAll("Emitted src/spec/schema.zig\n") catch {};
    try stderr_writer.interface.flush();

    // 4. Parse each WSDL and emit service definitions (Profiles S, T, G, M)
    const wsdls = [_]struct {
        name: []const u8,
        file_name: []const u8,
        rel_path: []const u8,
        alt_rel_path: ?[]const u8 = null,
    }{
        // Profile S / T Core
        .{ .name = "Device", .file_name = "device", .rel_path = "ver10/device/wsdl/devicemgmt.wsdl" },
        .{ .name = "Media", .file_name = "media", .rel_path = "ver10/media/wsdl/media.wsdl" },
        .{ .name = "Media2", .file_name = "media2", .rel_path = "ver20/media/wsdl/media.wsdl" },
        .{ .name = "PTZ", .file_name = "ptz", .rel_path = "ver20/ptz/wsdl/ptz.wsdl" },
        .{ .name = "Imaging", .file_name = "imaging", .rel_path = "ver20/imaging/wsdl/imaging.wsdl" },
        .{ .name = "Event", .file_name = "event", .rel_path = "ver10/events/wsdl/event.wsdl" },
        .{ .name = "DeviceIO", .file_name = "deviceio", .rel_path = "ver10/deviceio.wsdl" },
        // Profile G (Edge Storage, Search, Replay, Receiver)
        .{
            .name = "Recording",
            .file_name = "recording",
            .rel_path = "ver10/recording.wsdl",
            .alt_rel_path = "ver10/recording/wsdl/recording.wsdl",
        },
        .{
            .name = "Search",
            .file_name = "search",
            .rel_path = "ver10/search.wsdl",
            .alt_rel_path = "ver10/search/wsdl/search.wsdl",
        },
        .{
            .name = "Replay",
            .file_name = "replay",
            .rel_path = "ver10/replay.wsdl",
            .alt_rel_path = "ver10/replay/wsdl/replay.wsdl",
        },
        .{
            .name = "Receiver",
            .file_name = "receiver",
            .rel_path = "ver10/receiver.wsdl",
            .alt_rel_path = "ver10/receiver/wsdl/receiver.wsdl",
        },
        // Profile M (Analytics / AI Metadata)
        .{ .name = "Analytics", .file_name = "analytics", .rel_path = "ver20/analytics/wsdl/analytics.wsdl" },
    };

    inline for (wsdls) |item| {
        const bytes = blk: {
            const p1 = try std.fs.path.join(alloc, &.{ wsdl_dir, item.rel_path });
            break :blk std.Io.Dir.cwd().readFileAlloc(io, p1, alloc, .limited(4 * 1024 * 1024)) catch |err| switch (err) {
                error.FileNotFound => if (item.alt_rel_path) |alt| blk2: {
                    const p2 = try std.fs.path.join(alloc, &.{ wsdl_dir, alt });
                    break :blk2 try std.Io.Dir.cwd().readFileAlloc(io, p2, alloc, .limited(4 * 1024 * 1024));
                } else return err,
                else => return err,
            };
        };

        var parsed = try wsdl.parseWsdl(alloc, bytes);
        if (parsed.schema) |*service_schema| {
            try xsd.resolveInheritance(alloc, service_schema, &schema);
        }

        var total_ops: usize = 0;
        for (parsed.port_types.items) |pt| {
            total_ops += pt.operations.items.len;
        }

        const out_path = try std.fmt.allocPrint(alloc, "src/spec/services/{s}.zig", .{item.file_name});
        try emitter.emitService(alloc, io, item.name, parsed, out_path, &schema);

        _ = stderr_writer.interface.print("Emitted {s}: {d} operations\n", .{
            out_path,
            total_ops,
        }) catch {};
        try stderr_writer.interface.flush();
    }

    // 5. Emit master generated.zig
    try emitter.emitGenerated(alloc, io, "src/spec/generated.zig");
    _ = stderr_writer.interface.writeAll("Emitted src/spec/generated.zig\n") catch {};
    try stderr_writer.interface.flush();
}
