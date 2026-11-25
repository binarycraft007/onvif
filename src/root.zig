const std = @import("std");

pub const xml = struct {
    pub const Reader = @import("xml/Reader.zig").Reader;
    pub const Writer = @import("xml/Writer.zig").Writer;
    pub const Node = @import("xml/Any.zig").Node;
    pub const Any = @import("xml/Any.zig").Any;
};

pub const codec = @import("codec.zig");
pub const xsd = @import("xsd_types.zig");
pub const soap = @import("soap.zig");

pub const spec = @import("spec/generated.zig");

pub const transport = struct {
    pub const auth = @import("transport/auth.zig");
    pub const Client = @import("transport/Client.zig").Client;
    pub const Server = @import("transport/Server.zig").Server;
    pub const Router = @import("transport/Server.zig").Router;
    pub const Discovery = @import("transport/Discovery.zig");
    pub const PullPoint = @import("transport/PullPoint.zig");
};

test {
    std.testing.refAllDecls(@This());
    const gen = @import("spec/generated.zig");
    std.testing.refAllDecls(gen);
    std.testing.refAllDecls(gen.schema);
    std.testing.refAllDecls(gen.services.device.Device);
    std.testing.refAllDecls(gen.services.media.Media);
    std.testing.refAllDecls(gen.services.media2.Media2);
    std.testing.refAllDecls(gen.services.ptz.PTZ);
    std.testing.refAllDecls(gen.services.imaging.Imaging);
    std.testing.refAllDecls(gen.services.event.Event);
    std.testing.refAllDecls(gen.services.deviceio.DeviceIO);
    _ = @import("xml/Reader.zig");
    _ = @import("xml/Writer.zig");
    _ = @import("xml/Any.zig");
    _ = @import("xsd_types.zig");
    _ = @import("codec.zig");
    _ = @import("soap.zig");
    _ = @import("transport/auth.zig");
    _ = @import("transport/Server.zig");
    _ = @import("transport/Client.zig");
    _ = @import("transport/Discovery.zig");
    _ = @import("transport/PullPoint.zig");
    _ = @import("spec/integration_test.zig");
}
