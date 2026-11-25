const std = @import("std");
const xml = struct {
    pub const Reader = @import("xml_reader").Reader;
};

pub const Attribute = struct {
    name: []const u8,
    type_name: []const u8,
    is_required: bool = false,
};

pub const Element = struct {
    name: []const u8,
    type_name: []const u8,
    min_occurs: usize = 1,
    max_occurs: ?usize = 1, // null means unbounded
    is_any: bool = false,
    inline_complex: ?*ComplexType = null,
    namespace: ?[]const u8 = null,
};

pub const ComplexType = struct {
    name: []const u8,
    elements: std.ArrayList(Element),
    attributes: std.ArrayList(Attribute),
    base_type: ?[]const u8 = null,
    is_simple_content: bool = false,
    is_choice: bool = false,

    pub fn init(name: []const u8) ComplexType {
        return .{
            .name = name,
            .elements = .empty,
            .attributes = .empty,
        };
    }

    pub fn deinit(self: *ComplexType, gpa: std.mem.Allocator) void {
        for (self.elements.items) |*elem| {
            if (elem.inline_complex) |ic| {
                ic.deinit(gpa);
                gpa.destroy(ic);
            }
        }
        self.elements.deinit(gpa);
        self.attributes.deinit(gpa);
    }
};

pub const SimpleType = struct {
    name: []const u8,
    base_type: []const u8,
    enums: std.ArrayList([]const u8),

    pub fn init(name: []const u8, base_type: []const u8) SimpleType {
        return .{
            .name = name,
            .base_type = base_type,
            .enums = .empty,
        };
    }

    pub fn deinit(self: *SimpleType, gpa: std.mem.Allocator) void {
        self.enums.deinit(gpa);
    }
};

pub const Schema = struct {
    target_namespace: []const u8,
    element_form_qualified: bool = false,
    complex_types: std.ArrayList(ComplexType),
    simple_types: std.ArrayList(SimpleType),
    elements: std.ArrayList(Element),

    pub fn init(target_namespace: []const u8) Schema {
        return .{
            .target_namespace = target_namespace,
            .complex_types = .empty,
            .simple_types = .empty,
            .elements = .empty,
        };
    }

    pub fn deinit(self: *Schema, gpa: std.mem.Allocator) void {
        for (self.complex_types.items) |*ct| ct.deinit(gpa);
        self.complex_types.deinit(gpa);
        for (self.simple_types.items) |*st| st.deinit(gpa);
        self.simple_types.deinit(gpa);
        for (self.elements.items) |*el| {
            if (el.inline_complex) |ic| {
                ic.deinit(gpa);
                gpa.destroy(ic);
            }
        }
        self.elements.deinit(gpa);
    }
};

const ComplexFrame = struct {
    ct: ?*ComplexType,
    attached_to_elem: bool,
    choice_depth: usize = 0,
};

pub fn parseSchema(gpa: std.mem.Allocator, xml_data: []const u8) !Schema {
    var schema = Schema.init("");
    try parseSchemaInto(gpa, xml_data, &schema);
    return schema;
}

