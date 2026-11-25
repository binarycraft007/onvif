const std = @import("std");
const xsd = @import("xsd.zig");
const wsdl = @import("wsdl.zig");

const keywords = std.StaticStringMap(void).initComptime(.{
    .{"addrspace"},
    .{"align"},
    .{"allowzero"},
    .{"and"},
    .{"anyframe"},
    .{"anytype"},
    .{"asm"},
    .{"async"},
    .{"await"},
    .{"break"},
    .{"callconv"},
    .{"catch"},
    .{"comptime"},
    .{"const"},
    .{"continue"},
    .{"defer"},
    .{"else"},
    .{"enum"},
    .{"errdefer"},
    .{"error"},
    .{"export"},
    .{"extern"},
    .{"false"},
    .{"fn"},
    .{"for"},
    .{"if"},
    .{"inline"},
    .{"linksection"},
    .{"noalias"},
    .{"noinline"},
    .{"nosuspend"},
    .{"null"},
    .{"opaque"},
    .{"or"},
    .{"orelse"},
    .{"packed"},
    .{"pub"},
    .{"resume"},
    .{"return"},
    .{"struct"},
    .{"suspend"},
    .{"switch"},
    .{"test"},
    .{"threadlocal"},
    .{"true"},
    .{"try"},
    .{"type"},
    .{"undefined"},
    .{"union"},
    .{"unreachable"},
    .{"usingnamespace"},
    .{"var"},
    .{"volatile"},
    .{"while"},
});

