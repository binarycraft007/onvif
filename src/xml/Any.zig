const std = @import("std");
const reader_mod = @import("Reader.zig");
const Reader = reader_mod.Reader;
const StartElement = reader_mod.StartElement;
const Writer = @import("Writer.zig").Writer;

const XMLNS_URI = "http://www.w3.org/2000/xmlns/";

pub const Attribute = struct {
    name: []const u8,
    prefix: ?[]const u8 = null,
    ns_uri: ?[]const u8 = null,
    value: []const u8,

    pub fn clone(self: Attribute, allocator: std.mem.Allocator) !Attribute {
        const name = try allocator.dupe(u8, self.name);
        errdefer allocator.free(name);
        const prefix = if (self.prefix) |p| try allocator.dupe(u8, p) else null;
        errdefer if (prefix) |p| allocator.free(p);
        const ns_uri = if (self.ns_uri) |u| try allocator.dupe(u8, u) else null;
        errdefer if (ns_uri) |u| allocator.free(u);
        const value = try allocator.dupe(u8, self.value);

        return .{
            .name = name,
            .prefix = prefix,
            .ns_uri = ns_uri,
            .value = value,
        };
    }

    pub fn deinit(self: Attribute, allocator: std.mem.Allocator) void {
        allocator.free(self.name);
        if (self.prefix) |p| allocator.free(p);
        if (self.ns_uri) |u| allocator.free(u);
        allocator.free(self.value);
    }
};

pub const Node = struct {
    name: []const u8,
    prefix: ?[]const u8 = null,
    ns_uri: ?[]const u8 = null,
    attributes: []const Attribute = &.{},
    text: ?[]const u8 = null,
    children: []const Node = &.{},

    pub fn deinit(self: Node, allocator: std.mem.Allocator) void {
        allocator.free(self.name);
        if (self.prefix) |p| allocator.free(p);
        if (self.ns_uri) |u| allocator.free(u);
        for (self.attributes) |attr| {
            attr.deinit(allocator);
        }
        if (self.attributes.len > 0) allocator.free(self.attributes);
        if (self.text) |t| allocator.free(t);
        for (self.children) |child| {
            child.deinit(allocator);
        }
        if (self.children.len > 0) allocator.free(self.children);
    }

    pub fn writeTo(self: Node, w: *Writer) !void {
        try w.startElementNs(self.ns_uri, self.name, self.prefix);
        for (self.attributes) |attr| {
            if (attr.ns_uri) |uri| {
                if (std.mem.eql(u8, uri, XMLNS_URI)) {
                    if (attr.prefix) |p| {
                        if (std.mem.eql(u8, p, "xmlns") and !std.mem.eql(u8, attr.name, "xmlns")) {
                            if (!w.isPrefixBoundTo(attr.name, attr.value)) {
                                try w.attributePrefix("xmlns", attr.name, attr.value);
                            }
                        }
                    } else if (std.mem.eql(u8, attr.name, "xmlns")) {
                        if (!w.isPrefixBoundTo("", attr.value)) {
                            try w.attribute("xmlns", attr.value);
                        }
                    }
                    continue;
                }
                try w.attributeNs(uri, attr.name, attr.prefix, attr.value);
            } else if (attr.prefix) |p| {
                try w.attributePrefix(p, attr.name, attr.value);
            } else {
                try w.attribute(attr.name, attr.value);
            }
        }
        if (self.text) |t| {
            try w.writeCharacters(t);
        }
        for (self.children) |child| {
            try child.writeTo(w);
        }
        try w.endElement();
    }
};

pub const Any = struct {
    nodes: []const Node = &.{},

    pub fn deinit(self: Any, allocator: std.mem.Allocator) void {
        for (self.nodes) |node| {
            node.deinit(allocator);
        }
        if (self.nodes.len > 0) allocator.free(self.nodes);
    }

    pub fn writeTo(self: Any, w: *Writer) !void {
        for (self.nodes) |node| {
            try node.writeTo(w);
        }
    }
};

pub fn readNodeAlloc(r: *Reader, gpa: std.mem.Allocator) !Node {
    while (true) {
        const tok = try r.next();
        switch (tok) {
            .start_element => |se| {
                return readNodeFromStartElement(r, gpa, se);
            },
            .characters => |chars| {
                if (std.mem.trim(u8, chars, " \t\r\n").len != 0) {
                    return error.MalformedXml;
                }
            },
            .comment => {},
            .eof => return error.UnexpectedEof,
            .end_element => return error.MalformedXml,
        }
    }
}