pub fn parseSchemaInto(gpa: std.mem.Allocator, xml_data: []const u8, schema: *Schema) !void {
    var fixed_stream = std.Io.Reader.fixed(xml_data);
    var reader = xml.Reader.init(gpa, &fixed_stream);
    defer reader.deinit();

    var complex_stack: std.ArrayList(ComplexFrame) = .empty;
    defer {
        for (complex_stack.items) |frame| {
            if (frame.ct) |ct| {
                ct.deinit(gpa);
                gpa.destroy(ct);
            }
        }
        complex_stack.deinit(gpa);
    }

    var simple_stack: std.ArrayList(?SimpleType) = .empty;
    defer {
        for (simple_stack.items) |*maybe_st| {
            if (maybe_st.*) |*st| st.deinit(gpa);
        }
        simple_stack.deinit(gpa);
    }

    var elem_stack: std.ArrayList(?Element) = .empty;
    defer {
        for (elem_stack.items) |*maybe_el| {
            if (maybe_el.*) |*el| {
                if (el.inline_complex) |ic| {
                    ic.deinit(gpa);
                    gpa.destroy(ic);
                }
            }
        }
        elem_stack.deinit(gpa);
    }

    while (true) {
        const ev = try reader.next();
        switch (ev) {
            .eof => break,
            .start_element => |se| {
                if (std.mem.eql(u8, se.name, "schema")) {
                    if (se.getAttribute("targetNamespace")) |tns| {
                        if (schema.target_namespace.len == 0) {
                            schema.target_namespace = try gpa.dupe(u8, tns);
                        }
                    }
                    if (se.getAttribute("elementFormDefault")) |efd| {
                        if (std.mem.eql(u8, efd, "qualified")) {
                            schema.element_form_qualified = true;
                        }
                    }
                } else if (std.mem.eql(u8, se.name, "complexType")) {
                    if (se.getAttribute("name")) |name| {
                        const ct = try gpa.create(ComplexType);
                        ct.* = ComplexType.init(try gpa.dupe(u8, name));
                        try complex_stack.append(gpa, .{
                            .ct = ct,
                            .attached_to_elem = false,
                        });
                    } else if (elem_stack.items.len > 0 and elem_stack.items[elem_stack.items.len - 1] != null) {
                        const parent_el = elem_stack.items[elem_stack.items.len - 1].?;
                        const ct = try gpa.create(ComplexType);
                        ct.* = ComplexType.init(parent_el.name);
                        try complex_stack.append(gpa, .{
                            .ct = ct,
                            .attached_to_elem = true,
                        });
                    } else {
                        try complex_stack.append(gpa, .{
                            .ct = null,
                            .attached_to_elem = false,
                        });
                    }
                } else if (std.mem.eql(u8, se.name, "simpleType")) {
                    if (se.getAttribute("name")) |name| {
                        try simple_stack.append(gpa, SimpleType.init(try gpa.dupe(u8, name), "string"));
                    } else {
                        // Anonymous inline simpleType (inside element/attribute): keep stack balanced without overwriting outer
                        try simple_stack.append(gpa, null);
                    }
                } else if (std.mem.eql(u8, se.name, "simpleContent")) {
                    if (complex_stack.items.len > 0) {
                        if (complex_stack.items[complex_stack.items.len - 1].ct) |ct| {
                            ct.is_simple_content = true;
                        }
                    }
                } else if (std.mem.eql(u8, se.name, "extension")) {
                    if (se.getAttribute("base")) |base| {
                        const duped_base = try gpa.dupe(u8, base);
                        if (simple_stack.items.len > 0 and simple_stack.items[simple_stack.items.len - 1] != null) {
                            simple_stack.items[simple_stack.items.len - 1].?.base_type = duped_base;
                        } else if (complex_stack.items.len > 0) {
                            if (complex_stack.items[complex_stack.items.len - 1].ct) |ct| {
                                ct.base_type = duped_base;
                            }
                        }
                    }
                } else if (std.mem.eql(u8, se.name, "restriction")) {
                    if (simple_stack.items.len > 0 and simple_stack.items[simple_stack.items.len - 1] != null) {
                        if (se.getAttribute("base")) |base| {
                            simple_stack.items[simple_stack.items.len - 1].?.base_type = try gpa.dupe(u8, base);
                        }
                    }
                } else if (std.mem.eql(u8, se.name, "list")) {
                    if (simple_stack.items.len > 0 and simple_stack.items[simple_stack.items.len - 1] != null) {
                        if (se.getAttribute("itemType")) |it| {
                            simple_stack.items[simple_stack.items.len - 1].?.base_type = try gpa.dupe(u8, it);
                        }
                    }
                } else if (std.mem.eql(u8, se.name, "enumeration")) {
                    if (simple_stack.items.len > 0 and simple_stack.items[simple_stack.items.len - 1] != null) {
                        if (se.getAttribute("value")) |val| {
                            try simple_stack.items[simple_stack.items.len - 1].?.enums.append(gpa, try gpa.dupe(u8, val));
                        }
                    }
                } else if (std.mem.eql(u8, se.name, "choice")) {
                    if (complex_stack.items.len > 0) {
                        complex_stack.items[complex_stack.items.len - 1].choice_depth += 1;
                    }
                } else if (std.mem.eql(u8, se.name, "attribute")) {
                    if (complex_stack.items.len > 0) {
                        if (complex_stack.items[complex_stack.items.len - 1].ct) |ct| {
                            const attr_name_raw = se.getAttribute("name") orelse blk: {
                                if (se.getAttribute("ref")) |ref| {
                                    if (std.mem.indexOfScalar(u8, ref, ':')) |idx| break :blk ref[idx + 1 ..];
                                    break :blk ref;
                                }
                                break :blk "";
                            };
                            if (attr_name_raw.len > 0) {
                                const attr_type = se.getAttribute("type") orelse "string";
                                const is_req = if (se.getAttribute("use")) |u| std.mem.eql(u8, u, "required") else false;
                                try ct.attributes.append(gpa, .{
                                    .name = try gpa.dupe(u8, attr_name_raw),
                                    .type_name = try gpa.dupe(u8, attr_type),
                                    .is_required = is_req,
                                });
                            }
                        }
                    }
                } else if (std.mem.eql(u8, se.name, "element")) {
                    const ref_attr = se.getAttribute("ref");
                    const name_raw = se.getAttribute("name") orelse blk: {
                        if (ref_attr) |ref| {
                            if (std.mem.indexOfScalar(u8, ref, ':')) |idx| break :blk ref[idx + 1 ..];
                            break :blk ref;
                        }
                        break :blk "";
                    };
                    const type_raw = se.getAttribute("type") orelse (ref_attr orelse "");
                    var elem_ns: ?[]const u8 = null;
                    if (ref_attr) |ref| {
                        if (std.mem.indexOfScalar(u8, ref, ':')) |idx| {
                            if (reader.resolvePrefix(ref[0..idx])) |uri| {
                                elem_ns = try gpa.dupe(u8, uri);
                            }
                        }
                    }

                    var min_occ: usize = 1;
                    if (se.getAttribute("minOccurs")) |mo| {
                        min_occ = std.fmt.parseInt(usize, mo, 10) catch min_occ;
                    }
                    if (complex_stack.items.len > 0 and
                        complex_stack.items[complex_stack.items.len - 1].choice_depth > 0)
                    {
                        min_occ = 0;
                    }

                    var max_occ: ?usize = 1;
                    if (se.getAttribute("maxOccurs")) |mo| {
                        if (std.mem.eql(u8, mo, "unbounded")) {
                            max_occ = null;
                        } else {
                            max_occ = std.fmt.parseInt(usize, mo, 10) catch 1;
                        }
                    }

                    if (name_raw.len > 0) {
                        try elem_stack.append(gpa, .{
                            .name = try gpa.dupe(u8, name_raw),
                            .type_name = try gpa.dupe(u8, type_raw),
                            .min_occurs = min_occ,
                            .max_occurs = max_occ,
                            .namespace = elem_ns,
                        });
                    } else {
                        try elem_stack.append(gpa, null);
                    }
                } else if (std.mem.eql(u8, se.name, "any")) {
                    if (complex_stack.items.len > 0) {
                        if (complex_stack.items[complex_stack.items.len - 1].ct) |ct| {
                            try ct.elements.append(gpa, .{
                                .name = "any",
                                .type_name = "xs:any",
                                .min_occurs = 0,
                                .max_occurs = null,
                                .is_any = true,
                            });
                        }
                    }
                }
            },
            .end_element => |ee| {
                if (std.mem.eql(u8, ee.name, "choice")) {
                    if (complex_stack.items.len > 0 and
                        complex_stack.items[complex_stack.items.len - 1].choice_depth > 0)
                    {
                        complex_stack.items[complex_stack.items.len - 1].choice_depth -= 1;
                    }
                } else if (std.mem.eql(u8, ee.name, "complexType")) {
                    if (complex_stack.pop()) |frame| {
                        if (frame.ct) |ct| {
                            if (frame.attached_to_elem) {
                                if (elem_stack.items.len > 0 and elem_stack.items[elem_stack.items.len - 1] != null) {
                                    elem_stack.items[elem_stack.items.len - 1].?.inline_complex = ct;
                                } else {
                                    ct.deinit(gpa);
                                    gpa.destroy(ct);
                                }
                            } else {
                                if (findComplexIndex(schema.complex_types.items, ct.name) == null) {
                                    try schema.complex_types.append(gpa, ct.*);
                                } else {
                                    ct.deinit(gpa);
                                }
                                gpa.destroy(ct);
                            }
                        }
                    }
                } else if (std.mem.eql(u8, ee.name, "simpleType")) {
                    if (simple_stack.pop()) |maybe_st| {
                        if (maybe_st) |st| {
                            if (findSimpleIndex(schema.simple_types.items, st.name) == null) {
                                try schema.simple_types.append(gpa, st);
                            } else {
                                var st_mut = st;
                                st_mut.deinit(gpa);
                            }
                        }
                    }
                } else if (std.mem.eql(u8, ee.name, "element")) {
                    if (elem_stack.pop()) |maybe_el| {
                        if (maybe_el) |el| {
                            if (complex_stack.items.len > 0) {
                                if (complex_stack.items[complex_stack.items.len - 1].ct) |ct| {
                                    try ct.elements.append(gpa, el);
                                } else if (el.inline_complex) |ic| {
                                    ic.deinit(gpa);
                                    gpa.destroy(ic);
                                }
                            } else {
                                try schema.elements.append(gpa, el);
                            }
                        }
                    }
                }
            },
            else => {},
        }
    }
}

