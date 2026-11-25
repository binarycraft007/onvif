const std = @import("std");
const onvif = @import("onvif");
const spec = onvif.spec;
const schema = spec.schema;

pub const MockCamera = struct {
    manufacturer: []const u8 = "Antigravity Systems",
    model: []const u8 = "AGY-CAM-4K",
    firmware_version: []const u8 = "v26.06-onvif-zig",
    serial_number: []const u8 = "SN-20261125-001",
    hardware_id: []const u8 = "HW-X86-64",
    device_xaddr: []const u8 = "http://127.0.0.1:8080/onvif/device_service",
    media_xaddr: []const u8 = "http://127.0.0.1:8080/onvif/media_service",

    // =========================================================================
    // Profile Helpers
    // =========================================================================

    fn get4KProfile(arena: std.mem.Allocator) !schema.Profile {
        return .{
            .Name = try arena.dupe(u8, "MainProfile_4K"),
            .token = try arena.dupe(u8, "Profile_4K"),
            .fixed = true,
            .VideoSourceConfiguration = .{
                .token = try arena.dupe(u8, "VideoSourceConfig_4K"),
                .Name = try arena.dupe(u8, "VSC_4K"),
                .UseCount = 1,
                .SourceToken = try arena.dupe(u8, "VideoSource_0"),
                .Bounds = .{ .x = 0, .y = 0, .width = 3840, .height = 2160 },
            },
            .VideoEncoderConfiguration = .{
                .token = try arena.dupe(u8, "VideoEncoderConfig_4K"),
                .Name = try arena.dupe(u8, "VEC_4K_H264"),
                .UseCount = 1,
                .Encoding = .H264,
                .Resolution = .{ .Width = 3840, .Height = 2160 },
                .Quality = 5.0,
                .RateControl = .{
                    .FrameRateLimit = 30,
                    .EncodingInterval = 1,
                    .BitrateLimit = 8192,
                },
                .H264 = .{
                    .GovLength = 30,
                    .H264Profile = .High,
                },
            },
        };
    }

    fn get1080PProfile(arena: std.mem.Allocator) !schema.Profile {
        return .{
            .Name = try arena.dupe(u8, "SubProfile_1080P"),
            .token = try arena.dupe(u8, "Profile_1080P"),
            .fixed = true,
            .VideoSourceConfiguration = .{
                .token = try arena.dupe(u8, "VideoSourceConfig_1080P"),
                .Name = try arena.dupe(u8, "VSC_1080P"),
                .UseCount = 1,
                .SourceToken = try arena.dupe(u8, "VideoSource_0"),
                .Bounds = .{ .x = 0, .y = 0, .width = 1920, .height = 1080 },
            },
            .VideoEncoderConfiguration = .{
                .token = try arena.dupe(u8, "VideoEncoderConfig_1080P"),
                .Name = try arena.dupe(u8, "VEC_1080P_H264"),
                .UseCount = 1,
                .Encoding = .H264,
                .Resolution = .{ .Width = 1920, .Height = 1080 },
                .Quality = 4.0,
                .RateControl = .{
                    .FrameRateLimit = 30,
                    .EncodingInterval = 1,
                    .BitrateLimit = 4096,
                },
                .H264 = .{
                    .GovLength = 30,
                    .H264Profile = .Main,
                },
            },
        };
    }

    // =========================================================================
    // Device Management Service Operations (Mandatory Profile S)
    // =========================================================================

    pub fn GetSystemDateAndTime(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Device.GetSystemDateAndTime.Request,
    ) !spec.Device.GetSystemDateAndTime.Response {
        return .{
            .SystemDateAndTime = .{
                .DateTimeType = .NTP,
                .DaylightSavings = false,
                .TimeZone = .{ .TZ = try arena.dupe(u8, "UTC") },
                .UTCDateTime = .{
                    .Time = .{ .Hour = 12, .Minute = 0, .Second = 0 },
                    .Date = .{ .Year = 2026, .Month = 11, .Day = 25 },
                },
            },
        };
    }

    pub fn SetSystemDateAndTime(
        _: *MockCamera,
        _: std.mem.Allocator,
        _: spec.Device.SetSystemDateAndTime.Request,
    ) !spec.Device.SetSystemDateAndTime.Response {
        return .{};
    }

    pub fn GetDeviceInformation(
        self: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Device.GetDeviceInformation.Request,
    ) !spec.Device.GetDeviceInformation.Response {
        return .{
            .Manufacturer = try arena.dupe(u8, self.manufacturer),
            .Model = try arena.dupe(u8, self.model),
            .FirmwareVersion = try arena.dupe(u8, self.firmware_version),
            .SerialNumber = try arena.dupe(u8, self.serial_number),
            .HardwareId = try arena.dupe(u8, self.hardware_id),
        };
    }

    pub fn GetCapabilities(
        self: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Device.GetCapabilities.Request,
    ) !spec.Device.GetCapabilities.Response {
        return .{
            .Capabilities = .{
                .Device = .{
                    .XAddr = try arena.dupe(u8, self.device_xaddr),
                },
                .Media = .{
                    .XAddr = try arena.dupe(u8, self.media_xaddr),
                    .StreamingCapabilities = .{
                        .RTP_TCP = true,
                        .RTP_RTSP_TCP = true,
                    },
                },
            },
        };
    }

    pub fn GetServices(
        self: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Device.GetServices.Request,
    ) !spec.Device.GetServices.Response {
        const services = try arena.alloc(spec.Device.Service, 2);
        services[0] = .{
            .Namespace = try arena.dupe(u8, spec.Device.namespace),
            .XAddr = try arena.dupe(u8, self.device_xaddr),
            .Version = .{ .Major = 26, .Minor = 6 },
        };
        services[1] = .{
            .Namespace = try arena.dupe(u8, spec.Media.namespace),
            .XAddr = try arena.dupe(u8, self.media_xaddr),
            .Version = .{ .Major = 26, .Minor = 6 },
        };
        return .{ .Service = services };
    }

    pub fn GetServiceCapabilities(
        _: *MockCamera,
        _: std.mem.Allocator,
        req: anytype,
    ) !if (@TypeOf(req) == spec.Device.GetServiceCapabilities.Request)
        spec.Device.GetServiceCapabilities.Response
    else
        spec.Media.GetServiceCapabilities.Response
    {
        if (@TypeOf(req) == spec.Device.GetServiceCapabilities.Request) {
            return .{
                .Capabilities = .{
                    .Network = .{
                        .IPFilter = false,
                        .ZeroConfiguration = false,
                        .IPVersion6 = false,
                        .DynDNS = false,
                        .HostnameFromDHCP = false,
                        .NTP = 1,
                    },
                    .Security = .{
                        .@"TLS1.2" = true,
                        .MaxUsers = 16,
                        .MaxUserNameLength = 32,
                        .MaxPasswordLength = 32,
                    },
                    .System = .{
                        .DiscoveryResolve = true,
                        .DiscoveryBye = true,
                        .SystemLogging = true,
                    },
                },
            };
        } else {
            return .{
                .Capabilities = .{
                    .SnapshotUri = true,
                    .Rotation = false,
                    .VideoSourceMode = false,
                    .OSD = false,
                    .ProfileCapabilities = .{
                        .MaximumNumberOfProfiles = 8,
                    },
                    .StreamingCapabilities = .{
                        .RTPMulticast = false,
                        .RTP_TCP = true,
                        .RTP_RTSP_TCP = true,
                    },
                },
            };
        }
    }

    pub fn GetScopes(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Device.GetScopes.Request,
    ) !spec.Device.GetScopes.Response {
        const raw_scopes = [_][]const u8{
            "onvif://www.onvif.org/type/video_encoder",
            "onvif://www.onvif.org/type/audio_encoder",
            "onvif://www.onvif.org/hardware/HW-X86-64",
            "onvif://www.onvif.org/name/AGY-CAM-4K",
            "onvif://www.onvif.org/location/Office",
            "onvif://www.onvif.org/Profile/Streaming",
            "onvif://www.onvif.org/Profile/S",
        };
        const scopes = try arena.alloc(schema.Scope, raw_scopes.len);
        for (raw_scopes, 0..) |s, i| {
            scopes[i] = .{
                .ScopeDef = .Fixed,
                .ScopeItem = try arena.dupe(u8, s),
            };
        }
        return .{ .Scopes = scopes };
    }

    pub fn SetScopes(
        _: *MockCamera,
        _: std.mem.Allocator,
        _: spec.Device.SetScopes.Request,
    ) !spec.Device.SetScopes.Response {
        return .{};
    }

    pub fn GetNetworkInterfaces(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Device.GetNetworkInterfaces.Request,
    ) !spec.Device.GetNetworkInterfaces.Response {
        const interfaces = try arena.alloc(schema.NetworkInterface, 1);
        const manual_ips = try arena.alloc(schema.PrefixedIPv4Address, 1);
        manual_ips[0] = .{
            .Address = try arena.dupe(u8, "127.0.0.1"),
            .PrefixLength = 24,
        };

        interfaces[0] = .{
            .token = try arena.dupe(u8, "eth0"),
            .Enabled = true,
            .Info = .{
                .Name = try arena.dupe(u8, "eth0"),
                .HwAddress = try arena.dupe(u8, "00:1A:2B:3C:4D:5E"),
                .MTU = 1500,
            },
            .IPv4 = .{
                .Enabled = true,
                .Config = .{
                    .Manual = manual_ips,
                    .DHCP = false,
                },
            },
        };
        return .{ .NetworkInterfaces = interfaces };
    }

    pub fn GetHostname(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Device.GetHostname.Request,
    ) !spec.Device.GetHostname.Response {
        return .{
            .HostnameInformation = .{
                .FromDHCP = false,
                .Name = try arena.dupe(u8, "agy-cam-4k"),
            },
        };
    }

    pub fn GetDNS(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Device.GetDNS.Request,
    ) !spec.Device.GetDNS.Response {
        const dns_list = try arena.alloc(schema.IPAddress, 1);
        dns_list[0] = .{
            .Type = .IPv4,
            .IPv4Address = try arena.dupe(u8, "8.8.8.8"),
        };
        return .{
            .DNSInformation = .{
                .FromDHCP = false,
                .DNSManual = dns_list,
            },
        };
    }

    pub fn GetNTP(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Device.GetNTP.Request,
    ) !spec.Device.GetNTP.Response {
        const ntp_list = try arena.alloc(schema.NetworkHost, 1);
        ntp_list[0] = .{
            .Type = .IPv4,
            .IPv4Address = try arena.dupe(u8, "pool.ntp.org"),
        };
        return .{
            .NTPInformation = .{
                .FromDHCP = false,
                .NTPManual = ntp_list,
            },
        };
    }

    pub fn SystemReboot(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Device.SystemReboot.Request,
    ) !spec.Device.SystemReboot.Response {
        return .{
            .Message = try arena.dupe(u8, "Rebooting in 5 seconds"),
        };
    }

    // =========================================================================
    // Media Service Operations (Mandatory Profile S)
    // =========================================================================

    pub fn GetProfiles(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Media.GetProfiles.Request,
    ) !spec.Media.GetProfiles.Response {
        const p1 = try get4KProfile(arena);
        const p2 = try get1080PProfile(arena);
        const profiles = try arena.alloc(schema.Profile, 2);
        profiles[0] = p1;
        profiles[1] = p2;
        return .{ .Profiles = profiles };
    }

    pub fn GetProfile(
        _: *MockCamera,
        arena: std.mem.Allocator,
        req: spec.Media.GetProfile.Request,
    ) !spec.Media.GetProfile.Response {
        if (std.mem.eql(u8, req.ProfileToken, "Profile_1080P")) {
            return .{ .Profile = try get1080PProfile(arena) };
        }
        return .{ .Profile = try get4KProfile(arena) };
    }

    pub fn GetStreamUri(
        _: *MockCamera,
        arena: std.mem.Allocator,
        req: spec.Media.GetStreamUri.Request,
    ) !spec.Media.GetStreamUri.Response {
        const token = if (req.ProfileToken.len > 0) req.ProfileToken else "Profile_4K";
        const uri = try std.fmt.allocPrint(arena, "rtsp://127.0.0.1:8554/live/{s}", .{token});
        return .{
            .MediaUri = .{
                .Uri = uri,
                .InvalidAfterConnect = false,
                .InvalidAfterReboot = true,
                .Timeout = .{},
            },
        };
    }

    pub fn GetSnapshotUri(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Media.GetSnapshotUri.Request,
    ) !spec.Media.GetSnapshotUri.Response {
        return .{
            .MediaUri = .{
                .Uri = try arena.dupe(u8, "http://127.0.0.1:8080/onvif/snapshot.jpg"),
                .InvalidAfterConnect = false,
                .InvalidAfterReboot = true,
                .Timeout = .{},
            },
        };
    }

    pub fn GetVideoSources(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Media.GetVideoSources.Request,
    ) !spec.Media.GetVideoSources.Response {
        const sources = try arena.alloc(schema.VideoSource, 1);
        sources[0] = .{
            .token = try arena.dupe(u8, "VideoSource_0"),
            .Framerate = 30.0,
            .Resolution = .{ .Width = 3840, .Height = 2160 },
        };
        return .{ .VideoSources = sources };
    }

    pub fn GetVideoSourceConfigurations(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Media.GetVideoSourceConfigurations.Request,
    ) !spec.Media.GetVideoSourceConfigurations.Response {
        const p1 = try get4KProfile(arena);
        const p2 = try get1080PProfile(arena);
        const configs = try arena.alloc(schema.VideoSourceConfiguration, 2);
        configs[0] = p1.VideoSourceConfiguration.?;
        configs[1] = p2.VideoSourceConfiguration.?;
        return .{ .Configurations = configs };
    }

    pub fn GetVideoSourceConfiguration(
        _: *MockCamera,
        arena: std.mem.Allocator,
        req: spec.Media.GetVideoSourceConfiguration.Request,
    ) !spec.Media.GetVideoSourceConfiguration.Response {
        if (std.mem.eql(u8, req.ConfigurationToken, "VideoSourceConfig_1080P")) {
            const p = try get1080PProfile(arena);
            return .{ .Configuration = p.VideoSourceConfiguration.? };
        }
        const p = try get4KProfile(arena);
        return .{ .Configuration = p.VideoSourceConfiguration.? };
    }

    pub fn GetVideoEncoderConfigurations(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Media.GetVideoEncoderConfigurations.Request,
    ) !spec.Media.GetVideoEncoderConfigurations.Response {
        const p1 = try get4KProfile(arena);
        const p2 = try get1080PProfile(arena);
        const configs = try arena.alloc(schema.VideoEncoderConfiguration, 2);
        configs[0] = p1.VideoEncoderConfiguration.?;
        configs[1] = p2.VideoEncoderConfiguration.?;
        return .{ .Configurations = configs };
    }

    pub fn GetVideoEncoderConfiguration(
        _: *MockCamera,
        arena: std.mem.Allocator,
        req: spec.Media.GetVideoEncoderConfiguration.Request,
    ) !spec.Media.GetVideoEncoderConfiguration.Response {
        if (std.mem.eql(u8, req.ConfigurationToken, "VideoEncoderConfig_1080P")) {
            const p = try get1080PProfile(arena);
            return .{ .Configuration = p.VideoEncoderConfiguration.? };
        }
        const p = try get4KProfile(arena);
        return .{ .Configuration = p.VideoEncoderConfiguration.? };
    }

    pub fn GetVideoEncoderConfigurationOptions(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Media.GetVideoEncoderConfigurationOptions.Request,
    ) !spec.Media.GetVideoEncoderConfigurationOptions.Response {
        const resolutions = try arena.alloc(schema.VideoResolution, 3);
        resolutions[0] = .{ .Width = 3840, .Height = 2160 };
        resolutions[1] = .{ .Width = 1920, .Height = 1080 };
        resolutions[2] = .{ .Width = 1280, .Height = 720 };

        const h264_profiles = try arena.alloc(schema.H264Profile, 3);
        h264_profiles[0] = .Baseline;
        h264_profiles[1] = .Main;
        h264_profiles[2] = .High;

        return .{
            .Options = .{
                .QualityRange = .{ .Min = 1, .Max = 10 },
                .H264 = .{
                    .ResolutionsAvailable = resolutions,
                    .GovLengthRange = .{ .Min = 1, .Max = 120 },
                    .FrameRateRange = .{ .Min = 1, .Max = 60 },
                    .EncodingIntervalRange = .{ .Min = 1, .Max = 10 },
                    .H264ProfilesSupported = h264_profiles,
                },
            },
        };
    }

    pub fn GetCompatibleVideoEncoderConfigurations(
        _: *MockCamera,
        arena: std.mem.Allocator,
        _: spec.Media.GetCompatibleVideoEncoderConfigurations.Request,
    ) !spec.Media.GetCompatibleVideoEncoderConfigurations.Response {
        const p1 = try get4KProfile(arena);
        const p2 = try get1080PProfile(arena);
        const configs = try arena.alloc(schema.VideoEncoderConfiguration, 2);
        configs[0] = p1.VideoEncoderConfiguration.?;
        configs[1] = p2.VideoEncoderConfiguration.?;
        return .{ .Configurations = configs };
    }
};

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const gpa = init.gpa;

    var stderr_file = std.Io.File.stderr();
    var stderr_writer = stderr_file.writer(io, &.{});
    const log = &stderr_writer.interface;

    try log.print("=== ONVIF Mock Camera Server ===\n", .{});

    var camera = MockCamera{};
    const addr = std.Io.net.IpAddress{ .ip4 = std.Io.net.Ip4Address.loopback(8080) };

    const ServerType = onvif.transport.Server(MockCamera, &.{ spec.Device, spec.Media });
    var server = ServerType.init(io, gpa, &camera, addr);
    defer server.deinit();

    try server.listen();
    try log.print("Mock camera listening on http://127.0.0.1:8080/onvif/device_service\n", .{});
    try log.print("Ready to serve all mandatory ONVIF Profile S Device and Media operations.\n", .{});
    try log.flush();
}

