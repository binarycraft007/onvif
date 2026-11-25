//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const Media2 = struct {
    pub const namespace = "http://www.onvif.org/ver20/media/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver20/media/wsdl";

    pub const TTSVoiceType = enum {
        male,
        female,
    };

    pub const SupportedAudioClipFormat = enum {
        @"audio/vnd.wave;codec=1",
        @"audio/vnd.wave;codec=7",
        @"audio/mpeg",
        @"audio/ogg;codecs=opus",
        @"audio/ogg;codecs=vorbis",
        @"audio/ogg;codecs=flac",
        @"audio/ogg;codecs=speex",
    };

    pub const ConfigurationEnumeration = enum {
        All,
        VideoSource,
        VideoEncoder,
        AudioSource,
        AudioEncoder,
        AudioOutput,
        AudioDecoder,
        Metadata,
        Analytics,
        PTZ,
        Receiver,
    };

    pub const TransportProtocol = enum {
        RtspUnicast,
        RtspMulticast,
        RtspsUnicast,
        RtspsMulticast,
        RTSP,
        RtspOverHttp,
    };

    pub const MaskType = enum {
        Color,
        Pixelated,
        Blurred,
    };

    pub const Capabilities2 = struct {
        SnapshotUri: ?bool = null,
        Rotation: ?bool = null,
        VideoSourceMode: ?bool = null,
        OSD: ?bool = null,
        TemporaryOSDText: ?bool = null,
        Mask: ?bool = null,
        SourceMask: ?bool = null,
        WebRTC: ?i32 = null,
        WebRTC_codecs: ?[]const u8 = null,
        ProfileCapabilities: ProfileCapabilities = .{},
        StreamingCapabilities: StreamingCapabilities = .{},
        AudioClipCapabilities: ?AudioClipCapabilities = null,
        MulticastAudioDecoderCapabilities: ?MulticastAudioDecoderCapabilities = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Capabilities2",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .attributes = &.{"SnapshotUri", "Rotation", "VideoSourceMode", "OSD", "TemporaryOSDText", "Mask", "SourceMask", "WebRTC", "WebRTC_codecs"},
            .fields = .{
                .ProfileCapabilities = .{ .ns = Media2.namespace_uri },
                .StreamingCapabilities = .{ .ns = Media2.namespace_uri },
                .AudioClipCapabilities = .{ .ns = Media2.namespace_uri },
                .MulticastAudioDecoderCapabilities = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const ProfileCapabilities = struct {
        MaximumNumberOfProfiles: ?i32 = null,
        ConfigurationsSupported: ?[]const u8 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "ProfileCapabilities",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .attributes = &.{"MaximumNumberOfProfiles", "ConfigurationsSupported"},
        };
    };

    pub const StreamingCapabilities = struct {
        RTSPStreaming: ?bool = null,
        RTPMulticast: ?bool = null,
        RTP_RTSP_TCP: ?bool = null,
        NonAggregateControl: ?bool = null,
        RTSPWebSocketUri: ?[]const u8 = null,
        AutoStartMulticast: ?bool = null,
        SecureRTSPStreaming: ?bool = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "StreamingCapabilities",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .attributes = &.{"RTSPStreaming", "RTPMulticast", "RTP_RTSP_TCP", "NonAggregateControl", "RTSPWebSocketUri", "AutoStartMulticast", "SecureRTSPStreaming"},
        };
    };

    pub const MulticastAudioDecoderCapabilities = struct {
        MulticastAudioDecoder: ?bool = null,
        SRTP: ?bool = null,
        IPv6: ?bool = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "MulticastAudioDecoderCapabilities",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .attributes = &.{"MulticastAudioDecoder", "SRTP", "IPv6"},
        };
    };

    pub const AudioClipCapabilities = struct {
        MaxAudioClipLimit: ?i32 = null,
        MaxAudioClipSize: ?f32 = null,
        SupportedAudioClipFormat: ?[]const u8 = null,
        TTSCapabilities: ?TTSCapabilities = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "AudioClipCapabilities",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .attributes = &.{"MaxAudioClipLimit", "MaxAudioClipSize", "SupportedAudioClipFormat"},
            .fields = .{
                .TTSCapabilities = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const TTSCapabilities = struct {
        MaxContentLength: ?i32 = null,
        TTSLanguage: ?[]const u8 = null,
        TTSVoiceType: ?[]const u8 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "TTSCapabilities",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .attributes = &.{"MaxContentLength", "TTSLanguage", "TTSVoiceType"},
        };
    };

    pub const ConfigurationRef = struct {
        Type: []const u8 = "",
        Token: ?[]const u8 = null,
        pub const xml_meta = .{
            .element_name = "ConfigurationRef",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .fields = .{
                .Type = .{ .ns = Media2.namespace_uri },
                .Token = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const ReceiverConfiguration = struct {
        token: ?[]const u8 = null,
        pub const xml_meta = .{
            .element_name = "ReceiverConfiguration",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .attributes = &.{"token"},
        };
    };

    pub const ConfigurationSet = struct {
        VideoSource: ?schema.VideoSourceConfiguration = null,
        AudioSource: ?schema.AudioSourceConfiguration = null,
        VideoEncoder: ?schema.VideoEncoder2Configuration = null,
        AudioEncoder: ?schema.AudioEncoder2Configuration = null,
        Analytics: ?schema.VideoAnalyticsConfiguration = null,
        PTZ: ?schema.PTZConfiguration = null,
        Metadata: ?schema.MetadataConfiguration = null,
        AudioOutput: ?schema.AudioOutputConfiguration = null,
        AudioDecoder: ?schema.AudioDecoderConfiguration = null,
        Receiver: ?ReceiverConfiguration = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "ConfigurationSet",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .fields = .{
                .VideoSource = .{ .ns = Media2.namespace_uri },
                .AudioSource = .{ .ns = Media2.namespace_uri },
                .VideoEncoder = .{ .ns = Media2.namespace_uri },
                .AudioEncoder = .{ .ns = Media2.namespace_uri },
                .Analytics = .{ .ns = Media2.namespace_uri },
                .PTZ = .{ .ns = Media2.namespace_uri },
                .Metadata = .{ .ns = Media2.namespace_uri },
                .AudioOutput = .{ .ns = Media2.namespace_uri },
                .AudioDecoder = .{ .ns = Media2.namespace_uri },
                .Receiver = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const MediaProfile = struct {
        token: []const u8 = "",
        fixed: ?bool = null,
        Name: []const u8 = "",
        Configurations: ?ConfigurationSet = null,
        pub const xml_meta = .{
            .element_name = "MediaProfile",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .attributes = &.{"token", "fixed"},
            .fields = .{
                .Name = .{ .ns = Media2.namespace_uri },
                .Configurations = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const GetConfiguration = struct {
        ConfigurationToken: ?[]const u8 = null,
        ProfileToken: ?[]const u8 = null,
        pub const xml_meta = .{
            .element_name = "GetConfiguration",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .fields = .{
                .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                .ProfileToken = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const SetConfigurationResponse = struct {
        pub const xml_meta = .{
            .element_name = "SetConfigurationResponse",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
        };
    };

    pub const EncoderInstance = struct {
        Encoding: []const u8 = "",
        Number: i32 = 0,
        pub const xml_meta = .{
            .element_name = "EncoderInstance",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .fields = .{
                .Encoding = .{ .ns = Media2.namespace_uri },
                .Number = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const EncoderInstanceInfo = struct {
        Codec: []const EncoderInstance = &.{},
        Total: i32 = 0,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "EncoderInstanceInfo",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .fields = .{
                .Codec = .{ .ns = Media2.namespace_uri },
                .Total = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const StartStopMulticastStreaming = struct {
        ProfileToken: []const u8 = "",
        pub const xml_meta = .{
            .element_name = "StartStopMulticastStreaming",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .fields = .{
                .ProfileToken = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const VideoSourceMode = struct {
        token: []const u8 = "",
        Enabled: ?bool = null,
        MaxFramerate: f32 = 0.0,
        MaxResolution: schema.VideoResolution = .{},
        Encodings: []const u8 = "",
        Reboot: bool = false,
        Description: ?[]const u8 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "VideoSourceMode",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .attributes = &.{"token", "Enabled"},
            .fields = .{
                .MaxFramerate = .{ .ns = Media2.namespace_uri },
                .MaxResolution = .{ .ns = Media2.namespace_uri },
                .Encodings = .{ .ns = Media2.namespace_uri },
                .Reboot = .{ .ns = Media2.namespace_uri },
                .Description = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const Mask = struct {
        token: ?[]const u8 = null,
        ConfigurationToken: []const u8 = "",
        Polygon: schema.Polygon = .{},
        Type: []const u8 = "",
        Color: ?schema.Color = null,
        Enabled: bool = false,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Mask",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .attributes = &.{"token"},
            .fields = .{
                .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                .Polygon = .{ .ns = Media2.namespace_uri },
                .Type = .{ .ns = Media2.namespace_uri },
                .Color = .{ .ns = Media2.namespace_uri },
                .Enabled = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const MaskOptions = struct {
        RectangleOnly: ?bool = null,
        SingleColorOnly: ?bool = null,
        MaxMasks: i32 = 0,
        MaxPoints: i32 = 0,
        Types: []const []const u8 = &.{},
        Color: schema.ColorOptions = .{},
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "MaskOptions",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .attributes = &.{"RectangleOnly", "SingleColorOnly"},
            .fields = .{
                .MaxMasks = .{ .ns = Media2.namespace_uri },
                .MaxPoints = .{ .ns = Media2.namespace_uri },
                .Types = .{ .ns = Media2.namespace_uri },
                .Color = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const WebRTCConfiguration = struct {
        SignalingServer: []const u8 = "",
        CertPathValidationPolicyID: ?[]const u8 = null,
        AuthorizationServer: []const u8 = "",
        DefaultProfile: []const u8 = "",
        Enabled: bool = false,
        Connected: ?bool = null,
        Error: ?[]const u8 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "WebRTCConfiguration",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .fields = .{
                .SignalingServer = .{ .ns = Media2.namespace_uri },
                .CertPathValidationPolicyID = .{ .ns = Media2.namespace_uri },
                .AuthorizationServer = .{ .ns = Media2.namespace_uri },
                .DefaultProfile = .{ .ns = Media2.namespace_uri },
                .Enabled = .{ .ns = Media2.namespace_uri },
                .Connected = .{ .ns = Media2.namespace_uri },
                .Error = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const AudioClip = struct {
        Enabled: bool = false,
        Name: []const u8 = "",
        AudioOutputToken: []const []const u8 = &.{},
        Type: []const u8 = "",
        RepeatCycles: i32 = 0,
        RepeatInterval: ?i32 = null,
        AudioOutputLevel: ?i32 = null,
        ScheduleToken: ?[]const u8 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "AudioClip",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .fields = .{
                .Enabled = .{ .ns = Media2.namespace_uri },
                .Name = .{ .ns = Media2.namespace_uri },
                .AudioOutputToken = .{ .ns = Media2.namespace_uri },
                .Type = .{ .ns = Media2.namespace_uri },
                .RepeatCycles = .{ .ns = Media2.namespace_uri },
                .RepeatInterval = .{ .ns = Media2.namespace_uri },
                .AudioOutputLevel = .{ .ns = Media2.namespace_uri },
                .ScheduleToken = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const TTSAudio = struct {
        Content: []const u8 = "",
        Language: []const u8 = "",
        VoiceType: []const u8 = "",
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "TTSAudio",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .fields = .{
                .Content = .{ .ns = Media2.namespace_uri },
                .Language = .{ .ns = Media2.namespace_uri },
                .VoiceType = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const GetAudioClipsResponseItem = struct {
        Token: []const u8 = "",
        Configuration: AudioClip = .{},
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "GetAudioClipsResponseItem",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .fields = .{
                .Token = .{ .ns = Media2.namespace_uri },
                .Configuration = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const PlayingAudioClips = struct {
        Token: []const u8 = "",
        Name: []const u8 = "",
        AudioOutputToken: []const []const u8 = &.{},
        AudioOutputLevel: i32 = 0,
        RepeatsLeft: i32 = 0,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "PlayingAudioClips",
            .namespace = Media2.namespace_uri,
            .namespace_uri = Media2.namespace_uri,
            .fields = .{
                .Token = .{ .ns = Media2.namespace_uri },
                .Name = .{ .ns = Media2.namespace_uri },
                .AudioOutputToken = .{ .ns = Media2.namespace_uri },
                .AudioOutputLevel = .{ .ns = Media2.namespace_uri },
                .RepeatsLeft = .{ .ns = Media2.namespace_uri },
            },
        };
    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: Capabilities2 = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const CreateProfile = struct {
        pub const name = "CreateProfile";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/CreateProfile";
        pub const request_name = "CreateProfile";
        pub const response_name = "CreateProfileResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Name: []const u8 = "",
            Configuration: []const ConfigurationRef = &.{},
            pub const xml_meta = .{
                .element_name = "CreateProfile",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Name = .{ .ns = Media2.namespace_uri },
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Token: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "CreateProfileResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetProfiles = struct {
        pub const name = "GetProfiles";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetProfiles";
        pub const request_name = "GetProfiles";
        pub const response_name = "GetProfilesResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Token: ?[]const u8 = null,
            Type: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "GetProfiles",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                    .Type = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Profiles: []const MediaProfile = &.{},
            pub const xml_meta = .{
                .element_name = "GetProfilesResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Profiles = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const AddConfiguration = struct {
        pub const name = "AddConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/AddConfiguration";
        pub const request_name = "AddConfiguration";
        pub const response_name = "AddConfigurationResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            Name: ?[]const u8 = null,
            Configuration: []const ConfigurationRef = &.{},
            pub const xml_meta = .{
                .element_name = "AddConfiguration",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                    .Name = .{ .ns = Media2.namespace_uri },
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddConfigurationResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const RemoveConfiguration = struct {
        pub const name = "RemoveConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/RemoveConfiguration";
        pub const request_name = "RemoveConfiguration";
        pub const response_name = "RemoveConfigurationResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            Configuration: []const ConfigurationRef = &.{},
            pub const xml_meta = .{
                .element_name = "RemoveConfiguration",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemoveConfigurationResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const DeleteProfile = struct {
        pub const name = "DeleteProfile";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/DeleteProfile";
        pub const request_name = "DeleteProfile";
        pub const response_name = "DeleteProfileResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Token: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteProfile",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteProfileResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const GetVideoSourceConfigurations = struct {
        pub const name = "GetVideoSourceConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetVideoSourceConfigurations";
        pub const request_name = "GetVideoSourceConfigurations";
        pub const response_name = "GetVideoSourceConfigurationsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurations",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.VideoSourceConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurationsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoEncoderConfigurations = struct {
        pub const name = "GetVideoEncoderConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetVideoEncoderConfigurations";
        pub const request_name = "GetVideoEncoderConfigurations";
        pub const response_name = "GetVideoEncoderConfigurationsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderConfigurations",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.VideoEncoder2Configuration = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderConfigurationsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioSourceConfigurations = struct {
        pub const name = "GetAudioSourceConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetAudioSourceConfigurations";
        pub const request_name = "GetAudioSourceConfigurations";
        pub const response_name = "GetAudioSourceConfigurationsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurations",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioSourceConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurationsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioEncoderConfigurations = struct {
        pub const name = "GetAudioEncoderConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetAudioEncoderConfigurations";
        pub const request_name = "GetAudioEncoderConfigurations";
        pub const response_name = "GetAudioEncoderConfigurationsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioEncoderConfigurations",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioEncoder2Configuration = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioEncoderConfigurationsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetAnalyticsConfigurations = struct {
        pub const name = "GetAnalyticsConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetAnalyticsConfigurations";
        pub const request_name = "GetAnalyticsConfigurations";
        pub const response_name = "GetAnalyticsConfigurationsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAnalyticsConfigurations",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.VideoAnalyticsConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetAnalyticsConfigurationsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetMetadataConfigurations = struct {
        pub const name = "GetMetadataConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetMetadataConfigurations";
        pub const request_name = "GetMetadataConfigurations";
        pub const response_name = "GetMetadataConfigurationsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetMetadataConfigurations",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.MetadataConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetMetadataConfigurationsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioOutputConfigurations = struct {
        pub const name = "GetAudioOutputConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetAudioOutputConfigurations";
        pub const request_name = "GetAudioOutputConfigurations";
        pub const response_name = "GetAudioOutputConfigurationsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurations",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioOutputConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurationsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioDecoderConfigurations = struct {
        pub const name = "GetAudioDecoderConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetAudioDecoderConfigurations";
        pub const request_name = "GetAudioDecoderConfigurations";
        pub const response_name = "GetAudioDecoderConfigurationsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioDecoderConfigurations",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioDecoderConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioDecoderConfigurationsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const SetVideoSourceConfiguration = struct {
        pub const name = "SetVideoSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetVideoSourceConfiguration";
        pub const request_name = "SetVideoSourceConfiguration";
        pub const response_name = "SetVideoSourceConfigurationResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Configuration: schema.VideoSourceConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetVideoSourceConfiguration",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetVideoSourceConfigurationResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const SetVideoEncoderConfiguration = struct {
        pub const name = "SetVideoEncoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetVideoEncoderConfiguration";
        pub const request_name = "SetVideoEncoderConfiguration";
        pub const response_name = "SetVideoEncoderConfigurationResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Configuration: schema.VideoEncoder2Configuration = .{},
            pub const xml_meta = .{
                .element_name = "SetVideoEncoderConfiguration",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetVideoEncoderConfigurationResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const SetAudioSourceConfiguration = struct {
        pub const name = "SetAudioSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetAudioSourceConfiguration";
        pub const request_name = "SetAudioSourceConfiguration";
        pub const response_name = "SetAudioSourceConfigurationResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Configuration: schema.AudioSourceConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetAudioSourceConfiguration",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetAudioSourceConfigurationResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const SetAudioEncoderConfiguration = struct {
        pub const name = "SetAudioEncoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetAudioEncoderConfiguration";
        pub const request_name = "SetAudioEncoderConfiguration";
        pub const response_name = "SetAudioEncoderConfigurationResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Configuration: schema.AudioEncoder2Configuration = .{},
            pub const xml_meta = .{
                .element_name = "SetAudioEncoderConfiguration",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetAudioEncoderConfigurationResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const SetMetadataConfiguration = struct {
        pub const name = "SetMetadataConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetMetadataConfiguration";
        pub const request_name = "SetMetadataConfiguration";
        pub const response_name = "SetMetadataConfigurationResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Configuration: schema.MetadataConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetMetadataConfiguration",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetMetadataConfigurationResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const SetAudioOutputConfiguration = struct {
        pub const name = "SetAudioOutputConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetAudioOutputConfiguration";
        pub const request_name = "SetAudioOutputConfiguration";
        pub const response_name = "SetAudioOutputConfigurationResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Configuration: schema.AudioOutputConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetAudioOutputConfiguration",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetAudioOutputConfigurationResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const SetAudioDecoderConfiguration = struct {
        pub const name = "SetAudioDecoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetAudioDecoderConfiguration";
        pub const request_name = "SetAudioDecoderConfiguration";
        pub const response_name = "SetAudioDecoderConfigurationResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Configuration: schema.AudioDecoderConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetAudioDecoderConfiguration",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetAudioDecoderConfigurationResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const GetVideoSourceConfigurationOptions = struct {
        pub const name = "GetVideoSourceConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetVideoSourceConfigurationOptions";
        pub const request_name = "GetVideoSourceConfigurationOptions";
        pub const response_name = "GetVideoSourceConfigurationOptionsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurationOptions",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.VideoSourceConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurationOptionsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoEncoderConfigurationOptions = struct {
        pub const name = "GetVideoEncoderConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetVideoEncoderConfigurationOptions";
        pub const request_name = "GetVideoEncoderConfigurationOptions";
        pub const response_name = "GetVideoEncoderConfigurationOptionsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderConfigurationOptions",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: []const schema.VideoEncoder2ConfigurationOptions = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderConfigurationOptionsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioSourceConfigurationOptions = struct {
        pub const name = "GetAudioSourceConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetAudioSourceConfigurationOptions";
        pub const request_name = "GetAudioSourceConfigurationOptions";
        pub const response_name = "GetAudioSourceConfigurationOptionsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurationOptions",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.AudioSourceConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurationOptionsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioEncoderConfigurationOptions = struct {
        pub const name = "GetAudioEncoderConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetAudioEncoderConfigurationOptions";
        pub const request_name = "GetAudioEncoderConfigurationOptions";
        pub const response_name = "GetAudioEncoderConfigurationOptionsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioEncoderConfigurationOptions",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: []const schema.AudioEncoder2ConfigurationOptions = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioEncoderConfigurationOptionsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetMetadataConfigurationOptions = struct {
        pub const name = "GetMetadataConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetMetadataConfigurationOptions";
        pub const request_name = "GetMetadataConfigurationOptions";
        pub const response_name = "GetMetadataConfigurationOptionsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetMetadataConfigurationOptions",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.MetadataConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetMetadataConfigurationOptionsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioOutputConfigurationOptions = struct {
        pub const name = "GetAudioOutputConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetAudioOutputConfigurationOptions";
        pub const request_name = "GetAudioOutputConfigurationOptions";
        pub const response_name = "GetAudioOutputConfigurationOptionsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurationOptions",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.AudioOutputConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurationOptionsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioDecoderConfigurationOptions = struct {
        pub const name = "GetAudioDecoderConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetAudioDecoderConfigurationOptions";
        pub const request_name = "GetAudioDecoderConfigurationOptions";
        pub const response_name = "GetAudioDecoderConfigurationOptionsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioDecoderConfigurationOptions",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: []const schema.AudioEncoder2ConfigurationOptions = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioDecoderConfigurationOptionsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const SetEQPreset = struct {
        pub const name = "SetEQPreset";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetEQPreset";
        pub const request_name = "SetEQPresetConfiguration";
        pub const response_name = "SetEQPresetConfigurationResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Configuration: schema.EQPreset = .{},
            pub const xml_meta = .{
                .element_name = "SetEQPresetConfiguration",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetEQPresetConfigurationResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const GetVideoEncoderInstances = struct {
        pub const name = "GetVideoEncoderInstances";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetVideoEncoderInstances";
        pub const request_name = "GetVideoEncoderInstances";
        pub const response_name = "GetVideoEncoderInstancesResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderInstances",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Info: EncoderInstanceInfo = .{},
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderInstancesResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Info = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetStreamUri = struct {
        pub const name = "GetStreamUri";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetStreamUri";
        pub const request_name = "GetStreamUri";
        pub const response_name = "GetStreamUriResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Protocol: []const u8 = "",
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetStreamUri",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Protocol = .{ .ns = Media2.namespace_uri },
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Uri: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetStreamUriResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Uri = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const StartMulticastStreaming = struct {
        pub const name = "StartMulticastStreaming";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/StartMulticastStreaming";
        pub const request_name = "StartMulticastStreaming";
        pub const response_name = "StartMulticastStreamingResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "StartMulticastStreaming",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "StartMulticastStreamingResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const StopMulticastStreaming = struct {
        pub const name = "StopMulticastStreaming";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/StopMulticastStreaming";
        pub const request_name = "StopMulticastStreaming";
        pub const response_name = "StopMulticastStreamingResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "StopMulticastStreaming",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "StopMulticastStreamingResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const SetSynchronizationPoint = struct {
        pub const name = "SetSynchronizationPoint";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetSynchronizationPoint";
        pub const request_name = "SetSynchronizationPoint";
        pub const response_name = "SetSynchronizationPointResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SetSynchronizationPoint",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetSynchronizationPointResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const GetSnapshotUri = struct {
        pub const name = "GetSnapshotUri";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetSnapshotUri";
        pub const request_name = "GetSnapshotUri";
        pub const response_name = "GetSnapshotUriResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetSnapshotUri",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Uri: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetSnapshotUriResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Uri = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoSourceModes = struct {
        pub const name = "GetVideoSourceModes";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetVideoSourceModes";
        pub const request_name = "GetVideoSourceModes";
        pub const response_name = "GetVideoSourceModesResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetVideoSourceModes",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            VideoSourceModes: []const VideoSourceMode = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourceModesResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .VideoSourceModes = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const SetVideoSourceMode = struct {
        pub const name = "SetVideoSourceMode";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetVideoSourceMode";
        pub const request_name = "SetVideoSourceMode";
        pub const response_name = "SetVideoSourceModeResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            VideoSourceModeToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SetVideoSourceMode",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Media2.namespace_uri },
                    .VideoSourceModeToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Reboot: bool = false,
            pub const xml_meta = .{
                .element_name = "SetVideoSourceModeResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Reboot = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetOSDs = struct {
        pub const name = "GetOSDs";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetOSDs";
        pub const request_name = "GetOSDs";
        pub const response_name = "GetOSDsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            OSDToken: ?[]const u8 = null,
            ConfigurationToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetOSDs",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .OSDToken = .{ .ns = Media2.namespace_uri },
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            OSDs: []const schema.OSDConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetOSDsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .OSDs = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetOSDOptions = struct {
        pub const name = "GetOSDOptions";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetOSDOptions";
        pub const request_name = "GetOSDOptions";
        pub const response_name = "GetOSDOptionsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetOSDOptions",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            OSDOptions: schema.OSDConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetOSDOptionsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .OSDOptions = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const SetOSD = struct {
        pub const name = "SetOSD";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetOSD";
        pub const request_name = "SetOSD";
        pub const response_name = "SetOSDResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            OSD: schema.OSDConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetOSD",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .OSD = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetOSDResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const CreateOSD = struct {
        pub const name = "CreateOSD";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/CreateOSD";
        pub const request_name = "CreateOSD";
        pub const response_name = "CreateOSDResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            OSD: schema.OSDConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "CreateOSD",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .OSD = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            OSDToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "CreateOSDResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .OSDToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const DeleteOSD = struct {
        pub const name = "DeleteOSD";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/DeleteOSD";
        pub const request_name = "DeleteOSD";
        pub const response_name = "DeleteOSDResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            OSDToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteOSD",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .OSDToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteOSDResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const GetMasks = struct {
        pub const name = "GetMasks";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetMasks";
        pub const request_name = "GetMasks";
        pub const response_name = "GetMasksResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Token: ?[]const u8 = null,
            ConfigurationToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetMasks",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Masks: []const Mask = &.{},
            pub const xml_meta = .{
                .element_name = "GetMasksResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Masks = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetMaskOptions = struct {
        pub const name = "GetMaskOptions";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetMaskOptions";
        pub const request_name = "GetMaskOptions";
        pub const response_name = "GetMaskOptionsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetMaskOptions",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: MaskOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetMaskOptionsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const SetMask = struct {
        pub const name = "SetMask";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetMask";
        pub const request_name = "SetMask";
        pub const response_name = "SetMaskResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Mask: Mask = .{},
            pub const xml_meta = .{
                .element_name = "SetMask",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Mask = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetMaskResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const CreateMask = struct {
        pub const name = "CreateMask";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/CreateMask";
        pub const request_name = "CreateMask";
        pub const response_name = "CreateMaskResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Mask: Mask = .{},
            pub const xml_meta = .{
                .element_name = "CreateMask",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Mask = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Token: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "CreateMaskResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const DeleteMask = struct {
        pub const name = "DeleteMask";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/DeleteMask";
        pub const request_name = "DeleteMask";
        pub const response_name = "DeleteMaskResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Token: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteMask",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteMaskResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const GetWebRTCConfigurations = struct {
        pub const name = "GetWebRTCConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetWebRTCConfigurations";
        pub const request_name = "GetWebRTCConfigurations";
        pub const response_name = "GetWebRTCConfigurationsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetWebRTCConfigurations",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

        pub const Response = struct {
            WebRTCConfiguration: []const WebRTCConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetWebRTCConfigurationsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .WebRTCConfiguration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const SetWebRTCConfigurations = struct {
        pub const name = "SetWebRTCConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetWebRTCConfigurations";
        pub const request_name = "SetWebRTCConfigurations";
        pub const response_name = "SetWebRTCConfigurationsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            WebRTCConfiguration: []const WebRTCConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "SetWebRTCConfigurations",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .WebRTCConfiguration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetWebRTCConfigurationsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const GetAudioClips = struct {
        pub const name = "GetAudioClips";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetAudioClips";
        pub const request_name = "GetAudioClips";
        pub const response_name = "GetAudioClipsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Token: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioClips",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            AudioClipItem: []const GetAudioClipsResponseItem = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioClipsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .AudioClipItem = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const AddAudioClip = struct {
        pub const name = "AddAudioClip";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/AddAudioClip";
        pub const request_name = "AddAudioClip";
        pub const response_name = "AddAudioClipResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Token: ?[]const u8 = null,
            Configuration: AudioClip = .{},
            pub const xml_meta = .{
                .element_name = "AddAudioClip",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Token: []const u8 = "",
            UploadUri: []const u8 = "",
            ExpiryTime: xsd.DateTime = .{},
            pub const xml_meta = .{
                .element_name = "AddAudioClipResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                    .UploadUri = .{ .ns = Media2.namespace_uri },
                    .ExpiryTime = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const AddTTSAudioClip = struct {
        pub const name = "AddTTSAudioClip";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/AddTTSAudioClip";
        pub const request_name = "AddTTSAudioClip";
        pub const response_name = "AddTTSAudioClipResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Token: ?[]const u8 = null,
            Configuration: AudioClip = .{},
            TTSConfiguration: TTSAudio = .{},
            pub const xml_meta = .{
                .element_name = "AddTTSAudioClip",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                    .Configuration = .{ .ns = Media2.namespace_uri },
                    .TTSConfiguration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Token: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "AddTTSAudioClipResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const SetAudioClip = struct {
        pub const name = "SetAudioClip";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetAudioClip";
        pub const request_name = "SetAudioClip";
        pub const response_name = "SetAudioClipResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Token: []const u8 = "",
            Configuration: AudioClip = .{},
            pub const xml_meta = .{
                .element_name = "SetAudioClip",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetAudioClipResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const DeleteAudioClip = struct {
        pub const name = "DeleteAudioClip";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/DeleteAudioClip";
        pub const request_name = "DeleteAudioClip";
        pub const response_name = "DeleteAudioClipResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Token: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteAudioClip",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteAudioClipResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const PlayAudioClip = struct {
        pub const name = "PlayAudioClip";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/PlayAudioClip";
        pub const request_name = "PlayAudioClip";
        pub const response_name = "PlayAudioClipResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Token: []const u8 = "",
            AudioOutputToken: []const []const u8 = &.{},
            Play: bool = false,
            RepeatCycles: ?i32 = null,
            pub const xml_meta = .{
                .element_name = "PlayAudioClip",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Media2.namespace_uri },
                    .AudioOutputToken = .{ .ns = Media2.namespace_uri },
                    .Play = .{ .ns = Media2.namespace_uri },
                    .RepeatCycles = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "PlayAudioClipResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

    pub const GetPlayingAudioClips = struct {
        pub const name = "GetPlayingAudioClips";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetPlayingAudioClips";
        pub const request_name = "GetPlayingAudioClips";
        pub const response_name = "GetPlayingAudioClipsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetPlayingAudioClips",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

        pub const Response = struct {
            PlayingAudioClips: []const PlayingAudioClips = &.{},
            pub const xml_meta = .{
                .element_name = "GetPlayingAudioClipsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .PlayingAudioClips = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetMulticastAudioDecoderConfigurations = struct {
        pub const name = "GetMulticastAudioDecoderConfigurations";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetMulticastAudioDecoderConfigurations";
        pub const request_name = "GetMulticastAudioDecoderConfigurations";
        pub const response_name = "GetMulticastAudioDecoderConfigurationsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetMulticastAudioDecoderConfigurations",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.MulticastAudioDecoderConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetMulticastAudioDecoderConfigurationsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const GetMulticastAudioDecoderConfigurationOptions = struct {
        pub const name = "GetMulticastAudioDecoderConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/GetMulticastAudioDecoderConfigurationOptions";
        pub const request_name = "GetMulticastAudioDecoderConfigurationOptions";
        pub const response_name = "GetMulticastAudioDecoderConfigurationOptionsResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetMulticastAudioDecoderConfigurationOptions",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: []const schema.MulticastAudioDecoderConfigurationOptions = &.{},
            pub const xml_meta = .{
                .element_name = "GetMulticastAudioDecoderConfigurationOptionsResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media2.namespace_uri },
                },
            };
        };

    };

    pub const SetMulticastAudioDecoderConfiguration = struct {
        pub const name = "SetMulticastAudioDecoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver20/media/wsdl/SetMulticastAudioDecoderConfiguration";
        pub const request_name = "SetMulticastAudioDecoderConfiguration";
        pub const response_name = "SetMulticastAudioDecoderConfigurationResponse";
        pub const namespace = Media2.namespace_uri;
        pub const namespace_uri = Media2.namespace_uri;

        pub const Request = struct {
            Configuration: schema.MulticastAudioDecoderConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetMulticastAudioDecoderConfiguration",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media2.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetMulticastAudioDecoderConfigurationResponse",
                .namespace = Media2.namespace_uri,
                .namespace_uri = Media2.namespace_uri,
            };
        };

    };

};
