//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const Replay = struct {
    pub const namespace = "http://www.onvif.org/ver10/replay/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver10/replay/wsdl";

    pub const Capabilities = struct {
        ReversePlayback: ?bool = null,
        SessionTimeoutRange: ?[]const u8 = null,
        RTP_RTSP_TCP: ?bool = null,
        RTSPWebSocketUri: ?[]const u8 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Capabilities",
            .namespace = Replay.namespace_uri,
            .namespace_uri = Replay.namespace_uri,
            .attributes = &.{"ReversePlayback", "SessionTimeoutRange", "RTP_RTSP_TCP", "RTSPWebSocketUri"},
        };
    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver10/replay/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = Replay.namespace_uri;
        pub const namespace_uri = Replay.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = Replay.namespace_uri,
                .namespace_uri = Replay.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = Replay.namespace_uri,
                .namespace_uri = Replay.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Replay.namespace_uri },
                },
            };
        };

    };

    pub const GetReplayUri = struct {
        pub const name = "GetReplayUri";
        pub const soap_action = "http://www.onvif.org/ver10/replay/wsdl/GetReplayUri";
        pub const request_name = "GetReplayUri";
        pub const response_name = "GetReplayUriResponse";
        pub const namespace = Replay.namespace_uri;
        pub const namespace_uri = Replay.namespace_uri;

        pub const Request = struct {
            StreamSetup: schema.StreamSetup = .{},
            RecordingToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetReplayUri",
                .namespace = Replay.namespace_uri,
                .namespace_uri = Replay.namespace_uri,
                .fields = .{
                    .StreamSetup = .{ .ns = Replay.namespace_uri },
                    .RecordingToken = .{ .ns = Replay.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Uri: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetReplayUriResponse",
                .namespace = Replay.namespace_uri,
                .namespace_uri = Replay.namespace_uri,
                .fields = .{
                    .Uri = .{ .ns = Replay.namespace_uri },
                },
            };
        };

    };

    pub const GetReplayConfiguration = struct {
        pub const name = "GetReplayConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/replay/wsdl/GetReplayConfiguration";
        pub const request_name = "GetReplayConfiguration";
        pub const response_name = "GetReplayConfigurationResponse";
        pub const namespace = Replay.namespace_uri;
        pub const namespace_uri = Replay.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetReplayConfiguration",
                .namespace = Replay.namespace_uri,
                .namespace_uri = Replay.namespace_uri,
            };
        };

        pub const Response = struct {
            Configuration: schema.ReplayConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetReplayConfigurationResponse",
                .namespace = Replay.namespace_uri,
                .namespace_uri = Replay.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Replay.namespace_uri },
                },
            };
        };

    };

    pub const SetReplayConfiguration = struct {
        pub const name = "SetReplayConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/replay/wsdl/SetReplayConfiguration";
        pub const request_name = "SetReplayConfiguration";
        pub const response_name = "SetReplayConfigurationResponse";
        pub const namespace = Replay.namespace_uri;
        pub const namespace_uri = Replay.namespace_uri;

        pub const Request = struct {
            Configuration: schema.ReplayConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetReplayConfiguration",
                .namespace = Replay.namespace_uri,
                .namespace_uri = Replay.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Replay.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetReplayConfigurationResponse",
                .namespace = Replay.namespace_uri,
                .namespace_uri = Replay.namespace_uri,
            };
        };

    };

};
