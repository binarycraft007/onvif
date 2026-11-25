const std = @import("std");
const xml = struct {
    pub const Reader = @import("xml/Reader.zig").Reader;
    pub const Writer = @import("xml/Writer.zig").Writer;
    pub const Error = @import("xml/Reader.zig").Error;
    pub const StartElement = @import("xml/Reader.zig").StartElement;
    pub const EndElement = @import("xml/Reader.zig").EndElement;
    pub const Token = @import("xml/Reader.zig").Token;
    pub const Attribute = @import("xml/Reader.zig").Attribute;
    pub const Any = @import("xml/Any.zig").Any;
    pub const Node = @import("xml/Any.zig").Node;
    pub const readNodeFromStartElement = @import("xml/Any.zig").readNodeFromStartElement;
};
const xsd = @import("xsd_types.zig");

pub const CodecError = error{
    UnexpectedToken,
    UnexpectedEof,
    MalformedXml,
    UnknownField,
    MissingRequiredField,
    InvalidEnumValue,
    InvalidNumber,
    OutOfMemory,
} || xml.Error || std.Io.Writer.Error;

pub fn getMeta(comptime T: type) struct {
    name: ?[]const u8,
    namespace: ?[]const u8,
    prefix: ?[]const u8,
} {
    const ti = @typeInfo(T);
    if (ti == .@"struct" or ti == .@"union" or ti == .@"enum" or ti == .@"opaque") {
        if (@hasDecl(T, "xml_meta")) {
            const meta = T.xml_meta;
            const MetaType = @TypeOf(meta);
            const name = if (MetaType == type) (if (@hasDecl(meta, "name")) meta.name else if (@hasDecl(meta, "element_name")) meta.element_name else null) else (if (@hasField(MetaType, "name")) meta.name else if (@hasField(MetaType, "element_name")) meta.element_name else null);
            const namespace = if (MetaType == type) (if (@hasDecl(meta, "namespace")) meta.namespace else if (@hasDecl(meta, "namespace_uri")) meta.namespace_uri else null) else (if (@hasField(MetaType, "namespace")) meta.namespace else if (@hasField(MetaType, "namespace_uri")) meta.namespace_uri else null);
            const prefix = if (MetaType == type) (if (@hasDecl(meta, "prefix")) meta.prefix else null) else (if (@hasField(MetaType, "prefix")) meta.prefix else null);
            return .{
                .name = name,
                .namespace = namespace,
                .prefix = prefix,
            };
        }
    }
    return .{ .name = null, .namespace = null, .prefix = null };
}

pub fn isFieldAttribute(comptime T: type, comptime field_name: []const u8) bool {
    if (comptime std.mem.startsWith(u8, field_name, "attr_")) return true;
    if (@hasDecl(T, "xml_meta")) {
        const meta = T.xml_meta;
        const MetaType = @TypeOf(meta);
        if (MetaType == type) {
            if (@hasDecl(meta, "attributes")) {
                inline for (meta.attributes) |attr| {
                    if (std.mem.eql(u8, attr, field_name)) return true;
                }
            }
            if (@hasDecl(meta, "fields")) {
                const fields_meta = meta.fields;
                if (@hasDecl(fields_meta, field_name)) {
                    const f_info = @field(fields_meta, field_name);
                    if (@hasField(@TypeOf(f_info), "is_attribute")) {
                        return f_info.is_attribute;
                    }
                }
            }
        } else {
            if (@hasField(MetaType, "attributes")) {
                inline for (meta.attributes) |attr| {
                    if (std.mem.eql(u8, attr, field_name)) return true;
                }
            }
            if (@hasField(MetaType, "fields")) {
                const fields_meta = meta.fields;
                const FMType = @TypeOf(fields_meta);
                if (FMType == type) {
                    if (@hasDecl(fields_meta, field_name)) {
                        const f_info = @field(fields_meta, field_name);
                        if (@hasField(@TypeOf(f_info), "is_attribute")) {
                            return f_info.is_attribute;
                        }
                    }
                } else {
                    if (@hasField(FMType, field_name)) {
                        const f_info = @field(fields_meta, field_name);
                        if (@hasField(@TypeOf(f_info), "is_attribute")) {
                            return f_info.is_attribute;
                        }
                    }
                }
            }
        }
    }
    return false;
}

pub fn getFieldXmlName(comptime T: type, comptime field_name: []const u8) []const u8 {
    if (@hasDecl(T, "xml_meta")) {
        const meta = T.xml_meta;
        const MetaType = @TypeOf(meta);
        if (MetaType == type) {
            if (@hasDecl(meta, "fields")) {
                const fields_meta = meta.fields;
                if (@hasDecl(fields_meta, field_name)) {
                    const f_info = @field(fields_meta, field_name);
                    if (@hasField(@TypeOf(f_info), "name")) {
                        return f_info.name;
                    }
                }
            }
        } else {
            if (@hasField(MetaType, "fields")) {
                const fields_meta = meta.fields;
                const FMType = @TypeOf(fields_meta);
                if (FMType == type) {
                    if (@hasDecl(fields_meta, field_name)) {
                        const f_info = @field(fields_meta, field_name);
                        if (@hasField(@TypeOf(f_info), "name")) {
                            return f_info.name;
                        }
                    }
                } else {
                    if (@hasField(FMType, field_name)) {
                        const f_info = @field(fields_meta, field_name);
                        if (@hasField(@TypeOf(f_info), "name")) {
                            return f_info.name;
                        }
                    }
                }
            }
        }
    }
    if (field_name.len > 5 and comptime std.mem.startsWith(u8, field_name, "attr_")) {
        return field_name[5..];
    }
    return field_name;
}