fn stripPrefix(qname: []const u8) []const u8 {
    if (std.mem.indexOfScalar(u8, qname, ':')) |idx| {
        return qname[idx + 1 ..];
    }
    return qname;
}

fn cloneComplexType(alloc: std.mem.Allocator, ct: *const ComplexType) !*ComplexType {
    const copy = try alloc.create(ComplexType);
    copy.* = .{
        .name = ct.name,
        .elements = .empty,
        .attributes = .empty,
        .base_type = ct.base_type,
        .is_simple_content = ct.is_simple_content,
        .is_choice = ct.is_choice,
    };
    for (ct.elements.items) |el| {
        var el_copy = el;
        if (el.inline_complex) |ic| {
            el_copy.inline_complex = try cloneComplexType(alloc, ic);
        }
        try copy.elements.append(alloc, el_copy);
    }
    try copy.attributes.appendSlice(alloc, ct.attributes.items);
    return copy;
}

fn findComplexIndex(types: []const ComplexType, local_name: []const u8) ?usize {
    for (types, 0..) |ct, i| {
        if (std.mem.eql(u8, ct.name, local_name)) return i;
    }
    return null;
}

fn findSimpleIndex(types: []const SimpleType, local_name: []const u8) ?usize {
    for (types, 0..) |st, i| {
        if (std.mem.eql(u8, st.name, local_name)) return i;
    }
    return null;
}