pub fn readNodeFromStartElement(r: *Reader, gpa: std.mem.Allocator, se: StartElement) !Node {
    const name = try gpa.dupe(u8, se.name);
    errdefer gpa.free(name);
    const prefix = if (se.prefix) |p| try gpa.dupe(u8, p) else null;
    errdefer if (prefix) |p| gpa.free(p);
    const ns_uri = if (se.ns_uri) |u| try gpa.dupe(u8, u) else null;
    errdefer if (ns_uri) |u| gpa.free(u);

    var attrs: std.ArrayList(Attribute) = .empty;
    errdefer {
        for (attrs.items) |attr| attr.deinit(gpa);
        attrs.deinit(gpa);
    }
    try attrs.ensureTotalCapacity(gpa, se.attributes.len);
    for (se.attributes) |attr| {
        const a_name = try gpa.dupe(u8, attr.name);
        errdefer gpa.free(a_name);
        const a_prefix = if (attr.prefix) |p| try gpa.dupe(u8, p) else null;
        errdefer if (a_prefix) |p| gpa.free(p);
        const a_ns_uri = if (attr.ns_uri) |u| try gpa.dupe(u8, u) else null;
        errdefer if (a_ns_uri) |u| gpa.free(u);
        const a_val = try gpa.dupe(u8, attr.value);

        attrs.appendAssumeCapacity(.{
            .name = a_name,
            .prefix = a_prefix,
            .ns_uri = a_ns_uri,
            .value = a_val,
        });
    }

    if (se.is_empty) {
        const end_tok = try r.next();
        if (end_tok != .end_element) return error.UnexpectedToken;
        return .{
            .name = name,
            .prefix = prefix,
            .ns_uri = ns_uri,
            .attributes = try attrs.toOwnedSlice(gpa),
            .text = null,
            .children = &.{},
        };
    }

    var text_list: std.ArrayList(u8) = .empty;
    errdefer text_list.deinit(gpa);

    var children: std.ArrayList(Node) = .empty;
    errdefer {
        for (children.items) |child| child.deinit(gpa);
        children.deinit(gpa);
    }

    while (true) {
        const next_tok = try r.next();
        switch (next_tok) {
            .characters => |chars| {
                try text_list.appendSlice(gpa, chars);
            },
            .start_element => |child_se| {
                const child_node = try readNodeFromStartElement(r, gpa, child_se);
                errdefer child_node.deinit(gpa);
                try children.append(gpa, child_node);
            },
            .end_element => break,
            .comment => {},
            .eof => return error.UnexpectedEof,
        }
    }

    const text: ?[]const u8 = if (text_list.items.len > 0)
        try text_list.toOwnedSlice(gpa)
    else blk: {
        text_list.deinit(gpa);
        break :blk null;
    };
    errdefer if (text) |t| gpa.free(t);

    const attrs_slice = try attrs.toOwnedSlice(gpa);
    errdefer {
        for (attrs_slice) |attr| attr.deinit(gpa);
        if (attrs_slice.len > 0) gpa.free(attrs_slice);
    }

    const children_slice = try children.toOwnedSlice(gpa);

    return .{
        .name = name,
        .prefix = prefix,
        .ns_uri = ns_uri,
        .attributes = attrs_slice,
        .text = text,
        .children = children_slice,
    };
}

test "xml.Any readNodeAlloc and writeTo preserves namespaces without xmlns:xmlns or duplicates" {
    const gpa = std.testing.allocator;
    const input =
        \\<!-- leading comment -->
        \\<tt:Config xmlns:tt="http://www.onvif.org/ver10/schema" xmlns:dn="http://www.onvif.org/ver10/network/wsdl" token="v1">
        \\  <tt:Types>dn:NetworkVideoTransmitter</tt:Types>
        \\  <Empty/>
        \\</tt:Config>
    ;

    var r_impl: std.Io.Reader = .fixed(input);
    var reader = Reader.init(gpa, &r_impl);
    defer reader.deinit();

    const node = try readNodeAlloc(&reader, gpa);
    defer node.deinit(gpa);

    var out: std.Io.Writer.Allocating = .init(gpa);
    defer out.deinit();
    var writer = Writer.init(gpa, &out.writer);
    defer writer.deinit();

    try node.writeTo(&writer);
    try writer.flush();

    const written = out.written();
    try std.testing.expect(std.mem.indexOf(u8, written, "xmlns:xmlns") == null);
    try std.testing.expect(std.mem.indexOf(u8, written, "xmlns:dn=\"http://www.onvif.org/ver10/network/wsdl\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, written, "token=\"v1\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, written, "<Empty/>") != null);

    // Ensure xmlns:tt appears only once
    const first_tt = std.mem.indexOf(u8, written, "xmlns:tt=").?;
    try std.testing.expect(std.mem.indexOfPos(u8, written, first_tt + 1, "xmlns:tt=") == null);

    // Verify re-parsing the serialized output succeeds cleanly
    var r2_impl: std.Io.Reader = .fixed(written);
    var reader2 = Reader.init(gpa, &r2_impl);
    defer reader2.deinit();

    const node2 = try readNodeAlloc(&reader2, gpa);
    defer node2.deinit(gpa);
    try std.testing.expectEqualStrings("Config", node2.name);
    try std.testing.expectEqual(@as(usize, 2), node2.children.len);
}