pub fn getFieldXmlNs(comptime T: type, comptime field_name: []const u8) ?[]const u8 {
    if (@hasDecl(T, "xml_meta")) {
        const meta = T.xml_meta;
        const MetaType = @TypeOf(meta);
        if (MetaType == type) {
            if (@hasDecl(meta, "fields")) {
                const fields_meta = meta.fields;
                if (@hasDecl(fields_meta, field_name)) {
                    const f_info = @field(fields_meta, field_name);
                    if (@hasField(@TypeOf(f_info), "ns")) {
                        return f_info.ns;
                    }
                }
            }
        } else {
            if (@hasField(MetaType, "fields")) {
                const fields_meta = meta.fields;
                const FMType = @TypeOf(fields_meta);
                if (FMType == type) {
                    if (@hasDecl(fields_meta, field_name)) {
                        const f_info = @field(fields_meta, field_name);
                        if (@hasField(@TypeOf(f_info), "ns")) {
                            return f_info.ns;
                        }
                    }
                } else {
                    if (@hasField(FMType, field_name)) {
                        const f_info = @field(fields_meta, field_name);
                        if (@hasField(@TypeOf(f_info), "ns")) {
                            return f_info.ns;
                        }
                    }
                }
            }
        }
    }
    return null;
}

pub fn encode(
    comptime T: type,
    val: T,
    w: *xml.Writer,
    override_name: ?[]const u8,
    override_ns: ?[]const u8,
) !void {
    const meta = getMeta(T);
    const elem_name = override_name orelse meta.name orelse @typeName(T);
    const elem_ns = override_ns orelse meta.namespace;
    const elem_prefix = meta.prefix;

    if (T == xsd.DateTime) {
        try w.startElementNs(elem_ns, elem_name, elem_prefix);
        var dt_buf: [64]u8 = undefined;
        var dt_w: std.Io.Writer = .fixed(&dt_buf);
        try val.format(&dt_w);
        try w.writeCharacters(dt_w.buffered());
        try w.endElement();
        return;
    }
    if (T == xsd.Duration) {
        try w.startElementNs(elem_ns, elem_name, elem_prefix);
        var dur_buf: [64]u8 = undefined;
        var dur_w: std.Io.Writer = .fixed(&dur_buf);
        try val.format(&dur_w);
        try w.writeCharacters(dur_w.buffered());
        try w.endElement();
        return;
    }
    if (T == xml.Any) {
        try val.writeTo(w);
        return;
    }

    const info = @typeInfo(T);
    switch (info) {
        .@"struct" => |s_info| {
            try w.startElementNs(elem_ns, elem_name, elem_prefix);

            // 1. Write attributes
            inline for (s_info.field_names, s_info.field_types) |f_name, FieldType| {
                if (comptime isFieldAttribute(T, f_name)) {
                    const attr_name = getFieldXmlName(T, f_name);
                    const attr_val = @field(val, f_name);
                    try encodeAttribute(FieldType, attr_val, w, attr_name);
                }
            }

            @setEvalBranchQuota(5000);
            // 2. Write text content (_value / text) and child elements
            inline for (s_info.field_names, s_info.field_types) |f_name, FieldType| {
                if (comptime !isFieldAttribute(T, f_name)) {
                    const field_val = @field(val, f_name);
                    if (comptime isTextContentField(f_name)) {
                        try encodeTextContent(FieldType, field_val, w);
                    } else {
                        const child_name = getFieldXmlName(T, f_name);
                        const child_ns = getFieldXmlNs(T, f_name);
                        try encodeChildField(FieldType, field_val, w, child_name, child_ns);
                    }
                }
            }

            try w.endElement();
        },
        .@"union" => |u_info| {
            if (u_info.tag_type == null) @compileError("Only tagged unions are supported: " ++ @typeName(T));
            switch (val) {
                inline else => |v, tag| {
                    const field_name = @tagName(tag);
                    const child_name = getFieldXmlName(T, field_name);
                    const child_ns = getFieldXmlNs(T, field_name);
                    try encode(@TypeOf(v), v, w, child_name, child_ns);
                },
            }
        },
        .@"enum" => {
            try w.startElementNs(elem_ns, elem_name, elem_prefix);
            try w.writeCharacters(@tagName(val));
            try w.endElement();
        },
        .bool => {
            try w.startElementNs(elem_ns, elem_name, elem_prefix);
            try w.writeCharacters(if (val) "true" else "false");
            try w.endElement();
        },
        .int => {
            try w.startElementNs(elem_ns, elem_name, elem_prefix);
            var buf: [32]u8 = undefined;
            const str = std.fmt.bufPrint(&buf, "{d}", .{val}) catch unreachable;
            try w.writeCharacters(str);
            try w.endElement();
        },
        .float => {
            try w.startElementNs(elem_ns, elem_name, elem_prefix);
            var buf: [64]u8 = undefined;
            const str = std.fmt.bufPrint(&buf, "{d}", .{val}) catch unreachable;
            try w.writeCharacters(str);
            try w.endElement();
        },
        .pointer => |p_info| {
            if (p_info.size == .slice and p_info.child == u8) {
                try w.startElementNs(elem_ns, elem_name, elem_prefix);
                try w.writeCharacters(val);
                try w.endElement();
            } else {
                @compileError("Unsupported pointer type for direct encode: " ++ @typeName(T));
            }
        },
        .optional => |opt_info| {
            if (val) |v| {
                try encode(opt_info.child, v, w, elem_name, elem_ns);
            }
        },
        else => @compileError("Unsupported type for encode: " ++ @typeName(T)),
    }
}

