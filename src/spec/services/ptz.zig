//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const PTZ = struct {
    pub const namespace = "http://www.onvif.org/ver20/ptz/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver20/ptz/wsdl";

    pub const Capabilities = struct {
        EFlip: ?bool = null,
        Reverse: ?bool = null,
        GetCompatibleConfigurations: ?bool = null,
        MoveStatus: ?bool = null,
        StatusPosition: ?bool = null,
        MoveAndTrack: ?[]const u8 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Capabilities",
            .namespace = PTZ.namespace_uri,
            .namespace_uri = PTZ.namespace_uri,
            .attributes = &.{"EFlip", "Reverse", "GetCompatibleConfigurations", "MoveStatus", "StatusPosition", "MoveAndTrack"},
        };
    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const GetNodes = struct {
        pub const name = "GetNodes";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetNodes";
        pub const request_name = "GetNodes";
        pub const response_name = "GetNodesResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetNodes",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

        pub const Response = struct {
            PTZNode: []const schema.PTZNode = &.{},
            pub const xml_meta = .{
                .element_name = "GetNodesResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PTZNode = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const GetNode = struct {
        pub const name = "GetNode";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetNode";
        pub const request_name = "GetNode";
        pub const response_name = "GetNodeResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            NodeToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetNode",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .NodeToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            PTZNode: schema.PTZNode = .{},
            pub const xml_meta = .{
                .element_name = "GetNodeResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PTZNode = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const GetConfiguration = struct {
        pub const name = "GetConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetConfiguration";
        pub const request_name = "GetConfiguration";
        pub const response_name = "GetConfigurationResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            PTZConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetConfiguration",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PTZConfigurationToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            PTZConfiguration: schema.PTZConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetConfigurationResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PTZConfiguration = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const GetConfigurations = struct {
        pub const name = "GetConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetConfigurations";
        pub const request_name = "GetConfigurations";
        pub const response_name = "GetConfigurationsResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetConfigurations",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

        pub const Response = struct {
            PTZConfiguration: []const schema.PTZConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetConfigurationsResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PTZConfiguration = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const SetConfiguration = struct {
        pub const name = "SetConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/SetConfiguration";
        pub const request_name = "SetConfiguration";
        pub const response_name = "SetConfigurationResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            PTZConfiguration: schema.PTZConfiguration = .{},
            ForcePersistence: bool = false,
            pub const xml_meta = .{
                .element_name = "SetConfiguration",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PTZConfiguration = .{ .ns = PTZ.namespace_uri },
                    .ForcePersistence = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetConfigurationResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const GetConfigurationOptions = struct {
        pub const name = "GetConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetConfigurationOptions";
        pub const request_name = "GetConfigurationOptions";
        pub const response_name = "GetConfigurationOptionsResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetConfigurationOptions",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            PTZConfigurationOptions: schema.PTZConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetConfigurationOptionsResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PTZConfigurationOptions = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const SendAuxiliaryCommand = struct {
        pub const name = "SendAuxiliaryCommand";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/SendAuxiliaryCommand";
        pub const request_name = "SendAuxiliaryCommand";
        pub const response_name = "SendAuxiliaryCommandResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            AuxiliaryData: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SendAuxiliaryCommand",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .AuxiliaryData = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            AuxiliaryResponse: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SendAuxiliaryCommandResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .AuxiliaryResponse = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const GetPresets = struct {
        pub const name = "GetPresets";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetPresets";
        pub const request_name = "GetPresets";
        pub const response_name = "GetPresetsResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetPresets",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Preset: []const schema.PTZPreset = &.{},
            pub const xml_meta = .{
                .element_name = "GetPresetsResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .Preset = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const SetPreset = struct {
        pub const name = "SetPreset";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/SetPreset";
        pub const request_name = "SetPreset";
        pub const response_name = "SetPresetResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            PresetName: ?[]const u8 = null,
            PresetToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "SetPreset",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .PresetName = .{ .ns = PTZ.namespace_uri },
                    .PresetToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            PresetToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SetPresetResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PresetToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const RemovePreset = struct {
        pub const name = "RemovePreset";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/RemovePreset";
        pub const request_name = "RemovePreset";
        pub const response_name = "RemovePresetResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            PresetToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "RemovePreset",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .PresetToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemovePresetResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const GotoPreset = struct {
        pub const name = "GotoPreset";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GotoPreset";
        pub const request_name = "GotoPreset";
        pub const response_name = "GotoPresetResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            PresetToken: []const u8 = "",
            Speed: ?schema.PTZSpeed = null,
            pub const xml_meta = .{
                .element_name = "GotoPreset",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .PresetToken = .{ .ns = PTZ.namespace_uri },
                    .Speed = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "GotoPresetResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const GotoHomePosition = struct {
        pub const name = "GotoHomePosition";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GotoHomePosition";
        pub const request_name = "GotoHomePosition";
        pub const response_name = "GotoHomePositionResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            Speed: ?schema.PTZSpeed = null,
            pub const xml_meta = .{
                .element_name = "GotoHomePosition",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .Speed = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "GotoHomePositionResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const SetHomePosition = struct {
        pub const name = "SetHomePosition";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/SetHomePosition";
        pub const request_name = "SetHomePosition";
        pub const response_name = "SetHomePositionResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SetHomePosition",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetHomePositionResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const ContinuousMove = struct {
        pub const name = "ContinuousMove";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/ContinuousMove";
        pub const request_name = "ContinuousMove";
        pub const response_name = "ContinuousMoveResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            Velocity: schema.PTZSpeed = .{},
            Timeout: ?xsd.Duration = null,
            pub const xml_meta = .{
                .element_name = "ContinuousMove",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .Velocity = .{ .ns = PTZ.namespace_uri },
                    .Timeout = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "ContinuousMoveResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const RelativeMove = struct {
        pub const name = "RelativeMove";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/RelativeMove";
        pub const request_name = "RelativeMove";
        pub const response_name = "RelativeMoveResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            Translation: schema.PTZVector = .{},
            Speed: ?schema.PTZSpeed = null,
            pub const xml_meta = .{
                .element_name = "RelativeMove",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .Translation = .{ .ns = PTZ.namespace_uri },
                    .Speed = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RelativeMoveResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const GetStatus = struct {
        pub const name = "GetStatus";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetStatus";
        pub const request_name = "GetStatus";
        pub const response_name = "GetStatusResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetStatus",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            PTZStatus: schema.PTZStatus = .{},
            pub const xml_meta = .{
                .element_name = "GetStatusResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PTZStatus = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const AbsoluteMove = struct {
        pub const name = "AbsoluteMove";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/AbsoluteMove";
        pub const request_name = "AbsoluteMove";
        pub const response_name = "AbsoluteMoveResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            Position: schema.PTZVector = .{},
            Speed: ?schema.PTZSpeed = null,
            pub const xml_meta = .{
                .element_name = "AbsoluteMove",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .Position = .{ .ns = PTZ.namespace_uri },
                    .Speed = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AbsoluteMoveResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const GeoMove = struct {
        pub const name = "GeoMove";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GeoMove";
        pub const request_name = "GeoMove";
        pub const response_name = "GeoMoveResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            Target: schema.GeoLocation = .{},
            Speed: ?schema.PTZSpeed = null,
            AreaHeight: ?f32 = null,
            AreaWidth: ?f32 = null,
            pub const xml_meta = .{
                .element_name = "GeoMove",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .Target = .{ .ns = PTZ.namespace_uri },
                    .Speed = .{ .ns = PTZ.namespace_uri },
                    .AreaHeight = .{ .ns = PTZ.namespace_uri },
                    .AreaWidth = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "GeoMoveResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const Stop = struct {
        pub const name = "Stop";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/Stop";
        pub const request_name = "Stop";
        pub const response_name = "StopResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            PanTilt: ?bool = null,
            Zoom: ?bool = null,
            pub const xml_meta = .{
                .element_name = "Stop",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .PanTilt = .{ .ns = PTZ.namespace_uri },
                    .Zoom = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "StopResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const GetPresetTours = struct {
        pub const name = "GetPresetTours";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetPresetTours";
        pub const request_name = "GetPresetTours";
        pub const response_name = "GetPresetToursResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetPresetTours",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            PresetTour: []const schema.PresetTour = &.{},
            pub const xml_meta = .{
                .element_name = "GetPresetToursResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PresetTour = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const GetPresetTour = struct {
        pub const name = "GetPresetTour";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetPresetTour";
        pub const request_name = "GetPresetTour";
        pub const response_name = "GetPresetTourResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            PresetTourToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetPresetTour",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .PresetTourToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            PresetTour: schema.PresetTour = .{},
            pub const xml_meta = .{
                .element_name = "GetPresetTourResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PresetTour = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const GetPresetTourOptions = struct {
        pub const name = "GetPresetTourOptions";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetPresetTourOptions";
        pub const request_name = "GetPresetTourOptions";
        pub const response_name = "GetPresetTourOptionsResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            PresetTourToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetPresetTourOptions",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .PresetTourToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.PTZPresetTourOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetPresetTourOptionsResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const CreatePresetTour = struct {
        pub const name = "CreatePresetTour";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/CreatePresetTour";
        pub const request_name = "CreatePresetTour";
        pub const response_name = "CreatePresetTourResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "CreatePresetTour",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            PresetTourToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "CreatePresetTourResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PresetTourToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const ModifyPresetTour = struct {
        pub const name = "ModifyPresetTour";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/ModifyPresetTour";
        pub const request_name = "ModifyPresetTour";
        pub const response_name = "ModifyPresetTourResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            PresetTour: schema.PresetTour = .{},
            pub const xml_meta = .{
                .element_name = "ModifyPresetTour",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .PresetTour = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "ModifyPresetTourResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const OperatePresetTour = struct {
        pub const name = "OperatePresetTour";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/OperatePresetTour";
        pub const request_name = "OperatePresetTour";
        pub const response_name = "OperatePresetTourResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            PresetTourToken: []const u8 = "",
            Operation: schema.PTZPresetTourOperation = .Start,
            pub const xml_meta = .{
                .element_name = "OperatePresetTour",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .PresetTourToken = .{ .ns = PTZ.namespace_uri },
                    .Operation = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "OperatePresetTourResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const RemovePresetTour = struct {
        pub const name = "RemovePresetTour";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/RemovePresetTour";
        pub const request_name = "RemovePresetTour";
        pub const response_name = "RemovePresetTourResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            PresetTourToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "RemovePresetTour",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .PresetTourToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemovePresetTourResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

    pub const GetCompatibleConfigurations = struct {
        pub const name = "GetCompatibleConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/GetCompatibleConfigurations";
        pub const request_name = "GetCompatibleConfigurations";
        pub const response_name = "GetCompatibleConfigurationsResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetCompatibleConfigurations",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            PTZConfiguration: []const schema.PTZConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetCompatibleConfigurationsResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .PTZConfiguration = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

    };

    pub const MoveAndStartTracking = struct {
        pub const name = "MoveAndStartTracking";
        pub const soap_action = "http://www.onvif.org/ver20/ptz/wsdl/MoveAndStartTracking";
        pub const request_name = "MoveAndStartTracking";
        pub const response_name = "MoveAndStartTrackingResponse";
        pub const namespace = PTZ.namespace_uri;
        pub const namespace_uri = PTZ.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            PresetToken: ?[]const u8 = null,
            GeoLocation: ?schema.GeoLocation = null,
            TargetPosition: ?schema.PTZVector = null,
            Speed: ?schema.PTZSpeed = null,
            ObjectID: ?i64 = null,
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "MoveAndStartTracking",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = PTZ.namespace_uri },
                    .PresetToken = .{ .ns = PTZ.namespace_uri },
                    .GeoLocation = .{ .ns = PTZ.namespace_uri },
                    .TargetPosition = .{ .ns = PTZ.namespace_uri },
                    .Speed = .{ .ns = PTZ.namespace_uri },
                    .ObjectID = .{ .ns = PTZ.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "MoveAndStartTrackingResponse",
                .namespace = PTZ.namespace_uri,
                .namespace_uri = PTZ.namespace_uri,
            };
        };

    };

};
