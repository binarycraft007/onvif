//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const Imaging = struct {
    pub const namespace = "http://www.onvif.org/ver20/imaging/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver20/imaging/wsdl";

    pub const ImagingPresetType = enum {
        Custom,
        ClearWeather,
        Cloudy,
        Fog,
        Rain,
        Snowing,
        Snow,
        WDR,
        Shade,
        Night,
        Indoor,
        Fluorescent,
        Incandescent,
        @"Sodium(Natrium)",
        @"Sunrise(Horizon)",
        @"Sunset(Rear)",
        ExtremeHot,
        ExtremeCold,
        Underwater,
        CloseUp,
        Motion,
        FlickerFree50,
        FlickerFree60,
    };

    pub const Capabilities = struct {
        ImageStabilization: ?bool = null,
        Presets: ?bool = null,
        AdaptablePreset: ?bool = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Capabilities",
            .namespace = Imaging.namespace_uri,
            .namespace_uri = Imaging.namespace_uri,
            .attributes = &.{"ImageStabilization", "Presets", "AdaptablePreset"},
        };
    };

    pub const ImagingPreset = struct {
        token: []const u8 = "",
        @"type": []const u8 = "",
        Name: []const u8 = "",
        pub const xml_meta = .{
            .element_name = "ImagingPreset",
            .namespace = Imaging.namespace_uri,
            .namespace_uri = Imaging.namespace_uri,
            .attributes = &.{"token", "type"},
            .fields = .{
                .Name = .{ .ns = Imaging.namespace_uri },
            },
        };
    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver20/imaging/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = Imaging.namespace_uri;
        pub const namespace_uri = Imaging.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

    };

    pub const GetImagingSettings = struct {
        pub const name = "GetImagingSettings";
        pub const soap_action = "http://www.onvif.org/ver20/imaging/wsdl/GetImagingSettings";
        pub const request_name = "GetImagingSettings";
        pub const response_name = "GetImagingSettingsResponse";
        pub const namespace = Imaging.namespace_uri;
        pub const namespace_uri = Imaging.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetImagingSettings",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            ImagingSettings: schema.ImagingSettings20 = .{},
            pub const xml_meta = .{
                .element_name = "GetImagingSettingsResponse",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .ImagingSettings = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

    };

    pub const SetImagingSettings = struct {
        pub const name = "SetImagingSettings";
        pub const soap_action = "http://www.onvif.org/ver20/imaging/wsdl/SetImagingSettings";
        pub const request_name = "SetImagingSettings";
        pub const response_name = "SetImagingSettingsResponse";
        pub const namespace = Imaging.namespace_uri;
        pub const namespace_uri = Imaging.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            ImagingSettings: schema.ImagingSettings20 = .{},
            ForcePersistence: ?bool = null,
            pub const xml_meta = .{
                .element_name = "SetImagingSettings",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Imaging.namespace_uri },
                    .ImagingSettings = .{ .ns = Imaging.namespace_uri },
                    .ForcePersistence = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetImagingSettingsResponse",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
            };
        };

    };

    pub const GetOptions = struct {
        pub const name = "GetOptions";
        pub const soap_action = "http://www.onvif.org/ver20/imaging/wsdl/GetOptions";
        pub const request_name = "GetOptions";
        pub const response_name = "GetOptionsResponse";
        pub const namespace = Imaging.namespace_uri;
        pub const namespace_uri = Imaging.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetOptions",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            ImagingOptions: schema.ImagingOptions20 = .{},
            pub const xml_meta = .{
                .element_name = "GetOptionsResponse",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .ImagingOptions = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

    };

    pub const Move = struct {
        pub const name = "Move";
        pub const soap_action = "http://www.onvif.org/ver20/imaging/wsdl/Move";
        pub const request_name = "Move";
        pub const response_name = "MoveResponse";
        pub const namespace = Imaging.namespace_uri;
        pub const namespace_uri = Imaging.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            Focus: schema.FocusMove = .{},
            pub const xml_meta = .{
                .element_name = "Move",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Imaging.namespace_uri },
                    .Focus = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "MoveResponse",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
            };
        };

    };

    pub const GetMoveOptions = struct {
        pub const name = "GetMoveOptions";
        pub const soap_action = "http://www.onvif.org/ver20/imaging/wsdl/GetMoveOptions";
        pub const request_name = "GetMoveOptions";
        pub const response_name = "GetMoveOptionsResponse";
        pub const namespace = Imaging.namespace_uri;
        pub const namespace_uri = Imaging.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetMoveOptions",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            MoveOptions: schema.MoveOptions20 = .{},
            pub const xml_meta = .{
                .element_name = "GetMoveOptionsResponse",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .MoveOptions = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

    };

    pub const Stop = struct {
        pub const name = "Stop";
        pub const soap_action = "http://www.onvif.org/ver20/imaging/wsdl/Stop";
        pub const request_name = "Stop";
        pub const response_name = "StopResponse";
        pub const namespace = Imaging.namespace_uri;
        pub const namespace_uri = Imaging.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "Stop",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "StopResponse",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
            };
        };

    };

    pub const GetStatus = struct {
        pub const name = "GetStatus";
        pub const soap_action = "http://www.onvif.org/ver20/imaging/wsdl/GetStatus";
        pub const request_name = "GetStatus";
        pub const response_name = "GetStatusResponse";
        pub const namespace = Imaging.namespace_uri;
        pub const namespace_uri = Imaging.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetStatus",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Status: schema.ImagingStatus20 = .{},
            pub const xml_meta = .{
                .element_name = "GetStatusResponse",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .Status = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

    };

    pub const GetPresets = struct {
        pub const name = "GetPresets";
        pub const soap_action = "http://www.onvif.org/ver20/imaging/wsdl/GetPresets";
        pub const request_name = "GetPresets";
        pub const response_name = "GetPresetsResponse";
        pub const namespace = Imaging.namespace_uri;
        pub const namespace_uri = Imaging.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetPresets",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Preset: []const ImagingPreset = &.{},
            pub const xml_meta = .{
                .element_name = "GetPresetsResponse",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .Preset = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

    };

    pub const GetCurrentPreset = struct {
        pub const name = "GetCurrentPreset";
        pub const soap_action = "http://www.onvif.org/ver20/imaging/wsdl/GetCurrentPreset";
        pub const request_name = "GetCurrentPreset";
        pub const response_name = "GetCurrentPresetResponse";
        pub const namespace = Imaging.namespace_uri;
        pub const namespace_uri = Imaging.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetCurrentPreset",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Preset: ?ImagingPreset = null,
            pub const xml_meta = .{
                .element_name = "GetCurrentPresetResponse",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .Preset = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

    };

    pub const SetCurrentPreset = struct {
        pub const name = "SetCurrentPreset";
        pub const soap_action = "http://www.onvif.org/ver20/imaging/wsdl/SetCurrentPreset";
        pub const request_name = "SetCurrentPreset";
        pub const response_name = "SetCurrentPresetResponse";
        pub const namespace = Imaging.namespace_uri;
        pub const namespace_uri = Imaging.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            PresetToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SetCurrentPreset",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Imaging.namespace_uri },
                    .PresetToken = .{ .ns = Imaging.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetCurrentPresetResponse",
                .namespace = Imaging.namespace_uri,
                .namespace_uri = Imaging.namespace_uri,
            };
        };

    };

};
