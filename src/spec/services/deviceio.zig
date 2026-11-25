//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const DeviceIO = struct {
    pub const namespace = "http://www.onvif.org/ver10/deviceIO/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver10/deviceIO/wsdl";

    pub const SerialPortType = enum {
        RS232,
        RS422HalfDuplex,
        RS422FullDuplex,
        RS485HalfDuplex,
        RS485FullDuplex,
        Generic,
    };

    pub const ParityBit = enum {
        None,
        Even,
        Odd,
        Mark,
        Space,
        Extended,
    };

    pub const Capabilities = struct {
        VideoSources: ?i32 = null,
        VideoOutputs: ?i32 = null,
        AudioSources: ?i32 = null,
        AudioOutputs: ?i32 = null,
        RelayOutputs: ?i32 = null,
        SerialPorts: ?i32 = null,
        DigitalInputs: ?i32 = null,
        DigitalInputOptions: ?bool = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Capabilities",
            .namespace = DeviceIO.namespace_uri,
            .namespace_uri = DeviceIO.namespace_uri,
            .attributes = &.{"VideoSources", "VideoOutputs", "AudioSources", "AudioOutputs", "RelayOutputs", "SerialPorts", "DigitalInputs", "DigitalInputOptions"},
        };
    };

    pub const RelayOutputOptions = struct {
        token: []const u8 = "",
        Mode: []const schema.RelayMode = &.{},
        DelayTimes: ?[]const u8 = null,
        Discrete: ?bool = null,
        Extension: ?RelayOutputOptionsExtension = null,
        pub const xml_meta = .{
            .element_name = "RelayOutputOptions",
            .namespace = DeviceIO.namespace_uri,
            .namespace_uri = DeviceIO.namespace_uri,
            .attributes = &.{"token"},
            .fields = .{
                .Mode = .{ .ns = DeviceIO.namespace_uri },
                .DelayTimes = .{ .ns = DeviceIO.namespace_uri },
                .Discrete = .{ .ns = DeviceIO.namespace_uri },
                .Extension = .{ .ns = DeviceIO.namespace_uri },
            },
        };
    };

    pub const RelayOutputOptionsExtension = struct {
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "RelayOutputOptionsExtension",
            .namespace = DeviceIO.namespace_uri,
            .namespace_uri = DeviceIO.namespace_uri,
        };
    };

    pub const Get = struct {
        pub const xml_meta = .{
            .element_name = "Get",
            .namespace = DeviceIO.namespace_uri,
            .namespace_uri = DeviceIO.namespace_uri,
        };
    };

    pub const GetResponse = struct {
        Token: []const []const u8 = &.{},
        pub const xml_meta = .{
            .element_name = "GetResponse",
            .namespace = DeviceIO.namespace_uri,
            .namespace_uri = DeviceIO.namespace_uri,
            .fields = .{
                .Token = .{ .ns = DeviceIO.namespace_uri },
            },
        };
    };

    pub const DigitalInputConfigurationOptions = struct {
        IdleState: []const schema.DigitalIdleState = &.{},
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "DigitalInputConfigurationOptions",
            .namespace = DeviceIO.namespace_uri,
            .namespace_uri = DeviceIO.namespace_uri,
            .fields = .{
                .IdleState = .{ .ns = DeviceIO.namespace_uri },
            },
        };
    };

    pub const SerialData = struct {
        Binary: ?[]const u8 = null,
        String: ?[]const u8 = null,
        pub const xml_meta = .{
            .element_name = "SerialData",
            .namespace = DeviceIO.namespace_uri,
            .namespace_uri = DeviceIO.namespace_uri,
            .fields = .{
                .Binary = .{ .ns = DeviceIO.namespace_uri },
                .String = .{ .ns = DeviceIO.namespace_uri },
            },
        };
    };

    pub const SerialPort = struct {
        token: []const u8 = "",
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "SerialPort",
            .namespace = DeviceIO.namespace_uri,
            .namespace_uri = DeviceIO.namespace_uri,
            .attributes = &.{"token"},
        };
    };

    pub const SerialPortConfiguration = struct {
        token: []const u8 = "",
        @"type": SerialPortType = .RS232,
        BaudRate: i32 = 0,
        ParityBit: ParityBit = .None,
        CharacterLength: i32 = 0,
        StopBit: f32 = 0.0,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "SerialPortConfiguration",
            .namespace = DeviceIO.namespace_uri,
            .namespace_uri = DeviceIO.namespace_uri,
            .attributes = &.{"token", "type"},
            .fields = .{
                .BaudRate = .{ .ns = DeviceIO.namespace_uri },
                .ParityBit = .{ .ns = DeviceIO.namespace_uri },
                .CharacterLength = .{ .ns = DeviceIO.namespace_uri },
                .StopBit = .{ .ns = DeviceIO.namespace_uri },
            },
        };
    };

    pub const SerialPortConfigurationOptions = struct {
        token: []const u8 = "",
        BaudRateList: schema.IntItems = .{},
        ParityBitList: ParityBitList = .{},
        CharacterLengthList: schema.IntItems = .{},
        StopBitList: schema.FloatItems = .{},
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "SerialPortConfigurationOptions",
            .namespace = DeviceIO.namespace_uri,
            .namespace_uri = DeviceIO.namespace_uri,
            .attributes = &.{"token"},
            .fields = .{
                .BaudRateList = .{ .ns = DeviceIO.namespace_uri },
                .ParityBitList = .{ .ns = DeviceIO.namespace_uri },
                .CharacterLengthList = .{ .ns = DeviceIO.namespace_uri },
                .StopBitList = .{ .ns = DeviceIO.namespace_uri },
            },
        };
    };

    pub const ParityBitList = struct {
        Items: []const ParityBit = &.{},
        pub const xml_meta = .{
            .element_name = "ParityBitList",
            .namespace = DeviceIO.namespace_uri,
            .namespace_uri = DeviceIO.namespace_uri,
            .fields = .{
                .Items = .{ .ns = DeviceIO.namespace_uri },
            },
        };
    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetRelayOutputOptions = struct {
        pub const name = "GetRelayOutputOptions";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetRelayOutputOptions";
        pub const request_name = "GetRelayOutputOptions";
        pub const response_name = "GetRelayOutputOptionsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            RelayOutputToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetRelayOutputOptions",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .RelayOutputToken = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            RelayOutputOptions: []const RelayOutputOptions = &.{},
            pub const xml_meta = .{
                .element_name = "GetRelayOutputOptionsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .RelayOutputOptions = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioSources = struct {
        pub const name = "GetAudioSources";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetAudioSources";
        pub const request_name = "GetAudioSources";
        pub const response_name = "GetAudioSourcesResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetAudioSources",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

        pub const Response = struct {
            Token: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioSourcesResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioOutputs = struct {
        pub const name = "GetAudioOutputs";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetAudioOutputs";
        pub const request_name = "GetAudioOutputs";
        pub const response_name = "GetAudioOutputsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetAudioOutputs",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

        pub const Response = struct {
            Token: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioOutputsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoSources = struct {
        pub const name = "GetVideoSources";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetVideoSources";
        pub const request_name = "GetVideoSources";
        pub const response_name = "GetVideoSourcesResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetVideoSources",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

        pub const Response = struct {
            Token: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourcesResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoOutputs = struct {
        pub const name = "GetVideoOutputs";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetVideoOutputs";
        pub const request_name = "GetVideoOutputs";
        pub const response_name = "GetVideoOutputsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetVideoOutputs",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

        pub const Response = struct {
            VideoOutputs: []const schema.VideoOutput = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoOutputsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .VideoOutputs = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoSourceConfiguration = struct {
        pub const name = "GetVideoSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetVideoSourceConfiguration";
        pub const request_name = "GetVideoSourceConfiguration";
        pub const response_name = "GetVideoSourceConfigurationResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfiguration",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            VideoSourceConfiguration: schema.VideoSourceConfiguration = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurationResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .VideoSourceConfiguration = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoOutputConfiguration = struct {
        pub const name = "GetVideoOutputConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetVideoOutputConfiguration";
        pub const request_name = "GetVideoOutputConfiguration";
        pub const response_name = "GetVideoOutputConfigurationResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            VideoOutputToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoOutputConfiguration",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .VideoOutputToken = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            VideoOutputConfiguration: schema.VideoOutputConfiguration = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoOutputConfigurationResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .VideoOutputConfiguration = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioSourceConfiguration = struct {
        pub const name = "GetAudioSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetAudioSourceConfiguration";
        pub const request_name = "GetAudioSourceConfiguration";
        pub const response_name = "GetAudioSourceConfigurationResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            AudioSourceToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfiguration",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .AudioSourceToken = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            AudioSourceConfiguration: schema.AudioSourceConfiguration = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurationResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .AudioSourceConfiguration = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioOutputConfiguration = struct {
        pub const name = "GetAudioOutputConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetAudioOutputConfiguration";
        pub const request_name = "GetAudioOutputConfiguration";
        pub const response_name = "GetAudioOutputConfigurationResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            AudioOutputToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfiguration",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .AudioOutputToken = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            AudioOutputConfiguration: schema.AudioOutputConfiguration = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurationResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .AudioOutputConfiguration = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const SetVideoSourceConfiguration = struct {
        pub const name = "SetVideoSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/SetVideoSourceConfiguration";
        pub const request_name = "SetVideoSourceConfiguration";
        pub const response_name = "SetVideoSourceConfigurationResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            Configuration: schema.VideoSourceConfiguration = .{},
            ForcePersistence: bool = false,
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "SetVideoSourceConfiguration",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = DeviceIO.namespace_uri },
                    .ForcePersistence = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "SetVideoSourceConfigurationResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

    };

    pub const SetVideoOutputConfiguration = struct {
        pub const name = "SetVideoOutputConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/SetVideoOutputConfiguration";
        pub const request_name = "SetVideoOutputConfiguration";
        pub const response_name = "SetVideoOutputConfigurationResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            Configuration: schema.VideoOutputConfiguration = .{},
            ForcePersistence: bool = false,
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "SetVideoOutputConfiguration",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = DeviceIO.namespace_uri },
                    .ForcePersistence = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "SetVideoOutputConfigurationResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

    };

    pub const SetAudioSourceConfiguration = struct {
        pub const name = "SetAudioSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/SetAudioSourceConfiguration";
        pub const request_name = "SetAudioSourceConfiguration";
        pub const response_name = "SetAudioSourceConfigurationResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            Configuration: schema.AudioSourceConfiguration = .{},
            ForcePersistence: bool = false,
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "SetAudioSourceConfiguration",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = DeviceIO.namespace_uri },
                    .ForcePersistence = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "SetAudioSourceConfigurationResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

    };

    pub const SetAudioOutputConfiguration = struct {
        pub const name = "SetAudioOutputConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/SetAudioOutputConfiguration";
        pub const request_name = "SetAudioOutputConfiguration";
        pub const response_name = "SetAudioOutputConfigurationResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            Configuration: schema.AudioOutputConfiguration = .{},
            ForcePersistence: bool = false,
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "SetAudioOutputConfiguration",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = DeviceIO.namespace_uri },
                    .ForcePersistence = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "SetAudioOutputConfigurationResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

    };

    pub const GetVideoSourceConfigurationOptions = struct {
        pub const name = "GetVideoSourceConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetVideoSourceConfigurationOptions";
        pub const request_name = "GetVideoSourceConfigurationOptions";
        pub const response_name = "GetVideoSourceConfigurationOptionsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurationOptions",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            VideoSourceConfigurationOptions: schema.VideoSourceConfigurationOptions = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurationOptionsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .VideoSourceConfigurationOptions = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoOutputConfigurationOptions = struct {
        pub const name = "GetVideoOutputConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetVideoOutputConfigurationOptions";
        pub const request_name = "GetVideoOutputConfigurationOptions";
        pub const response_name = "GetVideoOutputConfigurationOptionsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            VideoOutputToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoOutputConfigurationOptions",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .VideoOutputToken = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            VideoOutputConfigurationOptions: schema.VideoOutputConfigurationOptions = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoOutputConfigurationOptionsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .VideoOutputConfigurationOptions = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioSourceConfigurationOptions = struct {
        pub const name = "GetAudioSourceConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetAudioSourceConfigurationOptions";
        pub const request_name = "GetAudioSourceConfigurationOptions";
        pub const response_name = "GetAudioSourceConfigurationOptionsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            AudioSourceToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurationOptions",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .AudioSourceToken = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            AudioSourceOptions: schema.AudioSourceConfigurationOptions = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurationOptionsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .AudioSourceOptions = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioOutputConfigurationOptions = struct {
        pub const name = "GetAudioOutputConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetAudioOutputConfigurationOptions";
        pub const request_name = "GetAudioOutputConfigurationOptions";
        pub const response_name = "GetAudioOutputConfigurationOptionsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            AudioOutputToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurationOptions",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .AudioOutputToken = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            AudioOutputOptions: schema.AudioOutputConfigurationOptions = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurationOptionsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .AudioOutputOptions = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetRelayOutputs = struct {
        pub const name = "GetRelayOutputs";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetRelayOutputs";
        pub const request_name = "GetRelayOutputs";
        pub const response_name = "GetRelayOutputsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetRelayOutputs",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "GetRelayOutputsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

    };

    pub const SetRelayOutputSettings = struct {
        pub const name = "SetRelayOutputSettings";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/SetRelayOutputSettings";
        pub const request_name = "SetRelayOutputSettings";
        pub const response_name = "SetRelayOutputSettingsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            RelayOutput: schema.RelayOutput = .{},
            pub const xml_meta = .{
                .element_name = "SetRelayOutputSettings",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .RelayOutput = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetRelayOutputSettingsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

    };

    pub const SetRelayOutputState = struct {
        pub const name = "SetRelayOutputState";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/SetRelayOutputState";
        pub const request_name = "SetRelayOutputState";
        pub const response_name = "SetRelayOutputStateResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "SetRelayOutputState",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetRelayOutputStateResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

    };

    pub const GetDigitalInputs = struct {
        pub const name = "GetDigitalInputs";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetDigitalInputs";
        pub const request_name = "GetDigitalInputs";
        pub const response_name = "GetDigitalInputsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetDigitalInputs",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

        pub const Response = struct {
            DigitalInputs: []const schema.DigitalInput = &.{},
            pub const xml_meta = .{
                .element_name = "GetDigitalInputsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .DigitalInputs = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetDigitalInputConfigurationOptions = struct {
        pub const name = "GetDigitalInputConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetDigitalInputConfigurationOptions";
        pub const request_name = "GetDigitalInputConfigurationOptions";
        pub const response_name = "GetDigitalInputConfigurationOptionsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            Token: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetDigitalInputConfigurationOptions",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            DigitalInputOptions: DigitalInputConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetDigitalInputConfigurationOptionsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .DigitalInputOptions = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const SetDigitalInputConfigurations = struct {
        pub const name = "SetDigitalInputConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/SetDigitalInputConfigurations";
        pub const request_name = "SetDigitalInputConfigurations";
        pub const response_name = "SetDigitalInputConfigurationsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            DigitalInputs: []const schema.DigitalInput = &.{},
            pub const xml_meta = .{
                .element_name = "SetDigitalInputConfigurations",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .DigitalInputs = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetDigitalInputConfigurationsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

    };

    pub const GetSerialPorts = struct {
        pub const name = "GetSerialPorts";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetSerialPorts";
        pub const request_name = "GetSerialPorts";
        pub const response_name = "GetSerialPortsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetSerialPorts",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

        pub const Response = struct {
            SerialPort: []const SerialPort = &.{},
            pub const xml_meta = .{
                .element_name = "GetSerialPortsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .SerialPort = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const GetSerialPortConfiguration = struct {
        pub const name = "GetSerialPortConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetSerialPortConfiguration";
        pub const request_name = "GetSerialPortConfiguration";
        pub const response_name = "GetSerialPortConfigurationResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            SerialPortToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetSerialPortConfiguration",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .SerialPortToken = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SerialPortConfiguration: SerialPortConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetSerialPortConfigurationResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .SerialPortConfiguration = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const SetSerialPortConfiguration = struct {
        pub const name = "SetSerialPortConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/SetSerialPortConfiguration";
        pub const request_name = "SetSerialPortConfiguration";
        pub const response_name = "SetSerialPortConfigurationResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            SerialPortConfiguration: SerialPortConfiguration = .{},
            ForcePersistance: bool = false,
            pub const xml_meta = .{
                .element_name = "SetSerialPortConfiguration",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .SerialPortConfiguration = .{ .ns = DeviceIO.namespace_uri },
                    .ForcePersistance = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetSerialPortConfigurationResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
            };
        };

    };

    pub const GetSerialPortConfigurationOptions = struct {
        pub const name = "GetSerialPortConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/GetSerialPortConfigurationOptions";
        pub const request_name = "GetSerialPortConfigurationOptions";
        pub const response_name = "GetSerialPortConfigurationOptionsResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            SerialPortToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetSerialPortConfigurationOptions",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .SerialPortToken = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SerialPortOptions: SerialPortConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetSerialPortConfigurationOptionsResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .SerialPortOptions = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

    pub const SendReceiveSerialCommand = struct {
        pub const name = "SendReceiveSerialCommand";
        pub const soap_action = "http://www.onvif.org/ver10/deviceIO/wsdl/SendReceiveSerialCommand";
        pub const request_name = "SendReceiveSerialCommand";
        pub const response_name = "SendReceiveSerialCommandResponse";
        pub const namespace = DeviceIO.namespace_uri;
        pub const namespace_uri = DeviceIO.namespace_uri;

        pub const Request = struct {
            Token: ?[]const u8 = null,
            SerialData: ?SerialData = null,
            TimeOut: ?xsd.Duration = null,
            DataLength: ?i64 = null,
            Delimiter: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "SendReceiveSerialCommand",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = DeviceIO.namespace_uri },
                    .SerialData = .{ .ns = DeviceIO.namespace_uri },
                    .TimeOut = .{ .ns = DeviceIO.namespace_uri },
                    .DataLength = .{ .ns = DeviceIO.namespace_uri },
                    .Delimiter = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SerialData: ?SerialData = null,
            pub const xml_meta = .{
                .element_name = "SendReceiveSerialCommandResponse",
                .namespace = DeviceIO.namespace_uri,
                .namespace_uri = DeviceIO.namespace_uri,
                .fields = .{
                    .SerialData = .{ .ns = DeviceIO.namespace_uri },
                },
            };
        };

    };

};
