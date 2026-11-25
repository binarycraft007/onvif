//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const Media = struct {
    pub const namespace = "http://www.onvif.org/ver10/media/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver10/media/wsdl";

    pub const Capabilities = struct {
        SnapshotUri: ?bool = null,
        Rotation: ?bool = null,
        VideoSourceMode: ?bool = null,
        OSD: ?bool = null,
        TemporaryOSDText: ?bool = null,
        EXICompression: ?bool = null,
        ProfileCapabilities: ProfileCapabilities = .{},
        StreamingCapabilities: StreamingCapabilities = .{},
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Capabilities",
            .namespace = Media.namespace_uri,
            .namespace_uri = Media.namespace_uri,
            .attributes = &.{"SnapshotUri", "Rotation", "VideoSourceMode", "OSD", "TemporaryOSDText", "EXICompression"},
            .fields = .{
                .ProfileCapabilities = .{ .ns = Media.namespace_uri },
                .StreamingCapabilities = .{ .ns = Media.namespace_uri },
            },
        };
    };

    pub const ProfileCapabilities = struct {
        MaximumNumberOfProfiles: ?i32 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "ProfileCapabilities",
            .namespace = Media.namespace_uri,
            .namespace_uri = Media.namespace_uri,
            .attributes = &.{"MaximumNumberOfProfiles"},
        };
    };

    pub const StreamingCapabilities = struct {
        RTPMulticast: ?bool = null,
        RTP_TCP: ?bool = null,
        RTP_RTSP_TCP: ?bool = null,
        NonAggregateControl: ?bool = null,
        NoRTSPStreaming: ?bool = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "StreamingCapabilities",
            .namespace = Media.namespace_uri,
            .namespace_uri = Media.namespace_uri,
            .attributes = &.{"RTPMulticast", "RTP_TCP", "RTP_RTSP_TCP", "NonAggregateControl", "NoRTSPStreaming"},
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
        Extension: ?VideoSourceModeExtension = null,
        pub const xml_meta = .{
            .element_name = "VideoSourceMode",
            .namespace = Media.namespace_uri,
            .namespace_uri = Media.namespace_uri,
            .attributes = &.{"token", "Enabled"},
            .fields = .{
                .MaxFramerate = .{ .ns = Media.namespace_uri },
                .MaxResolution = .{ .ns = Media.namespace_uri },
                .Encodings = .{ .ns = Media.namespace_uri },
                .Reboot = .{ .ns = Media.namespace_uri },
                .Description = .{ .ns = Media.namespace_uri },
                .Extension = .{ .ns = Media.namespace_uri },
            },
        };
    };

    pub const VideoSourceModeExtension = struct {
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "VideoSourceModeExtension",
            .namespace = Media.namespace_uri,
            .namespace_uri = Media.namespace_uri,
        };
    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoSources = struct {
        pub const name = "GetVideoSources";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetVideoSources";
        pub const request_name = "GetVideoSources";
        pub const response_name = "GetVideoSourcesResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetVideoSources",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            VideoSources: []const schema.VideoSource = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourcesResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .VideoSources = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioSources = struct {
        pub const name = "GetAudioSources";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioSources";
        pub const request_name = "GetAudioSources";
        pub const response_name = "GetAudioSourcesResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetAudioSources",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            AudioSources: []const schema.AudioSource = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioSourcesResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .AudioSources = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioOutputs = struct {
        pub const name = "GetAudioOutputs";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioOutputs";
        pub const request_name = "GetAudioOutputs";
        pub const response_name = "GetAudioOutputsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetAudioOutputs",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            AudioOutputs: []const schema.AudioOutput = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioOutputsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .AudioOutputs = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const CreateProfile = struct {
        pub const name = "CreateProfile";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/CreateProfile";
        pub const request_name = "CreateProfile";
        pub const response_name = "CreateProfileResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            Name: []const u8 = "",
            Token: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "CreateProfile",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Name = .{ .ns = Media.namespace_uri },
                    .Token = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Profile: schema.Profile = .{},
            pub const xml_meta = .{
                .element_name = "CreateProfileResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Profile = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetProfile = struct {
        pub const name = "GetProfile";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetProfile";
        pub const request_name = "GetProfile";
        pub const response_name = "GetProfileResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetProfile",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Profile: schema.Profile = .{},
            pub const xml_meta = .{
                .element_name = "GetProfileResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Profile = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetProfiles = struct {
        pub const name = "GetProfiles";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetProfiles";
        pub const request_name = "GetProfiles";
        pub const response_name = "GetProfilesResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetProfiles",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            Profiles: []const schema.Profile = &.{},
            pub const xml_meta = .{
                .element_name = "GetProfilesResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Profiles = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const AddVideoEncoderConfiguration = struct {
        pub const name = "AddVideoEncoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/AddVideoEncoderConfiguration";
        pub const request_name = "AddVideoEncoderConfiguration";
        pub const response_name = "AddVideoEncoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "AddVideoEncoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddVideoEncoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const RemoveVideoEncoderConfiguration = struct {
        pub const name = "RemoveVideoEncoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/RemoveVideoEncoderConfiguration";
        pub const request_name = "RemoveVideoEncoderConfiguration";
        pub const response_name = "RemoveVideoEncoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "RemoveVideoEncoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemoveVideoEncoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const AddVideoSourceConfiguration = struct {
        pub const name = "AddVideoSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/AddVideoSourceConfiguration";
        pub const request_name = "AddVideoSourceConfiguration";
        pub const response_name = "AddVideoSourceConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "AddVideoSourceConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddVideoSourceConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const RemoveVideoSourceConfiguration = struct {
        pub const name = "RemoveVideoSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/RemoveVideoSourceConfiguration";
        pub const request_name = "RemoveVideoSourceConfiguration";
        pub const response_name = "RemoveVideoSourceConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "RemoveVideoSourceConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemoveVideoSourceConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const AddAudioEncoderConfiguration = struct {
        pub const name = "AddAudioEncoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/AddAudioEncoderConfiguration";
        pub const request_name = "AddAudioEncoderConfiguration";
        pub const response_name = "AddAudioEncoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "AddAudioEncoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddAudioEncoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const RemoveAudioEncoderConfiguration = struct {
        pub const name = "RemoveAudioEncoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/RemoveAudioEncoderConfiguration";
        pub const request_name = "RemoveAudioEncoderConfiguration";
        pub const response_name = "RemoveAudioEncoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "RemoveAudioEncoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemoveAudioEncoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const AddAudioSourceConfiguration = struct {
        pub const name = "AddAudioSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/AddAudioSourceConfiguration";
        pub const request_name = "AddAudioSourceConfiguration";
        pub const response_name = "AddAudioSourceConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "AddAudioSourceConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddAudioSourceConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const RemoveAudioSourceConfiguration = struct {
        pub const name = "RemoveAudioSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/RemoveAudioSourceConfiguration";
        pub const request_name = "RemoveAudioSourceConfiguration";
        pub const response_name = "RemoveAudioSourceConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "RemoveAudioSourceConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemoveAudioSourceConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const AddPTZConfiguration = struct {
        pub const name = "AddPTZConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/AddPTZConfiguration";
        pub const request_name = "AddPTZConfiguration";
        pub const response_name = "AddPTZConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "AddPTZConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddPTZConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const RemovePTZConfiguration = struct {
        pub const name = "RemovePTZConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/RemovePTZConfiguration";
        pub const request_name = "RemovePTZConfiguration";
        pub const response_name = "RemovePTZConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "RemovePTZConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemovePTZConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const AddVideoAnalyticsConfiguration = struct {
        pub const name = "AddVideoAnalyticsConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/AddVideoAnalyticsConfiguration";
        pub const request_name = "AddVideoAnalyticsConfiguration";
        pub const response_name = "AddVideoAnalyticsConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "AddVideoAnalyticsConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddVideoAnalyticsConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const RemoveVideoAnalyticsConfiguration = struct {
        pub const name = "RemoveVideoAnalyticsConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/RemoveVideoAnalyticsConfiguration";
        pub const request_name = "RemoveVideoAnalyticsConfiguration";
        pub const response_name = "RemoveVideoAnalyticsConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "RemoveVideoAnalyticsConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemoveVideoAnalyticsConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const AddMetadataConfiguration = struct {
        pub const name = "AddMetadataConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/AddMetadataConfiguration";
        pub const request_name = "AddMetadataConfiguration";
        pub const response_name = "AddMetadataConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "AddMetadataConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddMetadataConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const RemoveMetadataConfiguration = struct {
        pub const name = "RemoveMetadataConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/RemoveMetadataConfiguration";
        pub const request_name = "RemoveMetadataConfiguration";
        pub const response_name = "RemoveMetadataConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "RemoveMetadataConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemoveMetadataConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const AddAudioOutputConfiguration = struct {
        pub const name = "AddAudioOutputConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/AddAudioOutputConfiguration";
        pub const request_name = "AddAudioOutputConfiguration";
        pub const response_name = "AddAudioOutputConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "AddAudioOutputConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddAudioOutputConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const RemoveAudioOutputConfiguration = struct {
        pub const name = "RemoveAudioOutputConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/RemoveAudioOutputConfiguration";
        pub const request_name = "RemoveAudioOutputConfiguration";
        pub const response_name = "RemoveAudioOutputConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "RemoveAudioOutputConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemoveAudioOutputConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const AddAudioDecoderConfiguration = struct {
        pub const name = "AddAudioDecoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/AddAudioDecoderConfiguration";
        pub const request_name = "AddAudioDecoderConfiguration";
        pub const response_name = "AddAudioDecoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "AddAudioDecoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddAudioDecoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const RemoveAudioDecoderConfiguration = struct {
        pub const name = "RemoveAudioDecoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/RemoveAudioDecoderConfiguration";
        pub const request_name = "RemoveAudioDecoderConfiguration";
        pub const response_name = "RemoveAudioDecoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "RemoveAudioDecoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemoveAudioDecoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const DeleteProfile = struct {
        pub const name = "DeleteProfile";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/DeleteProfile";
        pub const request_name = "DeleteProfile";
        pub const response_name = "DeleteProfileResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteProfile",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteProfileResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const GetVideoSourceConfigurations = struct {
        pub const name = "GetVideoSourceConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetVideoSourceConfigurations";
        pub const request_name = "GetVideoSourceConfigurations";
        pub const response_name = "GetVideoSourceConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            Configurations: []const schema.VideoSourceConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoEncoderConfigurations = struct {
        pub const name = "GetVideoEncoderConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetVideoEncoderConfigurations";
        pub const request_name = "GetVideoEncoderConfigurations";
        pub const response_name = "GetVideoEncoderConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            Configurations: []const schema.VideoEncoderConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioSourceConfigurations = struct {
        pub const name = "GetAudioSourceConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioSourceConfigurations";
        pub const request_name = "GetAudioSourceConfigurations";
        pub const response_name = "GetAudioSourceConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioSourceConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioEncoderConfigurations = struct {
        pub const name = "GetAudioEncoderConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioEncoderConfigurations";
        pub const request_name = "GetAudioEncoderConfigurations";
        pub const response_name = "GetAudioEncoderConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetAudioEncoderConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioEncoderConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioEncoderConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoAnalyticsConfigurations = struct {
        pub const name = "GetVideoAnalyticsConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetVideoAnalyticsConfigurations";
        pub const request_name = "GetVideoAnalyticsConfigurations";
        pub const response_name = "GetVideoAnalyticsConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetVideoAnalyticsConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            Configurations: []const schema.VideoAnalyticsConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoAnalyticsConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetMetadataConfigurations = struct {
        pub const name = "GetMetadataConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetMetadataConfigurations";
        pub const request_name = "GetMetadataConfigurations";
        pub const response_name = "GetMetadataConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetMetadataConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            Configurations: []const schema.MetadataConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetMetadataConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioOutputConfigurations = struct {
        pub const name = "GetAudioOutputConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioOutputConfigurations";
        pub const request_name = "GetAudioOutputConfigurations";
        pub const response_name = "GetAudioOutputConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioOutputConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioDecoderConfigurations = struct {
        pub const name = "GetAudioDecoderConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioDecoderConfigurations";
        pub const request_name = "GetAudioDecoderConfigurations";
        pub const response_name = "GetAudioDecoderConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetAudioDecoderConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioDecoderConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetAudioDecoderConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoSourceConfiguration = struct {
        pub const name = "GetVideoSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetVideoSourceConfiguration";
        pub const request_name = "GetVideoSourceConfiguration";
        pub const response_name = "GetVideoSourceConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configuration: schema.VideoSourceConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoEncoderConfiguration = struct {
        pub const name = "GetVideoEncoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetVideoEncoderConfiguration";
        pub const request_name = "GetVideoEncoderConfiguration";
        pub const response_name = "GetVideoEncoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configuration: schema.VideoEncoderConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioSourceConfiguration = struct {
        pub const name = "GetAudioSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioSourceConfiguration";
        pub const request_name = "GetAudioSourceConfiguration";
        pub const response_name = "GetAudioSourceConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configuration: schema.AudioSourceConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioEncoderConfiguration = struct {
        pub const name = "GetAudioEncoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioEncoderConfiguration";
        pub const request_name = "GetAudioEncoderConfiguration";
        pub const response_name = "GetAudioEncoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetAudioEncoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configuration: schema.AudioEncoderConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetAudioEncoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoAnalyticsConfiguration = struct {
        pub const name = "GetVideoAnalyticsConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetVideoAnalyticsConfiguration";
        pub const request_name = "GetVideoAnalyticsConfiguration";
        pub const response_name = "GetVideoAnalyticsConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetVideoAnalyticsConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configuration: schema.VideoAnalyticsConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetVideoAnalyticsConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetMetadataConfiguration = struct {
        pub const name = "GetMetadataConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetMetadataConfiguration";
        pub const request_name = "GetMetadataConfiguration";
        pub const response_name = "GetMetadataConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetMetadataConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configuration: schema.MetadataConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetMetadataConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioOutputConfiguration = struct {
        pub const name = "GetAudioOutputConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioOutputConfiguration";
        pub const request_name = "GetAudioOutputConfiguration";
        pub const response_name = "GetAudioOutputConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configuration: schema.AudioOutputConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioDecoderConfiguration = struct {
        pub const name = "GetAudioDecoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioDecoderConfiguration";
        pub const request_name = "GetAudioDecoderConfiguration";
        pub const response_name = "GetAudioDecoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetAudioDecoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configuration: schema.AudioDecoderConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetAudioDecoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetCompatibleVideoEncoderConfigurations = struct {
        pub const name = "GetCompatibleVideoEncoderConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetCompatibleVideoEncoderConfigurations";
        pub const request_name = "GetCompatibleVideoEncoderConfigurations";
        pub const response_name = "GetCompatibleVideoEncoderConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetCompatibleVideoEncoderConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.VideoEncoderConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetCompatibleVideoEncoderConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetCompatibleVideoSourceConfigurations = struct {
        pub const name = "GetCompatibleVideoSourceConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetCompatibleVideoSourceConfigurations";
        pub const request_name = "GetCompatibleVideoSourceConfigurations";
        pub const response_name = "GetCompatibleVideoSourceConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetCompatibleVideoSourceConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.VideoSourceConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetCompatibleVideoSourceConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetCompatibleAudioEncoderConfigurations = struct {
        pub const name = "GetCompatibleAudioEncoderConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetCompatibleAudioEncoderConfigurations";
        pub const request_name = "GetCompatibleAudioEncoderConfigurations";
        pub const response_name = "GetCompatibleAudioEncoderConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetCompatibleAudioEncoderConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioEncoderConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetCompatibleAudioEncoderConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetCompatibleAudioSourceConfigurations = struct {
        pub const name = "GetCompatibleAudioSourceConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetCompatibleAudioSourceConfigurations";
        pub const request_name = "GetCompatibleAudioSourceConfigurations";
        pub const response_name = "GetCompatibleAudioSourceConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetCompatibleAudioSourceConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioSourceConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetCompatibleAudioSourceConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetCompatibleVideoAnalyticsConfigurations = struct {
        pub const name = "GetCompatibleVideoAnalyticsConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetCompatibleVideoAnalyticsConfigurations";
        pub const request_name = "GetCompatibleVideoAnalyticsConfigurations";
        pub const response_name = "GetCompatibleVideoAnalyticsConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetCompatibleVideoAnalyticsConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.VideoAnalyticsConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetCompatibleVideoAnalyticsConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetCompatibleMetadataConfigurations = struct {
        pub const name = "GetCompatibleMetadataConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetCompatibleMetadataConfigurations";
        pub const request_name = "GetCompatibleMetadataConfigurations";
        pub const response_name = "GetCompatibleMetadataConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetCompatibleMetadataConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.MetadataConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetCompatibleMetadataConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetCompatibleAudioOutputConfigurations = struct {
        pub const name = "GetCompatibleAudioOutputConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetCompatibleAudioOutputConfigurations";
        pub const request_name = "GetCompatibleAudioOutputConfigurations";
        pub const response_name = "GetCompatibleAudioOutputConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetCompatibleAudioOutputConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioOutputConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetCompatibleAudioOutputConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetCompatibleAudioDecoderConfigurations = struct {
        pub const name = "GetCompatibleAudioDecoderConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetCompatibleAudioDecoderConfigurations";
        pub const request_name = "GetCompatibleAudioDecoderConfigurations";
        pub const response_name = "GetCompatibleAudioDecoderConfigurationsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetCompatibleAudioDecoderConfigurations",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Configurations: []const schema.AudioDecoderConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetCompatibleAudioDecoderConfigurationsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configurations = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const SetVideoSourceConfiguration = struct {
        pub const name = "SetVideoSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/SetVideoSourceConfiguration";
        pub const request_name = "SetVideoSourceConfiguration";
        pub const response_name = "SetVideoSourceConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            Configuration: schema.VideoSourceConfiguration = .{},
            ForcePersistence: bool = false,
            pub const xml_meta = .{
                .element_name = "SetVideoSourceConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                    .ForcePersistence = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetVideoSourceConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const SetVideoEncoderConfiguration = struct {
        pub const name = "SetVideoEncoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/SetVideoEncoderConfiguration";
        pub const request_name = "SetVideoEncoderConfiguration";
        pub const response_name = "SetVideoEncoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            Configuration: schema.VideoEncoderConfiguration = .{},
            ForcePersistence: bool = false,
            pub const xml_meta = .{
                .element_name = "SetVideoEncoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                    .ForcePersistence = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetVideoEncoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const SetAudioSourceConfiguration = struct {
        pub const name = "SetAudioSourceConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/SetAudioSourceConfiguration";
        pub const request_name = "SetAudioSourceConfiguration";
        pub const response_name = "SetAudioSourceConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            Configuration: schema.AudioSourceConfiguration = .{},
            ForcePersistence: bool = false,
            pub const xml_meta = .{
                .element_name = "SetAudioSourceConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                    .ForcePersistence = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetAudioSourceConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const SetAudioEncoderConfiguration = struct {
        pub const name = "SetAudioEncoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/SetAudioEncoderConfiguration";
        pub const request_name = "SetAudioEncoderConfiguration";
        pub const response_name = "SetAudioEncoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            Configuration: schema.AudioEncoderConfiguration = .{},
            ForcePersistence: bool = false,
            pub const xml_meta = .{
                .element_name = "SetAudioEncoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                    .ForcePersistence = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetAudioEncoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const SetVideoAnalyticsConfiguration = struct {
        pub const name = "SetVideoAnalyticsConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/SetVideoAnalyticsConfiguration";
        pub const request_name = "SetVideoAnalyticsConfiguration";
        pub const response_name = "SetVideoAnalyticsConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            Configuration: schema.VideoAnalyticsConfiguration = .{},
            ForcePersistence: bool = false,
            pub const xml_meta = .{
                .element_name = "SetVideoAnalyticsConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                    .ForcePersistence = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetVideoAnalyticsConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const SetMetadataConfiguration = struct {
        pub const name = "SetMetadataConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/SetMetadataConfiguration";
        pub const request_name = "SetMetadataConfiguration";
        pub const response_name = "SetMetadataConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            Configuration: schema.MetadataConfiguration = .{},
            ForcePersistence: bool = false,
            pub const xml_meta = .{
                .element_name = "SetMetadataConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                    .ForcePersistence = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetMetadataConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const SetAudioOutputConfiguration = struct {
        pub const name = "SetAudioOutputConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/SetAudioOutputConfiguration";
        pub const request_name = "SetAudioOutputConfiguration";
        pub const response_name = "SetAudioOutputConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            Configuration: schema.AudioOutputConfiguration = .{},
            ForcePersistence: bool = false,
            pub const xml_meta = .{
                .element_name = "SetAudioOutputConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                    .ForcePersistence = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetAudioOutputConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const SetAudioDecoderConfiguration = struct {
        pub const name = "SetAudioDecoderConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/SetAudioDecoderConfiguration";
        pub const request_name = "SetAudioDecoderConfiguration";
        pub const response_name = "SetAudioDecoderConfigurationResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            Configuration: schema.AudioDecoderConfiguration = .{},
            ForcePersistence: bool = false,
            pub const xml_meta = .{
                .element_name = "SetAudioDecoderConfiguration",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Media.namespace_uri },
                    .ForcePersistence = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetAudioDecoderConfigurationResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const GetVideoSourceConfigurationOptions = struct {
        pub const name = "GetVideoSourceConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetVideoSourceConfigurationOptions";
        pub const request_name = "GetVideoSourceConfigurationOptions";
        pub const response_name = "GetVideoSourceConfigurationOptionsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurationOptions",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.VideoSourceConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourceConfigurationOptionsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoEncoderConfigurationOptions = struct {
        pub const name = "GetVideoEncoderConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetVideoEncoderConfigurationOptions";
        pub const request_name = "GetVideoEncoderConfigurationOptions";
        pub const response_name = "GetVideoEncoderConfigurationOptionsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderConfigurationOptions",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.VideoEncoderConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetVideoEncoderConfigurationOptionsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioSourceConfigurationOptions = struct {
        pub const name = "GetAudioSourceConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioSourceConfigurationOptions";
        pub const request_name = "GetAudioSourceConfigurationOptions";
        pub const response_name = "GetAudioSourceConfigurationOptionsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurationOptions",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.AudioSourceConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetAudioSourceConfigurationOptionsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioEncoderConfigurationOptions = struct {
        pub const name = "GetAudioEncoderConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioEncoderConfigurationOptions";
        pub const request_name = "GetAudioEncoderConfigurationOptions";
        pub const response_name = "GetAudioEncoderConfigurationOptionsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioEncoderConfigurationOptions",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.AudioEncoderConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetAudioEncoderConfigurationOptionsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetMetadataConfigurationOptions = struct {
        pub const name = "GetMetadataConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetMetadataConfigurationOptions";
        pub const request_name = "GetMetadataConfigurationOptions";
        pub const response_name = "GetMetadataConfigurationOptionsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetMetadataConfigurationOptions",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.MetadataConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetMetadataConfigurationOptionsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioOutputConfigurationOptions = struct {
        pub const name = "GetAudioOutputConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioOutputConfigurationOptions";
        pub const request_name = "GetAudioOutputConfigurationOptions";
        pub const response_name = "GetAudioOutputConfigurationOptionsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurationOptions",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.AudioOutputConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetAudioOutputConfigurationOptionsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetAudioDecoderConfigurationOptions = struct {
        pub const name = "GetAudioDecoderConfigurationOptions";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetAudioDecoderConfigurationOptions";
        pub const request_name = "GetAudioDecoderConfigurationOptions";
        pub const response_name = "GetAudioDecoderConfigurationOptionsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            ProfileToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetAudioDecoderConfigurationOptions",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: schema.AudioDecoderConfigurationOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetAudioDecoderConfigurationOptionsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetGuaranteedNumberOfVideoEncoderInstances = struct {
        pub const name = "GetGuaranteedNumberOfVideoEncoderInstances";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetGuaranteedNumberOfVideoEncoderInstances";
        pub const request_name = "GetGuaranteedNumberOfVideoEncoderInstances";
        pub const response_name = "GetGuaranteedNumberOfVideoEncoderInstancesResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetGuaranteedNumberOfVideoEncoderInstances",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            TotalNumber: i32 = 0,
            JPEG: ?i32 = null,
            H264: ?i32 = null,
            MPEG4: ?i32 = null,
            pub const xml_meta = .{
                .element_name = "GetGuaranteedNumberOfVideoEncoderInstancesResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .TotalNumber = .{ .ns = Media.namespace_uri },
                    .JPEG = .{ .ns = Media.namespace_uri },
                    .H264 = .{ .ns = Media.namespace_uri },
                    .MPEG4 = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetStreamUri = struct {
        pub const name = "GetStreamUri";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetStreamUri";
        pub const request_name = "GetStreamUri";
        pub const response_name = "GetStreamUriResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            StreamSetup: schema.StreamSetup = .{},
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetStreamUri",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .StreamSetup = .{ .ns = Media.namespace_uri },
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            MediaUri: schema.MediaUri = .{},
            pub const xml_meta = .{
                .element_name = "GetStreamUriResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .MediaUri = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const StartMulticastStreaming = struct {
        pub const name = "StartMulticastStreaming";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/StartMulticastStreaming";
        pub const request_name = "StartMulticastStreaming";
        pub const response_name = "StartMulticastStreamingResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "StartMulticastStreaming",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "StartMulticastStreamingResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const StopMulticastStreaming = struct {
        pub const name = "StopMulticastStreaming";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/StopMulticastStreaming";
        pub const request_name = "StopMulticastStreaming";
        pub const response_name = "StopMulticastStreamingResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "StopMulticastStreaming",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "StopMulticastStreamingResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const SetSynchronizationPoint = struct {
        pub const name = "SetSynchronizationPoint";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/SetSynchronizationPoint";
        pub const request_name = "SetSynchronizationPoint";
        pub const response_name = "SetSynchronizationPointResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SetSynchronizationPoint",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetSynchronizationPointResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const GetSnapshotUri = struct {
        pub const name = "GetSnapshotUri";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetSnapshotUri";
        pub const request_name = "GetSnapshotUri";
        pub const response_name = "GetSnapshotUriResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ProfileToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetSnapshotUri",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ProfileToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            MediaUri: schema.MediaUri = .{},
            pub const xml_meta = .{
                .element_name = "GetSnapshotUriResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .MediaUri = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetVideoSourceModes = struct {
        pub const name = "GetVideoSourceModes";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetVideoSourceModes";
        pub const request_name = "GetVideoSourceModes";
        pub const response_name = "GetVideoSourceModesResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetVideoSourceModes",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            VideoSourceModes: []const VideoSourceMode = &.{},
            pub const xml_meta = .{
                .element_name = "GetVideoSourceModesResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .VideoSourceModes = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const SetVideoSourceMode = struct {
        pub const name = "SetVideoSourceMode";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/SetVideoSourceMode";
        pub const request_name = "SetVideoSourceMode";
        pub const response_name = "SetVideoSourceModeResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            VideoSourceToken: []const u8 = "",
            VideoSourceModeToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SetVideoSourceMode",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .VideoSourceToken = .{ .ns = Media.namespace_uri },
                    .VideoSourceModeToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Reboot: bool = false,
            pub const xml_meta = .{
                .element_name = "SetVideoSourceModeResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .Reboot = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetOSDs = struct {
        pub const name = "GetOSDs";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetOSDs";
        pub const request_name = "GetOSDs";
        pub const response_name = "GetOSDsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetOSDs",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            OSDs: []const schema.OSDConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetOSDsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .OSDs = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetOSD = struct {
        pub const name = "GetOSD";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetOSD";
        pub const request_name = "GetOSD";
        pub const response_name = "GetOSDResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            OSDToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetOSD",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .OSDToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            OSD: schema.OSDConfiguration = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetOSDResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .OSD = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const GetOSDOptions = struct {
        pub const name = "GetOSDOptions";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/GetOSDOptions";
        pub const request_name = "GetOSDOptions";
        pub const response_name = "GetOSDOptionsResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetOSDOptions",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            OSDOptions: schema.OSDConfigurationOptions = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetOSDOptionsResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .OSDOptions = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const SetOSD = struct {
        pub const name = "SetOSD";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/SetOSD";
        pub const request_name = "SetOSD";
        pub const response_name = "SetOSDResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            OSD: schema.OSDConfiguration = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "SetOSD",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .OSD = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "SetOSDResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

    pub const CreateOSD = struct {
        pub const name = "CreateOSD";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/CreateOSD";
        pub const request_name = "CreateOSD";
        pub const response_name = "CreateOSDResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            OSD: schema.OSDConfiguration = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "CreateOSD",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .OSD = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            OSDToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "CreateOSDResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .OSDToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

    };

    pub const DeleteOSD = struct {
        pub const name = "DeleteOSD";
        pub const soap_action = "http://www.onvif.org/ver10/media/wsdl/DeleteOSD";
        pub const request_name = "DeleteOSD";
        pub const response_name = "DeleteOSDResponse";
        pub const namespace = Media.namespace_uri;
        pub const namespace_uri = Media.namespace_uri;

        pub const Request = struct {
            OSDToken: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "DeleteOSD",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
                .fields = .{
                    .OSDToken = .{ .ns = Media.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "DeleteOSDResponse",
                .namespace = Media.namespace_uri,
                .namespace_uri = Media.namespace_uri,
            };
        };

    };

};
