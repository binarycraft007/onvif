//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const Receiver = struct {
    pub const namespace = "http://www.onvif.org/ver10/receiver/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver10/receiver/wsdl";

    pub const Capabilities = struct {
        RTP_Multicast: ?bool = null,
        RTP_TCP: ?bool = null,
        RTP_RTSP_TCP: ?bool = null,
        SupportedReceivers: i32 = 0,
        MaximumRTSPURILength: ?i32 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Capabilities",
            .namespace = Receiver.namespace_uri,
            .namespace_uri = Receiver.namespace_uri,
            .attributes = &.{"RTP_Multicast", "RTP_TCP", "RTP_RTSP_TCP", "SupportedReceivers", "MaximumRTSPURILength"},
        };
    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver10/receiver/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = Receiver.namespace_uri;
        pub const namespace_uri = Receiver.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Receiver.namespace_uri },
                },
            };
        };

    };

    pub const GetReceivers = struct {
        pub const name = "GetReceivers";
        pub const soap_action = "http://www.onvif.org/ver10/receiver/wsdl/GetReceivers";
        pub const request_name = "GetReceivers";
        pub const response_name = "GetReceiversResponse";
        pub const namespace = Receiver.namespace_uri;
        pub const namespace_uri = Receiver.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetReceivers",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
            };
        };

        pub const Response = struct {
            Receivers: []const schema.Receiver = &.{},
            pub const xml_meta = .{
                .element_name = "GetReceiversResponse",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
                .fields = .{
                    .Receivers = .{ .ns = Receiver.namespace_uri },
                },
            };
        };

    };

    pub const GetReceiver = struct {
        pub const name = "GetReceiver";
        pub const soap_action = "http://www.onvif.org/ver10/receiver/wsdl/GetReceiver";
        pub const request_name = "GetReceiver";
        pub const response_name = "GetReceiverResponse";
        pub const namespace = Receiver.namespace_uri;
        pub const namespace_uri = Receiver.namespace_uri;

        pub const Request = struct {
            ReceiverToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetReceiver",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
                .fields = .{
                    .ReceiverToken = .{ .ns = Receiver.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Receiver: schema.Receiver = .{},
            pub const xml_meta = .{
                .element_name = "GetReceiverResponse",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
                .fields = .{
                    .Receiver = .{ .ns = Receiver.namespace_uri },
                },
            };
        };

    };

    pub const CreateReceiver = struct {
        pub const name = "CreateReceiver";
        pub const soap_action = "http://www.onvif.org/ver10/receiver/wsdl/CreateReceiver";
        pub const request_name = "CreateReceiver";
        pub const response_name = "CreateReceiverResponse";
        pub const namespace = Receiver.namespace_uri;
        pub const namespace_uri = Receiver.namespace_uri;

        pub const Request = struct {
            Configuration: schema.ReceiverConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "CreateReceiver",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
                .fields = .{
                    .Configuration = .{ .ns = Receiver.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Receiver: schema.Receiver = .{},
            pub const xml_meta = .{
                .element_name = "CreateReceiverResponse",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
                .fields = .{
                    .Receiver = .{ .ns = Receiver.namespace_uri },
                },
            };
        };

    };

    pub const DeleteReceiver = struct {
        pub const name = "DeleteReceiver";
        pub const soap_action = "http://www.onvif.org/ver10/receiver/wsdl/DeleteReceiver";
        pub const request_name = "DeleteReceiver";
        pub const response_name = "DeleteReceiverResponse";
        pub const namespace = Receiver.namespace_uri;
        pub const namespace_uri = Receiver.namespace_uri;

        pub const Request = struct {
            ReceiverToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteReceiver",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
                .fields = .{
                    .ReceiverToken = .{ .ns = Receiver.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteReceiverResponse",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
            };
        };

    };

    pub const ConfigureReceiver = struct {
        pub const name = "ConfigureReceiver";
        pub const soap_action = "http://www.onvif.org/ver10/receiver/wsdl/ConfigureReceiver";
        pub const request_name = "ConfigureReceiver";
        pub const response_name = "ConfigureReceiverResponse";
        pub const namespace = Receiver.namespace_uri;
        pub const namespace_uri = Receiver.namespace_uri;

        pub const Request = struct {
            ReceiverToken: []const u8 = "",
            Configuration: schema.ReceiverConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "ConfigureReceiver",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
                .fields = .{
                    .ReceiverToken = .{ .ns = Receiver.namespace_uri },
                    .Configuration = .{ .ns = Receiver.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "ConfigureReceiverResponse",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
            };
        };

    };

    pub const SetReceiverMode = struct {
        pub const name = "SetReceiverMode";
        pub const soap_action = "http://www.onvif.org/ver10/receiver/wsdl/SetReceiverMode";
        pub const request_name = "SetReceiverMode";
        pub const response_name = "SetReceiverModeResponse";
        pub const namespace = Receiver.namespace_uri;
        pub const namespace_uri = Receiver.namespace_uri;

        pub const Request = struct {
            ReceiverToken: []const u8 = "",
            Mode: schema.ReceiverMode = .AutoConnect,
            pub const xml_meta = .{
                .element_name = "SetReceiverMode",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
                .fields = .{
                    .ReceiverToken = .{ .ns = Receiver.namespace_uri },
                    .Mode = .{ .ns = Receiver.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetReceiverModeResponse",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
            };
        };

    };

    pub const GetReceiverState = struct {
        pub const name = "GetReceiverState";
        pub const soap_action = "http://www.onvif.org/ver10/receiver/wsdl/GetReceiverState";
        pub const request_name = "GetReceiverState";
        pub const response_name = "GetReceiverStateResponse";
        pub const namespace = Receiver.namespace_uri;
        pub const namespace_uri = Receiver.namespace_uri;

        pub const Request = struct {
            ReceiverToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetReceiverState",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
                .fields = .{
                    .ReceiverToken = .{ .ns = Receiver.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            ReceiverState: schema.ReceiverStateInformation = .{},
            pub const xml_meta = .{
                .element_name = "GetReceiverStateResponse",
                .namespace = Receiver.namespace_uri,
                .namespace_uri = Receiver.namespace_uri,
                .fields = .{
                    .ReceiverState = .{ .ns = Receiver.namespace_uri },
                },
            };
        };

    };

};
