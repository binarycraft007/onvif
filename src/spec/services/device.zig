//! ONVIF Generated Service Operations
const std = @import("std");
const xsd = @import("../../xsd_types.zig");
const xml_any = @import("../../xml/Any.zig");
const schema = @import("../schema.zig");

pub const Device = struct {
    pub const namespace = "http://www.onvif.org/ver10/device/wsdl";
    pub const namespace_uri = "http://www.onvif.org/ver10/device/wsdl";

    pub const AutoGeoModes = enum {
        Location,
        Heading,
        Leveling,
    };

    pub const HardwareTypes = enum {
        Camera,
        MultiSensorCamera,
        Encoder,
        Intercom,
        AccessControl,
        Speaker,
        Recorder,
        Microphone,
        Display,
        @"IO-Device",
    };

    pub const StorageType = enum {
        NFS,
        CIFS,
        CDMI,
        FTP,
        ObjectStorageS3,
        ObjectStorageAzure,
    };

    pub const Service = struct {
        pub const Inline_Capabilities = struct {
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "Capabilities",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        Namespace: []const u8 = "",
        XAddr: []const u8 = "",
        Capabilities: ?Inline_Capabilities = null,
        Version: schema.OnvifVersion = .{},
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Service",
            .namespace = Device.namespace_uri,
            .namespace_uri = Device.namespace_uri,
            .fields = .{
                .Namespace = .{ .ns = Device.namespace_uri },
                .XAddr = .{ .ns = Device.namespace_uri },
                .Capabilities = .{ .ns = Device.namespace_uri },
                .Version = .{ .ns = Device.namespace_uri },
            },
        };
    };

    pub const DeviceServiceCapabilities = struct {
        Network: NetworkCapabilities = .{},
        Security: SecurityCapabilities = .{},
        System: SystemCapabilities = .{},
        Misc: ?MiscCapabilities = null,
        pub const xml_meta = .{
            .element_name = "DeviceServiceCapabilities",
            .namespace = Device.namespace_uri,
            .namespace_uri = Device.namespace_uri,
            .fields = .{
                .Network = .{ .ns = Device.namespace_uri },
                .Security = .{ .ns = Device.namespace_uri },
                .System = .{ .ns = Device.namespace_uri },
                .Misc = .{ .ns = Device.namespace_uri },
            },
        };
    };

    pub const NetworkCapabilities = struct {
        IPFilter: ?bool = null,
        ZeroConfiguration: ?bool = null,
        IPVersion6: ?bool = null,
        DynDNS: ?bool = null,
        Dot11Configuration: ?bool = null,
        Dot1XConfigurations: ?i32 = null,
        HostnameFromDHCP: ?bool = null,
        NTP: ?i32 = null,
        DHCPv6: ?bool = null,
        pub const xml_meta = .{
            .element_name = "NetworkCapabilities",
            .namespace = Device.namespace_uri,
            .namespace_uri = Device.namespace_uri,
            .attributes = &.{"IPFilter", "ZeroConfiguration", "IPVersion6", "DynDNS", "Dot11Configuration", "Dot1XConfigurations", "HostnameFromDHCP", "NTP", "DHCPv6"},
        };
    };

    pub const SecurityCapabilities = struct {
        @"TLS1.0": ?bool = null,
        @"TLS1.1": ?bool = null,
        @"TLS1.2": ?bool = null,
        OnboardKeyGeneration: ?bool = null,
        AccessPolicyConfig: ?bool = null,
        DefaultAccessPolicy: ?bool = null,
        Dot1X: ?bool = null,
        RemoteUserHandling: ?bool = null,
        @"X.509Token": ?bool = null,
        SAMLToken: ?bool = null,
        KerberosToken: ?bool = null,
        UsernameToken: ?bool = null,
        HttpDigest: ?bool = null,
        RELToken: ?bool = null,
        JsonWebToken: ?bool = null,
        SupportedEAPMethods: ?[]const u8 = null,
        MaxUsers: ?i32 = null,
        MaxUserNameLength: ?i32 = null,
        MaxPasswordLength: ?i32 = null,
        SecurityPolicies: ?[]const u8 = null,
        MaxPasswordHistory: ?i32 = null,
        HashingAlgorithms: ?[]const u8 = null,
        MaxUserRoles: ?i32 = null,
        pub const xml_meta = .{
            .element_name = "SecurityCapabilities",
            .namespace = Device.namespace_uri,
            .namespace_uri = Device.namespace_uri,
            .attributes = &.{"TLS1.0", "TLS1.1", "TLS1.2", "OnboardKeyGeneration", "AccessPolicyConfig", "DefaultAccessPolicy", "Dot1X", "RemoteUserHandling", "X.509Token", "SAMLToken", "KerberosToken", "UsernameToken", "HttpDigest", "RELToken", "JsonWebToken", "SupportedEAPMethods", "MaxUsers", "MaxUserNameLength", "MaxPasswordLength", "SecurityPolicies", "MaxPasswordHistory", "HashingAlgorithms", "MaxUserRoles"},
        };
    };

    pub const SystemCapabilities = struct {
        DiscoveryResolve: ?bool = null,
        DiscoveryBye: ?bool = null,
        RemoteDiscovery: ?bool = null,
        SystemBackup: ?bool = null,
        SystemLogging: ?bool = null,
        CloudFirmwareUpgrade: ?bool = null,
        HttpFirmwareUpgrade: ?bool = null,
        HttpSystemBackup: ?bool = null,
        HttpSystemLogging: ?bool = null,
        HttpSupportInformation: ?bool = null,
        StorageConfiguration: ?bool = null,
        MaxStorageConfigurations: ?i32 = null,
        StorageConfigurationRenewal: ?bool = null,
        GeoLocationEntries: ?i32 = null,
        AutoGeo: ?[]const u8 = null,
        StorageTypesSupported: ?[]const u8 = null,
        DiscoveryNotSupported: ?bool = null,
        NetworkConfigNotSupported: ?bool = null,
        UserConfigNotSupported: ?bool = null,
        Addons: ?[]const u8 = null,
        HardwareType: ?[]const u8 = null,
        pub const xml_meta = .{
            .element_name = "SystemCapabilities",
            .namespace = Device.namespace_uri,
            .namespace_uri = Device.namespace_uri,
            .attributes = &.{"DiscoveryResolve", "DiscoveryBye", "RemoteDiscovery", "SystemBackup", "SystemLogging", "CloudFirmwareUpgrade", "HttpFirmwareUpgrade", "HttpSystemBackup", "HttpSystemLogging", "HttpSupportInformation", "StorageConfiguration", "MaxStorageConfigurations", "StorageConfigurationRenewal", "GeoLocationEntries", "AutoGeo", "StorageTypesSupported", "DiscoveryNotSupported", "NetworkConfigNotSupported", "UserConfigNotSupported", "Addons", "HardwareType"},
        };
    };

    pub const MiscCapabilities = struct {
        AuxiliaryCommands: ?[]const u8 = null,
        pub const xml_meta = .{
            .element_name = "MiscCapabilities",
            .namespace = Device.namespace_uri,
            .namespace_uri = Device.namespace_uri,
            .attributes = &.{"AuxiliaryCommands"},
        };
    };

    pub const UserCredential = struct {
        pub const Inline_Extension = struct {
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "Extension",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        UserName: []const u8 = "",
        Password: ?[]const u8 = null,
        Extension: ?Inline_Extension = null,
        Token: ?[]const u8 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "UserCredential",
            .namespace = Device.namespace_uri,
            .namespace_uri = Device.namespace_uri,
            .fields = .{
                .UserName = .{ .ns = Device.namespace_uri },
                .Password = .{ .ns = Device.namespace_uri },
                .Extension = .{ .ns = Device.namespace_uri },
                .Token = .{ .ns = Device.namespace_uri },
            },
        };
    };

    pub const StorageConfigurationData = struct {
        pub const Inline_Extension = struct {
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "Extension",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Inline_ConfigurationRenewal = struct {
            RenewalEndpoint: []const u8 = "",
            AuthorizationServer: []const u8 = "",
            CertPathValidationPolicyID: ?[]const u8 = null,
            Error: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "ConfigurationRenewal",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .RenewalEndpoint = .{ .ns = Device.namespace_uri },
                    .AuthorizationServer = .{ .ns = Device.namespace_uri },
                    .CertPathValidationPolicyID = .{ .ns = Device.namespace_uri },
                    .Error = .{ .ns = Device.namespace_uri },
                },
            };
        };

        @"type": []const u8 = "",
        Region: ?[]const u8 = null,
        LocalPath: ?[]const u8 = null,
        StorageUri: ?[]const u8 = null,
        User: ?UserCredential = null,
        Extension: ?Inline_Extension = null,
        CertPathValidationPolicyID: ?[]const u8 = null,
        ConfigurationRenewal: ?Inline_ConfigurationRenewal = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "StorageConfigurationData",
            .namespace = Device.namespace_uri,
            .namespace_uri = Device.namespace_uri,
            .attributes = &.{"type", "Region"},
            .fields = .{
                .LocalPath = .{ .ns = Device.namespace_uri },
                .StorageUri = .{ .ns = Device.namespace_uri },
                .User = .{ .ns = Device.namespace_uri },
                .Extension = .{ .ns = Device.namespace_uri },
                .CertPathValidationPolicyID = .{ .ns = Device.namespace_uri },
                .ConfigurationRenewal = .{ .ns = Device.namespace_uri },
            },
        };
    };

    pub const StorageConfiguration = struct {
        token: []const u8 = "",
        Data: StorageConfigurationData = .{},
        pub const xml_meta = .{
            .element_name = "StorageConfiguration",
            .namespace = Device.namespace_uri,
            .namespace_uri = Device.namespace_uri,
            .attributes = &.{"token"},
            .fields = .{
                .Data = .{ .ns = Device.namespace_uri },
            },
        };
    };

    pub const GetServices = struct {
        pub const name = "GetServices";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetServices";
        pub const request_name = "GetServices";
        pub const response_name = "GetServicesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            IncludeCapability: bool = false,
            pub const xml_meta = .{
                .element_name = "GetServices",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .IncludeCapability = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Service: []const Service = &.{},
            pub const xml_meta = .{
                .element_name = "GetServicesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Service = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetServiceCapabilities = struct {
        pub const name = "GetServiceCapabilities";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetServiceCapabilities";
        pub const request_name = "GetServiceCapabilities";
        pub const response_name = "GetServiceCapabilitiesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilities",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: DeviceServiceCapabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetServiceCapabilitiesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetDeviceInformation = struct {
        pub const name = "GetDeviceInformation";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetDeviceInformation";
        pub const request_name = "GetDeviceInformation";
        pub const response_name = "GetDeviceInformationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetDeviceInformation",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            Manufacturer: []const u8 = "",
            Model: []const u8 = "",
            FirmwareVersion: []const u8 = "",
            SerialNumber: []const u8 = "",
            HardwareId: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetDeviceInformationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Manufacturer = .{ .ns = Device.namespace_uri },
                    .Model = .{ .ns = Device.namespace_uri },
                    .FirmwareVersion = .{ .ns = Device.namespace_uri },
                    .SerialNumber = .{ .ns = Device.namespace_uri },
                    .HardwareId = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetSystemDateAndTime = struct {
        pub const name = "SetSystemDateAndTime";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetSystemDateAndTime";
        pub const request_name = "SetSystemDateAndTime";
        pub const response_name = "SetSystemDateAndTimeResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            DateTimeType: schema.SetDateTimeType = .Manual,
            DaylightSavings: bool = false,
            TimeZone: ?schema.TimeZone = null,
            UTCDateTime: ?schema.DateTime = null,
            pub const xml_meta = .{
                .element_name = "SetSystemDateAndTime",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .DateTimeType = .{ .ns = Device.namespace_uri },
                    .DaylightSavings = .{ .ns = Device.namespace_uri },
                    .TimeZone = .{ .ns = Device.namespace_uri },
                    .UTCDateTime = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetSystemDateAndTimeResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetSystemDateAndTime = struct {
        pub const name = "GetSystemDateAndTime";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetSystemDateAndTime";
        pub const request_name = "GetSystemDateAndTime";
        pub const response_name = "GetSystemDateAndTimeResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetSystemDateAndTime",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            SystemDateAndTime: schema.SystemDateTime = .{},
            pub const xml_meta = .{
                .element_name = "GetSystemDateAndTimeResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .SystemDateAndTime = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetSystemFactoryDefault = struct {
        pub const name = "SetSystemFactoryDefault";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetSystemFactoryDefault";
        pub const request_name = "SetSystemFactoryDefault";
        pub const response_name = "SetSystemFactoryDefaultResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            FactoryDefault: schema.FactoryDefaultType = .Hard,
            pub const xml_meta = .{
                .element_name = "SetSystemFactoryDefault",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .FactoryDefault = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetSystemFactoryDefaultResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const UpgradeSystemFirmware = struct {
        pub const name = "UpgradeSystemFirmware";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/UpgradeSystemFirmware";
        pub const request_name = "UpgradeSystemFirmware";
        pub const response_name = "UpgradeSystemFirmwareResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Firmware: schema.AttachmentData = .{},
            pub const xml_meta = .{
                .element_name = "UpgradeSystemFirmware",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Firmware = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Message: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "UpgradeSystemFirmwareResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Message = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SystemReboot = struct {
        pub const name = "SystemReboot";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SystemReboot";
        pub const request_name = "SystemReboot";
        pub const response_name = "SystemRebootResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "SystemReboot",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            Message: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SystemRebootResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Message = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const RestoreSystem = struct {
        pub const name = "RestoreSystem";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/RestoreSystem";
        pub const request_name = "RestoreSystem";
        pub const response_name = "RestoreSystemResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            BackupFiles: []const schema.BackupFile = &.{},
            pub const xml_meta = .{
                .element_name = "RestoreSystem",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .BackupFiles = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RestoreSystemResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetSystemBackup = struct {
        pub const name = "GetSystemBackup";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetSystemBackup";
        pub const request_name = "GetSystemBackup";
        pub const response_name = "GetSystemBackupResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetSystemBackup",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            BackupFiles: []const schema.BackupFile = &.{},
            pub const xml_meta = .{
                .element_name = "GetSystemBackupResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .BackupFiles = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetSystemLog = struct {
        pub const name = "GetSystemLog";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetSystemLog";
        pub const request_name = "GetSystemLog";
        pub const response_name = "GetSystemLogResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            LogType: schema.SystemLogType = .System,
            pub const xml_meta = .{
                .element_name = "GetSystemLog",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .LogType = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            SystemLog: schema.SystemLog = .{},
            pub const xml_meta = .{
                .element_name = "GetSystemLogResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .SystemLog = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetSystemSupportInformation = struct {
        pub const name = "GetSystemSupportInformation";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetSystemSupportInformation";
        pub const request_name = "GetSystemSupportInformation";
        pub const response_name = "GetSystemSupportInformationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetSystemSupportInformation",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            SupportInformation: schema.SupportInformation = .{},
            pub const xml_meta = .{
                .element_name = "GetSystemSupportInformationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .SupportInformation = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetScopes = struct {
        pub const name = "GetScopes";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetScopes";
        pub const request_name = "GetScopes";
        pub const response_name = "GetScopesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetScopes",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            Scopes: []const schema.Scope = &.{},
            pub const xml_meta = .{
                .element_name = "GetScopesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Scopes = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetScopes = struct {
        pub const name = "SetScopes";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetScopes";
        pub const request_name = "SetScopes";
        pub const response_name = "SetScopesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Scopes: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "SetScopes",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Scopes = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetScopesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const AddScopes = struct {
        pub const name = "AddScopes";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/AddScopes";
        pub const request_name = "AddScopes";
        pub const response_name = "AddScopesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            ScopeItem: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "AddScopes",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .ScopeItem = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddScopesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const RemoveScopes = struct {
        pub const name = "RemoveScopes";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/RemoveScopes";
        pub const request_name = "RemoveScopes";
        pub const response_name = "RemoveScopesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            ScopeItem: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "RemoveScopes",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .ScopeItem = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            ScopeItem: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "RemoveScopesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .ScopeItem = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetDiscoveryMode = struct {
        pub const name = "GetDiscoveryMode";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetDiscoveryMode";
        pub const request_name = "GetDiscoveryMode";
        pub const response_name = "GetDiscoveryModeResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetDiscoveryMode",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            DiscoveryMode: schema.DiscoveryMode = .Discoverable,
            pub const xml_meta = .{
                .element_name = "GetDiscoveryModeResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .DiscoveryMode = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetDiscoveryMode = struct {
        pub const name = "SetDiscoveryMode";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetDiscoveryMode";
        pub const request_name = "SetDiscoveryMode";
        pub const response_name = "SetDiscoveryModeResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            DiscoveryMode: schema.DiscoveryMode = .Discoverable,
            pub const xml_meta = .{
                .element_name = "SetDiscoveryMode",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .DiscoveryMode = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetDiscoveryModeResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetRemoteDiscoveryMode = struct {
        pub const name = "GetRemoteDiscoveryMode";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetRemoteDiscoveryMode";
        pub const request_name = "GetRemoteDiscoveryMode";
        pub const response_name = "GetRemoteDiscoveryModeResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetRemoteDiscoveryMode",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            RemoteDiscoveryMode: schema.DiscoveryMode = .Discoverable,
            pub const xml_meta = .{
                .element_name = "GetRemoteDiscoveryModeResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .RemoteDiscoveryMode = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetRemoteDiscoveryMode = struct {
        pub const name = "SetRemoteDiscoveryMode";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetRemoteDiscoveryMode";
        pub const request_name = "SetRemoteDiscoveryMode";
        pub const response_name = "SetRemoteDiscoveryModeResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            RemoteDiscoveryMode: schema.DiscoveryMode = .Discoverable,
            pub const xml_meta = .{
                .element_name = "SetRemoteDiscoveryMode",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .RemoteDiscoveryMode = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetRemoteDiscoveryModeResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetDPAddresses = struct {
        pub const name = "GetDPAddresses";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetDPAddresses";
        pub const request_name = "GetDPAddresses";
        pub const response_name = "GetDPAddressesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetDPAddresses",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            DPAddress: []const schema.NetworkHost = &.{},
            pub const xml_meta = .{
                .element_name = "GetDPAddressesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .DPAddress = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetDPAddresses = struct {
        pub const name = "SetDPAddresses";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetDPAddresses";
        pub const request_name = "SetDPAddresses";
        pub const response_name = "SetDPAddressesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            DPAddress: []const schema.NetworkHost = &.{},
            pub const xml_meta = .{
                .element_name = "SetDPAddresses",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .DPAddress = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetDPAddressesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetEndpointReference = struct {
        pub const name = "GetEndpointReference";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetEndpointReference";
        pub const request_name = "GetEndpointReference";
        pub const response_name = "GetEndpointReferenceResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetEndpointReference",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            GUID: []const u8 = "",
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetEndpointReferenceResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .GUID = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetUserRoles = struct {
        pub const name = "GetUserRoles";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetUserRoles";
        pub const request_name = "GetUserRoles";
        pub const response_name = "GetUserRolesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            UserRole: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "GetUserRoles",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .UserRole = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            UserRole: []const schema.UserRole = &.{},
            pub const xml_meta = .{
                .element_name = "GetUserRolesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .UserRole = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetUserRole = struct {
        pub const name = "SetUserRole";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetUserRole";
        pub const request_name = "SetUserRole";
        pub const response_name = "SetUserRoleResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            UserRole: schema.UserRole = .{},
            pub const xml_meta = .{
                .element_name = "SetUserRole",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .UserRole = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetUserRoleResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const DeleteUserRole = struct {
        pub const name = "DeleteUserRole";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/DeleteUserRole";
        pub const request_name = "DeleteUserRole";
        pub const response_name = "DeleteUserRoleResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            UserRole: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteUserRole",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .UserRole = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteUserRoleResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetRemoteUser = struct {
        pub const name = "GetRemoteUser";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetRemoteUser";
        pub const request_name = "GetRemoteUser";
        pub const response_name = "GetRemoteUserResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetRemoteUser",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            RemoteUser: ?schema.RemoteUser = null,
            pub const xml_meta = .{
                .element_name = "GetRemoteUserResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .RemoteUser = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetRemoteUser = struct {
        pub const name = "SetRemoteUser";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetRemoteUser";
        pub const request_name = "SetRemoteUser";
        pub const response_name = "SetRemoteUserResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            RemoteUser: ?schema.RemoteUser = null,
            pub const xml_meta = .{
                .element_name = "SetRemoteUser",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .RemoteUser = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetRemoteUserResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetUsers = struct {
        pub const name = "GetUsers";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetUsers";
        pub const request_name = "GetUsers";
        pub const response_name = "GetUsersResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetUsers",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            User: []const schema.User = &.{},
            pub const xml_meta = .{
                .element_name = "GetUsersResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .User = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const CreateUsers = struct {
        pub const name = "CreateUsers";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/CreateUsers";
        pub const request_name = "CreateUsers";
        pub const response_name = "CreateUsersResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            User: []const schema.User = &.{},
            pub const xml_meta = .{
                .element_name = "CreateUsers",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .User = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "CreateUsersResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const DeleteUsers = struct {
        pub const name = "DeleteUsers";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/DeleteUsers";
        pub const request_name = "DeleteUsers";
        pub const response_name = "DeleteUsersResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Username: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "DeleteUsers",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Username = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteUsersResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const SetUser = struct {
        pub const name = "SetUser";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetUser";
        pub const request_name = "SetUser";
        pub const response_name = "SetUserResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            User: []const schema.User = &.{},
            pub const xml_meta = .{
                .element_name = "SetUser",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .User = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetUserResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetWsdlUrl = struct {
        pub const name = "GetWsdlUrl";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetWsdlUrl";
        pub const request_name = "GetWsdlUrl";
        pub const response_name = "GetWsdlUrlResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetWsdlUrl",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            WsdlUrl: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetWsdlUrlResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .WsdlUrl = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetPasswordComplexityOptions = struct {
        pub const name = "GetPasswordComplexityOptions";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetPasswordComplexityOptions";
        pub const request_name = "GetPasswordComplexityOptions";
        pub const response_name = "GetPasswordComplexityOptionsResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetPasswordComplexityOptions",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            MinLenRange: ?schema.IntRange = null,
            UppercaseRange: ?schema.IntRange = null,
            NumberRange: ?schema.IntRange = null,
            SpecialCharsRange: ?schema.IntRange = null,
            BlockUsernameOccurrenceSupported: ?bool = null,
            PolicyConfigurationLockSupported: ?bool = null,
            pub const xml_meta = .{
                .element_name = "GetPasswordComplexityOptionsResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .MinLenRange = .{ .ns = Device.namespace_uri },
                    .UppercaseRange = .{ .ns = Device.namespace_uri },
                    .NumberRange = .{ .ns = Device.namespace_uri },
                    .SpecialCharsRange = .{ .ns = Device.namespace_uri },
                    .BlockUsernameOccurrenceSupported = .{ .ns = Device.namespace_uri },
                    .PolicyConfigurationLockSupported = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetPasswordComplexityConfiguration = struct {
        pub const name = "GetPasswordComplexityConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetPasswordComplexityConfiguration";
        pub const request_name = "GetPasswordComplexityConfiguration";
        pub const response_name = "GetPasswordComplexityConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetPasswordComplexityConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            MinLen: ?i32 = null,
            Uppercase: ?i32 = null,
            Number: ?i32 = null,
            SpecialChars: ?i32 = null,
            BlockUsernameOccurrence: ?bool = null,
            PolicyConfigurationLocked: ?bool = null,
            pub const xml_meta = .{
                .element_name = "GetPasswordComplexityConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .MinLen = .{ .ns = Device.namespace_uri },
                    .Uppercase = .{ .ns = Device.namespace_uri },
                    .Number = .{ .ns = Device.namespace_uri },
                    .SpecialChars = .{ .ns = Device.namespace_uri },
                    .BlockUsernameOccurrence = .{ .ns = Device.namespace_uri },
                    .PolicyConfigurationLocked = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetPasswordComplexityConfiguration = struct {
        pub const name = "SetPasswordComplexityConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetPasswordComplexityConfiguration";
        pub const request_name = "SetPasswordComplexityConfiguration";
        pub const response_name = "SetPasswordComplexityConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            MinLen: ?i32 = null,
            Uppercase: ?i32 = null,
            Number: ?i32 = null,
            SpecialChars: ?i32 = null,
            BlockUsernameOccurrence: ?bool = null,
            PolicyConfigurationLocked: ?bool = null,
            pub const xml_meta = .{
                .element_name = "SetPasswordComplexityConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .MinLen = .{ .ns = Device.namespace_uri },
                    .Uppercase = .{ .ns = Device.namespace_uri },
                    .Number = .{ .ns = Device.namespace_uri },
                    .SpecialChars = .{ .ns = Device.namespace_uri },
                    .BlockUsernameOccurrence = .{ .ns = Device.namespace_uri },
                    .PolicyConfigurationLocked = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetPasswordComplexityConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetPasswordHistoryConfiguration = struct {
        pub const name = "GetPasswordHistoryConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetPasswordHistoryConfiguration";
        pub const request_name = "GetPasswordHistoryConfiguration";
        pub const response_name = "GetPasswordHistoryConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetPasswordHistoryConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            Enabled: bool = false,
            Length: i32 = 0,
            pub const xml_meta = .{
                .element_name = "GetPasswordHistoryConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Enabled = .{ .ns = Device.namespace_uri },
                    .Length = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetPasswordHistoryConfiguration = struct {
        pub const name = "SetPasswordHistoryConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetPasswordHistoryConfiguration";
        pub const request_name = "SetPasswordHistoryConfiguration";
        pub const response_name = "SetPasswordHistoryConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Enabled: bool = false,
            Length: i32 = 0,
            pub const xml_meta = .{
                .element_name = "SetPasswordHistoryConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Enabled = .{ .ns = Device.namespace_uri },
                    .Length = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetPasswordHistoryConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetAuthFailureWarningOptions = struct {
        pub const name = "GetAuthFailureWarningOptions";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetAuthFailureWarningOptions";
        pub const request_name = "GetAuthFailureWarningOptions";
        pub const response_name = "GetAuthFailureWarningOptionsResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetAuthFailureWarningOptions",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            MonitorPeriodRange: schema.IntRange = .{},
            AuthFailureRange: schema.IntRange = .{},
            pub const xml_meta = .{
                .element_name = "GetAuthFailureWarningOptionsResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .MonitorPeriodRange = .{ .ns = Device.namespace_uri },
                    .AuthFailureRange = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetAuthFailureWarningConfiguration = struct {
        pub const name = "GetAuthFailureWarningConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetAuthFailureWarningConfiguration";
        pub const request_name = "GetAuthFailureWarningConfiguration";
        pub const response_name = "GetAuthFailureWarningConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetAuthFailureWarningConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            Enabled: bool = false,
            MonitorPeriod: i32 = 0,
            MaxAuthFailures: i32 = 0,
            pub const xml_meta = .{
                .element_name = "GetAuthFailureWarningConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Enabled = .{ .ns = Device.namespace_uri },
                    .MonitorPeriod = .{ .ns = Device.namespace_uri },
                    .MaxAuthFailures = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetAuthFailureWarningConfiguration = struct {
        pub const name = "SetAuthFailureWarningConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetAuthFailureWarningConfiguration";
        pub const request_name = "SetAuthFailureWarningConfiguration";
        pub const response_name = "SetAuthFailureWarningConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Enabled: bool = false,
            MonitorPeriod: i32 = 0,
            MaxAuthFailures: i32 = 0,
            pub const xml_meta = .{
                .element_name = "SetAuthFailureWarningConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Enabled = .{ .ns = Device.namespace_uri },
                    .MonitorPeriod = .{ .ns = Device.namespace_uri },
                    .MaxAuthFailures = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetAuthFailureWarningConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetCapabilities = struct {
        pub const name = "GetCapabilities";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetCapabilities";
        pub const request_name = "GetCapabilities";
        pub const response_name = "GetCapabilitiesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Category: []const schema.CapabilityCategory = &.{},
            pub const xml_meta = .{
                .element_name = "GetCapabilities",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Category = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Capabilities: schema.Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetCapabilitiesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetHostname = struct {
        pub const name = "GetHostname";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetHostname";
        pub const request_name = "GetHostname";
        pub const response_name = "GetHostnameResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetHostname",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            HostnameInformation: schema.HostnameInformation = .{},
            pub const xml_meta = .{
                .element_name = "GetHostnameResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .HostnameInformation = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetHostname = struct {
        pub const name = "SetHostname";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetHostname";
        pub const request_name = "SetHostname";
        pub const response_name = "SetHostnameResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Name: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SetHostname",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Name = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetHostnameResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const SetHostnameFromDHCP = struct {
        pub const name = "SetHostnameFromDHCP";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetHostnameFromDHCP";
        pub const request_name = "SetHostnameFromDHCP";
        pub const response_name = "SetHostnameFromDHCPResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            FromDHCP: bool = false,
            pub const xml_meta = .{
                .element_name = "SetHostnameFromDHCP",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .FromDHCP = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            RebootNeeded: bool = false,
            pub const xml_meta = .{
                .element_name = "SetHostnameFromDHCPResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .RebootNeeded = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetDNS = struct {
        pub const name = "GetDNS";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetDNS";
        pub const request_name = "GetDNS";
        pub const response_name = "GetDNSResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetDNS",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            DNSInformation: schema.DNSInformation = .{},
            pub const xml_meta = .{
                .element_name = "GetDNSResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .DNSInformation = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetDNS = struct {
        pub const name = "SetDNS";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetDNS";
        pub const request_name = "SetDNS";
        pub const response_name = "SetDNSResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            FromDHCP: bool = false,
            SearchDomain: []const []const u8 = &.{},
            DNSManual: []const schema.IPAddress = &.{},
            pub const xml_meta = .{
                .element_name = "SetDNS",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .FromDHCP = .{ .ns = Device.namespace_uri },
                    .SearchDomain = .{ .ns = Device.namespace_uri },
                    .DNSManual = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetDNSResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetNTP = struct {
        pub const name = "GetNTP";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetNTP";
        pub const request_name = "GetNTP";
        pub const response_name = "GetNTPResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetNTP",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            NTPInformation: schema.NTPInformation = .{},
            pub const xml_meta = .{
                .element_name = "GetNTPResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .NTPInformation = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetNTP = struct {
        pub const name = "SetNTP";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetNTP";
        pub const request_name = "SetNTP";
        pub const response_name = "SetNTPResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            FromDHCP: bool = false,
            NTPManual: []const schema.NetworkHost = &.{},
            pub const xml_meta = .{
                .element_name = "SetNTP",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .FromDHCP = .{ .ns = Device.namespace_uri },
                    .NTPManual = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetNTPResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetDynamicDNS = struct {
        pub const name = "GetDynamicDNS";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetDynamicDNS";
        pub const request_name = "GetDynamicDNS";
        pub const response_name = "GetDynamicDNSResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetDynamicDNS",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            DynamicDNSInformation: schema.DynamicDNSInformation = .{},
            pub const xml_meta = .{
                .element_name = "GetDynamicDNSResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .DynamicDNSInformation = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetDynamicDNS = struct {
        pub const name = "SetDynamicDNS";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetDynamicDNS";
        pub const request_name = "SetDynamicDNS";
        pub const response_name = "SetDynamicDNSResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Type: schema.DynamicDNSType = .NoUpdate,
            Name: ?[]const u8 = null,
            TTL: ?xsd.Duration = null,
            pub const xml_meta = .{
                .element_name = "SetDynamicDNS",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Type = .{ .ns = Device.namespace_uri },
                    .Name = .{ .ns = Device.namespace_uri },
                    .TTL = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetDynamicDNSResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetNetworkInterfaces = struct {
        pub const name = "GetNetworkInterfaces";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetNetworkInterfaces";
        pub const request_name = "GetNetworkInterfaces";
        pub const response_name = "GetNetworkInterfacesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetNetworkInterfaces",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            NetworkInterfaces: []const schema.NetworkInterface = &.{},
            pub const xml_meta = .{
                .element_name = "GetNetworkInterfacesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .NetworkInterfaces = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetNetworkInterfaces = struct {
        pub const name = "SetNetworkInterfaces";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetNetworkInterfaces";
        pub const request_name = "SetNetworkInterfaces";
        pub const response_name = "SetNetworkInterfacesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            InterfaceToken: []const u8 = "",
            NetworkInterface: schema.NetworkInterfaceSetConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetNetworkInterfaces",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .InterfaceToken = .{ .ns = Device.namespace_uri },
                    .NetworkInterface = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            RebootNeeded: bool = false,
            pub const xml_meta = .{
                .element_name = "SetNetworkInterfacesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .RebootNeeded = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetNetworkProtocols = struct {
        pub const name = "GetNetworkProtocols";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetNetworkProtocols";
        pub const request_name = "GetNetworkProtocols";
        pub const response_name = "GetNetworkProtocolsResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetNetworkProtocols",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            NetworkProtocols: []const schema.NetworkProtocol = &.{},
            pub const xml_meta = .{
                .element_name = "GetNetworkProtocolsResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .NetworkProtocols = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetNetworkProtocols = struct {
        pub const name = "SetNetworkProtocols";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetNetworkProtocols";
        pub const request_name = "SetNetworkProtocols";
        pub const response_name = "SetNetworkProtocolsResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            NetworkProtocols: []const schema.NetworkProtocol = &.{},
            pub const xml_meta = .{
                .element_name = "SetNetworkProtocols",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .NetworkProtocols = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetNetworkProtocolsResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetNetworkDefaultGateway = struct {
        pub const name = "GetNetworkDefaultGateway";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetNetworkDefaultGateway";
        pub const request_name = "GetNetworkDefaultGateway";
        pub const response_name = "GetNetworkDefaultGatewayResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetNetworkDefaultGateway",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            NetworkGateway: schema.NetworkGateway = .{},
            pub const xml_meta = .{
                .element_name = "GetNetworkDefaultGatewayResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .NetworkGateway = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetNetworkDefaultGateway = struct {
        pub const name = "SetNetworkDefaultGateway";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetNetworkDefaultGateway";
        pub const request_name = "SetNetworkDefaultGateway";
        pub const response_name = "SetNetworkDefaultGatewayResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            IPv4Address: []const []const u8 = &.{},
            IPv6Address: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "SetNetworkDefaultGateway",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .IPv4Address = .{ .ns = Device.namespace_uri },
                    .IPv6Address = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetNetworkDefaultGatewayResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetZeroConfiguration = struct {
        pub const name = "GetZeroConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetZeroConfiguration";
        pub const request_name = "GetZeroConfiguration";
        pub const response_name = "GetZeroConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetZeroConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            ZeroConfiguration: schema.NetworkZeroConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetZeroConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .ZeroConfiguration = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetZeroConfiguration = struct {
        pub const name = "SetZeroConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetZeroConfiguration";
        pub const request_name = "SetZeroConfiguration";
        pub const response_name = "SetZeroConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            InterfaceToken: []const u8 = "",
            Enabled: bool = false,
            pub const xml_meta = .{
                .element_name = "SetZeroConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .InterfaceToken = .{ .ns = Device.namespace_uri },
                    .Enabled = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetZeroConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetIPAddressFilter = struct {
        pub const name = "GetIPAddressFilter";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetIPAddressFilter";
        pub const request_name = "GetIPAddressFilter";
        pub const response_name = "GetIPAddressFilterResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetIPAddressFilter",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            IPAddressFilter: schema.IPAddressFilter = .{},
            pub const xml_meta = .{
                .element_name = "GetIPAddressFilterResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .IPAddressFilter = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetIPAddressFilter = struct {
        pub const name = "SetIPAddressFilter";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetIPAddressFilter";
        pub const request_name = "SetIPAddressFilter";
        pub const response_name = "SetIPAddressFilterResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            IPAddressFilter: schema.IPAddressFilter = .{},
            pub const xml_meta = .{
                .element_name = "SetIPAddressFilter",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .IPAddressFilter = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetIPAddressFilterResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const AddIPAddressFilter = struct {
        pub const name = "AddIPAddressFilter";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/AddIPAddressFilter";
        pub const request_name = "AddIPAddressFilter";
        pub const response_name = "AddIPAddressFilterResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            IPAddressFilter: schema.IPAddressFilter = .{},
            pub const xml_meta = .{
                .element_name = "AddIPAddressFilter",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .IPAddressFilter = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "AddIPAddressFilterResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const RemoveIPAddressFilter = struct {
        pub const name = "RemoveIPAddressFilter";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/RemoveIPAddressFilter";
        pub const request_name = "RemoveIPAddressFilter";
        pub const response_name = "RemoveIPAddressFilterResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            IPAddressFilter: schema.IPAddressFilter = .{},
            pub const xml_meta = .{
                .element_name = "RemoveIPAddressFilter",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .IPAddressFilter = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "RemoveIPAddressFilterResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetAccessPolicy = struct {
        pub const name = "GetAccessPolicy";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetAccessPolicy";
        pub const request_name = "GetAccessPolicy";
        pub const response_name = "GetAccessPolicyResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetAccessPolicy",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            PolicyFile: schema.BinaryData = .{},
            pub const xml_meta = .{
                .element_name = "GetAccessPolicyResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .PolicyFile = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetAccessPolicy = struct {
        pub const name = "SetAccessPolicy";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetAccessPolicy";
        pub const request_name = "SetAccessPolicy";
        pub const response_name = "SetAccessPolicyResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            PolicyFile: schema.BinaryData = .{},
            pub const xml_meta = .{
                .element_name = "SetAccessPolicy",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .PolicyFile = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetAccessPolicyResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetRelayOutputs = struct {
        pub const name = "GetRelayOutputs";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetRelayOutputs";
        pub const request_name = "GetRelayOutputs";
        pub const response_name = "GetRelayOutputsResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetRelayOutputs",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            RelayOutputs: []const schema.RelayOutput = &.{},
            pub const xml_meta = .{
                .element_name = "GetRelayOutputsResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .RelayOutputs = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetRelayOutputSettings = struct {
        pub const name = "SetRelayOutputSettings";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetRelayOutputSettings";
        pub const request_name = "SetRelayOutputSettings";
        pub const response_name = "SetRelayOutputSettingsResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            RelayOutputToken: []const u8 = "",
            Properties: schema.RelayOutputSettings = .{},
            pub const xml_meta = .{
                .element_name = "SetRelayOutputSettings",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .RelayOutputToken = .{ .ns = Device.namespace_uri },
                    .Properties = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetRelayOutputSettingsResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const SetRelayOutputState = struct {
        pub const name = "SetRelayOutputState";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetRelayOutputState";
        pub const request_name = "SetRelayOutputState";
        pub const response_name = "SetRelayOutputStateResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            RelayOutputToken: []const u8 = "",
            LogicalState: schema.RelayLogicalState = .active,
            pub const xml_meta = .{
                .element_name = "SetRelayOutputState",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .RelayOutputToken = .{ .ns = Device.namespace_uri },
                    .LogicalState = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetRelayOutputStateResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const SendAuxiliaryCommand = struct {
        pub const name = "SendAuxiliaryCommand";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SendAuxiliaryCommand";
        pub const request_name = "SendAuxiliaryCommand";
        pub const response_name = "SendAuxiliaryCommandResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            AuxiliaryCommand: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SendAuxiliaryCommand",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .AuxiliaryCommand = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            AuxiliaryCommandResponse: ?[]const u8 = null,
            pub const xml_meta = .{
                .element_name = "SendAuxiliaryCommandResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .AuxiliaryCommandResponse = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetDot11Capabilities = struct {
        pub const name = "GetDot11Capabilities";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetDot11Capabilities";
        pub const request_name = "GetDot11Capabilities";
        pub const response_name = "GetDot11CapabilitiesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            any: []const xml_any.Any = &.{},
            pub const xml_meta = .{
                .element_name = "GetDot11Capabilities",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            Capabilities: schema.Dot11Capabilities = .{},
            pub const xml_meta = .{
                .element_name = "GetDot11CapabilitiesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Capabilities = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetDot11Status = struct {
        pub const name = "GetDot11Status";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetDot11Status";
        pub const request_name = "GetDot11Status";
        pub const response_name = "GetDot11StatusResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            InterfaceToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetDot11Status",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .InterfaceToken = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Status: schema.Dot11Status = .{},
            pub const xml_meta = .{
                .element_name = "GetDot11StatusResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Status = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const ScanAvailableDot11Networks = struct {
        pub const name = "ScanAvailableDot11Networks";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/ScanAvailableDot11Networks";
        pub const request_name = "ScanAvailableDot11Networks";
        pub const response_name = "ScanAvailableDot11NetworksResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            InterfaceToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "ScanAvailableDot11Networks",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .InterfaceToken = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Networks: []const schema.Dot11AvailableNetworks = &.{},
            pub const xml_meta = .{
                .element_name = "ScanAvailableDot11NetworksResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Networks = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetSystemUris = struct {
        pub const name = "GetSystemUris";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetSystemUris";
        pub const request_name = "GetSystemUris";
        pub const response_name = "GetSystemUrisResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetSystemUris",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            pub const Inline_Extension = struct {
                any: []const xml_any.Any = &.{},
                pub const xml_meta = .{
                    .element_name = "Extension",
                    .namespace = Device.namespace_uri,
                    .namespace_uri = Device.namespace_uri,
                };
            };

            SystemLogUris: ?schema.SystemLogUriList = null,
            SupportInfoUri: ?[]const u8 = null,
            SystemBackupUri: ?[]const u8 = null,
            Extension: ?Inline_Extension = null,
            pub const xml_meta = .{
                .element_name = "GetSystemUrisResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .SystemLogUris = .{ .ns = Device.namespace_uri },
                    .SupportInfoUri = .{ .ns = Device.namespace_uri },
                    .SystemBackupUri = .{ .ns = Device.namespace_uri },
                    .Extension = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const StartFirmwareUpgrade = struct {
        pub const name = "StartFirmwareUpgrade";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/StartFirmwareUpgrade";
        pub const request_name = "StartFirmwareUpgrade";
        pub const response_name = "StartFirmwareUpgradeResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "StartFirmwareUpgrade",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            UploadUri: []const u8 = "",
            UploadDelay: xsd.Duration = .{},
            ExpectedDownTime: xsd.Duration = .{},
            pub const xml_meta = .{
                .element_name = "StartFirmwareUpgradeResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .UploadUri = .{ .ns = Device.namespace_uri },
                    .UploadDelay = .{ .ns = Device.namespace_uri },
                    .ExpectedDownTime = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const UpgradeFirmware = struct {
        pub const name = "UpgradeFirmware";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/UpgradeFirmware";
        pub const request_name = "UpgradeFirmware";
        pub const response_name = "UpgradeFirmwareResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Version: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "UpgradeFirmware",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Version = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            ExpectedDownTime: xsd.Duration = .{},
            pub const xml_meta = .{
                .element_name = "UpgradeFirmwareResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .ExpectedDownTime = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const StartSystemRestore = struct {
        pub const name = "StartSystemRestore";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/StartSystemRestore";
        pub const request_name = "StartSystemRestore";
        pub const response_name = "StartSystemRestoreResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "StartSystemRestore",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            UploadUri: []const u8 = "",
            ExpectedDownTime: xsd.Duration = .{},
            pub const xml_meta = .{
                .element_name = "StartSystemRestoreResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .UploadUri = .{ .ns = Device.namespace_uri },
                    .ExpectedDownTime = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetStorageConfigurations = struct {
        pub const name = "GetStorageConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetStorageConfigurations";
        pub const request_name = "GetStorageConfigurations";
        pub const response_name = "GetStorageConfigurationsResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetStorageConfigurations",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            StorageConfigurations: []const StorageConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetStorageConfigurationsResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .StorageConfigurations = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const CreateStorageConfiguration = struct {
        pub const name = "CreateStorageConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/CreateStorageConfiguration";
        pub const request_name = "CreateStorageConfiguration";
        pub const response_name = "CreateStorageConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            StorageConfiguration: StorageConfigurationData = .{},
            pub const xml_meta = .{
                .element_name = "CreateStorageConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .StorageConfiguration = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Token: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "CreateStorageConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetStorageConfiguration = struct {
        pub const name = "GetStorageConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetStorageConfiguration";
        pub const request_name = "GetStorageConfiguration";
        pub const response_name = "GetStorageConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Token: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetStorageConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            StorageConfiguration: StorageConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetStorageConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .StorageConfiguration = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetStorageConfiguration = struct {
        pub const name = "SetStorageConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetStorageConfiguration";
        pub const request_name = "SetStorageConfiguration";
        pub const response_name = "SetStorageConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            StorageConfiguration: StorageConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetStorageConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .StorageConfiguration = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetStorageConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const DeleteStorageConfiguration = struct {
        pub const name = "DeleteStorageConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/DeleteStorageConfiguration";
        pub const request_name = "DeleteStorageConfiguration";
        pub const response_name = "DeleteStorageConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Token: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "DeleteStorageConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Token = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteStorageConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetGeoLocation = struct {
        pub const name = "GetGeoLocation";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetGeoLocation";
        pub const request_name = "GetGeoLocation";
        pub const response_name = "GetGeoLocationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetGeoLocation",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            Location: []const schema.LocationEntity = &.{},
            pub const xml_meta = .{
                .element_name = "GetGeoLocationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Location = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetGeoLocation = struct {
        pub const name = "SetGeoLocation";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetGeoLocation";
        pub const request_name = "SetGeoLocation";
        pub const response_name = "SetGeoLocationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Location: []const schema.LocationEntity = &.{},
            pub const xml_meta = .{
                .element_name = "SetGeoLocation",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Location = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetGeoLocationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const DeleteGeoLocation = struct {
        pub const name = "DeleteGeoLocation";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/DeleteGeoLocation";
        pub const request_name = "DeleteGeoLocation";
        pub const response_name = "DeleteGeoLocationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Location: []const schema.LocationEntity = &.{},
            pub const xml_meta = .{
                .element_name = "DeleteGeoLocation",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Location = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteGeoLocationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const SetHashingAlgorithm = struct {
        pub const name = "SetHashingAlgorithm";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetHashingAlgorithm";
        pub const request_name = "SetHashingAlgorithm";
        pub const response_name = "SetHashingAlgorithmResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Algorithm: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "SetHashingAlgorithm",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Algorithm = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetHashingAlgorithmResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const CreateCertificate = struct {
        pub const name = "CreateCertificate";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/CreateCertificate";
        pub const request_name = "CreateCertificate";
        pub const response_name = "CreateCertificateResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            CertificateID: ?[]const u8 = null,
            Subject: ?[]const u8 = null,
            ValidNotBefore: ?xsd.DateTime = null,
            ValidNotAfter: ?xsd.DateTime = null,
            pub const xml_meta = .{
                .element_name = "CreateCertificate",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .CertificateID = .{ .ns = Device.namespace_uri },
                    .Subject = .{ .ns = Device.namespace_uri },
                    .ValidNotBefore = .{ .ns = Device.namespace_uri },
                    .ValidNotAfter = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            NvtCertificate: schema.Certificate = .{},
            pub const xml_meta = .{
                .element_name = "CreateCertificateResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .NvtCertificate = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetCertificates = struct {
        pub const name = "GetCertificates";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetCertificates";
        pub const request_name = "GetCertificates";
        pub const response_name = "GetCertificatesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetCertificates",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            NvtCertificate: []const schema.Certificate = &.{},
            pub const xml_meta = .{
                .element_name = "GetCertificatesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .NvtCertificate = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetCertificatesStatus = struct {
        pub const name = "GetCertificatesStatus";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetCertificatesStatus";
        pub const request_name = "GetCertificatesStatus";
        pub const response_name = "GetCertificatesStatusResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetCertificatesStatus",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            CertificateStatus: []const schema.CertificateStatus = &.{},
            pub const xml_meta = .{
                .element_name = "GetCertificatesStatusResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .CertificateStatus = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetCertificatesStatus = struct {
        pub const name = "SetCertificatesStatus";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetCertificatesStatus";
        pub const request_name = "SetCertificatesStatus";
        pub const response_name = "SetCertificatesStatusResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            CertificateStatus: []const schema.CertificateStatus = &.{},
            pub const xml_meta = .{
                .element_name = "SetCertificatesStatus",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .CertificateStatus = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetCertificatesStatusResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const DeleteCertificates = struct {
        pub const name = "DeleteCertificates";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/DeleteCertificates";
        pub const request_name = "DeleteCertificates";
        pub const response_name = "DeleteCertificatesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            CertificateID: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "DeleteCertificates",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .CertificateID = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteCertificatesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetPkcs10Request = struct {
        pub const name = "GetPkcs10Request";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetPkcs10Request";
        pub const request_name = "GetPkcs10Request";
        pub const response_name = "GetPkcs10RequestResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            CertificateID: []const u8 = "",
            Subject: ?[]const u8 = null,
            Attributes: ?schema.BinaryData = null,
            pub const xml_meta = .{
                .element_name = "GetPkcs10Request",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .CertificateID = .{ .ns = Device.namespace_uri },
                    .Subject = .{ .ns = Device.namespace_uri },
                    .Attributes = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Pkcs10Request: schema.BinaryData = .{},
            pub const xml_meta = .{
                .element_name = "GetPkcs10RequestResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Pkcs10Request = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const LoadCertificates = struct {
        pub const name = "LoadCertificates";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/LoadCertificates";
        pub const request_name = "LoadCertificates";
        pub const response_name = "LoadCertificatesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            NVTCertificate: []const schema.Certificate = &.{},
            pub const xml_meta = .{
                .element_name = "LoadCertificates",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .NVTCertificate = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "LoadCertificatesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetClientCertificateMode = struct {
        pub const name = "GetClientCertificateMode";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetClientCertificateMode";
        pub const request_name = "GetClientCertificateMode";
        pub const response_name = "GetClientCertificateModeResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetClientCertificateMode",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            Enabled: bool = false,
            pub const xml_meta = .{
                .element_name = "GetClientCertificateModeResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Enabled = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const SetClientCertificateMode = struct {
        pub const name = "SetClientCertificateMode";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetClientCertificateMode";
        pub const request_name = "SetClientCertificateMode";
        pub const response_name = "SetClientCertificateModeResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Enabled: bool = false,
            pub const xml_meta = .{
                .element_name = "SetClientCertificateMode",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Enabled = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetClientCertificateModeResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetCACertificates = struct {
        pub const name = "GetCACertificates";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetCACertificates";
        pub const request_name = "GetCACertificates";
        pub const response_name = "GetCACertificatesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetCACertificates",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            CACertificate: []const schema.Certificate = &.{},
            pub const xml_meta = .{
                .element_name = "GetCACertificatesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .CACertificate = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const LoadCertificateWithPrivateKey = struct {
        pub const name = "LoadCertificateWithPrivateKey";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/LoadCertificateWithPrivateKey";
        pub const request_name = "LoadCertificateWithPrivateKey";
        pub const response_name = "LoadCertificateWithPrivateKeyResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            CertificateWithPrivateKey: []const schema.CertificateWithPrivateKey = &.{},
            pub const xml_meta = .{
                .element_name = "LoadCertificateWithPrivateKey",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .CertificateWithPrivateKey = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "LoadCertificateWithPrivateKeyResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetCertificateInformation = struct {
        pub const name = "GetCertificateInformation";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetCertificateInformation";
        pub const request_name = "GetCertificateInformation";
        pub const response_name = "GetCertificateInformationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            CertificateID: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetCertificateInformation",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .CertificateID = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            CertificateInformation: schema.CertificateInformation = .{},
            pub const xml_meta = .{
                .element_name = "GetCertificateInformationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .CertificateInformation = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const LoadCACertificates = struct {
        pub const name = "LoadCACertificates";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/LoadCACertificates";
        pub const request_name = "LoadCACertificates";
        pub const response_name = "LoadCACertificatesResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            CACertificate: []const schema.Certificate = &.{},
            pub const xml_meta = .{
                .element_name = "LoadCACertificates",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .CACertificate = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "LoadCACertificatesResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const CreateDot1XConfiguration = struct {
        pub const name = "CreateDot1XConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/CreateDot1XConfiguration";
        pub const request_name = "CreateDot1XConfiguration";
        pub const response_name = "CreateDot1XConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Dot1XConfiguration: schema.Dot1XConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "CreateDot1XConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Dot1XConfiguration = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "CreateDot1XConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const SetDot1XConfiguration = struct {
        pub const name = "SetDot1XConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/SetDot1XConfiguration";
        pub const request_name = "SetDot1XConfiguration";
        pub const response_name = "SetDot1XConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Dot1XConfiguration: schema.Dot1XConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "SetDot1XConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Dot1XConfiguration = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "SetDot1XConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

    pub const GetDot1XConfiguration = struct {
        pub const name = "GetDot1XConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetDot1XConfiguration";
        pub const request_name = "GetDot1XConfiguration";
        pub const response_name = "GetDot1XConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Dot1XConfigurationToken: []const u8 = "",
            pub const xml_meta = .{
                .element_name = "GetDot1XConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Dot1XConfigurationToken = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            Dot1XConfiguration: schema.Dot1XConfiguration = .{},
            pub const xml_meta = .{
                .element_name = "GetDot1XConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Dot1XConfiguration = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const GetDot1XConfigurations = struct {
        pub const name = "GetDot1XConfigurations";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/GetDot1XConfigurations";
        pub const request_name = "GetDot1XConfigurations";
        pub const response_name = "GetDot1XConfigurationsResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            pub const xml_meta = .{
                .element_name = "GetDot1XConfigurations",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

        pub const Response = struct {
            Dot1XConfiguration: []const schema.Dot1XConfiguration = &.{},
            pub const xml_meta = .{
                .element_name = "GetDot1XConfigurationsResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Dot1XConfiguration = .{ .ns = Device.namespace_uri },
                },
            };
        };

    };

    pub const DeleteDot1XConfiguration = struct {
        pub const name = "DeleteDot1XConfiguration";
        pub const soap_action = "http://www.onvif.org/ver10/device/wsdl/DeleteDot1XConfiguration";
        pub const request_name = "DeleteDot1XConfiguration";
        pub const response_name = "DeleteDot1XConfigurationResponse";
        pub const namespace = Device.namespace_uri;
        pub const namespace_uri = Device.namespace_uri;

        pub const Request = struct {
            Dot1XConfigurationToken: []const []const u8 = &.{},
            pub const xml_meta = .{
                .element_name = "DeleteDot1XConfiguration",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
                .fields = .{
                    .Dot1XConfigurationToken = .{ .ns = Device.namespace_uri },
                },
            };
        };

        pub const Response = struct {
            pub const xml_meta = .{
                .element_name = "DeleteDot1XConfigurationResponse",
                .namespace = Device.namespace_uri,
                .namespace_uri = Device.namespace_uri,
            };
        };

    };

};
