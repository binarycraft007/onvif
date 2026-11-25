//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const Search = struct {
    pub const namespace = "http://www.onvif.org/ver10/search/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver10/search/wsdl";

    pub const Capabilities = struct {
        MetadataSearch: ?bool = null,
        GeneralStartEvents: ?bool = null,
        NLSearch: ?bool = null,
        ImageSearch: ?bool = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Capabilities",
            .namespace = Search.namespace_uri,
            .namespace_uri = Search.namespace_uri,
            .attributes = &.{"MetadataSearch", "GeneralStartEvents", "NLSearch", "ImageSearch"},
        };
    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const GetRecordingSummary = struct {
        pub const name = "GetRecordingSummary";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/GetRecordingSummary";
        pub const request_name = "GetRecordingSummary";
        pub const response_name = "GetRecordingSummaryResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetRecordingSummary",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
            };
        };

        pub const Response = struct {
            Summary: schema.RecordingSummary = .{},
            pub const xml_meta = .{
                .element_name = "GetRecordingSummaryResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .Summary = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const GetRecordingInformation = struct {
        pub const name = "GetRecordingInformation";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/GetRecordingInformation";
        pub const request_name = "GetRecordingInformation";
        pub const response_name = "GetRecordingInformationResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            RecordingToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetRecordingInformation",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .RecordingToken = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            RecordingInformation: schema.RecordingInformation = .{},
            pub const xml_meta = .{
                .element_name = "GetRecordingInformationResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .RecordingInformation = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const GetMediaAttributes = struct {
        pub const name = "GetMediaAttributes";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/GetMediaAttributes";
        pub const request_name = "GetMediaAttributes";
        pub const response_name = "GetMediaAttributesResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            RecordingTokens: []const []const u8 = &.{},
            Time: xsd.DateTime = .{},
            pub const xml_meta = .{
                .element_name = "GetMediaAttributes",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .RecordingTokens = .{ .ns = Search.namespace_uri },
                    .Time = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            MediaAttributes: []const schema.MediaAttributes = &.{},
            pub const xml_meta = .{
                .element_name = "GetMediaAttributesResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .MediaAttributes = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const FindRecordings = struct {
        pub const name = "FindRecordings";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/FindRecordings";
        pub const request_name = "FindRecordings";
        pub const response_name = "FindRecordingsResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            Scope: schema.SearchScope = .{},
            MaxMatches: ?i32 = null,
            KeepAliveTime: xsd.Duration = .{},
            pub const xml_meta = .{
                .element_name = "FindRecordings",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .Scope = .{ .ns = Search.namespace_uri },
                    .MaxMatches = .{ .ns = Search.namespace_uri },
                    .KeepAliveTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SearchToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "FindRecordingsResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const GetRecordingSearchResults = struct {
        pub const name = "GetRecordingSearchResults";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/GetRecordingSearchResults";
        pub const request_name = "GetRecordingSearchResults";
        pub const response_name = "GetRecordingSearchResultsResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            SearchToken: []const u8 = "",
            MinResults: ?i32 = null,
            MaxResults: ?i32 = null,
            WaitTime: ?xsd.Duration = null,
            pub const xml_meta = .{
                .element_name = "GetRecordingSearchResults",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                    .MinResults = .{ .ns = Search.namespace_uri },
                    .MaxResults = .{ .ns = Search.namespace_uri },
                    .WaitTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            ResultList: schema.FindRecordingResultList = .{},
            pub const xml_meta = .{
                .element_name = "GetRecordingSearchResultsResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .ResultList = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const FindEvents = struct {
        pub const name = "FindEvents";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/FindEvents";
        pub const request_name = "FindEvents";
        pub const response_name = "FindEventsResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            StartPoint: xsd.DateTime = .{},
            EndPoint: ?xsd.DateTime = null,
            Scope: schema.SearchScope = .{},
            SearchFilter: schema.EventFilter = .{},
            IncludeStartState: bool = false,
            MaxMatches: ?i32 = null,
            KeepAliveTime: xsd.Duration = .{},
            pub const xml_meta = .{
                .element_name = "FindEvents",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .StartPoint = .{ .ns = Search.namespace_uri },
                    .EndPoint = .{ .ns = Search.namespace_uri },
                    .Scope = .{ .ns = Search.namespace_uri },
                    .SearchFilter = .{ .ns = Search.namespace_uri },
                    .IncludeStartState = .{ .ns = Search.namespace_uri },
                    .MaxMatches = .{ .ns = Search.namespace_uri },
                    .KeepAliveTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SearchToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "FindEventsResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const GetEventSearchResults = struct {
        pub const name = "GetEventSearchResults";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/GetEventSearchResults";
        pub const request_name = "GetEventSearchResults";
        pub const response_name = "GetEventSearchResultsResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            SearchToken: []const u8 = "",
            MinResults: ?i32 = null,
            MaxResults: ?i32 = null,
            WaitTime: ?xsd.Duration = null,
            pub const xml_meta = .{
                .element_name = "GetEventSearchResults",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                    .MinResults = .{ .ns = Search.namespace_uri },
                    .MaxResults = .{ .ns = Search.namespace_uri },
                    .WaitTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            ResultList: schema.FindEventResultList = .{},
            pub const xml_meta = .{
                .element_name = "GetEventSearchResultsResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .ResultList = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const FindPTZPosition = struct {
        pub const name = "FindPTZPosition";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/FindPTZPosition";
        pub const request_name = "FindPTZPosition";
        pub const response_name = "FindPTZPositionResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            StartPoint: xsd.DateTime = .{},
            EndPoint: ?xsd.DateTime = null,
            Scope: schema.SearchScope = .{},
            SearchFilter: schema.PTZPositionFilter = .{},
            MaxMatches: ?i32 = null,
            KeepAliveTime: xsd.Duration = .{},
            pub const xml_meta = .{
                .element_name = "FindPTZPosition",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .StartPoint = .{ .ns = Search.namespace_uri },
                    .EndPoint = .{ .ns = Search.namespace_uri },
                    .Scope = .{ .ns = Search.namespace_uri },
                    .SearchFilter = .{ .ns = Search.namespace_uri },
                    .MaxMatches = .{ .ns = Search.namespace_uri },
                    .KeepAliveTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SearchToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "FindPTZPositionResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const GetPTZPositionSearchResults = struct {
        pub const name = "GetPTZPositionSearchResults";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/GetPTZPositionSearchResults";
        pub const request_name = "GetPTZPositionSearchResults";
        pub const response_name = "GetPTZPositionSearchResultsResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            SearchToken: []const u8 = "",
            MinResults: ?i32 = null,
            MaxResults: ?i32 = null,
            WaitTime: ?xsd.Duration = null,
            pub const xml_meta = .{
                .element_name = "GetPTZPositionSearchResults",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                    .MinResults = .{ .ns = Search.namespace_uri },
                    .MaxResults = .{ .ns = Search.namespace_uri },
                    .WaitTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            ResultList: schema.FindPTZPositionResultList = .{},
            pub const xml_meta = .{
                .element_name = "GetPTZPositionSearchResultsResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .ResultList = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const GetSearchState = struct {
        pub const name = "GetSearchState";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/GetSearchState";
        pub const request_name = "GetSearchState";
        pub const response_name = "GetSearchStateResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            SearchToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetSearchState",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            State: schema.SearchState = .Queued,
            pub const xml_meta = .{
                .element_name = "GetSearchStateResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .State = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const EndSearch = struct {
        pub const name = "EndSearch";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/EndSearch";
        pub const request_name = "EndSearch";
        pub const response_name = "EndSearchResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            SearchToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "EndSearch",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Endpoint: xsd.DateTime = .{},
            pub const xml_meta = .{
                .element_name = "EndSearchResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .Endpoint = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const FindMetadata = struct {
        pub const name = "FindMetadata";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/FindMetadata";
        pub const request_name = "FindMetadata";
        pub const response_name = "FindMetadataResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            StartPoint: xsd.DateTime = .{},
            EndPoint: ?xsd.DateTime = null,
            Scope: schema.SearchScope = .{},
            MetadataFilter: schema.MetadataFilter = .{},
            MaxMatches: ?i32 = null,
            KeepAliveTime: xsd.Duration = .{},
            pub const xml_meta = .{
                .element_name = "FindMetadata",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .StartPoint = .{ .ns = Search.namespace_uri },
                    .EndPoint = .{ .ns = Search.namespace_uri },
                    .Scope = .{ .ns = Search.namespace_uri },
                    .MetadataFilter = .{ .ns = Search.namespace_uri },
                    .MaxMatches = .{ .ns = Search.namespace_uri },
                    .KeepAliveTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SearchToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "FindMetadataResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const GetMetadataSearchResults = struct {
        pub const name = "GetMetadataSearchResults";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/GetMetadataSearchResults";
        pub const request_name = "GetMetadataSearchResults";
        pub const response_name = "GetMetadataSearchResultsResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            SearchToken: []const u8 = "",
            MinResults: ?i32 = null,
            MaxResults: ?i32 = null,
            WaitTime: ?xsd.Duration = null,
            pub const xml_meta = .{
                .element_name = "GetMetadataSearchResults",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                    .MinResults = .{ .ns = Search.namespace_uri },
                    .MaxResults = .{ .ns = Search.namespace_uri },
                    .WaitTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            ResultList: schema.FindMetadataResultList = .{},
            pub const xml_meta = .{
                .element_name = "GetMetadataSearchResultsResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .ResultList = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const SearchImageByNL = struct {
        pub const name = "SearchImageByNL";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/SearchImageByNL";
        pub const request_name = "SearchImageByNLRequest";
        pub const response_name = "SearchImageByNLResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            StartPoint: xsd.DateTime = .{},
            EndPoint: ?xsd.DateTime = null,
            RecordingToken: ?[]const u8 = null,
            Text: []const u8 = "",
            Similarity: ?f32 = null,
            MaxMatches: ?i32 = null,
            KeepAliveTime: xsd.Duration = .{},
            pub const xml_meta = .{
                .element_name = "SearchImageByNLRequest",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .StartPoint = .{ .ns = Search.namespace_uri },
                    .EndPoint = .{ .ns = Search.namespace_uri },
                    .RecordingToken = .{ .ns = Search.namespace_uri },
                    .Text = .{ .ns = Search.namespace_uri },
                    .Similarity = .{ .ns = Search.namespace_uri },
                    .MaxMatches = .{ .ns = Search.namespace_uri },
                    .KeepAliveTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SearchToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SearchImageByNLResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const GetNLSearchResults = struct {
        pub const name = "GetNLSearchResults";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/GetNLSearchResults";
        pub const request_name = "GetNLSearchResultsRequest";
        pub const response_name = "GetNLSearchResultsResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            SearchToken: []const u8 = "",
            MinResults: ?i32 = null,
            MaxResults: ?i32 = null,
            WaitTime: ?xsd.Duration = null,
            pub const xml_meta = .{
                .element_name = "GetNLSearchResultsRequest",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                    .MinResults = .{ .ns = Search.namespace_uri },
                    .MaxResults = .{ .ns = Search.namespace_uri },
                    .WaitTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            ResultList: schema.FindNLSearchResultList = .{},
            pub const xml_meta = .{
                .element_name = "GetNLSearchResultsResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .ResultList = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const SearchImageByImage = struct {
        pub const name = "SearchImageByImage";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/SearchImageByImage";
        pub const request_name = "SearchImageByImageRequest";
        pub const response_name = "SearchImageByImageResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            StartPoint: xsd.DateTime = .{},
            EndPoint: ?xsd.DateTime = null,
            RecordingToken: ?[]const u8 = null,
            TargetImageURI: ?[]const u8 = null,
            TargetImageData: ?[]const u8 = null,
            MaxMatches: ?i32 = null,
            KeepAliveTime: xsd.Duration = .{},
            pub const xml_meta = .{
                .element_name = "SearchImageByImageRequest",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .StartPoint = .{ .ns = Search.namespace_uri },
                    .EndPoint = .{ .ns = Search.namespace_uri },
                    .RecordingToken = .{ .ns = Search.namespace_uri },
                    .TargetImageURI = .{ .ns = Search.namespace_uri },
                    .TargetImageData = .{ .ns = Search.namespace_uri },
                    .MaxMatches = .{ .ns = Search.namespace_uri },
                    .KeepAliveTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SearchToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SearchImageByImageResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

    pub const GetImageSearchResults = struct {
        pub const name = "GetImageSearchResults";
        pub const soap_action = "http://www.onvif.org/ver10/search/wsdl/GetImageSearchResults";
        pub const request_name = "GetImageSearchResultsRequest";
        pub const response_name = "GetImageSearchResultsResponse";
        pub const namespace = Search.namespace_uri;
        pub const namespace_uri = Search.namespace_uri;

        pub const Request = struct {
            SearchToken: []const u8 = "",
            MinResults: ?i32 = null,
            MaxResults: ?i32 = null,
            WaitTime: ?xsd.Duration = null,
            pub const xml_meta = .{
                .element_name = "GetImageSearchResultsRequest",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .SearchToken = .{ .ns = Search.namespace_uri },
                    .MinResults = .{ .ns = Search.namespace_uri },
                    .MaxResults = .{ .ns = Search.namespace_uri },
                    .WaitTime = .{ .ns = Search.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            ResultList: schema.FindObjectImageResultList = .{},
            pub const xml_meta = .{
                .element_name = "GetImageSearchResultsResponse",
                .namespace = Search.namespace_uri,
                .namespace_uri = Search.namespace_uri,
                .fields = .{
                    .ResultList = .{ .ns = Search.namespace_uri },
                },
            };
        };

    };

};