fn resolveComplexOne(
    alloc: std.mem.Allocator,
    schema: *Schema,
    base_schema: ?*const Schema,
    idx: usize,
    resolved: []bool,
    visiting: []bool,
) !void {
    if (resolved[idx] or visiting[idx]) return;
    visiting[idx] = true;
    defer {
        visiting[idx] = false;
        resolved[idx] = true;
    }

    const base_qname = schema.complex_types.items[idx].base_type orelse return;
    if (std.mem.startsWith(u8, base_qname, "xs:") or std.mem.startsWith(u8, base_qname, "xsd:")) {
        return;
    }
    const base_local = stripPrefix(base_qname);

    var base_ct_opt: ?*const ComplexType = null;
    var base_ns: ?[]const u8 = null;
    if (findComplexIndex(schema.complex_types.items, base_local)) |base_idx| {
        if (base_idx != idx) {
            try resolveComplexOne(alloc, schema, base_schema, base_idx, resolved, visiting);
            base_ct_opt = &schema.complex_types.items[base_idx];
        }
    } else if (base_schema) |bs| {
        if (findComplexIndex(bs.complex_types.items, base_local)) |base_idx| {
            base_ct_opt = &bs.complex_types.items[base_idx];
            if (bs.element_form_qualified and bs.target_namespace.len > 0) {
                base_ns = bs.target_namespace;
            }
        }
    }

    const base_ct = base_ct_opt orelse return;
    try applyBaseComplexType(alloc, &schema.complex_types.items[idx], base_ct, base_ns);
}

