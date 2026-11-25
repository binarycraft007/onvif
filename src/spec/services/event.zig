//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const Event = struct {
    pub const namespace = "http://www.onvif.org/ver10/events/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver10/events/wsdl";

    pub const EventBrokerProtocol = enum {
        mqtt,
        mqtts,
        ws,
        wss,
    };

    pub const ConnectionStatus = enum {
        Offline,
        Connecting,
        Connected,
    };

    pub const Capabilities = struct {
        WSSubscriptionPolicySupport: ?bool = null,
        WSPausableSubscriptionManagerInterfaceSupport: ?bool = null,
        MaxNotificationProducers: ?i32 = null,
        MaxPullPoints: ?i32 = null,
        PersistentNotificationStorage: ?bool = null,
        EventBrokerProtocols: ?[]const u8 = null,
        MaxEventBrokers: ?i32 = null,
        MetadataOverMQTT: ?bool = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Capabilities",
            .namespace = Event.namespace_uri,
            .namespace_uri = Event.namespace_uri,
            .attributes = &.{"WSSubscriptionPolicySupport", "WSPausableSubscriptionManagerInterfaceSupport", "MaxNotificationProducers", "MaxPullPoints", "PersistentNotificationStorage", "EventBrokerProtocols", "MaxEventBrokers", "MetadataOverMQTT"},
        };
    };

    pub const EventBrokerConfig = struct {
        Address: []const u8 = "",
        TopicPrefix: []const u8 = "",
        UserName: ?[]const u8 = null,
        Password: ?[]const u8 = null,
        CertificateID: ?[]const u8 = null,
        PublishFilter: ?xml_any.Any = null,
        QoS: ?i32 = null,
        Status: ?[]const u8 = null,
        CertPathValidationPolicyID: ?[]const u8 = null,
        MetadataFilter: ?xml_any.Any = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "EventBrokerConfig",
            .namespace = Event.namespace_uri,
            .namespace_uri = Event.namespace_uri,
            .fields = .{
                .Address = .{ .ns = Event.namespace_uri },
                .TopicPrefix = .{ .ns = Event.namespace_uri },
                .UserName = .{ .ns = Event.namespace_uri },
                .Password = .{ .ns = Event.namespace_uri },
                .CertificateID = .{ .ns = Event.namespace_uri },
                .PublishFilter = .{ .ns = Event.namespace_uri },
                .QoS = .{ .ns = Event.namespace_uri },
                .Status = .{ .ns = Event.namespace_uri },
                .CertPathValidationPolicyID = .{ .ns = Event.namespace_uri },
                .MetadataFilter = .{ .ns = Event.namespace_uri },
            },
        };
    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver10/events/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = Event.namespace_uri;
        pub const namespace_uri = Event.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Event.namespace_uri },
                },
            };
        };

    };

    pub const CreatePullPointSubscription = struct {
        pub const name = "CreatePullPointSubscription";
        pub const soap_action = "http://www.onvif.org/ver10/events/wsdl/CreatePullPointSubscription";
        pub const request_name = "CreatePullPointSubscription";
        pub const response_name = "CreatePullPointSubscriptionResponse";
        pub const namespace = Event.namespace_uri;
        pub const namespace_uri = Event.namespace_uri;

        pub const Request = struct {
            pub const Inline_SubscriptionPolicy = struct {
                any: []const xml_any.Any = &.{},
                pub const xml_meta = .{
                    .element_name = "SubscriptionPolicy",
                    .namespace = Event.namespace_uri,
                    .namespace_uri = Event.namespace_uri,
                };
            };

            Filter: ?xml_any.Any = null,
            InitialTerminationTime: ?[]const u8 = null,
            SubscriptionPolicy: ?Inline_SubscriptionPolicy = null,
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "CreatePullPointSubscription",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
                .fields = .{
                    .Filter = .{ .ns = Event.namespace_uri },
                    .InitialTerminationTime = .{ .ns = Event.namespace_uri },
                    .SubscriptionPolicy = .{ .ns = Event.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SubscriptionReference: []const u8 = "",
            CurrentTime: xml_any.Any = .{},
            TerminationTime: xml_any.Any = .{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "CreatePullPointSubscriptionResponse",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
                .fields = .{
                    .SubscriptionReference = .{ .ns = Event.namespace_uri },
                    .CurrentTime = .{ .ns = "http://docs.oasis-open.org/wsn/b-2" },
                    .TerminationTime = .{ .ns = "http://docs.oasis-open.org/wsn/b-2" },
                },
            };
        };

    };

    pub const GetEventProperties = struct {
        pub const name = "GetEventProperties";
        pub const soap_action = "http://www.onvif.org/ver10/events/wsdl/GetEventProperties";
        pub const request_name = "GetEventProperties";
        pub const response_name = "GetEventPropertiesResponse";
        pub const namespace = Event.namespace_uri;
        pub const namespace_uri = Event.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetEventProperties",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
            };
        };

        pub const Response = struct {
            TopicNamespaceLocation: []const []const u8 = &.{},
            FixedTopicSet: xml_any.Any = .{},
            TopicSet: xml_any.Any = .{},
            TopicExpressionDialect: []const xml_any.Any = &.{},
            MessageContentFilterDialect: []const []const u8 = &.{},
            ProducerPropertiesFilterDialect: []const []const u8 = &.{},
            MessageContentSchemaLocation: []const []const u8 = &.{},
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetEventPropertiesResponse",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
                .fields = .{
                    .TopicNamespaceLocation = .{ .ns = Event.namespace_uri },
                    .FixedTopicSet = .{ .ns = "http://docs.oasis-open.org/wsn/b-2" },
                    .TopicSet = .{ .ns = "http://docs.oasis-open.org/wsn/t-1" },
                    .TopicExpressionDialect = .{ .ns = "http://docs.oasis-open.org/wsn/b-2" },
                    .MessageContentFilterDialect = .{ .ns = Event.namespace_uri },
                    .ProducerPropertiesFilterDialect = .{ .ns = Event.namespace_uri },
                    .MessageContentSchemaLocation = .{ .ns = Event.namespace_uri },
                },
            };
        };

    };

    pub const AddEventBroker = struct {
        pub const name = "AddEventBroker";
        pub const soap_action = "http://www.onvif.org/ver10/events/wsdl/AddEventBroker";
        pub const request_name = "AddEventBroker";
        pub const response_name = "AddEventBrokerResponse";
        pub const namespace = Event.namespace_uri;
        pub const namespace_uri = Event.namespace_uri;

        pub const Request = struct {
            EventBroker: EventBrokerConfig = .{},
            pub const xml_meta = .{
                .element_name = "AddEventBroker",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
                .fields = .{
                    .EventBroker = .{ .ns = Event.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddEventBrokerResponse",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
            };
        };

    };

    pub const DeleteEventBroker = struct {
        pub const name = "DeleteEventBroker";
        pub const soap_action = "http://www.onvif.org/ver10/events/wsdl/DeleteEventBroker";
        pub const request_name = "DeleteEventBroker";
        pub const response_name = "DeleteEventBrokerResponse";
        pub const namespace = Event.namespace_uri;
        pub const namespace_uri = Event.namespace_uri;

        pub const Request = struct {
            Address: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteEventBroker",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
                .fields = .{
                    .Address = .{ .ns = Event.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteEventBrokerResponse",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
            };
        };

    };

    pub const GetEventBrokers = struct {
        pub const name = "GetEventBrokers";
        pub const soap_action = "http://www.onvif.org/ver10/events/wsdl/GetEventBrokers";
        pub const request_name = "GetEventBrokers";
        pub const response_name = "GetEventBrokersResponse";
        pub const namespace = Event.namespace_uri;
        pub const namespace_uri = Event.namespace_uri;

        pub const Request = struct {
            Address: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetEventBrokers",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
                .fields = .{
                    .Address = .{ .ns = Event.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            EventBroker: []const EventBrokerConfig = &.{},
            pub const xml_meta = .{
                .element_name = "GetEventBrokersResponse",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
                .fields = .{
                    .EventBroker = .{ .ns = Event.namespace_uri },
                },
            };
        };

    };

    pub const PullMessages = struct {
        pub const name = "PullMessages";
        pub const soap_action = "http://www.onvif.org/ver10/events/wsdl/PullMessages";
        pub const request_name = "PullMessages";
        pub const response_name = "PullMessagesResponse";
        pub const namespace = Event.namespace_uri;
        pub const namespace_uri = Event.namespace_uri;

        pub const Request = struct {
            Timeout: xsd.Duration = .{},
            MessageLimit: i32 = 0,
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "PullMessages",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
                .fields = .{
                    .Timeout = .{ .ns = Event.namespace_uri },
                    .MessageLimit = .{ .ns = Event.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            CurrentTime: xsd.DateTime = .{},
            TerminationTime: xsd.DateTime = .{},
            NotificationMessage: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "PullMessagesResponse",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
                .fields = .{
                    .CurrentTime = .{ .ns = Event.namespace_uri },
                    .TerminationTime = .{ .ns = Event.namespace_uri },
                    .NotificationMessage = .{ .ns = "http://docs.oasis-open.org/wsn/b-2" },
                },
            };
        };

    };

    pub const Seek = struct {
        pub const name = "Seek";
        pub const soap_action = "http://www.onvif.org/ver10/events/wsdl/Seek";
        pub const request_name = "Seek";
        pub const response_name = "SeekResponse";
        pub const namespace = Event.namespace_uri;
        pub const namespace_uri = Event.namespace_uri;

        pub const Request = struct {
            UtcTime: xsd.DateTime = .{},
            Reverse: ?bool = null,
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "Seek",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
                .fields = .{
                    .UtcTime = .{ .ns = Event.namespace_uri },
                    .Reverse = .{ .ns = Event.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SeekResponse",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
            };
        };

    };

    pub const SetSynchronizationPoint = struct {
        pub const name = "SetSynchronizationPoint";
        pub const soap_action = "http://www.onvif.org/ver10/events/wsdl/SetSynchronizationPoint";
        pub const request_name = "SetSynchronizationPoint";
        pub const response_name = "SetSynchronizationPointResponse";
        pub const namespace = Event.namespace_uri;
        pub const namespace_uri = Event.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "SetSynchronizationPoint",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetSynchronizationPointResponse",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
            };
        };

    };

    pub const Unsubscribe = struct {
        pub const name = "Unsubscribe";
        pub const soap_action = "http://www.onvif.org/ver10/events/wsdl/Unsubscribe";
        pub const request_name = "Unsubscribe";
        pub const response_name = "UnsubscribeResponse";
        pub const namespace = Event.namespace_uri;
        pub const namespace_uri = Event.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "Unsubscribe",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "UnsubscribeResponse",
                .namespace = Event.namespace_uri,
                .namespace_uri = Event.namespace_uri,
            };
        };

    };

};
