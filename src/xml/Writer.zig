const std = @import("std");

pub const Writer = struct {
    const XML_NS = "http://www.w3.org/XML/1998/namespace";

    const ElementRecord = struct {
        prefix: ?[]const u8,
        local_name: []const u8,
        ns_uri: ?[]const u8,
        has_children: bool = false,
    };

    const NsBinding = struct {
        prefix: []const u8,
        uri: []const u8,
        depth: usize,
    };

    w: *std.Io.Writer,
    allocator: std.mem.Allocator,
    elem_stack: std.ArrayList(ElementRecord) = .empty,
    ns_stack: std.ArrayList(NsBinding) = .empty,
    in_start_tag: bool = false,

    pub fn init(allocator: std.mem.Allocator, w: *std.Io.Writer) Writer {
        return .{
            .w = w,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Writer) void {
        for (self.elem_stack.items) |e| {
            if (e.prefix) |p| self.allocator.free(p);
            self.allocator.free(e.local_name);
            if (e.ns_uri) |u| self.allocator.free(u);
        }
        self.elem_stack.deinit(self.allocator);

        for (self.ns_stack.items) |b| {
            self.allocator.free(b.prefix);
            self.allocator.free(b.uri);
        }
        self.ns_stack.deinit(self.allocator);
    }

    pub fn findPrefixForUri(self: *const Writer, uri: []const u8) ?[]const u8 {
        var i = self.ns_stack.items.len;
        while (i > 0) {
            i -= 1;
            const b = self.ns_stack.items[i];
            if (std.mem.eql(u8, b.uri, uri)) return b.prefix;
        }
        return null;
    }

    fn findNonEmptyPrefixForUri(self: *const Writer, uri: []const u8) ?[]const u8 {
        var i = self.ns_stack.items.len;
        while (i > 0) {
            i -= 1;
            const b = self.ns_stack.items[i];
            if (b.prefix.len > 0 and std.mem.eql(u8, b.uri, uri)) return b.prefix;
        }
        return null;
    }

    fn currentDefaultNs(self: *const Writer) ?[]const u8 {
        var i = self.ns_stack.items.len;
        while (i > 0) {
            i -= 1;
            const b = self.ns_stack.items[i];
            if (b.prefix.len == 0) return b.uri;
        }
        return null;
    }

    pub fn isPrefixBoundTo(self: *const Writer, prefix: []const u8, uri: []const u8) bool {
        var i = self.ns_stack.items.len;
        while (i > 0) {
            i -= 1;
            const b = self.ns_stack.items[i];
            if (std.mem.eql(u8, b.prefix, prefix)) {
                return std.mem.eql(u8, b.uri, uri);
            }
        }
        return false;
    }

    fn isPrefixBoundAtDepth(self: *const Writer, prefix: []const u8, depth: usize) bool {
        var i = self.ns_stack.items.len;
        while (i > 0) {
            i -= 1;
            const b = self.ns_stack.items[i];
            if (b.depth < depth) break;
            if (std.mem.eql(u8, b.prefix, prefix)) return true;
        }
        return false;
    }

    fn pushNsBinding(self: *Writer, prefix: []const u8, uri: []const u8, depth: usize) !void {
        const p_dup = try self.allocator.dupe(u8, prefix);
        errdefer self.allocator.free(p_dup);
        const u_dup = try self.allocator.dupe(u8, uri);
        errdefer self.allocator.free(u_dup);
        try self.ns_stack.append(self.allocator, .{
            .prefix = p_dup,
            .uri = u_dup,
            .depth = depth,
        });
    }

    fn closeStartTagIfNeeded(self: *Writer) !void {
        if (self.in_start_tag) {
            try self.w.writeByte('>');
            self.in_start_tag = false;
        }
    }

    pub fn startElement(self: *Writer, local_name: []const u8) !void {
        try self.startElementNs(null, local_name, null);
    }

    pub fn startElementNs(
        self: *Writer,
        ns_uri: ?[]const u8,
        local_name: []const u8,
        preferred_prefix: ?[]const u8,
    ) !void {
        try self.closeStartTagIfNeeded();
        if (self.elem_stack.items.len > 0) {
            self.elem_stack.items[self.elem_stack.items.len - 1].has_children = true;
        }

        const current_depth = self.elem_stack.items.len + 1;
        var prefix_to_use: ?[]const u8 = null;
        var needs_ns_decl = false;
        var undeclare_default_ns = false;

        if (ns_uri) |uri| {
            if (preferred_prefix) |pref| {
                if (!self.isPrefixBoundTo(pref, uri)) {
                    needs_ns_decl = true;
                }
                prefix_to_use = pref;
            } else if (self.findPrefixForUri(uri)) |bound_prefix| {
                prefix_to_use = if (bound_prefix.len == 0) null else bound_prefix;
            } else {
                needs_ns_decl = true;
                prefix_to_use = null;
            }
        } else if (self.currentDefaultNs()) |def_uri| {
            if (def_uri.len > 0) {
                undeclare_default_ns = true;
            }
        }

        try self.w.writeByte('<');
        if (prefix_to_use) |p| {
            if (p.len > 0) {
                try self.w.writeAll(p);
                try self.w.writeByte(':');
            }
        }
        try self.w.writeAll(local_name);

        self.in_start_tag = true;

        const elem_pref_dup = if (prefix_to_use) |p| try self.allocator.dupe(u8, p) else null;
        errdefer if (elem_pref_dup) |p| self.allocator.free(p);
        const elem_name_dup = try self.allocator.dupe(u8, local_name);
        errdefer self.allocator.free(elem_name_dup);
        const elem_ns_dup = if (ns_uri) |u| try self.allocator.dupe(u8, u) else null;
        errdefer if (elem_ns_dup) |u| self.allocator.free(u);

        try self.elem_stack.append(self.allocator, .{
            .prefix = elem_pref_dup,
            .local_name = elem_name_dup,
            .ns_uri = elem_ns_dup,
            .has_children = false,
        });

        if (needs_ns_decl and ns_uri != null) {
            const uri = ns_uri.?;
            if (prefix_to_use) |p| {
                if (p.len > 0) {
                    try self.writeAttributeRaw("xmlns", p, uri);
                    try self.pushNsBinding(p, uri, current_depth);
                } else {
                    try self.writeAttributeRaw("", "xmlns", uri);
                    try self.pushNsBinding("", uri, current_depth);
                }
            } else {
                try self.writeAttributeRaw("", "xmlns", uri);
                try self.pushNsBinding("", uri, current_depth);
            }
        } else if (undeclare_default_ns) {
            try self.writeAttributeRaw("", "xmlns", "");
            try self.pushNsBinding("", "", current_depth);
        }
    }

    fn writeAttributeRaw(self: *Writer, prefix: []const u8, name: []const u8, value: []const u8) !void {
        std.debug.assert(self.in_start_tag);
        try self.w.writeByte(' ');
        if (prefix.len > 0) {
            try self.w.writeAll(prefix);
            try self.w.writeByte(':');
        }
        try self.w.writeAll(name);
        try self.w.writeAll("=\"");
        try self.writeEscaped(value, true);
        try self.w.writeByte('"');
    }

    pub fn attribute(self: *Writer, name: []const u8, value: []const u8) !void {
        if (std.mem.eql(u8, name, "xmlns")) {
            try self.pushNsBinding("", value, self.elem_stack.items.len);
        }
        try self.writeAttributeRaw("", name, value);
    }

    pub fn attributePrefix(self: *Writer, prefix: []const u8, name: []const u8, value: []const u8) !void {
        if (std.mem.eql(u8, prefix, "xmlns") and name.len > 0) {
            try self.pushNsBinding(name, value, self.elem_stack.items.len);
        }
        try self.writeAttributeRaw(prefix, name, value);
    }

    pub fn attributeNs(
        self: *Writer,
        ns_uri: []const u8,
        name: []const u8,
        preferred_prefix: ?[]const u8,
        value: []const u8,
    ) !void {
        std.debug.assert(self.in_start_tag);

        if (std.mem.eql(u8, ns_uri, XML_NS)) {
            try self.writeAttributeRaw("xml", name, value);
            return;
        }

        const current_depth = self.elem_stack.items.len;
        var chosen_prefix: []const u8 = if (preferred_prefix) |p|
            (if (p.len > 0) p else (self.findNonEmptyPrefixForUri(ns_uri) orelse "ns"))
        else
            (self.findNonEmptyPrefixForUri(ns_uri) orelse "ns");

        var auto_buf: [16]u8 = undefined;
        if (!self.isPrefixBoundTo(chosen_prefix, ns_uri)) {
            if (self.isPrefixBoundAtDepth(chosen_prefix, current_depth)) {
                var n: usize = 1;
                while (true) : (n += 1) {
                    const cand = std.fmt.bufPrint(&auto_buf, "ns{d}", .{n}) catch unreachable;
                    if (!self.isPrefixBoundAtDepth(cand, current_depth)) {
                        chosen_prefix = cand;
                        break;
                    }
                }
            }
            if (!self.isPrefixBoundTo(chosen_prefix, ns_uri)) {
                try self.writeAttributeRaw("xmlns", chosen_prefix, ns_uri);
                try self.pushNsBinding(chosen_prefix, ns_uri, current_depth);
            }
        }
        try self.writeAttributeRaw(chosen_prefix, name, value);
    }

    pub fn writeCharacters(self: *Writer, text: []const u8) !void {
        try self.closeStartTagIfNeeded();
        if (self.elem_stack.items.len > 0) {
            self.elem_stack.items[self.elem_stack.items.len - 1].has_children = true;
        }
        try self.writeEscaped(text, false);
    }

    pub fn writeRaw(self: *Writer, raw_xml: []const u8) !void {
        try self.closeStartTagIfNeeded();
        if (self.elem_stack.items.len > 0) {
            self.elem_stack.items[self.elem_stack.items.len - 1].has_children = true;
        }
        try self.w.writeAll(raw_xml);
    }

    pub fn writeComment(self: *Writer, comment: []const u8) !void {
        if (std.mem.indexOf(u8, comment, "--") != null) return error.InvalidComment;
        try self.closeStartTagIfNeeded();
        try self.w.writeAll("<!--");
        try self.w.writeAll(comment);
        try self.w.writeAll("-->");
    }

    pub fn endElement(self: *Writer) !void {
        if (self.elem_stack.items.len == 0) return;
        const elem = self.elem_stack.pop().?;
        defer {
            if (elem.prefix) |p| self.allocator.free(p);
            self.allocator.free(elem.local_name);
            if (elem.ns_uri) |u| self.allocator.free(u);
        }

        const depth = self.elem_stack.items.len + 1;
        while (self.ns_stack.items.len > 0) {
            const top = self.ns_stack.items[self.ns_stack.items.len - 1];
            if (top.depth >= depth) {
                const popped = self.ns_stack.pop().?;
                self.allocator.free(popped.prefix);
                self.allocator.free(popped.uri);
            } else {
                break;
            }
        }

        if (self.in_start_tag and !elem.has_children) {
            try self.w.writeAll("/>");
            self.in_start_tag = false;
        } else {
            try self.closeStartTagIfNeeded();
            try self.w.writeAll("</");
            if (elem.prefix) |p| {
                if (p.len > 0) {
                    try self.w.writeAll(p);
                    try self.w.writeByte(':');
                }
            }
            try self.w.writeAll(elem.local_name);
            try self.w.writeByte('>');
        }
    }

    pub fn flush(self: *Writer) !void {
        try self.closeStartTagIfNeeded();
        try self.w.flush();
    }

    fn writeEscaped(self: *Writer, text: []const u8, comptime is_attr: bool) !void {
        var start: usize = 0;
        for (text, 0..) |c, i| {
            const repl: ?[]const u8 = switch (c) {
                '&' => "&amp;",
                '<' => "&lt;",
                '>' => "&gt;",
                '"' => if (is_attr) "&quot;" else null,
                '\'' => if (is_attr) "&apos;" else null,
                else => null,
            };
            if (repl) |r| {
                if (i > start) {
                    try self.w.writeAll(text[start..i]);
                }
                try self.w.writeAll(r);
                start = i + 1;
            }
        }
        if (start < text.len) {
            try self.w.writeAll(text[start..]);
        }
    }
};

test "xml.Writer basic emission and escaping" {
    var out: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer out.deinit();

    var writer = Writer.init(std.testing.allocator, &out.writer);
    defer writer.deinit();

    try writer.startElementNs("http://www.w3.org/2003/05/soap-envelope", "Envelope", "s");
    try writer.startElementNs("http://www.onvif.org/ver10/schema", "GetDeviceInformation", "tt");
    try writer.attribute("token", "123 & \"special\"");
    try writer.startElement("Manufacturer");
    try writer.writeCharacters("ACME <Corp>");
    try writer.endElement();
    try writer.startElement("Empty");
    try writer.endElement();
    try writer.endElement();
    try writer.endElement();
    try writer.flush();

    const result = out.written();
    try std.testing.expect(std.mem.indexOf(u8, result, "<s:Envelope xmlns:s=\"http://www.w3.org/2003/05/soap-envelope\">") != null);
    try std.testing.expect(std.mem.indexOf(u8, result, "xmlns:tt=\"http://www.onvif.org/ver10/schema\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, result, "token=\"123 &amp; &quot;special&quot;\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, result, "<Manufacturer>ACME &lt;Corp&gt;</Manufacturer>") != null);
    try std.testing.expect(std.mem.indexOf(u8, result, "<Empty/>") != null);
}

test "xml.Writer default ns undeclare and attributeNs avoids default ns and prefix collision" {
    var out: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer out.deinit();

    var writer = Writer.init(std.testing.allocator, &out.writer);
    defer writer.deinit();

    try writer.startElementNs("urn:outer", "Root", null);
    try writer.attributeNs("urn:outer", "id", null, "1");
    try writer.attributeNs("urn:other", "lang", "xml", "en");
    try writer.startElement("Child");
    try writer.writeCharacters("plain");
    try writer.endElement();
    try writer.endElement();
    try writer.flush();

    const result = out.written();
    try std.testing.expect(std.mem.indexOf(u8, result, "xmlns=\"urn:outer\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, result, "xmlns:ns=\"urn:outer\" ns:id=\"1\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, result, "<Child xmlns=\"\">plain</Child>") != null);
}