fn encodeAttribute(comptime FieldType: type, val: FieldType, w: *xml.Writer, attr_name: []const u8) !void {
    const f_info = @typeInfo(FieldType);
    if (f_info == .optional) {
        if (val) |v| {
            try encodeAttribute(f_info.optional.child, v, w, attr_name);
        }
        return;
    }

    if (FieldType == []const u8 or FieldType == []u8) {
        try w.attribute(attr_name, val);
    } else if (f_info == .bool) {
        try w.attribute(attr_name, if (val) "true" else "false");
    } else if (f_info == .int) {
        var buf: [32]u8 = undefined;
        const str = std.fmt.bufPrint(&buf, "{d}", .{val}) catch unreachable;
        try w.attribute(attr_name, str);
    } else if (f_info == .float) {
        var buf: [64]u8 = undefined;
        const str = std.fmt.bufPrint(&buf, "{d}", .{val}) catch unreachable;
        try w.attribute(attr_name, str);
    } else if (f_info == .@"enum") {
        try w.attribute(attr_name, @tagName(val));
    } else {
        @compileError("Unsupported attribute type: " ++ @typeName(FieldType));
    }
}

fn encodeTextContent(comptime FieldType: type, val: FieldType, w: *xml.Writer) !void {
    if (FieldType == xsd.DateTime) {
        var dt_buf: [64]u8 = undefined;
        var dt_w: std.Io.Writer = .fixed(&dt_buf);
        try val.format(&dt_w);
        try w.writeCharacters(dt_w.buffered());
        return;
    }
    if (FieldType == xsd.Duration) {
        var dur_buf: [64]u8 = undefined;
        var dur_w: std.Io.Writer = .fixed(&dur_buf);
        try val.format(&dur_w);
        try w.writeCharacters(dur_w.buffered());
        return;
    }
    const f_info = @typeInfo(FieldType);
    if (f_info == .optional) {
        if (val) |v| {
            try encodeTextContent(f_info.optional.child, v, w);
        }
        return;
    }
    if (FieldType == []const u8 or FieldType == []u8) {
        try w.writeCharacters(val);
    } else if (f_info == .bool) {
        try w.writeCharacters(if (val) "true" else "false");
    } else if (f_info == .int) {
        var buf: [32]u8 = undefined;
        const str = std.fmt.bufPrint(&buf, "{d}", .{val}) catch unreachable;
        try w.writeCharacters(str);
    } else if (f_info == .float) {
        var buf: [64]u8 = undefined;
        const str = std.fmt.bufPrint(&buf, "{d}", .{val}) catch unreachable;
        try w.writeCharacters(str);
    } else if (f_info == .@"enum") {
        try w.writeCharacters(@tagName(val));
    } else {
        @compileError("Unsupported text content type for encode: " ++ @typeName(FieldType));
    }
}

fn encodeChildField(
    comptime FieldType: type,
    val: FieldType,
    w: *xml.Writer,
    child_name: []const u8,
    child_ns: ?[]const u8,
) !void {
    if (FieldType == xml.Any) {
        try val.writeTo(w);
        return;
    }
    const info = @typeInfo(FieldType);
    if (info == .optional) {
        if (val) |v| {
            try encodeChildField(info.optional.child, v, w, child_name, child_ns);
        }
        return;
    }

    if (info == .pointer and info.pointer.size == .slice and info.pointer.child != u8) {
        // Repeated element slice
        for (val) |item| {
            try encode(info.pointer.child, item, w, child_name, child_ns);
        }
        return;
    }

    try encode(FieldType, val, w, child_name, child_ns);
}

pub fn decode(comptime T: type, r: *xml.Reader, gpa: std.mem.Allocator) CodecError!T {
    while (true) {
        const tok = try r.next();
        switch (tok) {
            .start_element => |se| {
                return decodeFromStartElement(T, r, gpa, se);
            },
            .characters => |chars| {
                if (std.mem.trim(u8, chars, " \t\r\n").len != 0) {
                    return error.UnexpectedToken;
                }
            },
            .comment => {},
            .eof => return error.UnexpectedEof,
            else => return error.UnexpectedToken,
        }
    }
}

fn isTextContentField(comptime field_name: []const u8) bool {
    return std.mem.eql(u8, field_name, "_value") or std.mem.eql(u8, field_name, "text");
}

fn hasTextContentField(comptime T: type) bool {
    const s_info = @typeInfo(T).@"struct";
    @setEvalBranchQuota(5000);
    inline for (s_info.field_names) |f_name| {
        if (isTextContentField(f_name)) return true;
    }
    return false;
}

