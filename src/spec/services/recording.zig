//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const Recording = struct {
    pub const namespace = "http://www.onvif.org/ver10/recording/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver10/recording/wsdl";

    pub const Capabilities = struct {
        DynamicRecordings: ?bool = null,
        DynamicTracks: ?bool = null,
        Encoding: ?[]const u8 = null,
        MaxRate: ?f32 = null,
        MaxTotalRate: ?f32 = null,
        MaxRecordings: ?f32 = null,
        MaxRecordingJobs: ?i32 = null,
        Options: ?bool = null,
        MetadataRecording: ?bool = null,
        SupportedExportFileFormats: ?[]const u8 = null,
        EventRecording: ?bool = null,
        BeforeEventLimit: ?xsd.Duration = null,
        AfterEventLimit: ?xsd.Duration = null,
        SupportedTargetFormats: ?[]const u8 = null,
        EncryptionEntryLimit: ?i32 = null,
        SupportedEncryptionModes: ?[]const u8 = null,
        OverrideSegmentDuration: ?bool = null,
        AsymmetricEncryptionSupported: ?bool = null,
        ScheduledRecording: ?bool = null,
        OnboardStorage: ?bool = null,
        SegmentExport: ?bool = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Capabilities",
            .namespace = Recording.namespace_uri,
            .namespace_uri = Recording.namespace_uri,
            .attributes = &.{"DynamicRecordings", "DynamicTracks", "Encoding", "MaxRate", "MaxTotalRate", "MaxRecordings", "MaxRecordingJobs", "Options", "MetadataRecording", "SupportedExportFileFormats", "EventRecording", "BeforeEventLimit", "AfterEventLimit", "SupportedTargetFormats", "EncryptionEntryLimit", "SupportedEncryptionModes", "OverrideSegmentDuration", "AsymmetricEncryptionSupported", "ScheduledRecording", "OnboardStorage", "SegmentExport"},
        };
    };

    pub const SegmentListResult = struct {
        pub const Inline_Segment = struct {
            StartTime: xsd.DateTime = .{},
            EndTime: xsd.DateTime = .{},
            MediaType: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "Segment",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .StartTime = .{ .ns = Recording.namespace_uri },
                    .EndTime = .{ .ns = Recording.namespace_uri },
                    .MediaType = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        Segment: []const Inline_Segment = &.{},
        HasMoreResults: bool = false,
        pub const xml_meta = .{
            .element_name = "SegmentListResult",
            .namespace = Recording.namespace_uri,
            .namespace_uri = Recording.namespace_uri,
            .fields = .{
                .Segment = .{ .ns = Recording.namespace_uri },
                .HasMoreResults = .{ .ns = Recording.namespace_uri },
            },
        };
    };

    pub const RecordingOptions = struct {
        Job: JobOptions = .{},
        Track: TrackOptions = .{},
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "RecordingOptions",
            .namespace = Recording.namespace_uri,
            .namespace_uri = Recording.namespace_uri,
            .fields = .{
                .Job = .{ .ns = Recording.namespace_uri },
                .Track = .{ .ns = Recording.namespace_uri },
            },
        };
    };

    pub const JobOptions = struct {
        Spare: ?i32 = null,
        CompatibleSources: ?[]const u8 = null,
        pub const xml_meta = .{
            .element_name = "JobOptions",
            .namespace = Recording.namespace_uri,
            .namespace_uri = Recording.namespace_uri,
            .attributes = &.{"Spare", "CompatibleSources"},
        };
    };

    pub const TrackOptions = struct {
        SpareTotal: ?i32 = null,
        SpareVideo: ?i32 = null,
        SpareAudio: ?i32 = null,
        SpareMetadata: ?i32 = null,
        pub const xml_meta = .{
            .element_name = "TrackOptions",
            .namespace = Recording.namespace_uri,
            .namespace_uri = Recording.namespace_uri,
            .attributes = &.{"SpareTotal", "SpareVideo", "SpareAudio", "SpareMetadata"},
        };
    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const CreateRecording = struct {
        pub const name = "CreateRecording";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/CreateRecording";
        pub const request_name = "CreateRecording";
        pub const response_name = "CreateRecordingResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            RecordingConfiguration: schema.RecordingConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "CreateRecording",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            RecordingToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "CreateRecordingResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const DeleteRecording = struct {
        pub const name = "DeleteRecording";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/DeleteRecording";
        pub const request_name = "DeleteRecording";
        pub const response_name = "DeleteRecordingResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            RecordingToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteRecording",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteRecordingResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
            };
        };

    };

    pub const GetRecordings = struct {
        pub const name = "GetRecordings";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/GetRecordings";
        pub const request_name = "GetRecordings";
        pub const response_name = "GetRecordingsResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetRecordings",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
            };
        };

        pub const Response = struct {
            RecordingItem: []const schema.GetRecordingsResponseItem = &.{},
            pub const xml_meta = .{
                .element_name = "GetRecordingsResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingItem = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const SetRecordingConfiguration = struct {
        pub const name = "SetRecordingConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/SetRecordingConfiguration";
        pub const request_name = "SetRecordingConfiguration";
        pub const response_name = "SetRecordingConfigurationResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            RecordingToken: []const u8 = "",
            RecordingConfiguration: schema.RecordingConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetRecordingConfiguration",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingToken = .{ .ns = Recording.namespace_uri },
                    .RecordingConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetRecordingConfigurationResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
            };
        };

    };

    pub const GetRecordingConfiguration = struct {
        pub const name = "GetRecordingConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/GetRecordingConfiguration";
        pub const request_name = "GetRecordingConfiguration";
        pub const response_name = "GetRecordingConfigurationResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            RecordingToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetRecordingConfiguration",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            RecordingConfiguration: schema.RecordingConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetRecordingConfigurationResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const GetRecordingOptions = struct {
        pub const name = "GetRecordingOptions";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/GetRecordingOptions";
        pub const request_name = "GetRecordingOptions";
        pub const response_name = "GetRecordingOptionsResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            RecordingToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetRecordingOptions",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: RecordingOptions = .{},
            pub const xml_meta = .{
                .element_name = "GetRecordingOptionsResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const CreateTrack = struct {
        pub const name = "CreateTrack";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/CreateTrack";
        pub const request_name = "CreateTrack";
        pub const response_name = "CreateTrackResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            RecordingToken: []const u8 = "",
            TrackConfiguration: schema.TrackConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "CreateTrack",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingToken = .{ .ns = Recording.namespace_uri },
                    .TrackConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            TrackToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "CreateTrackResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .TrackToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const DeleteTrack = struct {
        pub const name = "DeleteTrack";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/DeleteTrack";
        pub const request_name = "DeleteTrack";
        pub const response_name = "DeleteTrackResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            RecordingToken: []const u8 = "",
            TrackToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteTrack",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingToken = .{ .ns = Recording.namespace_uri },
                    .TrackToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteTrackResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
            };
        };

    };

    pub const GetTrackConfiguration = struct {
        pub const name = "GetTrackConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/GetTrackConfiguration";
        pub const request_name = "GetTrackConfiguration";
        pub const response_name = "GetTrackConfigurationResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            RecordingToken: []const u8 = "",
            TrackToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetTrackConfiguration",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingToken = .{ .ns = Recording.namespace_uri },
                    .TrackToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            TrackConfiguration: schema.TrackConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetTrackConfigurationResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .TrackConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const SetTrackConfiguration = struct {
        pub const name = "SetTrackConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/SetTrackConfiguration";
        pub const request_name = "SetTrackConfiguration";
        pub const response_name = "SetTrackConfigurationResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            RecordingToken: []const u8 = "",
            TrackToken: []const u8 = "",
            TrackConfiguration: schema.TrackConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetTrackConfiguration",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .RecordingToken = .{ .ns = Recording.namespace_uri },
                    .TrackToken = .{ .ns = Recording.namespace_uri },
                    .TrackConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetTrackConfigurationResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
            };
        };

    };

    pub const CreateRecordingJob = struct {
        pub const name = "CreateRecordingJob";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/CreateRecordingJob";
        pub const request_name = "CreateRecordingJob";
        pub const response_name = "CreateRecordingJobResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            JobConfiguration: schema.RecordingJobConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "CreateRecordingJob",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .JobConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            JobToken: []const u8 = "",
            JobConfiguration: schema.RecordingJobConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "CreateRecordingJobResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .JobToken = .{ .ns = Recording.namespace_uri },
                    .JobConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const DeleteRecordingJob = struct {
        pub const name = "DeleteRecordingJob";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/DeleteRecordingJob";
        pub const request_name = "DeleteRecordingJob";
        pub const response_name = "DeleteRecordingJobResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            JobToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteRecordingJob",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .JobToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteRecordingJobResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
            };
        };

    };

    pub const GetRecordingJobs = struct {
        pub const name = "GetRecordingJobs";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/GetRecordingJobs";
        pub const request_name = "GetRecordingJobs";
        pub const response_name = "GetRecordingJobsResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetRecordingJobs",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
            };
        };

        pub const Response = struct {
            JobItem: []const schema.GetRecordingJobsResponseItem = &.{},
            pub const xml_meta = .{
                .element_name = "GetRecordingJobsResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .JobItem = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const SetRecordingJobConfiguration = struct {
        pub const name = "SetRecordingJobConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/SetRecordingJobConfiguration";
        pub const request_name = "SetRecordingJobConfiguration";
        pub const response_name = "SetRecordingJobConfigurationResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            JobToken: []const u8 = "",
            JobConfiguration: schema.RecordingJobConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetRecordingJobConfiguration",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .JobToken = .{ .ns = Recording.namespace_uri },
                    .JobConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            JobConfiguration: schema.RecordingJobConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetRecordingJobConfigurationResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .JobConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const GetRecordingJobConfiguration = struct {
        pub const name = "GetRecordingJobConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/GetRecordingJobConfiguration";
        pub const request_name = "GetRecordingJobConfiguration";
        pub const response_name = "GetRecordingJobConfigurationResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            JobToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetRecordingJobConfiguration",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .JobToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            JobConfiguration: schema.RecordingJobConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetRecordingJobConfigurationResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .JobConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const SetRecordingJobMode = struct {
        pub const name = "SetRecordingJobMode";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/SetRecordingJobMode";
        pub const request_name = "SetRecordingJobMode";
        pub const response_name = "SetRecordingJobModeResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            JobToken: []const u8 = "",
            Mode: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SetRecordingJobMode",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .JobToken = .{ .ns = Recording.namespace_uri },
                    .Mode = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetRecordingJobModeResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
            };
        };

    };

    pub const GetRecordingJobState = struct {
        pub const name = "GetRecordingJobState";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/GetRecordingJobState";
        pub const request_name = "GetRecordingJobState";
        pub const response_name = "GetRecordingJobStateResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            JobToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetRecordingJobState",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .JobToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            State: schema.RecordingJobStateInformation = .{},
            pub const xml_meta = .{
                .element_name = "GetRecordingJobStateResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .State = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const ListRecordedSegments = struct {
        pub const name = "ListRecordedSegments";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/ListRecordedSegments";
        pub const request_name = "ListRecordedSegments";
        pub const response_name = "ListRecordedSegmentsResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            Time: schema.DateTimeRange = .{},
            RecordingToken: []const u8 = "",
            MaxResults: ?i32 = null,
            pub const xml_meta = .{
                .element_name = "ListRecordedSegments",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .Time = .{ .ns = Recording.namespace_uri },
                    .RecordingToken = .{ .ns = Recording.namespace_uri },
                    .MaxResults = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Results: SegmentListResult = .{},
            pub const xml_meta = .{
                .element_name = "ListRecordedSegmentsResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .Results = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const ExportRecordedSegments = struct {
        pub const name = "ExportRecordedSegments";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/ExportRecordedSegments";
        pub const request_name = "ExportRecordedSegments";
        pub const response_name = "ExportRecordedSegmentsResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            Time: schema.DateTimeRange = .{},
            RecordingToken: []const u8 = "",
            Alias: ?[]const u8 = null,
            StorageToken: ?[]const u8 = null,
            Track: ?[]const u8 = null,
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "ExportRecordedSegments",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .Time = .{ .ns = Recording.namespace_uri },
                    .RecordingToken = .{ .ns = Recording.namespace_uri },
                    .Alias = .{ .ns = Recording.namespace_uri },
                    .StorageToken = .{ .ns = Recording.namespace_uri },
                    .Track = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            OperationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "ExportRecordedSegmentsResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .OperationToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const StopExportRecordedSegments = struct {
        pub const name = "StopExportRecordedSegments";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/StopExportRecordedSegments";
        pub const request_name = "StopExportRecordedSegments";
        pub const response_name = "StopExportRecordedSegmentsResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            OperationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "StopExportRecordedSegments",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .OperationToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "StopExportRecordedSegmentsResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
            };
        };

    };

    pub const ExportRecordedData = struct {
        pub const name = "ExportRecordedData";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/ExportRecordedData";
        pub const request_name = "ExportRecordedData";
        pub const response_name = "ExportRecordedDataResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            StartPoint: ?xsd.DateTime = null,
            EndPoint: ?xsd.DateTime = null,
            SearchScope: schema.SearchScope = .{},
            FileFormat: []const u8 = "",
            StorageDestination: schema.StorageReferencePath = .{},
            pub const xml_meta = .{
                .element_name = "ExportRecordedData",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .StartPoint = .{ .ns = Recording.namespace_uri },
                    .EndPoint = .{ .ns = Recording.namespace_uri },
                    .SearchScope = .{ .ns = Recording.namespace_uri },
                    .FileFormat = .{ .ns = Recording.namespace_uri },
                    .StorageDestination = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const Inline_Extension = struct {
                any: []const xml_any.Any = &.{},
                pub const xml_meta = .{
                    .element_name = "Extension",
                    .namespace = Recording.namespace_uri,
                    .namespace_uri = Recording.namespace_uri,
                };
            };

            OperationToken: []const u8 = "",
            FileNames: []const []const u8 = &.{},
            Extension: ?Inline_Extension = null,
            pub const xml_meta = .{
                .element_name = "ExportRecordedDataResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .OperationToken = .{ .ns = Recording.namespace_uri },
                    .FileNames = .{ .ns = Recording.namespace_uri },
                    .Extension = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const StopExportRecordedData = struct {
        pub const name = "StopExportRecordedData";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/StopExportRecordedData";
        pub const request_name = "StopExportRecordedData";
        pub const response_name = "StopExportRecordedDataResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            OperationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "StopExportRecordedData",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .OperationToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Progress: f32 = 0.0,
            FileProgressStatus: schema.ArrayOfFileProgress = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "StopExportRecordedDataResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .Progress = .{ .ns = Recording.namespace_uri },
                    .FileProgressStatus = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const GetExportRecordedDataState = struct {
        pub const name = "GetExportRecordedDataState";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/GetExportRecordedDataState";
        pub const request_name = "GetExportRecordedDataState";
        pub const response_name = "GetExportRecordedDataStateResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            OperationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetExportRecordedDataState",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .OperationToken = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Progress: f32 = 0.0,
            FileProgressStatus: schema.ArrayOfFileProgress = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetExportRecordedDataStateResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .Progress = .{ .ns = Recording.namespace_uri },
                    .FileProgressStatus = .{ .ns = Recording.namespace_uri },
                },
            };
        };

    };

    pub const OverrideSegmentDuration = struct {
        pub const name = "OverrideSegmentDuration";
        pub const soap_action = "http://www.onvif.org/ver10/recording/wsdl/OverrideSegmentDuration";
        pub const request_name = "OverrideSegmentDuration";
        pub const response_name = "OverrideSegmentDurationResponse";
        pub const namespace = Recording.namespace_uri;
        pub const namespace_uri = Recording.namespace_uri;

        pub const Request = struct {
            TargetSegmentDuration: xsd.Duration = .{},
            Expiration: xsd.Duration = .{},
            RecordingConfiguration: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "OverrideSegmentDuration",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
                .fields = .{
                    .TargetSegmentDuration = .{ .ns = Recording.namespace_uri },
                    .Expiration = .{ .ns = Recording.namespace_uri },
                    .RecordingConfiguration = .{ .ns = Recording.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "OverrideSegmentDurationResponse",
                .namespace = Recording.namespace_uri,
                .namespace_uri = Recording.namespace_uri,
            };
        };

    };

};