// =============================================================================
// Comprehensive Tests for all Mock Camera APIs
// =============================================================================

test "MockCamera Device and Media operations dispatch correctly" {
    var camera = MockCamera{};
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const R = onvif.transport.Router(MockCamera, &.{ spec.Device, spec.Media });

    // 1. GetSystemDateAndTime
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/GetSystemDateAndTime",
            \\<tds:GetSystemDateAndTime xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "GetSystemDateAndTimeResponse") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "UTC") != null);
    }

    // 2. SetSystemDateAndTime
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/SetSystemDateAndTime",
            \\<tds:SetSystemDateAndTime xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "SetSystemDateAndTimeResponse") != null);
    }

    // 3. GetDeviceInformation
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/GetDeviceInformation",
            \\<tds:GetDeviceInformation xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "Antigravity Systems") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "AGY-CAM-4K") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "HW-X86-64") != null);
    }

    // 4. GetCapabilities
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/GetCapabilities",
            \\<tds:GetCapabilities xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "device_service") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "media_service") != null);
    }

    // 5. GetServices
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/GetServices",
            \\<tds:GetServices xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "GetServicesResponse") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "device_service") != null);
    }

    // 6. GetServiceCapabilities (Device)
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/GetServiceCapabilities",
            \\<tds:GetServiceCapabilities xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "GetServiceCapabilitiesResponse") != null);
    }

    // 7. GetScopes
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/GetScopes",
            \\<tds:GetScopes xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "onvif://www.onvif.org/Profile/S") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "video_encoder") != null);
    }

    // 8. SetScopes
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/SetScopes",
            \\<tds:SetScopes xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "SetScopesResponse") != null);
    }

    // 9. GetNetworkInterfaces
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/GetNetworkInterfaces",
            \\<tds:GetNetworkInterfaces xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "eth0") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "00:1A:2B:3C:4D:5E") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "127.0.0.1") != null);
    }

    // 10. GetHostname
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/GetHostname",
            \\<tds:GetHostname xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "agy-cam-4k") != null);
    }

    // 11. GetDNS
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/GetDNS",
            \\<tds:GetDNS xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "8.8.8.8") != null);
    }

    // 12. GetNTP
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/GetNTP",
            \\<tds:GetNTP xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "pool.ntp.org") != null);
    }

    // 13. SystemReboot
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/device/wsdl/SystemReboot",
            \\<tds:SystemReboot xmlns:tds="http://www.onvif.org/ver10/device/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "Rebooting in 5 seconds") != null);
    }

    // 14. GetServiceCapabilities (Media)
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetServiceCapabilities",
            \\<trt:GetServiceCapabilities xmlns:trt="http://www.onvif.org/ver10/media/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "SnapshotUri") != null);
    }

    // 15. GetProfiles
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetProfiles",
            \\<trt:GetProfiles xmlns:trt="http://www.onvif.org/ver10/media/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "MainProfile_4K") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "SubProfile_1080P") != null);
    }

    // 16. GetProfile
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetProfile",
            \\<trt:GetProfile xmlns:trt="http://www.onvif.org/ver10/media/wsdl">
            \\  <trt:ProfileToken>Profile_1080P</trt:ProfileToken>
            \\</trt:GetProfile>
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "SubProfile_1080P") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "1920") != null);
    }

    // 17. GetStreamUri
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetStreamUri",
            \\<trt:GetStreamUri xmlns:trt="http://www.onvif.org/ver10/media/wsdl">
            \\  <trt:ProfileToken>Profile_4K</trt:ProfileToken>
            \\</trt:GetStreamUri>
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "rtsp://127.0.0.1:8554/live/Profile_4K") != null);
    }

    // 18. GetSnapshotUri
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetSnapshotUri",
            \\<trt:GetSnapshotUri xmlns:trt="http://www.onvif.org/ver10/media/wsdl">
            \\  <trt:ProfileToken>Profile_4K</trt:ProfileToken>
            \\</trt:GetSnapshotUri>
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "http://127.0.0.1:8080/onvif/snapshot.jpg") != null);
    }

    // 19. GetVideoSources
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetVideoSources",
            \\<trt:GetVideoSources xmlns:trt="http://www.onvif.org/ver10/media/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "VideoSource_0") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "3840") != null);
    }

    // 20. GetVideoSourceConfigurations
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetVideoSourceConfigurations",
            \\<trt:GetVideoSourceConfigurations xmlns:trt="http://www.onvif.org/ver10/media/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "VideoSourceConfig_4K") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "VideoSourceConfig_1080P") != null);
    }

    // 21. GetVideoSourceConfiguration
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetVideoSourceConfiguration",
            \\<trt:GetVideoSourceConfiguration xmlns:trt="http://www.onvif.org/ver10/media/wsdl">
            \\  <trt:ConfigurationToken>VideoSourceConfig_1080P</trt:ConfigurationToken>
            \\</trt:GetVideoSourceConfiguration>
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "VSC_1080P") != null);
    }

    // 22. GetVideoEncoderConfigurations
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetVideoEncoderConfigurations",
            \\<trt:GetVideoEncoderConfigurations xmlns:trt="http://www.onvif.org/ver10/media/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "VideoEncoderConfig_4K") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "VideoEncoderConfig_1080P") != null);
    }

    // 23. GetVideoEncoderConfiguration
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetVideoEncoderConfiguration",
            \\<trt:GetVideoEncoderConfiguration xmlns:trt="http://www.onvif.org/ver10/media/wsdl">
            \\  <trt:ConfigurationToken>VideoEncoderConfig_4K</trt:ConfigurationToken>
            \\</trt:GetVideoEncoderConfiguration>
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "VEC_4K_H264") != null);
    }

    // 24. GetVideoEncoderConfigurationOptions
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetVideoEncoderConfigurationOptions",
            \\<trt:GetVideoEncoderConfigurationOptions xmlns:trt="http://www.onvif.org/ver10/media/wsdl" />
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "QualityRange") != null);
        try std.testing.expect(std.mem.indexOf(u8, resp, "3840") != null);
    }

    // 25. GetCompatibleVideoEncoderConfigurations
    {
        const resp = try R.dispatch(
            &camera,
            alloc,
            "http://www.onvif.org/ver10/media/wsdl/GetCompatibleVideoEncoderConfigurations",
            \\<trt:GetCompatibleVideoEncoderConfigurations xmlns:trt="http://www.onvif.org/ver10/media/wsdl">
            \\  <trt:ProfileToken>Profile_4K</trt:ProfileToken>
            \\</trt:GetCompatibleVideoEncoderConfigurations>
        ,
        );
        try std.testing.expect(std.mem.indexOf(u8, resp, "VideoEncoderConfig_4K") != null);
    }
}
