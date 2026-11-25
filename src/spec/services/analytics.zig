//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const Analytics = struct {
    pub const namespace = "http://www.onvif.org/ver20/analytics/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver20/analytics/wsdl";

    pub const Capabilities = struct {
        RuleSupport: ?bool = null,
        AnalyticsModuleSupport: ?bool = null,
        CellBasedSceneDescriptionSupported: ?bool = null,
        RuleOptionsSupported: ?bool = null,
        AnalyticsModuleOptionsSupported: ?bool = null,
        SupportedMetadata: ?bool = null,
        ImageSendingType: ?[]const u8 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Capabilities",
            .namespace = Analytics.namespace_uri,
            .namespace_uri = Analytics.namespace_uri,
            .attributes = &.{"RuleSupport", "AnalyticsModuleSupport", "CellBasedSceneDescriptionSupported", "RuleOptionsSupported", "AnalyticsModuleOptionsSupported", "SupportedMetadata", "ImageSendingType"},
        };
    };

    pub const ConfigOptions = struct {
        RuleType: ?[]const u8 = null,
        Name: []const u8 = "",
        Type: ?[]const u8 = null,
        AnalyticsModule: ?[]const u8 = null,
        minOccurs: ?i32 = null,
        maxOccurs: ?i32 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "ConfigOptions",
            .namespace = Analytics.namespace_uri,
            .namespace_uri = Analytics.namespace_uri,
            .attributes = &.{"RuleType", "Name", "Type", "AnalyticsModule", "minOccurs", "maxOccurs"},
        };
    };

    pub const MetadataInfo = struct {
        Type: []const u8 = "",
        SampleFrame: schema.Frame = .{},
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "MetadataInfo",
            .namespace = Analytics.namespace_uri,
            .namespace_uri = Analytics.namespace_uri,
            .attributes = &.{"Type"},
            .fields = .{
                .SampleFrame = .{ .ns = Analytics.namespace_uri },
            },
        };
    };

    pub const GetSupportedRules = struct {
        pub const name = "GetSupportedRules";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/GetSupportedRules";
        pub const request_name = "GetSupportedRules";
        pub const response_name = "GetSupportedRulesResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetSupportedRules",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SupportedRules: schema.SupportedRules = .{},
            pub const xml_meta = .{
                .element_name = "GetSupportedRulesResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .SupportedRules = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

    };

    pub const CreateRules = struct {
        pub const name = "CreateRules";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/CreateRules";
        pub const request_name = "CreateRules";
        pub const response_name = "CreateRulesResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            Rule: []const schema.Config = &.{},
            pub const xml_meta = .{
                .element_name = "CreateRules",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                    .Rule = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "CreateRulesResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
            };
        };

    };

    pub const DeleteRules = struct {
        pub const name = "DeleteRules";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/DeleteRules";
        pub const request_name = "DeleteRules";
        pub const response_name = "DeleteRulesResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            RuleName: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "DeleteRules",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                    .RuleName = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteRulesResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
            };
        };

    };

    pub const GetRules = struct {
        pub const name = "GetRules";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/GetRules";
        pub const request_name = "GetRules";
        pub const response_name = "GetRulesResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetRules",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Rule: []const schema.Config = &.{},
            pub const xml_meta = .{
                .element_name = "GetRulesResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .Rule = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

    };

    pub const GetRuleOptions = struct {
        pub const name = "GetRuleOptions";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/GetRuleOptions";
        pub const request_name = "GetRuleOptions";
        pub const response_name = "GetRuleOptionsResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            RuleType: ?[]const u8 = null,
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetRuleOptions",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .RuleType = .{ .ns = Analytics.namespace_uri },
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            RuleOptions: []const ConfigOptions = &.{},
            pub const xml_meta = .{
                .element_name = "GetRuleOptionsResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .RuleOptions = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

    };

    pub const ModifyRules = struct {
        pub const name = "ModifyRules";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/ModifyRules";
        pub const request_name = "ModifyRules";
        pub const response_name = "ModifyRulesResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            Rule: []const schema.Config = &.{},
            pub const xml_meta = .{
                .element_name = "ModifyRules",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                    .Rule = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "ModifyRulesResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
            };
        };

    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

    };

    pub const GetSupportedAnalyticsModules = struct {
        pub const name = "GetSupportedAnalyticsModules";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/GetSupportedAnalyticsModules";
        pub const request_name = "GetSupportedAnalyticsModules";
        pub const response_name = "GetSupportedAnalyticsModulesResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetSupportedAnalyticsModules",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SupportedAnalyticsModules: schema.SupportedAnalyticsModules = .{},
            pub const xml_meta = .{
                .element_name = "GetSupportedAnalyticsModulesResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .SupportedAnalyticsModules = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

    };

    pub const GetAnalyticsModuleOptions = struct {
        pub const name = "GetAnalyticsModuleOptions";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/GetAnalyticsModuleOptions";
        pub const request_name = "GetAnalyticsModuleOptions";
        pub const response_name = "GetAnalyticsModuleOptionsResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            Type: ?[]const u8 = null,
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetAnalyticsModuleOptions",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .Type = .{ .ns = Analytics.namespace_uri },
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Options: []const ConfigOptions = &.{},
            pub const xml_meta = .{
                .element_name = "GetAnalyticsModuleOptionsResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .Options = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

    };

    pub const CreateAnalyticsModules = struct {
        pub const name = "CreateAnalyticsModules";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/CreateAnalyticsModules";
        pub const request_name = "CreateAnalyticsModules";
        pub const response_name = "CreateAnalyticsModulesResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            AnalyticsModule: []const schema.Config = &.{},
            pub const xml_meta = .{
                .element_name = "CreateAnalyticsModules",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                    .AnalyticsModule = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "CreateAnalyticsModulesResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
            };
        };

    };

    pub const DeleteAnalyticsModules = struct {
        pub const name = "DeleteAnalyticsModules";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/DeleteAnalyticsModules";
        pub const request_name = "DeleteAnalyticsModules";
        pub const response_name = "DeleteAnalyticsModulesResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            AnalyticsModuleName: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "DeleteAnalyticsModules",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                    .AnalyticsModuleName = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteAnalyticsModulesResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
            };
        };

    };

    pub const GetAnalyticsModules = struct {
        pub const name = "GetAnalyticsModules";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/GetAnalyticsModules";
        pub const request_name = "GetAnalyticsModules";
        pub const response_name = "GetAnalyticsModulesResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetAnalyticsModules",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            AnalyticsModule: []const schema.Config = &.{},
            pub const xml_meta = .{
                .element_name = "GetAnalyticsModulesResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .AnalyticsModule = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

    };

    pub const ModifyAnalyticsModules = struct {
        pub const name = "ModifyAnalyticsModules";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/ModifyAnalyticsModules";
        pub const request_name = "ModifyAnalyticsModules";
        pub const response_name = "ModifyAnalyticsModulesResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            ConfigurationToken: []const u8 = "",
            AnalyticsModule: []const schema.Config = &.{},
            pub const xml_meta = .{
                .element_name = "ModifyAnalyticsModules",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .ConfigurationToken = .{ .ns = Analytics.namespace_uri },
                    .AnalyticsModule = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "ModifyAnalyticsModulesResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
            };
        };

    };

    pub const GetSupportedMetadata = struct {
        pub const name = "GetSupportedMetadata";
        pub const soap_action = "http://www.onvif.org/ver20/analytics/wsdl/GetSupportedMetadata";
        pub const request_name = "GetSupportedMetadata";
        pub const response_name = "GetSupportedMetadataResponse";
        pub const namespace = Analytics.namespace_uri;
        pub const namespace_uri = Analytics.namespace_uri;

        pub const Request = struct {
            Type: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetSupportedMetadata",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .Type = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            AnalyticsModule: []const MetadataInfo = &.{},
            pub const xml_meta = .{
                .element_name = "GetSupportedMetadataResponse",
                .namespace = Analytics.namespace_uri,
                .namespace_uri = Analytics.namespace_uri,
                .fields = .{
                    .AnalyticsModule = .{ .ns = Analytics.namespace_uri },
                },
            };
        };

    };

};