fn SliceElemType(comptime FieldType: type) ?type {
    const fi = @typeInfo(FieldType);
    if (fi == .pointer and fi.pointer.size == .slice and fi.pointer.child != u8) {
        return fi.pointer.child;
    }
    if (fi == .optional) {
        const cfi = @typeInfo(fi.optional.child);
        if (cfi == .pointer and cfi.pointer.size == .slice and cfi.pointer.child != u8) {
            return cfi.pointer.child;
        }
    }
    return null;
}

fn isUnionType(comptime FieldType: type) ?type {
    const fi = @typeInfo(FieldType);
    if (fi == .@"union") return FieldType;
    if (fi == .optional and @typeInfo(fi.optional.child) == .@"union") {
        return fi.optional.child;
    }
    return null;
}

fn tryMatchUnionField(
    comptime UnionType: type,
    r: *xml.Reader,
    gpa: std.mem.Allocator,
    child_se: xml.StartElement,
) CodecError!?UnionType {
    const u_info = @typeInfo(UnionType).@"union";
    if (u_info.tag_type == null) @compileError("Only tagged unions supported: " ++ @typeName(UnionType));
    inline for (u_info.field_names, u_info.field_types) |var_name, VarType| {
        const exp_name = getFieldXmlName(UnionType, var_name);
        const exp_ns = getFieldXmlNs(UnionType, var_name);
        if (std.mem.eql(u8, child_se.name, exp_name) and
            (exp_ns == null or child_se.ns_uri == null or std.mem.eql(u8, child_se.ns_uri.?, exp_ns.?)))
        {
            const var_val = try decodeFromStartElement(VarType, r, gpa, child_se);
            return @unionInit(UnionType, var_name, var_val);
        }
    }
    return null;
}