fn applyBaseComplexType(
    alloc: std.mem.Allocator,
    ct: *ComplexType,
    base_ct: *const ComplexType,
    base_ns: ?[]const u8,
) !void {
    var new_elements: std.ArrayList(Element) = .empty;
    for (base_ct.elements.items) |el| {
        var el_copy = el;
        if (el_copy.namespace == null) el_copy.namespace = base_ns;
        if (el.inline_complex) |ic| {
            el_copy.inline_complex = try cloneComplexType(alloc, ic);
        }
        try new_elements.append(alloc, el_copy);
    }
    try new_elements.appendSlice(alloc, ct.elements.items);
    ct.elements.deinit(alloc);
    ct.elements = new_elements;

    var new_attributes: std.ArrayList(Attribute) = .empty;
    try new_attributes.appendSlice(alloc, base_ct.attributes.items);
    try new_attributes.appendSlice(alloc, ct.attributes.items);
    ct.attributes.deinit(alloc);
    ct.attributes = new_attributes;

    if (base_ct.is_simple_content and !ct.is_simple_content) {
        ct.is_simple_content = true;
        ct.base_type = base_ct.base_type;
    }
}

pub fn resolveInheritance(
    alloc: std.mem.Allocator,
    schema: *Schema,
    base_schema: ?*const Schema,
) !void {
    const n = schema.complex_types.items.len;
    if (n > 0) {
        const resolved = try alloc.alloc(bool, n);
        defer alloc.free(resolved);
        @memset(resolved, false);

        const visiting = try alloc.alloc(bool, n);
        defer alloc.free(visiting);
        @memset(visiting, false);

        for (0..n) |i| {
            try resolveComplexOne(alloc, schema, base_schema, i, resolved, visiting);
        }
    }

    // Also resolve inheritance on top-level elements with inline complexTypes
    for (schema.elements.items) |*el| {
        if (el.inline_complex) |ic| {
            if (ic.base_type) |base_qname| {
                if (!std.mem.startsWith(u8, base_qname, "xs:") and !std.mem.startsWith(u8, base_qname, "xsd:")) {
                    const base_local = stripPrefix(base_qname);
                    if (findComplexIndex(schema.complex_types.items, base_local)) |base_idx| {
                        try applyBaseComplexType(alloc, ic, &schema.complex_types.items[base_idx], null);
                    } else if (base_schema) |bs| {
                        if (findComplexIndex(bs.complex_types.items, base_local)) |base_idx| {
                            const base_ns: ?[]const u8 = if (bs.element_form_qualified and bs.target_namespace.len > 0)
                                bs.target_namespace
                            else
                                null;
                            try applyBaseComplexType(alloc, ic, &bs.complex_types.items[base_idx], base_ns);
                        }
                    }
                }
            }
        }
    }
}