pub fn sanitize(alloc: std.mem.Allocator, name: []const u8) ![]const u8 {
    if (name.len == 0) return "unnamed";
    if (std.mem.startsWith(u8, name, "@\"") and std.mem.endsWith(u8, name, "\"")) return name;

    var needs_escape = keywords.has(name) or (name[0] >= '0' and name[0] <= '9');
    if (!needs_escape) {
        for (name) |c| {
            if (!((c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') or (c >= '0' and c <= '9') or c == '_')) {
                needs_escape = true;
                break;
            }
        }
    }
    if (needs_escape) {
        return std.fmt.allocPrint(alloc, "@\"{s}\"", .{name});
    }
    return name;
}

pub fn stripPrefix(qname: []const u8) []const u8 {
    if (std.mem.indexOfScalar(u8, qname, ':')) |idx| {
        return qname[idx + 1 ..];
    }
    return qname;
}

pub fn isServiceLocalType(qname: []const u8, wsdl_info: ?wsdl.Wsdl) bool {
    if (std.mem.startsWith(u8, qname, "tt:") or std.mem.startsWith(u8, qname, "xs:") or std.mem.startsWith(u8, qname, "xsd:")) {
        return false;
    }
    const info = wsdl_info orelse return false;
    const local = stripPrefix(qname);
    if (info.schema) |s| {
        for (s.complex_types.items) |ct| {
            if (std.mem.eql(u8, ct.name, local)) return true;
        }
        for (s.simple_types.items) |st| {
            if (std.mem.eql(u8, st.name, local)) return true;
        }
    }
    return false;
}

pub fn mapType(qname: []const u8, is_service: bool, is_local: bool) []const u8 {
    _ = is_service;
    _ = is_local;
    const local = stripPrefix(qname);

    if (std.mem.eql(u8, local, "string") or
        std.mem.eql(u8, local, "anyURI") or
        std.mem.eql(u8, local, "QName") or
        std.mem.eql(u8, local, "NCName") or
        std.mem.eql(u8, local, "Name") or
        std.mem.eql(u8, local, "token") or
        std.mem.eql(u8, local, "ReferenceToken") or
        std.mem.eql(u8, local, "base64Binary") or
        std.mem.eql(u8, local, "hexBinary") or
        std.mem.eql(u8, local, "anySimpleType") or
        std.mem.eql(u8, local, "StringAttrList") or
        std.mem.eql(u8, local, "StringList") or
        std.mem.eql(u8, local, "ReferenceTokenList") or
        std.mem.eql(u8, local, "IntList") or
        std.mem.eql(u8, local, "FloatList") or
        std.mem.eql(u8, local, "IPv4Address") or
        std.mem.eql(u8, local, "IPv6Address") or
        std.mem.eql(u8, local, "HwAddress") or
        std.mem.eql(u8, local, "DNSName") or
        std.mem.eql(u8, local, "Domain") or
        std.mem.eql(u8, local, "Dot11SSIDType") or
        std.mem.eql(u8, local, "Dot11PSK") or
        std.mem.eql(u8, local, "Dot11PSKPassphrase") or
        std.mem.eql(u8, local, "AuxiliaryData") or
        std.mem.eql(u8, local, "Description") or
        std.mem.eql(u8, local, "XPathExpression") or
        std.mem.eql(u8, local, "ReceiverReference") or
        std.mem.eql(u8, local, "RecordingReference") or
        std.mem.eql(u8, local, "TrackReference") or
        std.mem.eql(u8, local, "JobToken") or
        std.mem.eql(u8, local, "RecordingJobReference") or
        std.mem.eql(u8, local, "RecordingJobMode") or
        std.mem.eql(u8, local, "RecordingJobState") or
        std.mem.eql(u8, local, "EndpointReferenceType") or
        std.mem.eql(u8, local, "AbsoluteOrRelativeTimeType") or
        std.mem.eql(u8, local, "Include"))
    {
        return "[]const u8";
    }

    if (std.mem.eql(u8, local, "boolean")) return "bool";
    if (std.mem.eql(u8, local, "int") or
        std.mem.eql(u8, local, "short") or
        std.mem.eql(u8, local, "byte") or
        std.mem.eql(u8, local, "IANA-IfTypes"))
    {
        return "i32";
    }
    if (std.mem.eql(u8, local, "integer") or
        std.mem.eql(u8, local, "long") or
        std.mem.eql(u8, local, "NetworkInterfaceConfigPriority"))
    {
        return "i64";
    }
    if (std.mem.eql(u8, local, "unsignedInt") or
        std.mem.eql(u8, local, "unsignedShort") or
        std.mem.eql(u8, local, "positiveInteger") or
        std.mem.eql(u8, local, "nonNegativeInteger"))
    {
        return "u32";
    }
    if (std.mem.eql(u8, local, "float")) return "f32";
    if (std.mem.eql(u8, local, "double")) return "f64";
    if (std.mem.eql(u8, local, "dateTime")) return "xsd.DateTime";
    if (std.mem.eql(u8, local, "duration")) return "xsd.Duration";
    if (std.mem.eql(u8, local, "any") or
        std.mem.eql(u8, local, "Any") or
        std.mem.eql(u8, local, "anyType") or
        std.mem.eql(u8, local, "Envelope") or
        std.mem.eql(u8, local, "Fault") or
        std.mem.eql(u8, local, "NotificationMessageHolderType") or
        std.mem.eql(u8, local, "FilterType"))
    {
        return "xml_any.Any";
    }

    return local;
}

fn isMappedPrimitive(raw_type: []const u8) bool {
    return std.mem.eql(u8, raw_type, "[]const u8") or
        std.mem.eql(u8, raw_type, "bool") or
        std.mem.eql(u8, raw_type, "i32") or
        std.mem.eql(u8, raw_type, "i64") or
        std.mem.eql(u8, raw_type, "u32") or
        std.mem.eql(u8, raw_type, "f32") or
        std.mem.eql(u8, raw_type, "f64") or
        std.mem.eql(u8, raw_type, "xsd.DateTime") or
        std.mem.eql(u8, raw_type, "xsd.Duration") or
        std.mem.eql(u8, raw_type, "xml_any.Any");
}

const ResolvedNamedType = struct {
    exists: bool = false,
    enum_first_tag: ?[]const u8 = null,
    primitive_underlying: ?[]const u8 = null,
};

fn resolveNamedType(
    local_name: []const u8,
    is_local: bool,
    schema_ref: ?*const xsd.Schema,
    wsdl_ref: ?wsdl.Wsdl,
) ResolvedNamedType {
    var cur = local_name;
    var depth: usize = 0;

    while (depth < 8) : (depth += 1) {
        if (is_local and wsdl_ref != null and wsdl_ref.?.schema != null) {
            const ws = wsdl_ref.?.schema.?;
            for (ws.complex_types.items) |ct| {
                if (std.mem.eql(u8, ct.name, cur)) return .{ .exists = true };
            }
            for (ws.simple_types.items) |st| {
                if (std.mem.eql(u8, st.name, cur)) {
                    if (st.enums.items.len > 0) {
                        return .{ .exists = true, .enum_first_tag = st.enums.items[0] };
                    }
                    const next_mapped = mapType(st.base_type, true, true);
                    if (isMappedPrimitive(next_mapped)) {
                        return .{ .exists = true, .primitive_underlying = next_mapped };
                    }
                    cur = next_mapped;
                    continue;
                }
            }
        }

        if (schema_ref) |sr| {
            for (sr.complex_types.items) |ct| {
                if (std.mem.eql(u8, ct.name, cur)) return .{ .exists = true };
            }
            for (sr.simple_types.items) |st| {
                if (std.mem.eql(u8, st.name, cur)) {
                    if (st.enums.items.len > 0) {
                        return .{ .exists = true, .enum_first_tag = st.enums.items[0] };
                    }
                    const next_mapped = mapType(st.base_type, false, false);
                    if (isMappedPrimitive(next_mapped)) {
                        return .{ .exists = true, .primitive_underlying = next_mapped };
                    }
                    cur = next_mapped;
                    continue;
                }
            }
        }
        break;
    }

    return .{};
}

fn defaultForPrimitive(prim: []const u8) []const u8 {
    if (std.mem.eql(u8, prim, "bool")) return "false";
    if (std.mem.eql(u8, prim, "i32") or std.mem.eql(u8, prim, "i64") or std.mem.eql(u8, prim, "u32")) return "0";
    if (std.mem.eql(u8, prim, "f32") or std.mem.eql(u8, prim, "f64")) return "0.0";
    if (std.mem.eql(u8, prim, "[]const u8")) return "\"\"";
    return ".{}";
}

pub fn formatFieldType(
    alloc: std.mem.Allocator,
    elem: xsd.Element,
    is_service: bool,
    is_local: bool,
    schema_ref: ?*const xsd.Schema,
    wsdl_ref: ?wsdl.Wsdl,
    inline_struct_name: ?[]const u8,
) !struct { type_str: []const u8, default_val: []const u8 } {
    var raw_type = if (inline_struct_name) |isn|
        isn
    else if (elem.is_any or elem.type_name.len == 0)
        "xml_any.Any"
    else
        mapType(elem.type_name, is_service, is_local);

    var resolved: ResolvedNamedType = .{};
    if (inline_struct_name == null and !isMappedPrimitive(raw_type)) {
        resolved = resolveNamedType(raw_type, is_local, schema_ref, wsdl_ref);
        if (!resolved.exists) {
            raw_type = "xml_any.Any";
        }
    }

    const is_primitive = inline_struct_name == null and isMappedPrimitive(raw_type);
    var base_type: []const u8 = raw_type;

    if (inline_struct_name == null and !is_primitive) {
        const safe_raw = try sanitize(alloc, raw_type);
        const is_schema_type = is_service and !is_local;
        if (is_schema_type) {
            base_type = try std.fmt.allocPrint(alloc, "schema.{s}", .{safe_raw});
        } else {
            base_type = safe_raw;
        }
    }

    if (elem.max_occurs == null or elem.max_occurs.? > 1) {
        return .{
            .type_str = try std.fmt.allocPrint(alloc, "[]const {s}", .{base_type}),
            .default_val = "&.{}",
        };
    } else if (elem.min_occurs == 0) {
        return .{
            .type_str = try std.fmt.allocPrint(alloc, "?{s}", .{base_type}),
            .default_val = "null",
        };
    } else {
        var def: []const u8 = ".{}";
        if (resolved.enum_first_tag) |tag| {
            const safe_tag = try sanitize(alloc, tag);
            def = try std.fmt.allocPrint(alloc, ".{s}", .{safe_tag});
        } else if (resolved.primitive_underlying) |prim| {
            def = defaultForPrimitive(prim);
        } else if (is_primitive) {
            def = defaultForPrimitive(raw_type);
        }

        return .{
            .type_str = base_type,
            .default_val = def,
        };
    }
}

fn emitAttributeField(
    alloc: std.mem.Allocator,
    w: *std.Io.Writer,
    attr: xsd.Attribute,
    is_service: bool,
    is_local: bool,
    schema_ref: ?*const xsd.Schema,
    wsdl_ref: ?wsdl.Wsdl,
    indent: []const u8,
) !void {
    const safe_attr = try sanitize(alloc, attr.name);
    var raw_type = mapType(attr.type_name, is_service, is_local);

    var resolved: ResolvedNamedType = .{};
    if (!isMappedPrimitive(raw_type)) {
        resolved = resolveNamedType(raw_type, is_local, schema_ref, wsdl_ref);
        if (!resolved.exists) {
            raw_type = "[]const u8";
        }
    }

    const is_prim = isMappedPrimitive(raw_type);
    var zig_type: []const u8 = raw_type;
    if (!is_prim) {
        const safe_raw = try sanitize(alloc, raw_type);
        zig_type = if (is_service and !is_local)
            try std.fmt.allocPrint(alloc, "schema.{s}", .{safe_raw})
        else
            safe_raw;
    }

    if (!attr.is_required) {
        try w.print("{s}{s}: ?{s} = null,\n", .{ indent, safe_attr, zig_type });
        return;
    }

    var def: []const u8 = "\"\"";
    if (resolved.enum_first_tag) |tag| {
        const safe_tag = try sanitize(alloc, tag);
        def = try std.fmt.allocPrint(alloc, ".{s}", .{safe_tag});
    } else if (resolved.primitive_underlying) |prim| {
        def = defaultForPrimitive(prim);
    } else if (is_prim) {
        def = defaultForPrimitive(raw_type);
    }

    try w.print("{s}{s}: {s} = {s},\n", .{ indent, safe_attr, zig_type, def });
}

fn emitComplexTypeBody(
    alloc: std.mem.Allocator,
    w: *std.Io.Writer,
    ct: xsd.ComplexType,
    elem_xml_name: []const u8,
    ns_expr: []const u8,
    fields_ns_expr: []const u8,
    elem_form_qualified: bool,
    is_service: bool,
    wsdl_info: ?wsdl.Wsdl,
    schema_ref: ?*const xsd.Schema,
    indent: []const u8,
) !void {
    // 1. Emit inline helper structs for child elements that define anonymous complexTypes
    var inline_names = try alloc.alloc(?[]const u8, ct.elements.items.len);
    for (ct.elements.items, 0..) |el, idx| {
        if (el.inline_complex != null and el.type_name.len == 0) {
            const ic = el.inline_complex.?;
            const helper_raw = try std.fmt.allocPrint(alloc, "Inline_{s}", .{el.name});
            const helper_name = try sanitize(alloc, helper_raw);
            inline_names[idx] = helper_name;

            try w.print("{s}pub const {s} = struct {{\n", .{ indent, helper_name });
            const inner_indent = try std.fmt.allocPrint(alloc, "{s}    ", .{indent});
            try emitComplexTypeBody(
                alloc,
                w,
                ic.*,
                el.name,
                ns_expr,
                fields_ns_expr,
                elem_form_qualified,
                is_service,
                wsdl_info,
                schema_ref,
                inner_indent,
            );
            try w.print("{s}}};\n\n", .{indent});
        } else {
            inline_names[idx] = null;
        }
    }

    // 2. Emit attributes
    for (ct.attributes.items) |attr| {
        const is_local = is_service and isServiceLocalType(attr.type_name, wsdl_info);
        try emitAttributeField(alloc, w, attr, is_service, is_local, schema_ref, wsdl_info, indent);
    }

    // 3. Emit _value if this is a simpleContent complexType extending a simple base type
    if (ct.is_simple_content) {
        if (ct.base_type) |base_qname| {
            var base_raw = mapType(base_qname, is_service, isServiceLocalType(base_qname, wsdl_info));
            const base_local = is_service and isServiceLocalType(base_qname, wsdl_info);
            var resolved: ResolvedNamedType = .{};
            if (!isMappedPrimitive(base_raw)) {
                resolved = resolveNamedType(base_raw, base_local, schema_ref, wsdl_info);
                if (!resolved.exists) base_raw = "[]const u8";
            }
            const base_is_prim = isMappedPrimitive(base_raw);
            var base_zig: []const u8 = base_raw;
            if (!base_is_prim) {
                const safe_raw = try sanitize(alloc, base_raw);
                base_zig = if (is_service and !base_local)
                    try std.fmt.allocPrint(alloc, "schema.{s}", .{safe_raw})
                else
                    safe_raw;
            }
            var def: []const u8 = "\"\"";
            if (resolved.enum_first_tag) |tag| {
                const safe_tag = try sanitize(alloc, tag);
                def = try std.fmt.allocPrint(alloc, ".{s}", .{safe_tag});
            } else if (resolved.primitive_underlying) |prim| {
                def = defaultForPrimitive(prim);
            } else if (base_is_prim) {
                def = defaultForPrimitive(base_raw);
            }
            try w.print("{s}_value: {s} = {s},\n", .{ indent, base_zig, def });
        }
    }

    // 4. Emit child elements
    for (ct.elements.items, 0..) |elem, idx| {
        const safe_elem = try sanitize(alloc, elem.name);
        const is_local = is_service and isServiceLocalType(elem.type_name, wsdl_info);
        const formatted = try formatFieldType(
            alloc,
            elem,
            is_service,
            is_local,
            schema_ref,
            wsdl_info,
            inline_names[idx],
        );
        try w.print("{s}{s}: {s} = {s},\n", .{ indent, safe_elem, formatted.type_str, formatted.default_val });
    }

    // 5. Emit xml_meta
    try w.print(
        \\{s}pub const xml_meta = .{{
        \\{s}    .element_name = "{s}",
        \\{s}    .namespace = {s},
        \\{s}    .namespace_uri = {s},
    , .{ indent, indent, elem_xml_name, indent, ns_expr, indent, ns_expr });

    if (ct.attributes.items.len > 0) {
        try w.print("\n{s}    .attributes = &.{{", .{indent});
        for (ct.attributes.items, 0..) |attr, idx| {
            if (idx > 0) try w.writeAll(", ");
            try w.print("\"{s}\"", .{attr.name});
        }
        try w.writeAll("},");
    }
    var has_field_ns = false;
    for (ct.elements.items) |el| {
        if (!el.is_any and (elem_form_qualified or el.namespace != null)) {
            has_field_ns = true;
            break;
        }
    }
    if (has_field_ns) {
        try w.print("\n{s}    .fields = .{{", .{indent});
        for (ct.elements.items) |el| {
            if (el.is_any) continue;
            const field_ns: ?[]const u8 = if (el.namespace) |ns_str|
                try std.fmt.allocPrint(alloc, "\"{s}\"", .{ns_str})
            else if (elem_form_qualified)
                fields_ns_expr
            else
                null;
            if (field_ns) |fns| {
                const safe_el = try sanitize(alloc, el.name);
                try w.print("\n{s}        .{s} = .{{ .ns = {s} }},", .{ indent, safe_el, fns });
            }
        }
        try w.print("\n{s}    }},", .{indent});
    }
    try w.print("\n{s}}};\n", .{indent});
}

pub fn emitSchema(alloc: std.mem.Allocator, io: std.Io, schema: xsd.Schema, file_path: []const u8) !void {
    const file = try std.Io.Dir.cwd().createFile(io, file_path, .{});
    defer file.close(io);

    var file_writer_buf: [16384]u8 = undefined;
    var file_writer = file.writer(io, &file_writer_buf);
    const w = &file_writer.interface;

    try w.writeAll(
        \\//! ONVIF Common Schema Types (tt)
        \\//! Generated from specs/wsdl/ver10/schema/common.xsd, onvif.xsd, and metadatastream.xsd
        \\const std = @import("std");
        \\const xsd = @import("../xsd_types.zig");
        \\const xml_any = @import("../xml/Any.zig");
        \\
        \\
    );

    const ns_literal = try std.fmt.allocPrint(alloc, "\"{s}\"", .{schema.target_namespace});

    // 1. Emit simple types
    for (schema.simple_types.items) |st| {
        const safe_name = try sanitize(alloc, st.name);
        if (st.enums.items.len > 0) {
            try w.print("pub const {s} = enum {{\n", .{safe_name});
            for (st.enums.items) |val| {
                const safe_val = try sanitize(alloc, val);
                try w.print("    {s},\n", .{safe_val});
            }
            try w.writeAll("};\n\n");
        } else {
            var target_type = mapType(st.base_type, false, false);
            if (!isMappedPrimitive(target_type)) {
                const res = resolveNamedType(target_type, false, &schema, null);
                if (!res.exists) target_type = "[]const u8";
            }
            const safe_target = if (isMappedPrimitive(target_type)) target_type else try sanitize(alloc, target_type);
            try w.print("pub const {s} = {s};\n\n", .{ safe_name, safe_target });
        }
    }

    // 2. Emit complex types
    for (schema.complex_types.items) |ct| {
        const safe_name = try sanitize(alloc, ct.name);
        try w.print("pub const {s} = struct {{\n", .{safe_name});
        try emitComplexTypeBody(alloc, w, ct, ct.name, ns_literal, ns_literal, schema.element_form_qualified, false, null, &schema, "    ");
        try w.writeAll("};\n\n");
    }

    try file_writer.interface.flush();
}

pub fn emitService(
    alloc: std.mem.Allocator,
    io: std.Io,
    service_name: []const u8,
    wsdl_info: wsdl.Wsdl,
    file_path: []const u8,
    schema_ref: *const xsd.Schema,
) !void {
    const file = try std.Io.Dir.cwd().createFile(io, file_path, .{});
    defer file.close(io);

    var file_writer_buf: [16384]u8 = undefined;
    var file_writer = file.writer(io, &file_writer_buf);
    const w = &file_writer.interface;

    try w.writeAll(
        \\//! ONVIF Generated Service Operations
        \\const std = @import("std");
        \\const xsd = @import("../../xsd_types.zig");
        \\const xml_any = @import("../../xml/Any.zig");
        \\const schema = @import("../schema.zig");
        \\
        \\
    );

    const safe_service = try sanitize(alloc, service_name);
    const ns_expr = try std.fmt.allocPrint(alloc, "{s}.namespace_uri", .{safe_service});

    try w.print("pub const {s} = struct {{\n", .{safe_service});
    try w.print("    pub const namespace = \"{s}\";\n", .{wsdl_info.target_namespace});
    try w.print("    pub const namespace_uri = \"{s}\";\n\n", .{wsdl_info.target_namespace});

    // 1. Emit service-local simple and complex types
    if (wsdl_info.schema) |s| {
        for (s.simple_types.items) |st| {
            const safe_name = try sanitize(alloc, st.name);
            if (st.enums.items.len > 0) {
                try w.print("    pub const {s} = enum {{\n", .{safe_name});
                for (st.enums.items) |val| {
                    const safe_val = try sanitize(alloc, val);
                    try w.print("        {s},\n", .{safe_val});
                }
                try w.writeAll("    };\n\n");
            } else {
                var target_type = mapType(st.base_type, true, true);
                if (!isMappedPrimitive(target_type)) {
                    const res = resolveNamedType(target_type, true, schema_ref, wsdl_info);
                    if (!res.exists) target_type = "[]const u8";
                }
                const safe_target = if (isMappedPrimitive(target_type))
                    target_type
                else if (isServiceLocalType(st.base_type, wsdl_info))
                    try sanitize(alloc, target_type)
                else
                    try std.fmt.allocPrint(alloc, "schema.{s}", .{try sanitize(alloc, target_type)});
                try w.print("    pub const {s} = {s};\n\n", .{ safe_name, safe_target });
            }
        }

        for (s.complex_types.items) |ct| {
            const safe_name = try sanitize(alloc, ct.name);
            try w.print("    pub const {s} = struct {{\n", .{safe_name});
            try emitComplexTypeBody(alloc, w, ct, ct.name, ns_expr, ns_expr, s.element_form_qualified, true, wsdl_info, schema_ref, "        ");
            try w.writeAll("    };\n\n");
        }
    }

    // 2. Emit operations (deduplicated across multiple portTypes in a WSDL)
    var emitted_ops = std.StringHashMap(void).init(alloc);
    defer emitted_ops.deinit();

    for (wsdl_info.port_types.items) |pt| {
        for (pt.operations.items) |op| {
            if (emitted_ops.contains(op.name)) continue;
            try emitted_ops.put(op.name, {});

            const safe_op_name = try sanitize(alloc, op.name);

            try w.print("    pub const {s} = struct {{\n", .{safe_op_name});
            try w.print("        pub const name = \"{s}\";\n", .{op.name});
            try w.print("        pub const soap_action = \"{s}\";\n", .{op.soap_action});
            try w.print("        pub const request_name = \"{s}\";\n", .{op.input_element});
            try w.print("        pub const response_name = \"{s}\";\n", .{op.output_element});
            try w.print("        pub const namespace = {s}.namespace_uri;\n", .{safe_service});
            try w.print("        pub const namespace_uri = {s}.namespace_uri;\n\n", .{safe_service});

            try emitOperationMessage(alloc, w, op.input_element, "Request", wsdl_info, ns_expr, schema_ref);
            try emitOperationMessage(alloc, w, op.output_element, "Response", wsdl_info, ns_expr, schema_ref);

            try w.writeAll("    };\n\n");
        }
    }

    try w.writeAll("};\n");
    try file_writer.interface.flush();
}

fn emitOperationMessage(
    alloc: std.mem.Allocator,
    w: *std.Io.Writer,
    elem_name: []const u8,
    struct_name: []const u8,
    wsdl_info: wsdl.Wsdl,
    ns_expr: []const u8,
    schema_ref: *const xsd.Schema,
) !void {
    try w.print("        pub const {s} = struct {{\n", .{struct_name});

    var found_elem: ?xsd.Element = null;
    if (wsdl_info.schema) |s| {
        for (s.elements.items) |el| {
            if (std.mem.eql(u8, el.name, elem_name)) {
                found_elem = el;
                break;
            }
        }
    }

    var resolved_ct: ?xsd.ComplexType = null;
    var resolved_from_schema_ref = false;

    if (found_elem) |el| {
        if (el.inline_complex) |ic| {
            resolved_ct = ic.*;
        } else if (el.type_name.len > 0) {
            const type_local = stripPrefix(el.type_name);
            if (!std.mem.startsWith(u8, el.type_name, "tt:") and wsdl_info.schema != null) {
                for (wsdl_info.schema.?.complex_types.items) |ct| {
                    if (std.mem.eql(u8, ct.name, type_local)) {
                        resolved_ct = ct;
                        break;
                    }
                }
            }
            if (resolved_ct == null) {
                for (schema_ref.complex_types.items) |ct| {
                    if (std.mem.eql(u8, ct.name, type_local)) {
                        resolved_ct = ct;
                        resolved_from_schema_ref = true;
                        break;
                    }
                }
            }
        }
    }

    if (resolved_ct) |ct| {
        const fields_ns_expr = if (resolved_from_schema_ref)
            try std.fmt.allocPrint(alloc, "\"{s}\"", .{schema_ref.target_namespace})
        else
            ns_expr;
        const efd_qualified = if (resolved_from_schema_ref)
            schema_ref.element_form_qualified
        else if (wsdl_info.schema) |ws|
            ws.element_form_qualified
        else
            false;

        try emitComplexTypeBody(
            alloc,
            w,
            ct,
            elem_name,
            ns_expr,
            fields_ns_expr,
            efd_qualified,
            true,
            if (resolved_from_schema_ref) null else wsdl_info,
            schema_ref,
            "            ",
        );
    } else {
        try w.print(
            \\            pub const xml_meta = .{{
            \\                .element_name = "{s}",
            \\                .namespace = {s},
            \\                .namespace_uri = {s},
            \\            }};
            \\
        , .{ elem_name, ns_expr, ns_expr });
    }

    try w.writeAll("        };\n\n");
}

pub fn emitGenerated(alloc: std.mem.Allocator, io: std.Io, file_path: []const u8) !void {
    _ = alloc;
    const file = try std.Io.Dir.cwd().createFile(io, file_path, .{});
    defer file.close(io);

    var file_writer_buf: [8192]u8 = undefined;
    var file_writer = file.writer(io, &file_writer_buf);
    const w = &file_writer.interface;

    try w.writeAll(
        \\//! ONVIF Generated Schemas and Services
        \\//! Master module exporting all schemas and service definitions.
        \\const std = @import("std");
        \\pub const xsd = @import("../xsd_types.zig");
        \\pub const xml_any = @import("../xml/Any.zig");
        \\
        \\pub const schema = @import("schema.zig");
        \\
        \\pub const services = struct {
        \\    pub const device = @import("services/device.zig");
        \\    pub const media = @import("services/media.zig");
        \\    pub const media2 = @import("services/media2.zig");
        \\    pub const ptz = @import("services/ptz.zig");
        \\    pub const imaging = @import("services/imaging.zig");
        \\    pub const event = @import("services/event.zig");
        \\    pub const deviceio = @import("services/deviceio.zig");
        \\    pub const recording = @import("services/recording.zig");
        \\    pub const search = @import("services/search.zig");
        \\    pub const replay = @import("services/replay.zig");
        \\    pub const receiver = @import("services/receiver.zig");
        \\    pub const analytics = @import("services/analytics.zig");
        \\};
        \\
        \\pub const Device = services.device.Device;
        \\pub const Media = services.media.Media;
        \\pub const Media2 = services.media2.Media2;
        \\pub const PTZ = services.ptz.PTZ;
        \\pub const Imaging = services.imaging.Imaging;
        \\pub const Event = services.event.Event;
        \\pub const DeviceIO = services.deviceio.DeviceIO;
        \\pub const Recording = services.recording.Recording;
        \\pub const Search = services.search.Search;
        \\pub const Replay = services.replay.Replay;
        \\pub const Receiver = services.receiver.Receiver;
        \\pub const Analytics = services.analytics.Analytics;
        \\
    );

    try file_writer.interface.flush();
}