pub fn decodeFromStartElement(
    comptime T: type,
    r: *xml.Reader,
    gpa: std.mem.Allocator,
    se: xml.StartElement,
) CodecError!T {
    if (T == xsd.DateTime) {
        const text = try r.readElementTextAlloc(gpa);
        defer gpa.free(text);
        return xsd.DateTime.parse(text) catch error.MalformedXml;
    }
    if (T == xsd.Duration) {
        const text = try r.readElementTextAlloc(gpa);
        defer gpa.free(text);
        return xsd.Duration.parse(text) catch error.MalformedXml;
    }
    if (T == xml.Any) {
        const node = try xml.readNodeFromStartElement(r, gpa, se);
        const nodes = try gpa.alloc(xml.Node, 1);
        nodes[0] = node;
        return .{ .nodes = nodes };
    }

    const info = @typeInfo(T);
    switch (info) {
        .@"struct" => |s_info| {
            var result: T = undefined;

            // Track slice accumulators for repeated fields (gpa should be an arena if mid-struct errors must not leak scalar fields)
            var slice_builders: ComptimeSliceBuilders(T) = .init;
            defer slice_builders.deinit(gpa);

            // 1. Decode attributes
            inline for (s_info.field_names, s_info.field_types, 0..) |f_name, FieldType, idx| {
                if (comptime isFieldAttribute(T, f_name)) {
                    const attr_name = getFieldXmlName(T, f_name);
                    const raw_val = se.getAttribute(attr_name);
                    if (raw_val) |v| {
                        @field(result, f_name) = try decodeAttributeValue(FieldType, v, gpa);
                    } else if (s_info.field_attrs[idx].defaultValue(FieldType)) |def_val| {
                        @field(result, f_name) = def_val;
                    } else if (@typeInfo(FieldType) == .optional) {
                        @field(result, f_name) = null;
                    } else {
                        return error.MissingRequiredField;
                    }
                }
            }

            // 2. Empty element fast path
            if (se.is_empty) {
                inline for (s_info.field_names, s_info.field_types, 0..) |f_name, FieldType, idx| {
                    if (comptime !isFieldAttribute(T, f_name)) {
                        const f_info = @typeInfo(FieldType);
                        if (s_info.field_attrs[idx].defaultValue(FieldType)) |def_val| {
                            @field(result, f_name) = def_val;
                        } else if (f_info == .optional) {
                            @field(result, f_name) = null;
                        } else if (comptime SliceElemType(FieldType) != null) {
                            @field(result, f_name) = &.{};
                        } else if (FieldType == xml.Any) {
                            @field(result, f_name) = .{ .nodes = &.{} };
                        } else if (comptime isTextContentField(f_name)) {
                            @field(result, f_name) = try decodeTextContent(FieldType, "", gpa);
                        } else {
                            return error.MissingRequiredField;
                        }
                    }
                }
                const end_tok = try r.next();
                if (end_tok != .end_element) return error.UnexpectedToken;
                return result;
            }

            // 3. Parse child elements and accumulated character content
            var found_fields: [s_info.field_names.len]bool = @splat(false);
            var text_acc: std.ArrayList(u8) = .empty;
            defer text_acc.deinit(gpa);
            var saw_child_element = false;

            while (true) {
                const next_tok = try r.next();
                switch (next_tok) {
                    .characters => |chars| {
                        if (comptime hasTextContentField(T)) {
                            try text_acc.appendSlice(gpa, chars);
                        }
                    },
                    .start_element => |child_se| {
                        saw_child_element = true;
                        var matched = false;
                        inline for (s_info.field_names, s_info.field_types, 0..) |f_name, FieldType, idx| {
                            if (comptime (!isFieldAttribute(T, f_name))) {
                                if (!matched) {
                                    const exp_name = getFieldXmlName(T, f_name);
                                    const exp_ns = getFieldXmlNs(T, f_name);

                                    if (std.mem.eql(u8, child_se.name, exp_name)) {
                                        if (exp_ns == null or child_se.ns_uri == null or std.mem.eql(u8, child_se.ns_uri.?, exp_ns.?)) {
                                            matched = true;
                                            if (comptime SliceElemType(FieldType)) |Elem| {
                                                const item = try decodeFromStartElement(Elem, r, gpa, child_se);
                                                try slice_builders.append(idx, Elem, gpa, item);
                                                found_fields[idx] = true;
                                            } else if (@typeInfo(FieldType) == .optional) {
                                                @field(result, f_name) = try decodeFromStartElement(@typeInfo(FieldType).optional.child, r, gpa, child_se);
                                                found_fields[idx] = true;
                                            } else {
                                                @field(result, f_name) = try decodeFromStartElement(FieldType, r, gpa, child_se);
                                                found_fields[idx] = true;
                                            }
                                        }
                                    } else if (comptime isUnionType(FieldType)) |UnionType| {
                                        if (try tryMatchUnionField(UnionType, r, gpa, child_se)) |u_val| {
                                            matched = true;
                                            @field(result, f_name) = u_val;
                                            found_fields[idx] = true;
                                        }
                                    }
                                }
                            }
                        }

                        if (!matched) {
                            var any_handled = false;
                            inline for (s_info.field_names, s_info.field_types, 0..) |_, FieldType, idx| {
                                if ((FieldType == xml.Any or FieldType == ?xml.Any) and !any_handled) {
                                    any_handled = true;
                                    const node = try xml.readNodeFromStartElement(r, gpa, child_se);
                                    try slice_builders.appendAny(idx, gpa, node);
                                    found_fields[idx] = true;
                                }
                            }
                            if (!any_handled) {
                                try r.skipElement();
                            }
                        }
                    },
                    .end_element => break,
                    .comment => {},
                    .eof => return error.UnexpectedEof,
                }
            }

            // Decode accumulated character content once after </Element>
            if (comptime hasTextContentField(T)) {
                const has_non_ws = std.mem.trim(u8, text_acc.items, " \t\r\n").len > 0;
                if (text_acc.items.len > 0 and (!saw_child_element or has_non_ws)) {
                    inline for (s_info.field_names, s_info.field_types, 0..) |f_name, FieldType, idx| {
                        if (comptime isTextContentField(f_name)) {
                            @field(result, f_name) = try decodeTextContent(FieldType, text_acc.items, gpa);
                            found_fields[idx] = true;
                        }
                    }
                }
            }

            // 4. Finalize slices, xml.Any, and defaults
            inline for (s_info.field_names, s_info.field_types, 0..) |f_name, FieldType, idx| {
                if (!isFieldAttribute(T, f_name)) {
                    const f_info = @typeInfo(FieldType);
                    if (comptime SliceElemType(FieldType)) |Elem| {
                        if (f_info == .optional and !found_fields[idx]) {
                            @field(result, f_name) = s_info.field_attrs[idx].defaultValue(FieldType) orelse null;
                        } else {
                            @field(result, f_name) = try slice_builders.toOwnedSlice(idx, Elem, gpa);
                        }
                    } else if (FieldType == xml.Any) {
                        @field(result, f_name) = .{ .nodes = try slice_builders.toOwnedAnyNodes(idx, gpa) };
                    } else if (FieldType == ?xml.Any) {
                        if (found_fields[idx]) {
                            @field(result, f_name) = .{ .nodes = try slice_builders.toOwnedAnyNodes(idx, gpa) };
                        } else {
                            @field(result, f_name) = s_info.field_attrs[idx].defaultValue(FieldType) orelse null;
                        }
                    } else if (!found_fields[idx]) {
                        if (s_info.field_attrs[idx].defaultValue(FieldType)) |def_val| {
                            @field(result, f_name) = def_val;
                        } else if (f_info == .optional) {
                            @field(result, f_name) = null;
                        } else if (comptime isTextContentField(f_name)) {
                            @field(result, f_name) = try decodeTextContent(FieldType, "", gpa);
                        } else {
                            return error.MissingRequiredField;
                        }
                    }
                }
            }

            return result;
        },
        .@"union" => {
            return (try tryMatchUnionField(T, r, gpa, se)) orelse error.UnknownField;
        },
        .@"enum" => {
            const text = try r.readElementTextAlloc(gpa);
            defer gpa.free(text);
            const trimmed = std.mem.trim(u8, text, " \t\r\n");
            return std.meta.stringToEnum(T, trimmed) orelse error.InvalidEnumValue;
        },
        .bool => {
            const text = try r.readElementTextAlloc(gpa);
            defer gpa.free(text);
            return parseBool(text);
        },
        .int => {
            const text = try r.readElementTextAlloc(gpa);
            defer gpa.free(text);
            return std.fmt.parseInt(T, std.mem.trim(u8, text, " \t\r\n"), 10) catch error.InvalidNumber;
        },
        .float => {
            const text = try r.readElementTextAlloc(gpa);
            defer gpa.free(text);
            return std.fmt.parseFloat(T, std.mem.trim(u8, text, " \t\r\n")) catch error.InvalidNumber;
        },
        .pointer => |p_info| {
            if (p_info.size == .slice and p_info.child == u8) {
                return try r.readElementTextAlloc(gpa);
            }
            @compileError("Unsupported pointer type for decode: " ++ @typeName(T));
        },
        else => @compileError("Unsupported type for decode: " ++ @typeName(T)),
    }
}

