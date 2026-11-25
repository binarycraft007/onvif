//! ONVIF Generated Schemas and Services
//! Master module exporting all schemas and service definitions.
const std = @import("std");
pub const xsd = @import("../xsd_types.zig");
pub const xml_any = @import("../xml/Any.zig");

pub const schema = @import("schema.zig");

pub const services = struct {
    pub const device = @import("services/device.zig");
    pub const media = @import("services/media.zig");
    pub const media2 = @import("services/media2.zig");
    pub const ptz = @import("services/ptz.zig");
    pub const imaging = @import("services/imaging.zig");
    pub const event = @import("services/event.zig");
    pub const deviceio = @import("services/deviceio.zig");
    pub const recording = @import("services/recording.zig");
    pub const search = @import("services/search.zig");
    pub const replay = @import("services/replay.zig");
    pub const receiver = @import("services/receiver.zig");
    pub const analytics = @import("services/analytics.zig");
};

pub const Device = services.device.Device;
pub const Media = services.media.Media;
pub const Media2 = services.media2.Media2;
pub const PTZ = services.ptz.PTZ;
pub const Imaging = services.imaging.Imaging;
pub const Event = services.event.Event;
pub const DeviceIO = services.deviceio.DeviceIO;
pub const Recording = services.recording.Recording;
pub const Search = services.search.Search;
pub const Replay = services.replay.Replay;
pub const Receiver = services.receiver.Receiver;
pub const Analytics = services.analytics.Analytics;
