const std = @import("std");
const xml = struct {
    pub const Reader = @import("xml_reader").Reader;
};
const xsd = @import("xsd.zig");

pub const Operation = struct {
    name: []const u8,
    soap_action: []const u8,
    input_message: []const u8,
    output_message: []const u8,
    input_element: []const u8,
    output_element: []const u8,
};

pub const PortType = struct {
    name: []const u8,
    operations: std.ArrayList(Operation),

    pub fn deinit(self: *PortType, gpa: std.mem.Allocator) void {
        self.operations.deinit(gpa);
    }
};

pub const Wsdl = struct {
    target_namespace: []const u8,
    schema: ?xsd.Schema = null,
    port_types: std.ArrayList(PortType),

    pub fn init(target_namespace: []const u8) Wsdl {
        return .{
            .target_namespace = target_namespace,
            .port_types = .empty,
        };
    }

    pub fn deinit(self: *Wsdl, gpa: std.mem.Allocator) void {
        if (self.schema) |*s| s.deinit(gpa);
        for (self.port_types.items) |*pt| pt.deinit(gpa);
        self.port_types.deinit(gpa);
    }
};

pub fn parseWsdl(gpa: std.mem.Allocator, xml_data: []const u8) !Wsdl {
    var fixed_stream = std.Io.Reader.fixed(xml_data);
    var reader = xml.Reader.init(gpa, &fixed_stream);
    defer reader.deinit();

    var target_ns: []const u8 = "";
    var wsdl = Wsdl.init("");

    var current_port: ?PortType = null;
    var current_op_name: ?[]const u8 = null;
    var current_input_msg: ?[]const u8 = null;
    var current_output_msg: ?[]const u8 = null;

    var action_map = std.StringHashMap([]const u8).init(gpa);
    defer action_map.deinit();

    var message_to_element = std.StringHashMap([]const u8).init(gpa);
    defer message_to_element.deinit();

    var in_binding = false;
    var binding_op_depth: usize = 0;
    var binding_op_name: ?[]const u8 = null;
    var current_message_name: ?[]const u8 = null;

    while (true) {
        const ev = try reader.next();
        switch (ev) {
            .eof => break,
            .start_element => |se| {
                if (std.mem.eql(u8, se.name, "definitions")) {
                    if (se.getAttribute("targetNamespace")) |tns| {
                        target_ns = try gpa.dupe(u8, tns);
                        wsdl.target_namespace = target_ns;
                    }
                } else if (std.mem.eql(u8, se.name, "message")) {
                    if (se.getAttribute("name")) |name| {
                        current_message_name = try gpa.dupe(u8, name);
                    }
                } else if (std.mem.eql(u8, se.name, "part")) {
                    if (current_message_name) |mname| {
                        if (se.getAttribute("element")) |elem_qname| {
                            const local_elem = if (std.mem.indexOfScalar(u8, elem_qname, ':')) |idx|
                                elem_qname[idx + 1 ..]
                            else
                                elem_qname;
                            try message_to_element.put(mname, try gpa.dupe(u8, local_elem));
                        }
                    }
                } else if (std.mem.eql(u8, se.name, "portType")) {
                    if (se.getAttribute("name")) |name| {
                        current_port = .{
                            .name = try gpa.dupe(u8, name),
                            .operations = .empty,
                        };
                    }
                } else if (std.mem.eql(u8, se.name, "binding")) {
                    in_binding = true;
                    binding_op_depth = 0;
                    binding_op_name = null;
                } else if (std.mem.eql(u8, se.name, "operation")) {
                    if (in_binding) {
                        binding_op_depth += 1;
                        if (se.getAttribute("name")) |name| {
                            binding_op_name = try gpa.dupe(u8, name);
                        }
                        if (se.getAttribute("soapAction")) |sa| {
                            if (sa.len > 0) {
                                if (binding_op_name) |bon| {
                                    try action_map.put(bon, try gpa.dupe(u8, sa));
                                }
                            }
                        }
                    } else if (current_port != null) {
                        if (se.getAttribute("name")) |name| {
                            current_op_name = try gpa.dupe(u8, name);
                            current_input_msg = null;
                            current_output_msg = null;
                        }
                    }
                } else if (!in_binding and current_op_name != null) {
                    if (std.mem.eql(u8, se.name, "input")) {
                        if (se.getAttribute("message")) |msg| {
                            const local_msg = if (std.mem.indexOfScalar(u8, msg, ':')) |idx|
                                msg[idx + 1 ..]
                            else
                                msg;
                            current_input_msg = try gpa.dupe(u8, local_msg);
                        }
                    } else if (std.mem.eql(u8, se.name, "output")) {
                        if (se.getAttribute("message")) |msg| {
                            const local_msg = if (std.mem.indexOfScalar(u8, msg, ':')) |idx|
                                msg[idx + 1 ..]
                            else
                                msg;
                            current_output_msg = try gpa.dupe(u8, local_msg);
                        }
                    }
                }
            },
            .end_element => |ee| {
                if (std.mem.eql(u8, ee.name, "message")) {
                    current_message_name = null;
                } else if (std.mem.eql(u8, ee.name, "portType")) {
                    if (current_port) |pt| {
                        try wsdl.port_types.append(gpa, pt);
                        current_port = null;
                    }
                } else if (std.mem.eql(u8, ee.name, "binding")) {
                    in_binding = false;
                    binding_op_depth = 0;
                    binding_op_name = null;
                } else if (std.mem.eql(u8, ee.name, "operation")) {
                    if (in_binding) {
                        if (binding_op_depth > 0) binding_op_depth -= 1;
                        if (binding_op_depth == 0) binding_op_name = null;
                    } else if (current_port != null and current_op_name != null) {
                        const op_name = current_op_name.?;
                        const in_msg = current_input_msg orelse op_name;
                        const out_msg = current_output_msg orelse try std.fmt.allocPrint(gpa, "{s}Response", .{op_name});

                        try current_port.?.operations.append(gpa, .{
                            .name = op_name,
                            .soap_action = "",
                            .input_message = in_msg,
                            .output_message = out_msg,
                            .input_element = "",
                            .output_element = "",
                        });
                        current_op_name = null;
                    }
                }
            },
            else => {},
        }
    }

    // Resolve bindings and message -> element mappings after full WSDL pass
    for (wsdl.port_types.items) |*pt| {
        for (pt.operations.items) |*op| {
            op.soap_action = action_map.get(op.name) orelse
                try std.fmt.allocPrint(gpa, "{s}/{s}", .{ target_ns, op.name });
            op.input_element = message_to_element.get(op.input_message) orelse op.name;
            op.output_element = message_to_element.get(op.output_message) orelse
                try std.fmt.allocPrint(gpa, "{s}Response", .{op.name});
        }
    }

    wsdl.schema = try xsd.parseSchema(gpa, xml_data);
    return wsdl;
}