fn parseBool(s: []const u8) !bool {
    const trimmed = std.mem.trim(u8, s, " \t\r\n");
    if (std.mem.eql(u8, trimmed, "true") or std.mem.eql(u8, trimmed, "1")) return true;
    if (std.mem.eql(u8, trimmed, "false") or std.mem.eql(u8, trimmed, "0")) return false;
    return error.MalformedXml;
}

fn decodeAttributeValue(comptime FieldType: type, raw_val: ?[]const u8, gpa: std.mem.Allocator) CodecError!FieldType {
    const f_info = @typeInfo(FieldType);
    if (f_info == .optional) {
        if (raw_val) |v| {
            return try decodeAttributeValue(f_info.optional.child, v, gpa);
        }
        return null;
    }
    const val = raw_val orelse return error.MissingRequiredField;
    if (FieldType == []const u8 or FieldType == []u8) {
        return try gpa.dupe(u8, val);
    }
    if (f_info == .bool) {
        return parseBool(val);
    }
    if (f_info == .int) {
        return std.fmt.parseInt(FieldType, std.mem.trim(u8, val, " \t\r\n"), 10) catch error.InvalidNumber;
    }
    if (f_info == .float) {
        return std.fmt.parseFloat(FieldType, std.mem.trim(u8, val, " \t\r\n")) catch error.InvalidNumber;
    }
    if (f_info == .@"enum") {
        const trimmed = std.mem.trim(u8, val, " \t\r\n");
        return std.meta.stringToEnum(FieldType, trimmed) orelse error.InvalidEnumValue;
    }
    @compileError("Unsupported attribute type: " ++ @typeName(FieldType));
}

fn decodeTextContent(comptime FieldType: type, text: []const u8, gpa: std.mem.Allocator) CodecError!FieldType {
    const f_info = @typeInfo(FieldType);
    if (f_info == .optional) {
        return try decodeTextContent(f_info.optional.child, text, gpa);
    }
    if (FieldType == []const u8 or FieldType == []u8) {
        return try gpa.dupe(u8, text);
    }
    if (f_info == .bool) {
        return parseBool(text);
    }
    if (f_info == .int) {
        return std.fmt.parseInt(FieldType, std.mem.trim(u8, text, " \t\r\n"), 10) catch error.InvalidNumber;
    }
    if (f_info == .float) {
        return std.fmt.parseFloat(FieldType, std.mem.trim(u8, text, " \t\r\n")) catch error.InvalidNumber;
    }
    if (f_info == .@"enum") {
        const trimmed = std.mem.trim(u8, text, " \t\r\n");
        return std.meta.stringToEnum(FieldType, trimmed) orelse error.InvalidEnumValue;
    }
    @compileError("Unsupported text content type: " ++ @typeName(FieldType));
}

fn ComptimeSliceBuilders(comptime T: type) type {
    const s_info = @typeInfo(T).@"struct";

    return struct {
        const Self = @This();
        items: [s_info.field_names.len]?*anyopaque = @splat(null),

        pub const init: Self = .{};

        pub fn deinit(self: *Self, gpa: std.mem.Allocator) void {
            inline for (s_info.field_types, 0..) |FieldType, idx| {
                if (comptime SliceElemType(FieldType)) |Elem| {
                    if (self.items[idx]) |ptr| {
                        const list: *std.ArrayList(Elem) = @ptrCast(@alignCast(ptr));
                        list.deinit(gpa);
                        gpa.destroy(list);
                        self.items[idx] = null;
                    }
                } else if (FieldType == xml.Any or FieldType == ?xml.Any) {
                    if (self.items[idx]) |ptr| {
                        const list: *std.ArrayList(xml.Node) = @ptrCast(@alignCast(ptr));
                        for (list.items) |node| node.deinit(gpa);
                        list.deinit(gpa);
                        gpa.destroy(list);
                        self.items[idx] = null;
                    }
                }
            }
        }

        pub fn append(self: *Self, comptime idx: usize, comptime Child: type, gpa: std.mem.Allocator, item: Child) !void {
            if (self.items[idx] == null) {
                const list = try gpa.create(std.ArrayList(Child));
                list.* = .empty;
                self.items[idx] = list;
            }
            const list: *std.ArrayList(Child) = @ptrCast(@alignCast(self.items[idx].?));
            try list.append(gpa, item);
        }

        pub fn appendAny(self: *Self, comptime idx: usize, gpa: std.mem.Allocator, node: xml.Node) !void {
            if (self.items[idx] == null) {
                const list = try gpa.create(std.ArrayList(xml.Node));
                list.* = .empty;
                self.items[idx] = list;
            }
            const list: *std.ArrayList(xml.Node) = @ptrCast(@alignCast(self.items[idx].?));
            try list.append(gpa, node);
        }

        pub fn toOwnedSlice(self: *Self, comptime idx: usize, comptime Child: type, gpa: std.mem.Allocator) ![]Child {
            if (self.items[idx]) |ptr| {
                const list: *std.ArrayList(Child) = @ptrCast(@alignCast(ptr));
                const slice = try list.toOwnedSlice(gpa);
                gpa.destroy(list);
                self.items[idx] = null;
                return slice;
            }
            return &.{};
        }

        pub fn toOwnedAnyNodes(self: *Self, comptime idx: usize, gpa: std.mem.Allocator) ![]xml.Node {
            if (self.items[idx]) |ptr| {
                const list: *std.ArrayList(xml.Node) = @ptrCast(@alignCast(ptr));
                const slice = try list.toOwnedSlice(gpa);
                gpa.destroy(list);
                self.items[idx] = null;
                return slice;
            }
            return &.{};
        }
    };
}

test "codec roundtrip complex struct with attributes, optionals, slices, unions, enums, any" {
    const Mode = enum { auto, manual };
    const Choice = union(enum) {
        resolution: []const u8,
        framerate: u32,
    };
    const Item = struct {
        id: u32,
        name: []const u8,
    };
    const DeviceConfig = struct {
        pub const xml_meta = struct {
            pub const name = "DeviceConfig";
            pub const namespace = "http://www.onvif.org/ver10/schema";
            pub const prefix = "tt";
            pub const fields = struct {
                pub const token = .{ .is_attribute = true, .name = "token" };
                pub const enabled = .{ .is_attribute = true, .name = "enabled" };
            };
        };

        token: []const u8,
        enabled: bool,
        mode: Mode,
        choice: Choice,
        opt_val: ?u32,
        missing_opt: ?[]const u8 = null,
        items: []const Item,
        extra: xml.Any,
    };

    const extra_node: xml.Node = .{
        .name = "CustomSetting",
        .prefix = null,
        .ns_uri = null,
        .attributes = &.{},
        .text = "CustomValue",
        .children = &.{},
    };
    const extra_nodes = try std.testing.allocator.alloc(xml.Node, 1);
    defer std.testing.allocator.free(extra_nodes);
    extra_nodes[0] = extra_node;

    const original: DeviceConfig = .{
        .token = "dev-42",
        .enabled = true,
        .mode = .manual,
        .choice = .{ .framerate = 60 },
        .opt_val = 100,
        .missing_opt = null,
        .items = &.{
            .{ .id = 1, .name = "Lens 1" },
            .{ .id = 2, .name = "Lens 2" },
        },
        .extra = .{ .nodes = extra_nodes },
    };

    // 1. Encode
    var out: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer out.deinit();
    var writer = xml.Writer.init(std.testing.allocator, &out.writer);
    defer writer.deinit();

    try encode(DeviceConfig, original, &writer, null, null);
    try writer.flush();

    const xml_bytes = out.written();

    // Verify XML contains expected namespaces and fields
    try std.testing.expect(std.mem.indexOf(u8, xml_bytes, "<tt:DeviceConfig") != null);
    try std.testing.expect(std.mem.indexOf(u8, xml_bytes, "token=\"dev-42\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, xml_bytes, "enabled=\"true\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, xml_bytes, "<mode>manual</mode>") != null);
    try std.testing.expect(std.mem.indexOf(u8, xml_bytes, "<framerate>60</framerate>") != null);
    try std.testing.expect(std.mem.indexOf(u8, xml_bytes, "<opt_val>100</opt_val>") != null);
    try std.testing.expect(std.mem.indexOf(u8, xml_bytes, "<items>") != null);
    try std.testing.expect(std.mem.indexOf(u8, xml_bytes, "<CustomSetting>CustomValue</CustomSetting>") != null);

    // 2. Decode
    var r_impl: std.Io.Reader = .fixed(xml_bytes);
    var reader = xml.Reader.init(std.testing.allocator, &r_impl);
    defer reader.deinit();

    const decoded = try decode(DeviceConfig, &reader, std.testing.allocator);
    defer {
        std.testing.allocator.free(decoded.token);
        for (decoded.items) |item| {
            std.testing.allocator.free(item.name);
        }
        std.testing.allocator.free(decoded.items);
        var any_mut = decoded.extra;
        any_mut.deinit(std.testing.allocator);
    }

    try std.testing.expectEqualStrings(original.token, decoded.token);
    try std.testing.expectEqual(original.enabled, decoded.enabled);
    try std.testing.expectEqual(original.mode, decoded.mode);
    try std.testing.expectEqual(@as(u32, 60), decoded.choice.framerate);
    try std.testing.expectEqual(@as(?u32, 100), decoded.opt_val);
    try std.testing.expectEqual(@as(?[]const u8, null), decoded.missing_opt);
    try std.testing.expectEqual(@as(usize, 2), decoded.items.len);
    try std.testing.expectEqual(@as(u32, 1), decoded.items[0].id);
    try std.testing.expectEqualStrings("Lens 1", decoded.items[0].name);
    try std.testing.expectEqual(@as(u32, 2), decoded.items[1].id);
    try std.testing.expectEqualStrings("Lens 2", decoded.items[1].name);

    try std.testing.expectEqual(@as(usize, 1), decoded.extra.nodes.len);
    try std.testing.expectEqualStrings("CustomSetting", decoded.extra.nodes[0].name);
    try std.testing.expectEqualStrings("CustomValue", decoded.extra.nodes[0].text.?);
}

test "codec arbitrary namespace prefix matching" {
    const xml_text =
        \\  <ns99:DeviceInfo xmlns:ns99="http://www.onvif.org/ver10/schema" serial="XYZ-987">
        \\  <ns99:Manufacturer>Sony</ns99:Manufacturer>
        \\  <ns99:Model>SNC-WR630</ns99:Model>
        \\</ns99:DeviceInfo>
    ;

    const DeviceInfo = struct {
        pub const xml_meta = struct {
            pub const name = "DeviceInfo";
            pub const namespace = "http://www.onvif.org/ver10/schema";
            pub const fields = struct {
                pub const serial = .{ .is_attribute = true, .name = "serial" };
                pub const manufacturer = .{ .name = "Manufacturer", .ns = "http://www.onvif.org/ver10/schema" };
                pub const model = .{ .name = "Model", .ns = "http://www.onvif.org/ver10/schema" };
            };
        };

        serial: []const u8,
        manufacturer: []const u8,
        model: []const u8,
    };

    var r_impl: std.Io.Reader = .fixed(xml_text);
    var reader = xml.Reader.init(std.testing.allocator, &r_impl);
    defer reader.deinit();

    const decoded = try decode(DeviceInfo, &reader, std.testing.allocator);
    defer {
        std.testing.allocator.free(decoded.serial);
        std.testing.allocator.free(decoded.manufacturer);
        std.testing.allocator.free(decoded.model);
    }

    try std.testing.expectEqualStrings("XYZ-987", decoded.serial);
    try std.testing.expectEqualStrings("Sony", decoded.manufacturer);
    try std.testing.expectEqualStrings("SNC-WR630", decoded.model);
}

test "codec text content entities, optional union with xml_meta, trimmed enum, and empty element" {
    const Status = enum { active, inactive };
    const Payload = union(enum) {
        pub const xml_meta = struct {
            pub const fields = struct {
                pub const text_val = .{ .name = "TextVal" };
            };
        };
        text_val: []const u8,
        num_val: u32,
    };
    const Wrapper = struct {
        status: Status,
        payload: ?Payload = null,
        opt_items: ?[]const u32 = null,
        extra: xml.Any,
    };
    const TextAttr = struct {
        attr_lang: []const u8,
        _value: ?[]const u8 = null,
    };

    const xml_text =
        \\<Wrapper>
        \\  <status>
        \\    active
        \\  </status>
        \\  <TextVal>A &amp; B</TextVal>
        \\  <opt_items>10</opt_items>
        \\  <opt_items>20</opt_items>
        \\</Wrapper>
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const aa = arena.allocator();

    var r1_impl: std.Io.Reader = .fixed(xml_text);
    var r1 = xml.Reader.init(aa, &r1_impl);
    defer r1.deinit();

    const w = try decode(Wrapper, &r1, aa);
    try std.testing.expectEqual(Status.active, w.status);
    try std.testing.expect(w.payload != null);
    try std.testing.expectEqualStrings("A & B", w.payload.?.text_val);
    try std.testing.expect(w.opt_items != null);
    try std.testing.expectEqualSlices(u32, &.{ 10, 20 }, w.opt_items.?);
    try std.testing.expectEqual(@as(usize, 0), w.extra.nodes.len);

    // Empty element with xml.Any and optional _value
    var r2_impl: std.Io.Reader = .fixed("<Wrapper><status>inactive</status></Wrapper>");
    var r2 = xml.Reader.init(aa, &r2_impl);
    defer r2.deinit();
    const w2 = try decode(Wrapper, &r2, aa);
    try std.testing.expectEqual(@as(?Payload, null), w2.payload);
    try std.testing.expectEqual(@as(?[]const u32, null), w2.opt_items);

    var r3_impl: std.Io.Reader = .fixed("<TextAttr lang=\"en\"/>");
    var r3 = xml.Reader.init(aa, &r3_impl);
    defer r3.deinit();
    const ta1 = try decode(TextAttr, &r3, aa);
    try std.testing.expectEqualStrings("en", ta1.attr_lang);
    try std.testing.expectEqual(@as(?[]const u8, null), ta1._value);

    var r4_impl: std.Io.Reader = .fixed("<TextAttr lang=\"en\">Hello &amp; Hi</TextAttr>");
    var r4 = xml.Reader.init(aa, &r4_impl);
    defer r4.deinit();
    const ta2 = try decode(TextAttr, &r4, aa);
    try std.testing.expectEqualStrings("Hello & Hi", ta2._value.?);

    // Encode roundtrip for simpleContent (_value + attribute)
    var out_buf: std.Io.Writer.Allocating = .init(aa);
    defer out_buf.deinit();
    var w_text = xml.Writer.init(aa, &out_buf.writer);
    defer w_text.deinit();

    try encode(TextAttr, .{ .attr_lang = "en", ._value = "Hello & Hi" }, &w_text, "TextAttr", null);
    try w_text.flush();
    try std.testing.expectEqualStrings("<TextAttr lang=\"en\">Hello &amp; Hi</TextAttr>", out_buf.written());

    var r5_impl: std.Io.Reader = .fixed(out_buf.written());
    var r5 = xml.Reader.init(aa, &r5_impl);
    defer r5.deinit();
    const ta3 = try decode(TextAttr, &r5, aa);
    try std.testing.expectEqualStrings("Hello & Hi", ta3._value.?);
}
