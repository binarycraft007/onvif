//! ONVIF Common Schema Types (tt)
//! Generated from specs/wsdl/ver10/schema/common.xsd, onvif.xsd, and metadatastream.xsd
const std = @import("std");
const xsd = @import("../xsd_types.zig");
const xml_any = @import("../xml/Any.zig");

pub const ReferenceToken = []const u8;

pub const MoveStatus = enum {
    IDLE,
    MOVING,
    UNKNOWN,
};

pub const Entity = enum {
    Device,
    VideoSource,
    AudioSource,
};

pub const Name = []const u8;

pub const IntList = i32;

pub const FloatList = f32;

pub const StringAttrList = []const u8;

pub const StringList = []const u8;

pub const ReferenceTokenList = []const u8;

pub const RotateMode = enum {
    OFF,
    ON,
    AUTO,
};

pub const SceneOrientationMode = enum {
    MANUAL,
    AUTO,
};

pub const SceneOrientationOption = enum {
    Below,
    Horizon,
    Above,
};

pub const ViewModes = enum {
    @"tt:Fisheye",
    @"tt:360Panorama",
    @"tt:180Panorama",
    @"tt:Quad",
    @"tt:Original",
    @"tt:LeftHalf",
    @"tt:RightHalf",
    @"tt:Dewarp",
};

pub const VideoEncoding = enum {
    JPEG,
    MPEG4,
    H264,
};

pub const Mpeg4Profile = enum {
    SP,
    ASP,
};

pub const H264Profile = enum {
    Baseline,
    Main,
    Extended,
    High,
};

pub const SrtpSecurityAlgorithms = enum {
    NONE,
    AES_CM_128_HMAC_SHA1_80,
    AEAD_AES_128_GCM,
    AEAD_AES_256_GCM,
};

pub const VideoEncodingMimeNames = enum {
    JPEG,
    @"MPV4-ES",
    H264,
    H265,
};

pub const VideoEncodingProfiles = enum {
    Simple,
    AdvancedSimple,
    Baseline,
    Main,
    Main10,
    Extended,
    High,
};

pub const AudioEncoding = enum {
    G711,
    G726,
    AAC,
};

pub const AudioEncodingMimeNames = enum {
    PCMU,
    G726,
    @"MP4A-LATM",
    @"mpeg4-generic",
};

pub const MetadataCompressionType = enum {
    None,
    GZIP,
    EXI,
};

pub const StreamType = enum {
    @"RTP-Unicast",
    @"RTP-Multicast",
};

pub const TransportProtocol = enum {
    UDP,
    TCP,
    RTSP,
    HTTP,
};

pub const ScopeDefinition = enum {
    Fixed,
    Configurable,
};

pub const DiscoveryMode = enum {
    Discoverable,
    NonDiscoverable,
};

pub const NetworkInterfaceConfigPriority = i64;

pub const Duplex = enum {
    Full,
    Half,
};

pub const @"IANA-IfTypes" = i32;

pub const IPv6DHCPConfiguration = enum {
    Auto,
    Stateful,
    Stateless,
    Off,
};

pub const NetworkProtocolType = enum {
    HTTP,
    HTTPS,
    RTSP,
};

pub const NetworkHostType = enum {
    IPv4,
    IPv6,
    DNS,
};

pub const IPv4Address = []const u8;

pub const IPv6Address = []const u8;

pub const HwAddress = []const u8;

pub const IPType = enum {
    IPv4,
    IPv6,
};

pub const DNSName = []const u8;

pub const Domain = []const u8;

pub const IPAddressFilterType = enum {
    Allow,
    Deny,
};

pub const DynamicDNSType = enum {
    NoUpdate,
    ClientUpdates,
    ServerUpdates,
};

pub const Dot11SSIDType = []const u8;

pub const Dot11StationMode = enum {
    @"Ad-hoc",
    Infrastructure,
    Extended,
};

pub const Dot11SecurityMode = enum {
    None,
    WEP,
    PSK,
    Dot1X,
    Extended,
};

pub const Dot11Cipher = enum {
    CCMP,
    TKIP,
    Any,
    Extended,
};

pub const Dot11PSK = []const u8;

pub const Dot11PSKPassphrase = []const u8;

pub const Dot11SignalStrength = enum {
    None,
    @"Very Bad",
    Bad,
    Good,
    @"Very Good",
    Extended,
};

pub const Dot11AuthAndMangementSuite = enum {
    None,
    Dot1X,
    PSK,
    Extended,
};

pub const CapabilityCategory = enum {
    All,
    Analytics,
    Device,
    Events,
    Imaging,
    Media,
    PTZ,
};

pub const SystemLogType = enum {
    System,
    Access,
};

pub const FactoryDefaultType = enum {
    Hard,
    Soft,
};

pub const SetDateTimeType = enum {
    Manual,
    NTP,
};

pub const UserLevel = enum {
    Administrator,
    Operator,
    User,
    Anonymous,
    Extended,
};

pub const RelayLogicalState = enum {
    active,
    inactive,
};

pub const RelayIdleState = enum {
    closed,
    open,
};

pub const RelayMode = enum {
    Monostable,
    Bistable,
};

pub const DigitalIdleState = enum {
    closed,
    open,
};

pub const EFlipMode = enum {
    OFF,
    ON,
    Extended,
};

pub const ReverseMode = enum {
    OFF,
    ON,
    AUTO,
    Extended,
};

pub const AuxiliaryData = []const u8;

pub const PTZPresetTourState = enum {
    Idle,
    Touring,
    Paused,
    Extended,
};

pub const PTZPresetTourDirection = enum {
    Forward,
    Backward,
    Extended,
};

pub const PTZPresetTourOperation = enum {
    Start,
    Stop,
    Pause,
    Extended,
};

pub const MoveAndTrackMethod = enum {
    PresetToken,
    GeoLocation,
    PTZVector,
    ObjectID,
};

pub const AutoFocusMode = enum {
    AUTO,
    MANUAL,
};

pub const AFModes = enum {
    OnceAfterMove,
};

pub const WideDynamicMode = enum {
    OFF,
    ON,
};

pub const BacklightCompensationMode = enum {
    OFF,
    ON,
};

pub const ExposurePriority = enum {
    LowNoise,
    FrameRate,
};

pub const ExposureMode = enum {
    AUTO,
    MANUAL,
};

pub const Enabled = enum {
    ENABLED,
    DISABLED,
};

pub const WhiteBalanceMode = enum {
    AUTO,
    MANUAL,
};

pub const IrCutFilterMode = enum {
    ON,
    OFF,
    AUTO,
};

pub const ImageStabilizationMode = enum {
    OFF,
    ON,
    AUTO,
    Extended,
};

pub const IrCutFilterAutoBoundaryType = enum {
    Common,
    ToOn,
    ToOff,
    Extended,
};

pub const ToneCompensationMode = enum {
    OFF,
    ON,
    AUTO,
};

pub const DefoggingMode = enum {
    OFF,
    ON,
    AUTO,
};

pub const ImageSendingType = enum {
    Embedded,
    LocalStorage,
    RemoteStorage,
};

pub const PropertyOperation = enum {
    Initialized,
    Deleted,
    Changed,
};

pub const Direction = []const u8;

pub const ExtendedDirection = enum {
    Left,
    Right,
    Any,
    Entering,
    Exiting,
    Approaching,
    Departing,
};

pub const ReceiverMode = enum {
    AutoConnect,
    AlwaysConnect,
    NeverConnect,
    Unknown,
};

pub const ReceiverState = enum {
    NotConnected,
    Connecting,
    Connected,
    Unknown,
};

pub const ReceiverReference = []const u8;

pub const RecordingReference = []const u8;

pub const TrackReference = []const u8;

pub const Description = []const u8;

pub const XPathExpression = []const u8;

pub const SearchState = enum {
    Queued,
    Searching,
    Completed,
    Unknown,
};

pub const JobToken = []const u8;

pub const TargetFormat = enum {
    MP4,
    CMAF,
};

pub const EncryptionMode = enum {
    CENC,
    CBCS,
};

pub const StorageStrategy = enum {
    External,
    Local,
    Both,
};

pub const RecordingStatus = enum {
    Initiated,
    Recording,
    Stopped,
    Removing,
    Removed,
    Unknown,
};

pub const TrackType = enum {
    Video,
    Audio,
    Metadata,
    Extended,
};

pub const RecordingJobReference = []const u8;

pub const RecordingJobMode = []const u8;

pub const RecordingJobState = []const u8;

pub const ModeOfOperation = enum {
    Idle,
    Active,
    Unknown,
};

pub const AudioClassType = enum {
    gun_shot,
    scream,
    glass_breaking,
    tire_screech,
};

pub const AudioClassification = enum {
    GunShot,
    Scream,
    GlassBreaking,
    TireScreech,
    Alarm,
};

pub const OSDType = enum {
    Text,
    Image,
    Extended,
};

pub const VehicleType = enum {
    Bus,
    Car,
    Truck,
    Bicycle,
    Motorcycle,
};

pub const PlateType = enum {
    Normal,
    Police,
    Diplomat,
    Temporary,
};

pub const BarcodeType = enum {
    @"Code-39",
    @"Code-49",
    @"Code-93",
    @"Code-128",
    @"Code-11",
    @"Code-25-Interleaved",
    @"Code-25-NonInterleaved",
    DataMatrix,
    Maxicode,
    Postnet,
    RM4SCC,
    @"ISBN-13",
    @"ISBN-13-Dual",
    @"ISBN-10",
    @"ITF-14",
    @"EAN-2",
    @"EAN-8",
    @"EAN-13",
    @"EAN-14",
    @"EAN-18",
    @"EAN-99",
    @"EAN-128",
    @"SCC-14",
    @"SSCC-18",
    @"UPC-A",
    @"UPC-E",
    PDF417,
    QRCode,
};

pub const LabelAuthority = enum {
    ISO_3864,
    ISO_7010,
    UNECE_ADR,
    UNECE_GHS,
};

pub const ObjectType = enum {
    Animal,
    HumanFace,
    Human,
    Bicycle,
    Vehicle,
    LicensePlate,
    Bike,
    Barcode,
    Fire,
    Smoke,
};

pub const ClassType = enum {
    Animal,
    Face,
    Human,
    Vehical,
    Other,
};

pub const IntRange = struct {
    Min: i32 = 0,
    Max: i32 = 0,
    pub const xml_meta = .{
        .element_name = "IntRange",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Min = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Max = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Vector2D = struct {
    x: f32 = 0.0,
    y: f32 = 0.0,
    space: ?[]const u8 = null,
    pub const xml_meta = .{
        .element_name = "Vector2D",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"x", "y", "space"},
    };
};

pub const Vector1D = struct {
    x: f32 = 0.0,
    space: ?[]const u8 = null,
    pub const xml_meta = .{
        .element_name = "Vector1D",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"x", "space"},
    };
};

pub const PTZVector = struct {
    PanTilt: ?Vector2D = null,
    Zoom: ?Vector1D = null,
    pub const xml_meta = .{
        .element_name = "PTZVector",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PanTilt = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Zoom = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FieldOfView = struct {
    hfov: f32 = 0.0,
    vfov: f32 = 0.0,
    pub const xml_meta = .{
        .element_name = "FieldOfView",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"hfov", "vfov"},
    };
};

pub const PTZStatus = struct {
    Position: ?PTZVector = null,
    MoveStatus: ?PTZMoveStatus = null,
    Error: ?[]const u8 = null,
    UtcTime: xsd.DateTime = .{},
    FieldOfView: ?FieldOfView = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZStatus",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Position = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MoveStatus = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Error = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UtcTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FieldOfView = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZMoveStatus = struct {
    PanTilt: ?MoveStatus = null,
    Zoom: ?MoveStatus = null,
    pub const xml_meta = .{
        .element_name = "PTZMoveStatus",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PanTilt = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Zoom = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Vector = struct {
    x: f32 = 0.0,
    y: f32 = 0.0,
    pub const xml_meta = .{
        .element_name = "Vector",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"x", "y"},
    };
};

pub const Rectangle = struct {
    bottom: f32 = 0.0,
    top: f32 = 0.0,
    right: f32 = 0.0,
    left: f32 = 0.0,
    pub const xml_meta = .{
        .element_name = "Rectangle",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"bottom", "top", "right", "left"},
    };
};

pub const Polygon = struct {
    Point: []const Vector = &.{},
    pub const xml_meta = .{
        .element_name = "Polygon",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Point = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Color = struct {
    X: f32 = 0.0,
    Y: f32 = 0.0,
    Z: f32 = 0.0,
    Colorspace: ?[]const u8 = null,
    Likelihood: ?f32 = null,
    pub const xml_meta = .{
        .element_name = "Color",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"X", "Y", "Z", "Colorspace", "Likelihood"},
    };
};

pub const ColorCovariance = struct {
    XX: f32 = 0.0,
    YY: f32 = 0.0,
    ZZ: f32 = 0.0,
    XY: ?f32 = null,
    XZ: ?f32 = null,
    YZ: ?f32 = null,
    Colorspace: ?[]const u8 = null,
    pub const xml_meta = .{
        .element_name = "ColorCovariance",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"XX", "YY", "ZZ", "XY", "XZ", "YZ", "Colorspace"},
    };
};

pub const ColorDescriptor = struct {
    pub const Inline_ColorCluster = struct {
        Color: Color = .{},
        Weight: ?f32 = null,
        Covariance: ?ColorCovariance = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "ColorCluster",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
            .fields = .{
                .Color = .{ .ns = "http://www.onvif.org/ver10/schema" },
                .Weight = .{ .ns = "http://www.onvif.org/ver10/schema" },
                .Covariance = .{ .ns = "http://www.onvif.org/ver10/schema" },
            },
        };
    };

    ColorCluster: []const Inline_ColorCluster = &.{},
    Extension: ?xml_any.Any = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ColorDescriptor",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ColorCluster = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Transformation = struct {
    Translate: ?Vector = null,
    Scale: ?Vector = null,
    Extension: ?TransformationExtension = null,
    pub const xml_meta = .{
        .element_name = "Transformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Translate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Scale = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const TransformationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "TransformationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const AspectRatioTransformation = struct {
    ratio: f32 = 0.0,
    Translate: ?Vector = null,
    Scale: ?Vector = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AspectRatioTransformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"ratio"},
        .fields = .{
            .Translate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Scale = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const GeoLocation = struct {
    lon: ?f64 = null,
    lat: ?f64 = null,
    elevation: ?f32 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "GeoLocation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"lon", "lat", "elevation"},
    };
};

pub const GeoOrientation = struct {
    roll: ?f32 = null,
    pitch: ?f32 = null,
    yaw: ?f32 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "GeoOrientation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"roll", "pitch", "yaw"},
    };
};

pub const LocalLocation = struct {
    x: ?f32 = null,
    y: ?f32 = null,
    z: ?f32 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "LocalLocation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"x", "y", "z"},
    };
};

pub const LocalOrientation = struct {
    pan: ?f32 = null,
    tilt: ?f32 = null,
    roll: ?f32 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "LocalOrientation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"pan", "tilt", "roll"},
    };
};

pub const SphericalCoordinate = struct {
    Distance: ?f32 = null,
    ElevationAngle: ?f32 = null,
    AzimuthAngle: ?f32 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SphericalCoordinate",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Distance", "ElevationAngle", "AzimuthAngle"},
    };
};

pub const LocationEntity = struct {
    Entity: ?[]const u8 = null,
    Token: ?[]const u8 = null,
    Fixed: ?bool = null,
    GeoSource: ?[]const u8 = null,
    AutoGeo: ?bool = null,
    GeoLocation: ?GeoLocation = null,
    GeoOrientation: ?GeoOrientation = null,
    LocalLocation: ?LocalLocation = null,
    LocalOrientation: ?LocalOrientation = null,
    pub const xml_meta = .{
        .element_name = "LocationEntity",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Entity", "Token", "Fixed", "GeoSource", "AutoGeo"},
        .fields = .{
            .GeoLocation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .GeoOrientation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .LocalLocation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .LocalOrientation = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DeviceEntity = struct {
    token: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "DeviceEntity",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
    };
};

pub const IntRectangle = struct {
    x: i32 = 0,
    y: i32 = 0,
    width: i32 = 0,
    height: i32 = 0,
    pub const xml_meta = .{
        .element_name = "IntRectangle",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"x", "y", "width", "height"},
    };
};

pub const IntRectangleRange = struct {
    XRange: IntRange = .{},
    YRange: IntRange = .{},
    WidthRange: IntRange = .{},
    HeightRange: IntRange = .{},
    pub const xml_meta = .{
        .element_name = "IntRectangleRange",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .YRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WidthRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .HeightRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FloatRange = struct {
    Min: f32 = 0.0,
    Max: f32 = 0.0,
    pub const xml_meta = .{
        .element_name = "FloatRange",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Min = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Max = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DurationRange = struct {
    Min: xsd.Duration = .{},
    Max: xsd.Duration = .{},
    pub const xml_meta = .{
        .element_name = "DurationRange",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Min = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Max = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IntItems = struct {
    Items: []const i32 = &.{},
    pub const xml_meta = .{
        .element_name = "IntItems",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Items = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FloatItems = struct {
    Items: []const f32 = &.{},
    pub const xml_meta = .{
        .element_name = "FloatItems",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Items = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnyHolder = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AnyHolder",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const VideoSource = struct {
    token: []const u8 = "",
    Framerate: f32 = 0.0,
    Resolution: VideoResolution = .{},
    Imaging: ?ImagingSettings = null,
    Extension: ?VideoSourceExtension = null,
    pub const xml_meta = .{
        .element_name = "VideoSource",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Framerate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Resolution = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Imaging = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoSourceExtension = struct {
    any: []const xml_any.Any = &.{},
    Imaging: ?ImagingSettings20 = null,
    Extension: ?VideoSourceExtension2 = null,
    pub const xml_meta = .{
        .element_name = "VideoSourceExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Imaging = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoSourceExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoSourceExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const AudioSource = struct {
    token: []const u8 = "",
    Channels: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioSource",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Channels = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Profile = struct {
    token: []const u8 = "",
    fixed: ?bool = null,
    Name: []const u8 = "",
    VideoSourceConfiguration: ?VideoSourceConfiguration = null,
    AudioSourceConfiguration: ?AudioSourceConfiguration = null,
    VideoEncoderConfiguration: ?VideoEncoderConfiguration = null,
    AudioEncoderConfiguration: ?AudioEncoderConfiguration = null,
    VideoAnalyticsConfiguration: ?VideoAnalyticsConfiguration = null,
    PTZConfiguration: ?PTZConfiguration = null,
    MetadataConfiguration: ?MetadataConfiguration = null,
    Extension: ?ProfileExtension = null,
    pub const xml_meta = .{
        .element_name = "Profile",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token", "fixed"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VideoSourceConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioSourceConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VideoEncoderConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioEncoderConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VideoAnalyticsConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PTZConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MetadataConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ProfileExtension = struct {
    any: []const xml_any.Any = &.{},
    AudioOutputConfiguration: ?AudioOutputConfiguration = null,
    AudioDecoderConfiguration: ?AudioDecoderConfiguration = null,
    Extension: ?ProfileExtension2 = null,
    pub const xml_meta = .{
        .element_name = "ProfileExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AudioOutputConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioDecoderConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ProfileExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ProfileExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ConfigurationEntity = struct {
    token: []const u8 = "",
    Name: []const u8 = "",
    UseCount: i32 = 0,
    pub const xml_meta = .{
        .element_name = "ConfigurationEntity",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoSourceConfiguration = struct {
    token: []const u8 = "",
    ViewMode: ?[]const u8 = null,
    Name: []const u8 = "",
    UseCount: i32 = 0,
    SourceToken: []const u8 = "",
    Bounds: IntRectangle = .{},
    any: []const xml_any.Any = &.{},
    Extension: ?VideoSourceConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "VideoSourceConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token", "ViewMode"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SourceToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Bounds = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoSourceConfigurationExtension = struct {
    Rotate: ?Rotate = null,
    Extension: ?VideoSourceConfigurationExtension2 = null,
    pub const xml_meta = .{
        .element_name = "VideoSourceConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Rotate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoSourceConfigurationExtension2 = struct {
    LensDescription: []const LensDescription = &.{},
    SceneOrientation: ?SceneOrientation = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoSourceConfigurationExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .LensDescription = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SceneOrientation = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Rotate = struct {
    Mirror: ?bool = null,
    Mode: RotateMode = .OFF,
    Degree: ?i32 = null,
    Extension: ?RotateExtension = null,
    pub const xml_meta = .{
        .element_name = "Rotate",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Mirror"},
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Degree = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RotateExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RotateExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const LensProjection = struct {
    Angle: f32 = 0.0,
    Radius: f32 = 0.0,
    Transmittance: ?f32 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "LensProjection",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Angle = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Radius = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Transmittance = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const LensOffset = struct {
    x: ?f32 = null,
    y: ?f32 = null,
    pub const xml_meta = .{
        .element_name = "LensOffset",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"x", "y"},
    };
};

pub const LensDescription = struct {
    FocalLength: ?f32 = null,
    Offset: LensOffset = .{},
    Projection: []const LensProjection = &.{},
    XFactor: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "LensDescription",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"FocalLength"},
        .fields = .{
            .Offset = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Projection = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .XFactor = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoSourceConfigurationOptions = struct {
    MaximumNumberOfProfiles: ?i32 = null,
    BoundsRange: IntRectangleRange = .{},
    VideoSourceTokensAvailable: []const []const u8 = &.{},
    Extension: ?VideoSourceConfigurationOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "VideoSourceConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"MaximumNumberOfProfiles"},
        .fields = .{
            .BoundsRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VideoSourceTokensAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoSourceConfigurationOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    Rotate: ?RotateOptions = null,
    Extension: ?VideoSourceConfigurationOptionsExtension2 = null,
    pub const xml_meta = .{
        .element_name = "VideoSourceConfigurationOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Rotate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoSourceConfigurationOptionsExtension2 = struct {
    SceneOrientationMode: []const SceneOrientationMode = &.{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoSourceConfigurationOptionsExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SceneOrientationMode = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RotateOptions = struct {
    Reboot: ?bool = null,
    Mirror: ?bool = null,
    Mode: []const RotateMode = &.{},
    DegreeList: ?IntItems = null,
    Extension: ?RotateOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "RotateOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Reboot", "Mirror"},
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DegreeList = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RotateOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RotateOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const SceneOrientation = struct {
    Mode: SceneOrientationMode = .MANUAL,
    Orientation: ?[]const u8 = null,
    pub const xml_meta = .{
        .element_name = "SceneOrientation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Orientation = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoEncoderConfiguration = struct {
    token: []const u8 = "",
    GuaranteedFrameRate: ?bool = null,
    Name: []const u8 = "",
    UseCount: i32 = 0,
    Encoding: VideoEncoding = .JPEG,
    Resolution: VideoResolution = .{},
    Quality: f32 = 0.0,
    RateControl: ?VideoRateControl = null,
    MPEG4: ?Mpeg4Configuration = null,
    H264: ?H264Configuration = null,
    Multicast: MulticastConfiguration = .{},
    SessionTimeout: xsd.Duration = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoEncoderConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token", "GuaranteedFrameRate"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Encoding = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Resolution = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Quality = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RateControl = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MPEG4 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .H264 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Multicast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SessionTimeout = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoResolution = struct {
    Width: i32 = 0,
    Height: i32 = 0,
    pub const xml_meta = .{
        .element_name = "VideoResolution",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Width = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Height = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoRateControl = struct {
    FrameRateLimit: i32 = 0,
    EncodingInterval: i32 = 0,
    BitrateLimit: i32 = 0,
    pub const xml_meta = .{
        .element_name = "VideoRateControl",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .FrameRateLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EncodingInterval = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BitrateLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Mpeg4Configuration = struct {
    GovLength: i32 = 0,
    Mpeg4Profile: Mpeg4Profile = .SP,
    pub const xml_meta = .{
        .element_name = "Mpeg4Configuration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .GovLength = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Mpeg4Profile = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const H264Configuration = struct {
    GovLength: i32 = 0,
    H264Profile: H264Profile = .Baseline,
    pub const xml_meta = .{
        .element_name = "H264Configuration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .GovLength = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .H264Profile = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoEncoderConfigurationOptions = struct {
    GuaranteedFrameRateSupported: ?bool = null,
    QualityRange: IntRange = .{},
    JPEG: ?JpegOptions = null,
    MPEG4: ?Mpeg4Options = null,
    H264: ?H264Options = null,
    Extension: ?VideoEncoderOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "VideoEncoderConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"GuaranteedFrameRateSupported"},
        .fields = .{
            .QualityRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .JPEG = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MPEG4 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .H264 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoEncoderOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    JPEG: ?JpegOptions2 = null,
    MPEG4: ?Mpeg4Options2 = null,
    H264: ?H264Options2 = null,
    Extension: ?VideoEncoderOptionsExtension2 = null,
    pub const xml_meta = .{
        .element_name = "VideoEncoderOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .JPEG = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MPEG4 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .H264 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoEncoderOptionsExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoEncoderOptionsExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const JpegOptions = struct {
    ResolutionsAvailable: []const VideoResolution = &.{},
    FrameRateRange: IntRange = .{},
    EncodingIntervalRange: IntRange = .{},
    pub const xml_meta = .{
        .element_name = "JpegOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ResolutionsAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FrameRateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EncodingIntervalRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const JpegOptions2 = struct {
    ResolutionsAvailable: []const VideoResolution = &.{},
    FrameRateRange: IntRange = .{},
    EncodingIntervalRange: IntRange = .{},
    BitrateRange: IntRange = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "JpegOptions2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ResolutionsAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FrameRateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EncodingIntervalRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BitrateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Mpeg4Options = struct {
    ResolutionsAvailable: []const VideoResolution = &.{},
    GovLengthRange: IntRange = .{},
    FrameRateRange: IntRange = .{},
    EncodingIntervalRange: IntRange = .{},
    Mpeg4ProfilesSupported: []const Mpeg4Profile = &.{},
    pub const xml_meta = .{
        .element_name = "Mpeg4Options",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ResolutionsAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .GovLengthRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FrameRateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EncodingIntervalRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Mpeg4ProfilesSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Mpeg4Options2 = struct {
    ResolutionsAvailable: []const VideoResolution = &.{},
    GovLengthRange: IntRange = .{},
    FrameRateRange: IntRange = .{},
    EncodingIntervalRange: IntRange = .{},
    Mpeg4ProfilesSupported: []const Mpeg4Profile = &.{},
    BitrateRange: IntRange = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Mpeg4Options2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ResolutionsAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .GovLengthRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FrameRateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EncodingIntervalRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Mpeg4ProfilesSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BitrateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const H264Options = struct {
    ResolutionsAvailable: []const VideoResolution = &.{},
    GovLengthRange: IntRange = .{},
    FrameRateRange: IntRange = .{},
    EncodingIntervalRange: IntRange = .{},
    H264ProfilesSupported: []const H264Profile = &.{},
    pub const xml_meta = .{
        .element_name = "H264Options",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ResolutionsAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .GovLengthRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FrameRateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EncodingIntervalRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .H264ProfilesSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const H264Options2 = struct {
    ResolutionsAvailable: []const VideoResolution = &.{},
    GovLengthRange: IntRange = .{},
    FrameRateRange: IntRange = .{},
    EncodingIntervalRange: IntRange = .{},
    H264ProfilesSupported: []const H264Profile = &.{},
    BitrateRange: IntRange = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "H264Options2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ResolutionsAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .GovLengthRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FrameRateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EncodingIntervalRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .H264ProfilesSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BitrateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoEncoder2Configuration = struct {
    token: []const u8 = "",
    GovLength: ?i32 = null,
    AnchorFrameDistance: ?i32 = null,
    Profile: ?[]const u8 = null,
    GuaranteedFrameRate: ?bool = null,
    Signed: ?bool = null,
    SecureStreamingProtocolAlgorithm: ?[]const u8 = null,
    Name: []const u8 = "",
    UseCount: i32 = 0,
    Encoding: []const u8 = "",
    Resolution: VideoResolution2 = .{},
    RateControl: ?VideoRateControl2 = null,
    Multicast: ?MulticastConfiguration = null,
    Quality: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoEncoder2Configuration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token", "GovLength", "AnchorFrameDistance", "Profile", "GuaranteedFrameRate", "Signed", "SecureStreamingProtocolAlgorithm"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Encoding = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Resolution = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RateControl = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Multicast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Quality = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoResolution2 = struct {
    Width: i32 = 0,
    Height: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoResolution2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Width = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Height = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoRateControl2 = struct {
    ConstantBitRate: ?bool = null,
    FrameRateLimit: f32 = 0.0,
    BitrateLimit: i32 = 0,
    AverageBitRate: ?i32 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoRateControl2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"ConstantBitRate"},
        .fields = .{
            .FrameRateLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BitrateLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AverageBitRate = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoEncoder2ConfigurationOptions = struct {
    GovLengthRange: ?[]const u8 = null,
    MaxAnchorFrameDistance: ?i32 = null,
    FrameRatesSupported: ?[]const u8 = null,
    ProfilesSupported: ?[]const u8 = null,
    ConstantBitRateSupported: ?bool = null,
    AverageBitRateSupported: ?bool = null,
    GuaranteedFrameRateSupported: ?bool = null,
    SecureStreamingProtocolAlgorithms: ?[]const u8 = null,
    SigningSupported: ?bool = null,
    Encoding: []const u8 = "",
    QualityRange: FloatRange = .{},
    ResolutionsAvailable: []const VideoResolution2 = &.{},
    BitrateRange: IntRange = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoEncoder2ConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"GovLengthRange", "MaxAnchorFrameDistance", "FrameRatesSupported", "ProfilesSupported", "ConstantBitRateSupported", "AverageBitRateSupported", "GuaranteedFrameRateSupported", "SecureStreamingProtocolAlgorithms", "SigningSupported"},
        .fields = .{
            .Encoding = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .QualityRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ResolutionsAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BitrateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioSourceConfiguration = struct {
    token: []const u8 = "",
    Name: []const u8 = "",
    UseCount: i32 = 0,
    SourceToken: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioSourceConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SourceToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioSourceConfigurationOptions = struct {
    InputTokensAvailable: []const []const u8 = &.{},
    Extension: ?AudioSourceOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "AudioSourceConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .InputTokensAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioSourceOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioSourceOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const AudioEncoderConfiguration = struct {
    token: []const u8 = "",
    Name: []const u8 = "",
    UseCount: i32 = 0,
    Encoding: AudioEncoding = .G711,
    Bitrate: i32 = 0,
    SampleRate: i32 = 0,
    Multicast: MulticastConfiguration = .{},
    SessionTimeout: xsd.Duration = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioEncoderConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Encoding = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Bitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SampleRate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Multicast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SessionTimeout = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioEncoderConfigurationOptions = struct {
    Options: []const AudioEncoderConfigurationOption = &.{},
    pub const xml_meta = .{
        .element_name = "AudioEncoderConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Options = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioEncoderConfigurationOption = struct {
    Encoding: AudioEncoding = .G711,
    BitrateList: IntItems = .{},
    SampleRateList: IntItems = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioEncoderConfigurationOption",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Encoding = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BitrateList = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SampleRateList = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioEncoder2Configuration = struct {
    token: []const u8 = "",
    SecureStreamingProtocolAlgorithm: ?[]const u8 = null,
    Name: []const u8 = "",
    UseCount: i32 = 0,
    Encoding: []const u8 = "",
    Multicast: ?MulticastConfiguration = null,
    Bitrate: i32 = 0,
    SampleRate: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioEncoder2Configuration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token", "SecureStreamingProtocolAlgorithm"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Encoding = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Multicast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Bitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SampleRate = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioEncoder2ConfigurationOptions = struct {
    SecureStreamingProtocolAlgorithms: ?[]const u8 = null,
    Encoding: []const u8 = "",
    BitrateList: IntItems = .{},
    SampleRateList: IntItems = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioEncoder2ConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"SecureStreamingProtocolAlgorithms"},
        .fields = .{
            .Encoding = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BitrateList = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SampleRateList = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoAnalyticsConfiguration = struct {
    token: []const u8 = "",
    Name: []const u8 = "",
    UseCount: i32 = 0,
    AnalyticsEngineConfiguration: AnalyticsEngineConfiguration = .{},
    RuleEngineConfiguration: RuleEngineConfiguration = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoAnalyticsConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AnalyticsEngineConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RuleEngineConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MetadataConfiguration = struct {
    token: []const u8 = "",
    CompressionType: ?[]const u8 = null,
    GeoLocation: ?bool = null,
    ShapePolygon: ?bool = null,
    SecureStreamingProtocolAlgorithm: ?[]const u8 = null,
    Name: []const u8 = "",
    UseCount: i32 = 0,
    PTZStatus: ?PTZFilter = null,
    Events: ?EventSubscription = null,
    Analytics: ?bool = null,
    Multicast: MulticastConfiguration = .{},
    SessionTimeout: xsd.Duration = .{},
    any: []const xml_any.Any = &.{},
    AnalyticsEngineConfiguration: ?AnalyticsEngineConfiguration = null,
    SensorData: ?SensorDataFilter = null,
    Extension: ?MetadataConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "MetadataConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token", "CompressionType", "GeoLocation", "ShapePolygon", "SecureStreamingProtocolAlgorithm"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PTZStatus = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Events = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Analytics = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Multicast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SessionTimeout = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AnalyticsEngineConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SensorData = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MetadataConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MetadataConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZFilter = struct {
    Status: bool = false,
    Position: bool = false,
    FieldOfView: ?bool = null,
    pub const xml_meta = .{
        .element_name = "PTZFilter",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Status = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Position = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FieldOfView = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SensorDataFilter = struct {
    SensorID: []const []const u8 = &.{},
    Type: []const []const u8 = &.{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SensorDataFilter",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SensorID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const EventSubscription = struct {
    pub const Inline_SubscriptionPolicy = struct {
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "SubscriptionPolicy",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
        };
    };

    Filter: ?xml_any.Any = null,
    SubscriptionPolicy: ?Inline_SubscriptionPolicy = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "EventSubscription",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Filter = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SubscriptionPolicy = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MetadataConfigurationOptions = struct {
    GeoLocation: ?bool = null,
    MaxContentFilterSize: ?i32 = null,
    SecureStreamingProtocolAlgorithms: ?[]const u8 = null,
    PTZStatusFilterOptions: PTZStatusFilterOptions = .{},
    SensorDataFilterOptions: ?SensorDataFilterOptions = null,
    any: []const xml_any.Any = &.{},
    Extension: ?MetadataConfigurationOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "MetadataConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"GeoLocation", "MaxContentFilterSize", "SecureStreamingProtocolAlgorithms"},
        .fields = .{
            .PTZStatusFilterOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SensorDataFilterOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MetadataConfigurationOptionsExtension = struct {
    CompressionType: []const []const u8 = &.{},
    Extension: ?MetadataConfigurationOptionsExtension2 = null,
    pub const xml_meta = .{
        .element_name = "MetadataConfigurationOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .CompressionType = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MetadataConfigurationOptionsExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MetadataConfigurationOptionsExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZStatusFilterOptions = struct {
    PanTiltStatusSupported: bool = false,
    ZoomStatusSupported: bool = false,
    any: []const xml_any.Any = &.{},
    PanTiltPositionSupported: ?bool = null,
    ZoomPositionSupported: ?bool = null,
    Extension: ?PTZStatusFilterOptionsExtension = null,
    FieldOfViewSupported: ?bool = null,
    pub const xml_meta = .{
        .element_name = "PTZStatusFilterOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PanTiltStatusSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ZoomStatusSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PanTiltPositionSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ZoomPositionSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FieldOfViewSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZStatusFilterOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZStatusFilterOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const SensorDataFilterOptions = struct {
    SensorIDFilterSupported: bool = false,
    TypeFilterSupported: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SensorDataFilterOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SensorIDFilterSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TypeFilterSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoOutput = struct {
    token: []const u8 = "",
    Layout: Layout = .{},
    Resolution: ?VideoResolution = null,
    RefreshRate: ?f32 = null,
    AspectRatio: ?f32 = null,
    Extension: ?VideoOutputExtension = null,
    pub const xml_meta = .{
        .element_name = "VideoOutput",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Layout = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Resolution = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RefreshRate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AspectRatio = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoOutputExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoOutputExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const VideoOutputConfiguration = struct {
    token: []const u8 = "",
    Name: []const u8 = "",
    UseCount: i32 = 0,
    OutputToken: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoOutputConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .OutputToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoOutputConfigurationOptions = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoOutputConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const VideoDecoderConfigurationOptions = struct {
    JpegDecOptions: ?JpegDecOptions = null,
    H264DecOptions: ?H264DecOptions = null,
    Mpeg4DecOptions: ?Mpeg4DecOptions = null,
    Extension: ?VideoDecoderConfigurationOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "VideoDecoderConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .JpegDecOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .H264DecOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Mpeg4DecOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const H264DecOptions = struct {
    ResolutionsAvailable: []const VideoResolution = &.{},
    SupportedH264Profiles: []const H264Profile = &.{},
    SupportedInputBitrate: IntRange = .{},
    SupportedFrameRate: IntRange = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "H264DecOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ResolutionsAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedH264Profiles = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedInputBitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedFrameRate = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const JpegDecOptions = struct {
    ResolutionsAvailable: []const VideoResolution = &.{},
    SupportedInputBitrate: IntRange = .{},
    SupportedFrameRate: IntRange = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "JpegDecOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ResolutionsAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedInputBitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedFrameRate = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Mpeg4DecOptions = struct {
    ResolutionsAvailable: []const VideoResolution = &.{},
    SupportedMpeg4Profiles: []const Mpeg4Profile = &.{},
    SupportedInputBitrate: IntRange = .{},
    SupportedFrameRate: IntRange = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Mpeg4DecOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ResolutionsAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedMpeg4Profiles = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedInputBitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedFrameRate = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoDecoderConfigurationOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoDecoderConfigurationOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const AudioOutput = struct {
    token: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioOutput",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
    };
};

pub const AudioOutputConfiguration = struct {
    token: []const u8 = "",
    Name: []const u8 = "",
    UseCount: i32 = 0,
    OutputToken: []const u8 = "",
    SendPrimacy: ?[]const u8 = null,
    OutputLevel: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioOutputConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .OutputToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SendPrimacy = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .OutputLevel = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FrequencyDecibelPair = struct {
    CenterFrequency: i32 = 0,
    Decibel: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "FrequencyDecibelPair",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .CenterFrequency = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Decibel = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const EQPreset = struct {
    Token: []const u8 = "",
    Name: []const u8 = "",
    isDefault: bool = false,
    ScheduleToken: ?[]const u8 = null,
    isFrequencyDecibelEditable: bool = false,
    FrequencyDecibelPair: []const FrequencyDecibelPair = &.{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "EQPreset",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Token = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .isDefault = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ScheduleToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .isFrequencyDecibelEditable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FrequencyDecibelPair = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioOutputConfigurationOptions = struct {
    OutputTokensAvailable: []const []const u8 = &.{},
    SendPrimacyOptions: []const []const u8 = &.{},
    OutputLevelRange: IntRange = .{},
    EQPresetScheduleSupport: ?bool = null,
    EQPresets: []const EQPreset = &.{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioOutputConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .OutputTokensAvailable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SendPrimacyOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .OutputLevelRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EQPresetScheduleSupport = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EQPresets = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioDecoderConfiguration = struct {
    token: []const u8 = "",
    Name: []const u8 = "",
    UseCount: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioDecoderConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioDecoderConfigurationOptions = struct {
    AACDecOptions: ?AACDecOptions = null,
    G711DecOptions: ?G711DecOptions = null,
    G726DecOptions: ?G726DecOptions = null,
    Extension: ?AudioDecoderConfigurationOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "AudioDecoderConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AACDecOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .G711DecOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .G726DecOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const G711DecOptions = struct {
    Bitrate: IntItems = .{},
    SampleRateRange: IntItems = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "G711DecOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Bitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SampleRateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AACDecOptions = struct {
    Bitrate: IntItems = .{},
    SampleRateRange: IntItems = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AACDecOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Bitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SampleRateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const G726DecOptions = struct {
    Bitrate: IntItems = .{},
    SampleRateRange: IntItems = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "G726DecOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Bitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SampleRateRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioDecoderConfigurationOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioDecoderConfigurationOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const MulticastAudioDecoderConfiguration = struct {
    token: []const u8 = "",
    Name: []const u8 = "",
    UseCount: i32 = 0,
    Enable: bool = false,
    AudioOutputToken: []const []const u8 = &.{},
    Encoding: []const u8 = "",
    Bitrate: i32 = 0,
    SamplingRate: i32 = 0,
    Multicast: MulticastReceiverConfiguration = .{},
    RTPPayloadType: i32 = 0,
    Priority: i32 = 0,
    MediaFormatParameters: ?[]const u8 = null,
    SRTPPreSharedParameters: ?SRTPPreShared = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MulticastAudioDecoderConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Enable = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioOutputToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Encoding = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Bitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SamplingRate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Multicast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RTPPayloadType = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Priority = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MediaFormatParameters = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SRTPPreSharedParameters = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SRTPPreShared = struct {
    SecureStreamingProtocolAlgorithm: ?[]const u8 = null,
    SRTPPSK: []const u8 = "",
    ROCExtMapID: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SRTPPreShared",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"SecureStreamingProtocolAlgorithm"},
        .fields = .{
            .SRTPPSK = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ROCExtMapID = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MulticastReceiverConfiguration = struct {
    Address: IPAddress = .{},
    Port: i32 = 0,
    TTL: i32 = 0,
    InterfaceToken: []const []const u8 = &.{},
    SourceSpecificMulticast: ?IPAddress = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MulticastReceiverConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Port = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TTL = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .InterfaceToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SourceSpecificMulticast = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MulticastAudioDecoderConfigurationOptions = struct {
    SecureStreamingProtocolAlgorithms: ?[]const u8 = null,
    EncodingOptions: AudioDecoder2Options = .{},
    PriorityRange: IntRange = .{},
    AudioOutputTokens: ?[]const u8 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MulticastAudioDecoderConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"SecureStreamingProtocolAlgorithms"},
        .fields = .{
            .EncodingOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PriorityRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioOutputTokens = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioDecoder2Options = struct {
    Encoding: []const u8 = "",
    BitrateList: IntItems = .{},
    SampleRateList: IntItems = .{},
    RTPPayloadType: ?i32 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioDecoder2Options",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Encoding = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BitrateList = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SampleRateList = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RTPPayloadType = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MulticastConfiguration = struct {
    Address: IPAddress = .{},
    Port: i32 = 0,
    TTL: i32 = 0,
    AutoStart: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MulticastConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Port = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TTL = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AutoStart = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const StreamSetup = struct {
    Stream: StreamType = .@"RTP-Unicast",
    Transport: Transport = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "StreamSetup",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Stream = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Transport = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Transport = struct {
    pub const Inline_Tunnel = struct {
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Tunnel",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
        };
    };

    Protocol: TransportProtocol = .UDP,
    Tunnel: ?Inline_Tunnel = null,
    pub const xml_meta = .{
        .element_name = "Transport",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Protocol = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Tunnel = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MediaUri = struct {
    Uri: []const u8 = "",
    InvalidAfterConnect: bool = false,
    InvalidAfterReboot: bool = false,
    Timeout: xsd.Duration = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MediaUri",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Uri = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .InvalidAfterConnect = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .InvalidAfterReboot = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Timeout = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Scope = struct {
    ScopeDef: ScopeDefinition = .Fixed,
    ScopeItem: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "Scope",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ScopeDef = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ScopeItem = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkInterface = struct {
    token: []const u8 = "",
    Enabled: bool = false,
    Info: ?NetworkInterfaceInfo = null,
    Link: ?NetworkInterfaceLink = null,
    IPv4: ?IPv4NetworkInterface = null,
    IPv6: ?IPv6NetworkInterface = null,
    Extension: ?NetworkInterfaceExtension = null,
    pub const xml_meta = .{
        .element_name = "NetworkInterface",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Enabled = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Info = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Link = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPv4 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPv6 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkInterfaceExtension = struct {
    any: []const xml_any.Any = &.{},
    InterfaceType: i32 = 0,
    Dot3: []const Dot3Configuration = &.{},
    Dot11: []const Dot11Configuration = &.{},
    Extension: ?NetworkInterfaceExtension2 = null,
    pub const xml_meta = .{
        .element_name = "NetworkInterfaceExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .InterfaceType = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Dot3 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Dot11 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Dot3Configuration = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Dot3Configuration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const NetworkInterfaceExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "NetworkInterfaceExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const NetworkInterfaceLink = struct {
    AdminSettings: NetworkInterfaceConnectionSetting = .{},
    OperSettings: NetworkInterfaceConnectionSetting = .{},
    InterfaceType: i32 = 0,
    pub const xml_meta = .{
        .element_name = "NetworkInterfaceLink",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AdminSettings = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .OperSettings = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .InterfaceType = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkInterfaceConnectionSetting = struct {
    AutoNegotiation: bool = false,
    Speed: i32 = 0,
    Duplex: Duplex = .Full,
    pub const xml_meta = .{
        .element_name = "NetworkInterfaceConnectionSetting",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AutoNegotiation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Speed = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Duplex = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkInterfaceInfo = struct {
    Name: ?[]const u8 = null,
    HwAddress: []const u8 = "",
    MTU: ?i32 = null,
    pub const xml_meta = .{
        .element_name = "NetworkInterfaceInfo",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .HwAddress = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MTU = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IPv6NetworkInterface = struct {
    Enabled: bool = false,
    Config: ?IPv6Configuration = null,
    pub const xml_meta = .{
        .element_name = "IPv6NetworkInterface",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Enabled = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Config = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IPv4NetworkInterface = struct {
    Enabled: bool = false,
    Config: IPv4Configuration = .{},
    pub const xml_meta = .{
        .element_name = "IPv4NetworkInterface",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Enabled = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Config = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IPv4Configuration = struct {
    Manual: []const PrefixedIPv4Address = &.{},
    LinkLocal: ?PrefixedIPv4Address = null,
    FromDHCP: ?PrefixedIPv4Address = null,
    DHCP: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "IPv4Configuration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Manual = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .LinkLocal = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FromDHCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DHCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IPv6Configuration = struct {
    AcceptRouterAdvert: ?bool = null,
    DHCP: IPv6DHCPConfiguration = .Auto,
    Manual: []const PrefixedIPv6Address = &.{},
    LinkLocal: []const PrefixedIPv6Address = &.{},
    FromDHCP: []const PrefixedIPv6Address = &.{},
    FromRA: []const PrefixedIPv6Address = &.{},
    Extension: ?IPv6ConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "IPv6Configuration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AcceptRouterAdvert = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DHCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Manual = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .LinkLocal = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FromDHCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FromRA = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IPv6ConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "IPv6ConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const NetworkProtocol = struct {
    Name: NetworkProtocolType = .HTTP,
    Enabled: bool = false,
    Port: []const i32 = &.{},
    Extension: ?NetworkProtocolExtension = null,
    pub const xml_meta = .{
        .element_name = "NetworkProtocol",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Enabled = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Port = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkProtocolExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "NetworkProtocolExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const NetworkHost = struct {
    Type: NetworkHostType = .IPv4,
    IPv4Address: ?[]const u8 = null,
    IPv6Address: ?[]const u8 = null,
    DNSname: ?[]const u8 = null,
    Extension: ?NetworkHostExtension = null,
    pub const xml_meta = .{
        .element_name = "NetworkHost",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPv4Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPv6Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DNSname = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkHostExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "NetworkHostExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const IPAddress = struct {
    Type: IPType = .IPv4,
    IPv4Address: ?[]const u8 = null,
    IPv6Address: ?[]const u8 = null,
    pub const xml_meta = .{
        .element_name = "IPAddress",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPv4Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPv6Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PrefixedIPv4Address = struct {
    Address: []const u8 = "",
    PrefixLength: i32 = 0,
    pub const xml_meta = .{
        .element_name = "PrefixedIPv4Address",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PrefixLength = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PrefixedIPv6Address = struct {
    Address: []const u8 = "",
    PrefixLength: i32 = 0,
    pub const xml_meta = .{
        .element_name = "PrefixedIPv6Address",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PrefixLength = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const HostnameInformation = struct {
    FromDHCP: bool = false,
    Name: ?[]const u8 = null,
    Extension: ?HostnameInformationExtension = null,
    pub const xml_meta = .{
        .element_name = "HostnameInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .FromDHCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const HostnameInformationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "HostnameInformationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const DNSInformation = struct {
    FromDHCP: bool = false,
    SearchDomain: []const []const u8 = &.{},
    DNSFromDHCP: []const IPAddress = &.{},
    DNSManual: []const IPAddress = &.{},
    Extension: ?DNSInformationExtension = null,
    pub const xml_meta = .{
        .element_name = "DNSInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .FromDHCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SearchDomain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DNSFromDHCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DNSManual = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DNSInformationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "DNSInformationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const NTPInformation = struct {
    FromDHCP: bool = false,
    NTPFromDHCP: []const NetworkHost = &.{},
    NTPManual: []const NetworkHost = &.{},
    Extension: ?NTPInformationExtension = null,
    pub const xml_meta = .{
        .element_name = "NTPInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .FromDHCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .NTPFromDHCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .NTPManual = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NTPInformationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "NTPInformationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const DynamicDNSInformation = struct {
    Type: DynamicDNSType = .NoUpdate,
    Name: ?[]const u8 = null,
    TTL: ?xsd.Duration = null,
    Extension: ?DynamicDNSInformationExtension = null,
    pub const xml_meta = .{
        .element_name = "DynamicDNSInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TTL = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DynamicDNSInformationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "DynamicDNSInformationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const NetworkInterfaceSetConfiguration = struct {
    Enabled: ?bool = null,
    Link: ?NetworkInterfaceConnectionSetting = null,
    MTU: ?i32 = null,
    IPv4: ?IPv4NetworkInterfaceSetConfiguration = null,
    IPv6: ?IPv6NetworkInterfaceSetConfiguration = null,
    Extension: ?NetworkInterfaceSetConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "NetworkInterfaceSetConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Enabled = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Link = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MTU = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPv4 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPv6 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkInterfaceSetConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    Dot3: []const Dot3Configuration = &.{},
    Dot11: []const Dot11Configuration = &.{},
    Extension: ?NetworkInterfaceSetConfigurationExtension2 = null,
    pub const xml_meta = .{
        .element_name = "NetworkInterfaceSetConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Dot3 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Dot11 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IPv6NetworkInterfaceSetConfiguration = struct {
    Enabled: ?bool = null,
    AcceptRouterAdvert: ?bool = null,
    Manual: []const PrefixedIPv6Address = &.{},
    DHCP: ?IPv6DHCPConfiguration = null,
    pub const xml_meta = .{
        .element_name = "IPv6NetworkInterfaceSetConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Enabled = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AcceptRouterAdvert = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Manual = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DHCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IPv4NetworkInterfaceSetConfiguration = struct {
    Enabled: ?bool = null,
    Manual: []const PrefixedIPv4Address = &.{},
    DHCP: ?bool = null,
    pub const xml_meta = .{
        .element_name = "IPv4NetworkInterfaceSetConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Enabled = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Manual = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DHCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkGateway = struct {
    IPv4Address: []const []const u8 = &.{},
    IPv6Address: []const []const u8 = &.{},
    pub const xml_meta = .{
        .element_name = "NetworkGateway",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .IPv4Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPv6Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkZeroConfiguration = struct {
    InterfaceToken: []const u8 = "",
    Enabled: bool = false,
    Addresses: []const []const u8 = &.{},
    Extension: ?NetworkZeroConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "NetworkZeroConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .InterfaceToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Enabled = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Addresses = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkZeroConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    Additional: []const NetworkZeroConfiguration = &.{},
    Extension: ?NetworkZeroConfigurationExtension2 = null,
    pub const xml_meta = .{
        .element_name = "NetworkZeroConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Additional = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkZeroConfigurationExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "NetworkZeroConfigurationExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const IPAddressFilter = struct {
    Type: IPAddressFilterType = .Allow,
    IPv4Address: []const PrefixedIPv4Address = &.{},
    IPv6Address: []const PrefixedIPv6Address = &.{},
    Extension: ?IPAddressFilterExtension = null,
    pub const xml_meta = .{
        .element_name = "IPAddressFilter",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPv4Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPv6Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IPAddressFilterExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "IPAddressFilterExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Dot11Configuration = struct {
    SSID: []const u8 = "",
    Mode: Dot11StationMode = .@"Ad-hoc",
    Alias: []const u8 = "",
    Priority: i64 = 0,
    Security: Dot11SecurityConfiguration = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Dot11Configuration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SSID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Alias = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Priority = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Security = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Dot11SecurityConfiguration = struct {
    Mode: Dot11SecurityMode = .None,
    Algorithm: ?Dot11Cipher = null,
    PSK: ?Dot11PSKSet = null,
    Dot1X: ?[]const u8 = null,
    Extension: ?Dot11SecurityConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "Dot11SecurityConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Algorithm = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PSK = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Dot1X = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Dot11SecurityConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Dot11SecurityConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Dot11PSKSet = struct {
    Key: ?[]const u8 = null,
    Passphrase: ?[]const u8 = null,
    Extension: ?Dot11PSKSetExtension = null,
    pub const xml_meta = .{
        .element_name = "Dot11PSKSet",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Key = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Passphrase = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Dot11PSKSetExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Dot11PSKSetExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const NetworkInterfaceSetConfigurationExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "NetworkInterfaceSetConfigurationExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Dot11Capabilities = struct {
    TKIP: bool = false,
    ScanAvailableNetworks: bool = false,
    MultipleConfiguration: bool = false,
    AdHocStationMode: bool = false,
    WEP: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Dot11Capabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .TKIP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ScanAvailableNetworks = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MultipleConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AdHocStationMode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WEP = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Dot11Status = struct {
    SSID: []const u8 = "",
    BSSID: ?[]const u8 = null,
    PairCipher: ?Dot11Cipher = null,
    GroupCipher: ?Dot11Cipher = null,
    SignalStrength: ?Dot11SignalStrength = null,
    ActiveConfigAlias: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Dot11Status",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SSID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BSSID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PairCipher = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .GroupCipher = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SignalStrength = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ActiveConfigAlias = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Dot11AvailableNetworks = struct {
    SSID: []const u8 = "",
    BSSID: ?[]const u8 = null,
    AuthAndMangementSuite: []const Dot11AuthAndMangementSuite = &.{},
    PairCipher: []const Dot11Cipher = &.{},
    GroupCipher: []const Dot11Cipher = &.{},
    SignalStrength: ?Dot11SignalStrength = null,
    Extension: ?Dot11AvailableNetworksExtension = null,
    pub const xml_meta = .{
        .element_name = "Dot11AvailableNetworks",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SSID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BSSID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AuthAndMangementSuite = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PairCipher = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .GroupCipher = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SignalStrength = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Dot11AvailableNetworksExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Dot11AvailableNetworksExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Capabilities = struct {
    Analytics: ?AnalyticsCapabilities = null,
    Device: ?DeviceCapabilities = null,
    Events: ?EventCapabilities = null,
    Imaging: ?ImagingCapabilities = null,
    Media: ?MediaCapabilities = null,
    PTZ: ?PTZCapabilities = null,
    Extension: ?CapabilitiesExtension = null,
    pub const xml_meta = .{
        .element_name = "Capabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Analytics = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Device = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Events = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Imaging = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Media = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PTZ = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const CapabilitiesExtension = struct {
    any: []const xml_any.Any = &.{},
    DeviceIO: ?DeviceIOCapabilities = null,
    Display: ?DisplayCapabilities = null,
    Recording: ?RecordingCapabilities = null,
    Search: ?SearchCapabilities = null,
    Replay: ?ReplayCapabilities = null,
    Receiver: ?ReceiverCapabilities = null,
    AnalyticsDevice: ?AnalyticsDeviceCapabilities = null,
    Extensions: ?CapabilitiesExtension2 = null,
    pub const xml_meta = .{
        .element_name = "CapabilitiesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .DeviceIO = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Display = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Recording = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Search = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Replay = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Receiver = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AnalyticsDevice = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extensions = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const CapabilitiesExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "CapabilitiesExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const AnalyticsCapabilities = struct {
    XAddr: []const u8 = "",
    RuleSupport: bool = false,
    AnalyticsModuleSupport: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AnalyticsCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RuleSupport = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AnalyticsModuleSupport = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DeviceCapabilities = struct {
    XAddr: []const u8 = "",
    Network: ?NetworkCapabilities = null,
    System: ?SystemCapabilities = null,
    IO: ?IOCapabilities = null,
    Security: ?SecurityCapabilities = null,
    Extension: ?DeviceCapabilitiesExtension = null,
    pub const xml_meta = .{
        .element_name = "DeviceCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Network = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .System = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IO = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Security = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DeviceCapabilitiesExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "DeviceCapabilitiesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const EventCapabilities = struct {
    XAddr: []const u8 = "",
    WSSubscriptionPolicySupport: bool = false,
    WSPullPointSupport: bool = false,
    WSPausableSubscriptionManagerInterfaceSupport: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "EventCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WSSubscriptionPolicySupport = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WSPullPointSupport = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WSPausableSubscriptionManagerInterfaceSupport = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IOCapabilities = struct {
    InputConnectors: ?i32 = null,
    RelayOutputs: ?i32 = null,
    Extension: ?IOCapabilitiesExtension = null,
    pub const xml_meta = .{
        .element_name = "IOCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .InputConnectors = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RelayOutputs = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IOCapabilitiesExtension = struct {
    any: []const xml_any.Any = &.{},
    Auxiliary: ?bool = null,
    AuxiliaryCommands: []const []const u8 = &.{},
    Extension: IOCapabilitiesExtension2 = .{},
    pub const xml_meta = .{
        .element_name = "IOCapabilitiesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Auxiliary = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AuxiliaryCommands = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IOCapabilitiesExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "IOCapabilitiesExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const MediaCapabilities = struct {
    XAddr: []const u8 = "",
    StreamingCapabilities: RealTimeStreamingCapabilities = .{},
    any: []const xml_any.Any = &.{},
    Extension: ?MediaCapabilitiesExtension = null,
    pub const xml_meta = .{
        .element_name = "MediaCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .StreamingCapabilities = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MediaCapabilitiesExtension = struct {
    ProfileCapabilities: ProfileCapabilities = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MediaCapabilitiesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ProfileCapabilities = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RealTimeStreamingCapabilities = struct {
    RTPMulticast: ?bool = null,
    RTP_TCP: ?bool = null,
    RTP_RTSP_TCP: ?bool = null,
    Extension: ?RealTimeStreamingCapabilitiesExtension = null,
    pub const xml_meta = .{
        .element_name = "RealTimeStreamingCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .RTPMulticast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RTP_TCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RTP_RTSP_TCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RealTimeStreamingCapabilitiesExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RealTimeStreamingCapabilitiesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ProfileCapabilities = struct {
    MaximumNumberOfProfiles: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ProfileCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .MaximumNumberOfProfiles = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkCapabilities = struct {
    IPFilter: ?bool = null,
    ZeroConfiguration: ?bool = null,
    IPVersion6: ?bool = null,
    DynDNS: ?bool = null,
    Extension: ?NetworkCapabilitiesExtension = null,
    pub const xml_meta = .{
        .element_name = "NetworkCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .IPFilter = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ZeroConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IPVersion6 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DynDNS = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkCapabilitiesExtension = struct {
    any: []const xml_any.Any = &.{},
    Dot11Configuration: ?bool = null,
    Extension: ?NetworkCapabilitiesExtension2 = null,
    pub const xml_meta = .{
        .element_name = "NetworkCapabilitiesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Dot11Configuration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NetworkCapabilitiesExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "NetworkCapabilitiesExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const SecurityCapabilities = struct {
    @"TLS1.1": bool = false,
    @"TLS1.2": bool = false,
    OnboardKeyGeneration: bool = false,
    AccessPolicyConfig: bool = false,
    @"X.509Token": bool = false,
    SAMLToken: bool = false,
    KerberosToken: bool = false,
    RELToken: bool = false,
    any: []const xml_any.Any = &.{},
    Extension: ?SecurityCapabilitiesExtension = null,
    pub const xml_meta = .{
        .element_name = "SecurityCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .@"TLS1.1" = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .@"TLS1.2" = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .OnboardKeyGeneration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AccessPolicyConfig = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .@"X.509Token" = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SAMLToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .KerberosToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RELToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SecurityCapabilitiesExtension = struct {
    @"TLS1.0": bool = false,
    Extension: ?SecurityCapabilitiesExtension2 = null,
    pub const xml_meta = .{
        .element_name = "SecurityCapabilitiesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .@"TLS1.0" = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SecurityCapabilitiesExtension2 = struct {
    Dot1X: bool = false,
    SupportedEAPMethod: []const i32 = &.{},
    RemoteUserHandling: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SecurityCapabilitiesExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Dot1X = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedEAPMethod = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RemoteUserHandling = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SystemCapabilities = struct {
    DiscoveryResolve: bool = false,
    DiscoveryBye: bool = false,
    RemoteDiscovery: bool = false,
    SystemBackup: bool = false,
    SystemLogging: bool = false,
    FirmwareUpgrade: bool = false,
    SupportedVersions: []const OnvifVersion = &.{},
    Extension: ?SystemCapabilitiesExtension = null,
    pub const xml_meta = .{
        .element_name = "SystemCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .DiscoveryResolve = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DiscoveryBye = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RemoteDiscovery = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SystemBackup = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SystemLogging = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FirmwareUpgrade = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedVersions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SystemCapabilitiesExtension = struct {
    any: []const xml_any.Any = &.{},
    HttpFirmwareUpgrade: ?bool = null,
    HttpSystemBackup: ?bool = null,
    HttpSystemLogging: ?bool = null,
    HttpSupportInformation: ?bool = null,
    Extension: ?SystemCapabilitiesExtension2 = null,
    pub const xml_meta = .{
        .element_name = "SystemCapabilitiesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .HttpFirmwareUpgrade = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .HttpSystemBackup = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .HttpSystemLogging = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .HttpSupportInformation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SystemCapabilitiesExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SystemCapabilitiesExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const OnvifVersion = struct {
    Major: i32 = 0,
    Minor: i32 = 0,
    pub const xml_meta = .{
        .element_name = "OnvifVersion",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Major = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Minor = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingCapabilities = struct {
    XAddr: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "ImagingCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZCapabilities = struct {
    XAddr: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DeviceIOCapabilities = struct {
    XAddr: []const u8 = "",
    VideoSources: i32 = 0,
    VideoOutputs: i32 = 0,
    AudioSources: i32 = 0,
    AudioOutputs: i32 = 0,
    RelayOutputs: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "DeviceIOCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VideoSources = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VideoOutputs = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioSources = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioOutputs = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RelayOutputs = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DisplayCapabilities = struct {
    XAddr: []const u8 = "",
    FixedLayout: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "DisplayCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FixedLayout = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingCapabilities = struct {
    XAddr: []const u8 = "",
    ReceiverSource: bool = false,
    MediaProfileSource: bool = false,
    DynamicRecordings: bool = false,
    DynamicTracks: bool = false,
    MaxStringLength: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ReceiverSource = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MediaProfileSource = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DynamicRecordings = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DynamicTracks = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxStringLength = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SearchCapabilities = struct {
    XAddr: []const u8 = "",
    MetadataSearch: bool = false,
    NLSearch: ?bool = null,
    ImageSearch: ?bool = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SearchCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MetadataSearch = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .NLSearch = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ImageSearch = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ReplayCapabilities = struct {
    XAddr: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ReplayCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ReceiverCapabilities = struct {
    XAddr: []const u8 = "",
    RTP_Multicast: bool = false,
    RTP_TCP: bool = false,
    RTP_RTSP_TCP: bool = false,
    SupportedReceivers: i32 = 0,
    MaximumRTSPURILength: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ReceiverCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RTP_Multicast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RTP_TCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RTP_RTSP_TCP = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedReceivers = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaximumRTSPURILength = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnalyticsDeviceCapabilities = struct {
    XAddr: []const u8 = "",
    RuleSupport: ?bool = null,
    Extension: ?AnalyticsDeviceExtension = null,
    pub const xml_meta = .{
        .element_name = "AnalyticsDeviceCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .XAddr = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RuleSupport = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnalyticsDeviceExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AnalyticsDeviceExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const SystemLog = struct {
    Binary: ?AttachmentData = null,
    String: ?[]const u8 = null,
    pub const xml_meta = .{
        .element_name = "SystemLog",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Binary = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .String = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SupportInformation = struct {
    Binary: ?AttachmentData = null,
    String: ?[]const u8 = null,
    pub const xml_meta = .{
        .element_name = "SupportInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Binary = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .String = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const BinaryData = struct {
    contentType: ?[]const u8 = null,
    Data: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "BinaryData",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"contentType"},
        .fields = .{
            .Data = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AttachmentData = struct {
    contentType: ?[]const u8 = null,
    Include: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "AttachmentData",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"contentType"},
        .fields = .{
            .Include = .{ .ns = "http://www.w3.org/2004/08/xop/include" },
        },
    };
};

pub const BackupFile = struct {
    Name: []const u8 = "",
    Data: AttachmentData = .{},
    pub const xml_meta = .{
        .element_name = "BackupFile",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Data = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SystemLogUriList = struct {
    SystemLog: []const SystemLogUri = &.{},
    pub const xml_meta = .{
        .element_name = "SystemLogUriList",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SystemLog = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SystemLogUri = struct {
    Type: SystemLogType = .System,
    Uri: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SystemLogUri",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Uri = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SystemDateTime = struct {
    DateTimeType: SetDateTimeType = .Manual,
    DaylightSavings: bool = false,
    TimeZone: ?TimeZone = null,
    UTCDateTime: ?DateTime = null,
    LocalDateTime: ?DateTime = null,
    Extension: ?SystemDateTimeExtension = null,
    pub const xml_meta = .{
        .element_name = "SystemDateTime",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .DateTimeType = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DaylightSavings = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TimeZone = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UTCDateTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .LocalDateTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SystemDateTimeExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SystemDateTimeExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const DateTime = struct {
    Time: Time = .{},
    Date: Date = .{},
    pub const xml_meta = .{
        .element_name = "DateTime",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Time = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Date = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Date = struct {
    Year: i32 = 0,
    Month: i32 = 0,
    Day: i32 = 0,
    pub const xml_meta = .{
        .element_name = "Date",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Year = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Month = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Day = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Time = struct {
    Hour: i32 = 0,
    Minute: i32 = 0,
    Second: i32 = 0,
    pub const xml_meta = .{
        .element_name = "Time",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Hour = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Minute = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Second = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const TimeZone = struct {
    TZ: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "TimeZone",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .TZ = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RemoteUser = struct {
    Username: []const u8 = "",
    Password: ?[]const u8 = null,
    UseDerivedPassword: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RemoteUser",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Username = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Password = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseDerivedPassword = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const UserRole = struct {
    Name: []const u8 = "",
    Functions: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "UserRole",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Functions = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const User = struct {
    Username: []const u8 = "",
    Password: ?[]const u8 = null,
    UserLevel: UserLevel = .Administrator,
    Extension: ?UserExtension = null,
    pub const xml_meta = .{
        .element_name = "User",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Username = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Password = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UserLevel = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const UserExtension = struct {
    Roles: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "UserExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Roles = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const CertificateGenerationParameters = struct {
    CertificateID: ?[]const u8 = null,
    Subject: ?[]const u8 = null,
    ValidNotBefore: ?[]const u8 = null,
    ValidNotAfter: ?[]const u8 = null,
    Extension: ?CertificateGenerationParametersExtension = null,
    pub const xml_meta = .{
        .element_name = "CertificateGenerationParameters",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .CertificateID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Subject = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ValidNotBefore = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ValidNotAfter = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const CertificateGenerationParametersExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "CertificateGenerationParametersExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Certificate = struct {
    CertificateID: []const u8 = "",
    Certificate: BinaryData = .{},
    pub const xml_meta = .{
        .element_name = "Certificate",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .CertificateID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Certificate = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const CertificateStatus = struct {
    CertificateID: []const u8 = "",
    Status: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "CertificateStatus",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .CertificateID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Status = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const CertificateWithPrivateKey = struct {
    CertificateID: ?[]const u8 = null,
    Certificate: BinaryData = .{},
    PrivateKey: BinaryData = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "CertificateWithPrivateKey",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .CertificateID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Certificate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PrivateKey = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const CertificateInformation = struct {
    CertificateID: []const u8 = "",
    IssuerDN: ?[]const u8 = null,
    SubjectDN: ?[]const u8 = null,
    KeyUsage: ?CertificateUsage = null,
    ExtendedKeyUsage: ?CertificateUsage = null,
    KeyLength: ?i32 = null,
    Version: ?[]const u8 = null,
    SerialNum: ?[]const u8 = null,
    SignatureAlgorithm: ?[]const u8 = null,
    Validity: ?DateTimeRange = null,
    Extension: ?CertificateInformationExtension = null,
    pub const xml_meta = .{
        .element_name = "CertificateInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .CertificateID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IssuerDN = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SubjectDN = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .KeyUsage = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ExtendedKeyUsage = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .KeyLength = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Version = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SerialNum = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SignatureAlgorithm = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Validity = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const CertificateUsage = struct {
    Critical: bool = false,
    _value: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "CertificateUsage",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Critical"},
    };
};

pub const CertificateInformationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "CertificateInformationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Dot1XConfiguration = struct {
    Dot1XConfigurationToken: []const u8 = "",
    Identity: []const u8 = "",
    AnonymousID: ?[]const u8 = null,
    EAPMethod: i32 = 0,
    CACertificateID: []const []const u8 = &.{},
    EAPMethodConfiguration: ?EAPMethodConfiguration = null,
    Extension: ?Dot1XConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "Dot1XConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Dot1XConfigurationToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Identity = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AnonymousID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EAPMethod = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .CACertificateID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EAPMethodConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Dot1XConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Dot1XConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const EAPMethodConfiguration = struct {
    TLSConfiguration: ?TLSConfiguration = null,
    Password: ?[]const u8 = null,
    Extension: ?EapMethodExtension = null,
    pub const xml_meta = .{
        .element_name = "EAPMethodConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .TLSConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Password = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const EapMethodExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "EapMethodExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const TLSConfiguration = struct {
    CertificateID: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "TLSConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .CertificateID = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const GenericEapPwdConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "GenericEapPwdConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const RelayOutputSettings = struct {
    Mode: RelayMode = .Monostable,
    DelayTime: xsd.Duration = .{},
    IdleState: RelayIdleState = .closed,
    pub const xml_meta = .{
        .element_name = "RelayOutputSettings",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DelayTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IdleState = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RelayOutput = struct {
    token: []const u8 = "",
    Properties: RelayOutputSettings = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RelayOutput",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Properties = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DigitalInput = struct {
    token: []const u8 = "",
    IdleState: ?DigitalIdleState = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "DigitalInput",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token", "IdleState"},
    };
};

pub const PTZNode = struct {
    token: []const u8 = "",
    FixedHomePosition: ?bool = null,
    GeoMove: ?bool = null,
    Name: ?[]const u8 = null,
    SupportedPTZSpaces: PTZSpaces = .{},
    MaximumNumberOfPresets: i32 = 0,
    HomeSupported: bool = false,
    AuxiliaryCommands: []const []const u8 = &.{},
    Extension: ?PTZNodeExtension = null,
    pub const xml_meta = .{
        .element_name = "PTZNode",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token", "FixedHomePosition", "GeoMove"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SupportedPTZSpaces = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaximumNumberOfPresets = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .HomeSupported = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AuxiliaryCommands = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZNodeExtension = struct {
    any: []const xml_any.Any = &.{},
    SupportedPresetTour: ?PTZPresetTourSupported = null,
    Extension: ?PTZNodeExtension2 = null,
    pub const xml_meta = .{
        .element_name = "PTZNodeExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SupportedPresetTour = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZNodeExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZNodeExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZPresetTourSupported = struct {
    MaximumNumberOfPresetTours: i32 = 0,
    PTZPresetTourOperation: []const PTZPresetTourOperation = &.{},
    Extension: ?PTZPresetTourSupportedExtension = null,
    pub const xml_meta = .{
        .element_name = "PTZPresetTourSupported",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .MaximumNumberOfPresetTours = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PTZPresetTourOperation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZPresetTourSupportedExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPresetTourSupportedExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZConfiguration = struct {
    token: []const u8 = "",
    MoveRamp: ?i32 = null,
    PresetRamp: ?i32 = null,
    PresetTourRamp: ?i32 = null,
    Name: []const u8 = "",
    UseCount: i32 = 0,
    NodeToken: []const u8 = "",
    DefaultAbsolutePantTiltPositionSpace: ?[]const u8 = null,
    DefaultAbsoluteZoomPositionSpace: ?[]const u8 = null,
    DefaultRelativePanTiltTranslationSpace: ?[]const u8 = null,
    DefaultRelativeZoomTranslationSpace: ?[]const u8 = null,
    DefaultContinuousPanTiltVelocitySpace: ?[]const u8 = null,
    DefaultContinuousZoomVelocitySpace: ?[]const u8 = null,
    DefaultPTZSpeed: ?PTZSpeed = null,
    DefaultPTZTimeout: ?xsd.Duration = null,
    PanTiltLimits: ?PanTiltLimits = null,
    ZoomLimits: ?ZoomLimits = null,
    Extension: ?PTZConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "PTZConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token", "MoveRamp", "PresetRamp", "PresetTourRamp"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .NodeToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultAbsolutePantTiltPositionSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultAbsoluteZoomPositionSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultRelativePanTiltTranslationSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultRelativeZoomTranslationSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultContinuousPanTiltVelocitySpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultContinuousZoomVelocitySpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultPTZSpeed = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultPTZTimeout = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PanTiltLimits = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ZoomLimits = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    PTControlDirection: ?PTControlDirection = null,
    Extension: ?PTZConfigurationExtension2 = null,
    pub const xml_meta = .{
        .element_name = "PTZConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PTControlDirection = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZConfigurationExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZConfigurationExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTControlDirection = struct {
    EFlip: ?EFlip = null,
    Reverse: ?Reverse = null,
    Extension: ?PTControlDirectionExtension = null,
    pub const xml_meta = .{
        .element_name = "PTControlDirection",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .EFlip = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Reverse = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTControlDirectionExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTControlDirectionExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const EFlip = struct {
    Mode: EFlipMode = .OFF,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "EFlip",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Reverse = struct {
    Mode: ReverseMode = .OFF,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Reverse",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZConfigurationOptions = struct {
    PTZRamps: ?[]const u8 = null,
    Spaces: PTZSpaces = .{},
    PTZTimeout: DurationRange = .{},
    any: []const xml_any.Any = &.{},
    PTControlDirection: ?PTControlDirectionOptions = null,
    Extension: ?PTZConfigurationOptions2 = null,
    pub const xml_meta = .{
        .element_name = "PTZConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"PTZRamps"},
        .fields = .{
            .Spaces = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PTZTimeout = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PTControlDirection = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZConfigurationOptions2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZConfigurationOptions2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTControlDirectionOptions = struct {
    EFlip: ?EFlipOptions = null,
    Reverse: ?ReverseOptions = null,
    Extension: ?PTControlDirectionOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "PTControlDirectionOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .EFlip = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Reverse = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTControlDirectionOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTControlDirectionOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const EFlipOptions = struct {
    Mode: []const EFlipMode = &.{},
    Extension: ?EFlipOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "EFlipOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const EFlipOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "EFlipOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ReverseOptions = struct {
    Mode: []const ReverseMode = &.{},
    Extension: ?ReverseOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "ReverseOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ReverseOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ReverseOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PanTiltLimits = struct {
    Range: Space2DDescription = .{},
    pub const xml_meta = .{
        .element_name = "PanTiltLimits",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Range = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ZoomLimits = struct {
    Range: Space1DDescription = .{},
    pub const xml_meta = .{
        .element_name = "ZoomLimits",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Range = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZSpaces = struct {
    AbsolutePanTiltPositionSpace: []const Space2DDescription = &.{},
    AbsoluteZoomPositionSpace: []const Space1DDescription = &.{},
    RelativePanTiltTranslationSpace: []const Space2DDescription = &.{},
    RelativeZoomTranslationSpace: []const Space1DDescription = &.{},
    ContinuousPanTiltVelocitySpace: []const Space2DDescription = &.{},
    ContinuousZoomVelocitySpace: []const Space1DDescription = &.{},
    PanTiltSpeedSpace: []const Space1DDescription = &.{},
    ZoomSpeedSpace: []const Space1DDescription = &.{},
    Extension: ?PTZSpacesExtension = null,
    pub const xml_meta = .{
        .element_name = "PTZSpaces",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AbsolutePanTiltPositionSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AbsoluteZoomPositionSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RelativePanTiltTranslationSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RelativeZoomTranslationSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ContinuousPanTiltVelocitySpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ContinuousZoomVelocitySpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PanTiltSpeedSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ZoomSpeedSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZSpacesExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZSpacesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Space2DDescription = struct {
    URI: []const u8 = "",
    XRange: FloatRange = .{},
    YRange: FloatRange = .{},
    pub const xml_meta = .{
        .element_name = "Space2DDescription",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .URI = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .XRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .YRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Space1DDescription = struct {
    URI: []const u8 = "",
    XRange: FloatRange = .{},
    pub const xml_meta = .{
        .element_name = "Space1DDescription",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .URI = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .XRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZSpeed = struct {
    PanTilt: ?Vector2D = null,
    Zoom: ?Vector1D = null,
    pub const xml_meta = .{
        .element_name = "PTZSpeed",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PanTilt = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Zoom = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZPreset = struct {
    token: ?[]const u8 = null,
    Name: ?[]const u8 = null,
    PTZPosition: ?PTZVector = null,
    pub const xml_meta = .{
        .element_name = "PTZPreset",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PTZPosition = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PresetTour = struct {
    token: ?[]const u8 = null,
    Name: ?[]const u8 = null,
    Status: PTZPresetTourStatus = .{},
    AutoStart: bool = false,
    StartingCondition: PTZPresetTourStartingCondition = .{},
    TourSpot: []const PTZPresetTourSpot = &.{},
    Extension: ?PTZPresetTourExtension = null,
    pub const xml_meta = .{
        .element_name = "PresetTour",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Status = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AutoStart = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .StartingCondition = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TourSpot = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZPresetTourExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPresetTourExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZPresetTourSpot = struct {
    PresetDetail: PTZPresetTourPresetDetail = .{},
    Speed: ?PTZSpeed = null,
    StayTime: ?xsd.Duration = null,
    Extension: ?PTZPresetTourSpotExtension = null,
    pub const xml_meta = .{
        .element_name = "PTZPresetTourSpot",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PresetDetail = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Speed = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .StayTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZPresetTourSpotExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPresetTourSpotExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZPresetTourPresetDetail = struct {
    PresetToken: ?[]const u8 = null,
    Home: ?bool = null,
    PTZPosition: ?PTZVector = null,
    TypeExtension: ?PTZPresetTourTypeExtension = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPresetTourPresetDetail",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PresetToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Home = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PTZPosition = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TypeExtension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZPresetTourTypeExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPresetTourTypeExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZPresetTourStatus = struct {
    State: PTZPresetTourState = .Idle,
    CurrentTourSpot: ?PTZPresetTourSpot = null,
    Extension: ?PTZPresetTourStatusExtension = null,
    pub const xml_meta = .{
        .element_name = "PTZPresetTourStatus",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .State = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .CurrentTourSpot = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZPresetTourStatusExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPresetTourStatusExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZPresetTourStartingCondition = struct {
    RandomPresetOrder: ?bool = null,
    RecurringTime: ?i32 = null,
    RecurringDuration: ?xsd.Duration = null,
    Direction: ?PTZPresetTourDirection = null,
    Extension: ?PTZPresetTourStartingConditionExtension = null,
    pub const xml_meta = .{
        .element_name = "PTZPresetTourStartingCondition",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"RandomPresetOrder"},
        .fields = .{
            .RecurringTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RecurringDuration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Direction = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZPresetTourStartingConditionExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPresetTourStartingConditionExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZPresetTourOptions = struct {
    AutoStart: bool = false,
    StartingCondition: PTZPresetTourStartingConditionOptions = .{},
    TourSpot: PTZPresetTourSpotOptions = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPresetTourOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AutoStart = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .StartingCondition = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TourSpot = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZPresetTourSpotOptions = struct {
    PresetDetail: PTZPresetTourPresetDetailOptions = .{},
    StayTime: DurationRange = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPresetTourSpotOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PresetDetail = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .StayTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZPresetTourPresetDetailOptions = struct {
    PresetToken: []const []const u8 = &.{},
    Home: ?bool = null,
    PanTiltPositionSpace: ?Space2DDescription = null,
    ZoomPositionSpace: ?Space1DDescription = null,
    Extension: ?PTZPresetTourPresetDetailOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "PTZPresetTourPresetDetailOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PresetToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Home = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PanTiltPositionSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ZoomPositionSpace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZPresetTourPresetDetailOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPresetTourPresetDetailOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZPresetTourStartingConditionOptions = struct {
    RecurringTime: ?IntRange = null,
    RecurringDuration: ?DurationRange = null,
    Direction: []const PTZPresetTourDirection = &.{},
    Extension: ?PTZPresetTourStartingConditionOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "PTZPresetTourStartingConditionOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .RecurringTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RecurringDuration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Direction = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZPresetTourStartingConditionOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPresetTourStartingConditionOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ImagingStatus = struct {
    FocusStatus: FocusStatus = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ImagingStatus",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .FocusStatus = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FocusStatus = struct {
    Position: f32 = 0.0,
    MoveStatus: MoveStatus = .IDLE,
    Error: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "FocusStatus",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Position = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MoveStatus = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Error = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FocusConfiguration = struct {
    AutoFocusMode: AutoFocusMode = .AUTO,
    DefaultSpeed: f32 = 0.0,
    NearLimit: f32 = 0.0,
    FarLimit: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "FocusConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AutoFocusMode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultSpeed = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .NearLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FarLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingSettings = struct {
    BacklightCompensation: ?BacklightCompensation = null,
    Brightness: ?f32 = null,
    ColorSaturation: ?f32 = null,
    Contrast: ?f32 = null,
    Exposure: ?Exposure = null,
    Focus: ?FocusConfiguration = null,
    IrCutFilter: ?IrCutFilterMode = null,
    Sharpness: ?f32 = null,
    WideDynamicRange: ?WideDynamicRange = null,
    WhiteBalance: ?WhiteBalance = null,
    Extension: ?ImagingSettingsExtension = null,
    pub const xml_meta = .{
        .element_name = "ImagingSettings",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .BacklightCompensation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Brightness = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ColorSaturation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Contrast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Exposure = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Focus = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IrCutFilter = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Sharpness = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WideDynamicRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WhiteBalance = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingSettingsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ImagingSettingsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Exposure = struct {
    Mode: ExposureMode = .AUTO,
    Priority: ExposurePriority = .LowNoise,
    Window: Rectangle = .{},
    MinExposureTime: f32 = 0.0,
    MaxExposureTime: f32 = 0.0,
    MinGain: f32 = 0.0,
    MaxGain: f32 = 0.0,
    MinIris: f32 = 0.0,
    MaxIris: f32 = 0.0,
    ExposureTime: f32 = 0.0,
    Gain: f32 = 0.0,
    Iris: f32 = 0.0,
    pub const xml_meta = .{
        .element_name = "Exposure",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Priority = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Window = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinIris = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxIris = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Gain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Iris = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const WideDynamicRange = struct {
    Mode: WideDynamicMode = .OFF,
    Level: f32 = 0.0,
    pub const xml_meta = .{
        .element_name = "WideDynamicRange",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const BacklightCompensation = struct {
    Mode: BacklightCompensationMode = .OFF,
    Level: f32 = 0.0,
    pub const xml_meta = .{
        .element_name = "BacklightCompensation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingOptions = struct {
    BacklightCompensation: BacklightCompensationOptions = .{},
    Brightness: FloatRange = .{},
    ColorSaturation: FloatRange = .{},
    Contrast: FloatRange = .{},
    Exposure: ExposureOptions = .{},
    Focus: FocusOptions = .{},
    IrCutFilterModes: []const IrCutFilterMode = &.{},
    Sharpness: FloatRange = .{},
    WideDynamicRange: WideDynamicRangeOptions = .{},
    WhiteBalance: WhiteBalanceOptions = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ImagingOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .BacklightCompensation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Brightness = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ColorSaturation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Contrast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Exposure = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Focus = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IrCutFilterModes = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Sharpness = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WideDynamicRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WhiteBalance = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const WideDynamicRangeOptions = struct {
    Mode: []const WideDynamicMode = &.{},
    Level: FloatRange = .{},
    pub const xml_meta = .{
        .element_name = "WideDynamicRangeOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const BacklightCompensationOptions = struct {
    Mode: []const WideDynamicMode = &.{},
    Level: FloatRange = .{},
    pub const xml_meta = .{
        .element_name = "BacklightCompensationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FocusOptions = struct {
    AutoFocusModes: []const AutoFocusMode = &.{},
    DefaultSpeed: FloatRange = .{},
    NearLimit: FloatRange = .{},
    FarLimit: FloatRange = .{},
    pub const xml_meta = .{
        .element_name = "FocusOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AutoFocusModes = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultSpeed = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .NearLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FarLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ExposureOptions = struct {
    Mode: []const ExposureMode = &.{},
    Priority: []const ExposurePriority = &.{},
    MinExposureTime: FloatRange = .{},
    MaxExposureTime: FloatRange = .{},
    MinGain: FloatRange = .{},
    MaxGain: FloatRange = .{},
    MinIris: FloatRange = .{},
    MaxIris: FloatRange = .{},
    ExposureTime: FloatRange = .{},
    Gain: FloatRange = .{},
    Iris: FloatRange = .{},
    pub const xml_meta = .{
        .element_name = "ExposureOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Priority = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinIris = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxIris = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Gain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Iris = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const WhiteBalanceOptions = struct {
    Mode: []const WhiteBalanceMode = &.{},
    YrGain: FloatRange = .{},
    YbGain: FloatRange = .{},
    pub const xml_meta = .{
        .element_name = "WhiteBalanceOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .YrGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .YbGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FocusMove = struct {
    Absolute: ?AbsoluteFocus = null,
    Relative: ?RelativeFocus = null,
    Continuous: ?ContinuousFocus = null,
    pub const xml_meta = .{
        .element_name = "FocusMove",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Absolute = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Relative = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Continuous = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AbsoluteFocus = struct {
    Position: f32 = 0.0,
    Speed: ?f32 = null,
    pub const xml_meta = .{
        .element_name = "AbsoluteFocus",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Position = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Speed = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RelativeFocus = struct {
    Distance: f32 = 0.0,
    Speed: ?f32 = null,
    pub const xml_meta = .{
        .element_name = "RelativeFocus",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Distance = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Speed = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ContinuousFocus = struct {
    Speed: f32 = 0.0,
    pub const xml_meta = .{
        .element_name = "ContinuousFocus",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Speed = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MoveOptions = struct {
    Absolute: ?AbsoluteFocusOptions = null,
    Relative: ?RelativeFocusOptions = null,
    Continuous: ?ContinuousFocusOptions = null,
    pub const xml_meta = .{
        .element_name = "MoveOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Absolute = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Relative = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Continuous = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AbsoluteFocusOptions = struct {
    Position: FloatRange = .{},
    Speed: ?FloatRange = null,
    pub const xml_meta = .{
        .element_name = "AbsoluteFocusOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Position = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Speed = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RelativeFocusOptions = struct {
    Distance: FloatRange = .{},
    Speed: FloatRange = .{},
    pub const xml_meta = .{
        .element_name = "RelativeFocusOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Distance = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Speed = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ContinuousFocusOptions = struct {
    Speed: FloatRange = .{},
    pub const xml_meta = .{
        .element_name = "ContinuousFocusOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Speed = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const WhiteBalance = struct {
    Mode: WhiteBalanceMode = .AUTO,
    CrGain: f32 = 0.0,
    CbGain: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "WhiteBalance",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .CrGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .CbGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingStatus20 = struct {
    FocusStatus20: ?FocusStatus20 = null,
    Extension: ?ImagingStatus20Extension = null,
    pub const xml_meta = .{
        .element_name = "ImagingStatus20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .FocusStatus20 = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingStatus20Extension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ImagingStatus20Extension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const FocusStatus20 = struct {
    Position: f32 = 0.0,
    MoveStatus: MoveStatus = .IDLE,
    Error: ?[]const u8 = null,
    Extension: ?FocusStatus20Extension = null,
    pub const xml_meta = .{
        .element_name = "FocusStatus20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Position = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MoveStatus = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Error = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FocusStatus20Extension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "FocusStatus20Extension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ImagingSettings20 = struct {
    BacklightCompensation: ?BacklightCompensation20 = null,
    Brightness: ?f32 = null,
    ColorSaturation: ?f32 = null,
    Contrast: ?f32 = null,
    Exposure: ?Exposure20 = null,
    Focus: ?FocusConfiguration20 = null,
    IrCutFilter: ?IrCutFilterMode = null,
    Sharpness: ?f32 = null,
    WideDynamicRange: ?WideDynamicRange20 = null,
    WhiteBalance: ?WhiteBalance20 = null,
    Extension: ?ImagingSettingsExtension20 = null,
    pub const xml_meta = .{
        .element_name = "ImagingSettings20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .BacklightCompensation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Brightness = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ColorSaturation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Contrast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Exposure = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Focus = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IrCutFilter = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Sharpness = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WideDynamicRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WhiteBalance = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingSettingsExtension20 = struct {
    any: []const xml_any.Any = &.{},
    ImageStabilization: ?ImageStabilization = null,
    Extension: ?ImagingSettingsExtension202 = null,
    pub const xml_meta = .{
        .element_name = "ImagingSettingsExtension20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ImageStabilization = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingSettingsExtension202 = struct {
    IrCutFilterAutoAdjustment: []const IrCutFilterAutoAdjustment = &.{},
    Extension: ?ImagingSettingsExtension203 = null,
    pub const xml_meta = .{
        .element_name = "ImagingSettingsExtension202",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .IrCutFilterAutoAdjustment = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingSettingsExtension203 = struct {
    ToneCompensation: ?ToneCompensation = null,
    Defogging: ?Defogging = null,
    NoiseReduction: ?NoiseReduction = null,
    Extension: ?ImagingSettingsExtension204 = null,
    pub const xml_meta = .{
        .element_name = "ImagingSettingsExtension203",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ToneCompensation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Defogging = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .NoiseReduction = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingSettingsExtension204 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ImagingSettingsExtension204",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ImageStabilization = struct {
    Mode: ImageStabilizationMode = .OFF,
    Level: ?f32 = null,
    Extension: ?ImageStabilizationExtension = null,
    pub const xml_meta = .{
        .element_name = "ImageStabilization",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImageStabilizationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ImageStabilizationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const IrCutFilterAutoAdjustment = struct {
    BoundaryType: []const u8 = "",
    BoundaryOffset: ?f32 = null,
    ResponseTime: ?xsd.Duration = null,
    Extension: ?IrCutFilterAutoAdjustmentExtension = null,
    pub const xml_meta = .{
        .element_name = "IrCutFilterAutoAdjustment",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .BoundaryType = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BoundaryOffset = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ResponseTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IrCutFilterAutoAdjustmentExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "IrCutFilterAutoAdjustmentExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const WideDynamicRange20 = struct {
    Mode: WideDynamicMode = .OFF,
    Level: ?f32 = null,
    pub const xml_meta = .{
        .element_name = "WideDynamicRange20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const BacklightCompensation20 = struct {
    Mode: BacklightCompensationMode = .OFF,
    Level: ?f32 = null,
    pub const xml_meta = .{
        .element_name = "BacklightCompensation20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Exposure20 = struct {
    Mode: ExposureMode = .AUTO,
    Priority: ?ExposurePriority = null,
    Window: ?Rectangle = null,
    MinExposureTime: ?f32 = null,
    MaxExposureTime: ?f32 = null,
    MinGain: ?f32 = null,
    MaxGain: ?f32 = null,
    MinIris: ?f32 = null,
    MaxIris: ?f32 = null,
    ExposureTime: ?f32 = null,
    Gain: ?f32 = null,
    Iris: ?f32 = null,
    pub const xml_meta = .{
        .element_name = "Exposure20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Priority = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Window = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinIris = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxIris = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Gain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Iris = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ToneCompensation = struct {
    Mode: []const u8 = "",
    Level: ?f32 = null,
    Extension: ?ToneCompensationExtension = null,
    pub const xml_meta = .{
        .element_name = "ToneCompensation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ToneCompensationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ToneCompensationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Defogging = struct {
    Mode: []const u8 = "",
    Level: ?f32 = null,
    Extension: ?DefoggingExtension = null,
    pub const xml_meta = .{
        .element_name = "Defogging",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DefoggingExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "DefoggingExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const NoiseReduction = struct {
    Level: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "NoiseReduction",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingOptions20 = struct {
    BacklightCompensation: ?BacklightCompensationOptions20 = null,
    Brightness: ?FloatRange = null,
    ColorSaturation: ?FloatRange = null,
    Contrast: ?FloatRange = null,
    Exposure: ?ExposureOptions20 = null,
    Focus: ?FocusOptions20 = null,
    IrCutFilterModes: []const IrCutFilterMode = &.{},
    Sharpness: ?FloatRange = null,
    WideDynamicRange: ?WideDynamicRangeOptions20 = null,
    WhiteBalance: ?WhiteBalanceOptions20 = null,
    Extension: ?ImagingOptions20Extension = null,
    pub const xml_meta = .{
        .element_name = "ImagingOptions20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .BacklightCompensation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Brightness = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ColorSaturation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Contrast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Exposure = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Focus = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IrCutFilterModes = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Sharpness = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WideDynamicRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .WhiteBalance = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingOptions20Extension = struct {
    any: []const xml_any.Any = &.{},
    ImageStabilization: ?ImageStabilizationOptions = null,
    Extension: ?ImagingOptions20Extension2 = null,
    pub const xml_meta = .{
        .element_name = "ImagingOptions20Extension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ImageStabilization = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingOptions20Extension2 = struct {
    IrCutFilterAutoAdjustment: ?IrCutFilterAutoAdjustmentOptions = null,
    Extension: ?ImagingOptions20Extension3 = null,
    pub const xml_meta = .{
        .element_name = "ImagingOptions20Extension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .IrCutFilterAutoAdjustment = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingOptions20Extension3 = struct {
    ToneCompensationOptions: ?ToneCompensationOptions = null,
    DefoggingOptions: ?DefoggingOptions = null,
    NoiseReductionOptions: ?NoiseReductionOptions = null,
    Extension: ?ImagingOptions20Extension4 = null,
    pub const xml_meta = .{
        .element_name = "ImagingOptions20Extension3",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ToneCompensationOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefoggingOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .NoiseReductionOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImagingOptions20Extension4 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ImagingOptions20Extension4",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ImageStabilizationOptions = struct {
    Mode: []const ImageStabilizationMode = &.{},
    Level: ?FloatRange = null,
    Extension: ?ImageStabilizationOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "ImageStabilizationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ImageStabilizationOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ImageStabilizationOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const IrCutFilterAutoAdjustmentOptions = struct {
    BoundaryType: []const []const u8 = &.{},
    BoundaryOffset: ?bool = null,
    ResponseTimeRange: ?DurationRange = null,
    Extension: ?IrCutFilterAutoAdjustmentOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "IrCutFilterAutoAdjustmentOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .BoundaryType = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BoundaryOffset = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ResponseTimeRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const IrCutFilterAutoAdjustmentOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "IrCutFilterAutoAdjustmentOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const WideDynamicRangeOptions20 = struct {
    Mode: []const WideDynamicMode = &.{},
    Level: ?FloatRange = null,
    pub const xml_meta = .{
        .element_name = "WideDynamicRangeOptions20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const BacklightCompensationOptions20 = struct {
    Mode: []const BacklightCompensationMode = &.{},
    Level: ?FloatRange = null,
    pub const xml_meta = .{
        .element_name = "BacklightCompensationOptions20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ExposureOptions20 = struct {
    Mode: []const ExposureMode = &.{},
    Priority: []const ExposurePriority = &.{},
    MinExposureTime: ?FloatRange = null,
    MaxExposureTime: ?FloatRange = null,
    MinGain: ?FloatRange = null,
    MaxGain: ?FloatRange = null,
    MinIris: ?FloatRange = null,
    MaxIris: ?FloatRange = null,
    ExposureTime: ?FloatRange = null,
    Gain: ?FloatRange = null,
    Iris: ?FloatRange = null,
    pub const xml_meta = .{
        .element_name = "ExposureOptions20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Priority = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MinIris = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxIris = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ExposureTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Gain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Iris = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MoveOptions20 = struct {
    Absolute: ?AbsoluteFocusOptions = null,
    Relative: ?RelativeFocusOptions20 = null,
    Continuous: ?ContinuousFocusOptions = null,
    pub const xml_meta = .{
        .element_name = "MoveOptions20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Absolute = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Relative = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Continuous = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RelativeFocusOptions20 = struct {
    Distance: FloatRange = .{},
    Speed: ?FloatRange = null,
    pub const xml_meta = .{
        .element_name = "RelativeFocusOptions20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Distance = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Speed = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const WhiteBalance20 = struct {
    Mode: WhiteBalanceMode = .AUTO,
    CrGain: ?f32 = null,
    CbGain: ?f32 = null,
    Extension: ?WhiteBalance20Extension = null,
    pub const xml_meta = .{
        .element_name = "WhiteBalance20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .CrGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .CbGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const WhiteBalance20Extension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "WhiteBalance20Extension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const FocusConfiguration20 = struct {
    AFMode: ?[]const u8 = null,
    AutoFocusMode: AutoFocusMode = .AUTO,
    DefaultSpeed: ?f32 = null,
    NearLimit: ?f32 = null,
    FarLimit: ?f32 = null,
    Extension: ?FocusConfiguration20Extension = null,
    pub const xml_meta = .{
        .element_name = "FocusConfiguration20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"AFMode"},
        .fields = .{
            .AutoFocusMode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultSpeed = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .NearLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FarLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FocusConfiguration20Extension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "FocusConfiguration20Extension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const WhiteBalanceOptions20 = struct {
    Mode: []const WhiteBalanceMode = &.{},
    YrGain: ?FloatRange = null,
    YbGain: ?FloatRange = null,
    Extension: ?WhiteBalanceOptions20Extension = null,
    pub const xml_meta = .{
        .element_name = "WhiteBalanceOptions20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .YrGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .YbGain = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const WhiteBalanceOptions20Extension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "WhiteBalanceOptions20Extension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const FocusOptions20 = struct {
    AutoFocusModes: []const AutoFocusMode = &.{},
    DefaultSpeed: ?FloatRange = null,
    NearLimit: ?FloatRange = null,
    FarLimit: ?FloatRange = null,
    Extension: ?FocusOptions20Extension = null,
    pub const xml_meta = .{
        .element_name = "FocusOptions20",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AutoFocusModes = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DefaultSpeed = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .NearLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FarLimit = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FocusOptions20Extension = struct {
    any: []const xml_any.Any = &.{},
    AFModes: ?[]const u8 = null,
    pub const xml_meta = .{
        .element_name = "FocusOptions20Extension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AFModes = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ToneCompensationOptions = struct {
    Mode: []const []const u8 = &.{},
    Level: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ToneCompensationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DefoggingOptions = struct {
    Mode: []const []const u8 = &.{},
    Level: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "DefoggingOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const NoiseReductionOptions = struct {
    Level: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "NoiseReductionOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Level = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MessageExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MessageExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ItemList = struct {
    pub const Inline_SimpleItem = struct {
        Name: []const u8 = "",
        Value: []const u8 = "",
        pub const xml_meta = .{
            .element_name = "SimpleItem",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
            .attributes = &.{"Name", "Value"},
        };
    };

    pub const Inline_ElementItem = struct {
        Name: []const u8 = "",
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "ElementItem",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
            .attributes = &.{"Name"},
        };
    };

    SimpleItem: []const Inline_SimpleItem = &.{},
    ElementItem: []const Inline_ElementItem = &.{},
    Extension: ?ItemListExtension = null,
    pub const xml_meta = .{
        .element_name = "ItemList",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SimpleItem = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ElementItem = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ItemListExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ItemListExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const MessageDescription = struct {
    IsProperty: ?bool = null,
    Source: ?ItemListDescription = null,
    Key: ?ItemListDescription = null,
    Data: ?ItemListDescription = null,
    Extension: ?MessageDescriptionExtension = null,
    pub const xml_meta = .{
        .element_name = "MessageDescription",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"IsProperty"},
        .fields = .{
            .Source = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Key = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Data = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MessageDescriptionExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MessageDescriptionExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ItemListDescription = struct {
    pub const Inline_SimpleItemDescription = struct {
        Name: []const u8 = "",
        Type: []const u8 = "",
        pub const xml_meta = .{
            .element_name = "SimpleItemDescription",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
            .attributes = &.{"Name", "Type"},
        };
    };

    pub const Inline_ElementItemDescription = struct {
        Name: []const u8 = "",
        Type: []const u8 = "",
        pub const xml_meta = .{
            .element_name = "ElementItemDescription",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
            .attributes = &.{"Name", "Type"},
        };
    };

    SimpleItemDescription: []const Inline_SimpleItemDescription = &.{},
    ElementItemDescription: []const Inline_ElementItemDescription = &.{},
    Extension: ?ItemListDescriptionExtension = null,
    pub const xml_meta = .{
        .element_name = "ItemListDescription",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SimpleItemDescription = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ElementItemDescription = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ItemListDescriptionExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ItemListDescriptionExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Polyline = struct {
    Point: []const Vector = &.{},
    pub const xml_meta = .{
        .element_name = "Polyline",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Point = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnalyticsEngineConfiguration = struct {
    AnalyticsModule: []const Config = &.{},
    Extension: ?AnalyticsEngineConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "AnalyticsEngineConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AnalyticsModule = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnalyticsEngineConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AnalyticsEngineConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const RuleEngineConfiguration = struct {
    Rule: []const Config = &.{},
    Extension: ?RuleEngineConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "RuleEngineConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Rule = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RuleEngineConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RuleEngineConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Config = struct {
    Name: []const u8 = "",
    Type: []const u8 = "",
    Parameters: ItemList = .{},
    pub const xml_meta = .{
        .element_name = "Config",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Name", "Type"},
        .fields = .{
            .Parameters = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ConfigDescription = struct {
    pub const Inline_Messages = struct {
        ParentTopic: []const u8 = "",
        pub const xml_meta = .{
            .element_name = "Messages",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
            .fields = .{
                .ParentTopic = .{ .ns = "http://www.onvif.org/ver10/schema" },
            },
        };
    };

    Name: []const u8 = "",
    fixed: ?bool = null,
    maxInstances: ?i64 = null,
    Parameters: ItemListDescription = .{},
    Messages: []const Inline_Messages = &.{},
    Extension: ?ConfigDescriptionExtension = null,
    pub const xml_meta = .{
        .element_name = "ConfigDescription",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Name", "fixed", "maxInstances"},
        .fields = .{
            .Parameters = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Messages = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ConfigDescriptionExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ConfigDescriptionExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const SupportedRules = struct {
    Limit: ?i32 = null,
    RuleContentSchemaLocation: []const []const u8 = &.{},
    RuleDescription: []const ConfigDescription = &.{},
    Extension: ?SupportedRulesExtension = null,
    pub const xml_meta = .{
        .element_name = "SupportedRules",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Limit"},
        .fields = .{
            .RuleContentSchemaLocation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RuleDescription = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SupportedRulesExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SupportedRulesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const SupportedAnalyticsModules = struct {
    Limit: ?i32 = null,
    AnalyticsModuleContentSchemaLocation: []const []const u8 = &.{},
    AnalyticsModuleDescription: []const ConfigDescription = &.{},
    Extension: ?SupportedAnalyticsModulesExtension = null,
    pub const xml_meta = .{
        .element_name = "SupportedAnalyticsModules",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Limit"},
        .fields = .{
            .AnalyticsModuleContentSchemaLocation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AnalyticsModuleDescription = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SupportedAnalyticsModulesExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SupportedAnalyticsModulesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const MotionExpression = struct {
    Type: ?[]const u8 = null,
    Expression: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MotionExpression",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Type"},
        .fields = .{
            .Expression = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MotionExpressionConfiguration = struct {
    MotionExpression: MotionExpression = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MotionExpressionConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .MotionExpression = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const CellLayout = struct {
    Columns: i64 = 0,
    Rows: i64 = 0,
    Transformation: Transformation = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "CellLayout",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Columns", "Rows"},
        .fields = .{
            .Transformation = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PaneConfiguration = struct {
    PaneName: ?[]const u8 = null,
    AudioOutputToken: ?[]const u8 = null,
    AudioSourceToken: ?[]const u8 = null,
    AudioEncoderConfiguration: ?AudioEncoderConfiguration = null,
    ReceiverToken: ?[]const u8 = null,
    Token: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PaneConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PaneName = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioOutputToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioSourceToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioEncoderConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ReceiverToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Token = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PaneLayout = struct {
    Pane: []const u8 = "",
    Area: Rectangle = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PaneLayout",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Pane = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Area = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Layout = struct {
    PaneLayout: []const PaneLayout = &.{},
    Extension: ?LayoutExtension = null,
    pub const xml_meta = .{
        .element_name = "Layout",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PaneLayout = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const LayoutExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "LayoutExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const CodingCapabilities = struct {
    AudioEncodingCapabilities: ?AudioEncoderConfigurationOptions = null,
    AudioDecodingCapabilities: ?AudioDecoderConfigurationOptions = null,
    VideoDecodingCapabilities: VideoDecoderConfigurationOptions = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "CodingCapabilities",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AudioEncodingCapabilities = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioDecodingCapabilities = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VideoDecodingCapabilities = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const LayoutOptions = struct {
    PaneLayoutOptions: []const PaneLayoutOptions = &.{},
    Extension: ?LayoutOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "LayoutOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PaneLayoutOptions = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const LayoutOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "LayoutOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PaneLayoutOptions = struct {
    Area: []const Rectangle = &.{},
    Extension: ?PaneOptionExtension = null,
    pub const xml_meta = .{
        .element_name = "PaneLayoutOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Area = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PaneOptionExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PaneOptionExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Receiver = struct {
    Token: []const u8 = "",
    Configuration: ReceiverConfiguration = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Receiver",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Token = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Configuration = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ReceiverConfiguration = struct {
    Mode: ReceiverMode = .AutoConnect,
    MediaUri: []const u8 = "",
    StreamSetup: StreamSetup = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ReceiverConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MediaUri = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .StreamSetup = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ReceiverStateInformation = struct {
    State: ReceiverState = .NotConnected,
    AutoCreated: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ReceiverStateInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .State = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AutoCreated = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SourceReference = struct {
    Type: ?[]const u8 = null,
    Token: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SourceReference",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Type"},
        .fields = .{
            .Token = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const DateTimeRange = struct {
    From: xsd.DateTime = .{},
    Until: xsd.DateTime = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "DateTimeRange",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .From = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Until = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingSummary = struct {
    DataFrom: xsd.DateTime = .{},
    DataUntil: xsd.DateTime = .{},
    NumberRecordings: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingSummary",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .DataFrom = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DataUntil = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .NumberRecordings = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SearchScope = struct {
    IncludedSources: []const SourceReference = &.{},
    IncludedRecordings: []const []const u8 = &.{},
    RecordingInformationFilter: ?[]const u8 = null,
    Extension: ?SearchScopeExtension = null,
    pub const xml_meta = .{
        .element_name = "SearchScope",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .IncludedSources = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IncludedRecordings = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RecordingInformationFilter = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SearchScopeExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SearchScopeExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const EventFilter = struct {
    pub const xml_meta = .{
        .element_name = "EventFilter",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZPositionFilter = struct {
    MinPosition: PTZVector = .{},
    MaxPosition: PTZVector = .{},
    EnterOrExit: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZPositionFilter",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .MinPosition = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaxPosition = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EnterOrExit = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MetadataFilter = struct {
    MetadataStreamFilter: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MetadataFilter",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .MetadataStreamFilter = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FindRecordingResultList = struct {
    SearchState: SearchState = .Queued,
    RecordingInformation: []const RecordingInformation = &.{},
    pub const xml_meta = .{
        .element_name = "FindRecordingResultList",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SearchState = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RecordingInformation = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FindEventResultList = struct {
    SearchState: SearchState = .Queued,
    Result: []const FindEventResult = &.{},
    pub const xml_meta = .{
        .element_name = "FindEventResultList",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SearchState = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Result = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FindEventResult = struct {
    RecordingToken: []const u8 = "",
    TrackToken: []const u8 = "",
    Time: xsd.DateTime = .{},
    Event: xml_any.Any = .{},
    StartStateEvent: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "FindEventResult",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .RecordingToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TrackToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Time = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Event = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .StartStateEvent = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FindPTZPositionResultList = struct {
    SearchState: SearchState = .Queued,
    Result: []const FindPTZPositionResult = &.{},
    pub const xml_meta = .{
        .element_name = "FindPTZPositionResultList",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SearchState = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Result = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FindPTZPositionResult = struct {
    RecordingToken: []const u8 = "",
    TrackToken: []const u8 = "",
    Time: xsd.DateTime = .{},
    Position: PTZVector = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "FindPTZPositionResult",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .RecordingToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TrackToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Time = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Position = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FindMetadataResultList = struct {
    SearchState: SearchState = .Queued,
    Result: []const FindMetadataResult = &.{},
    pub const xml_meta = .{
        .element_name = "FindMetadataResultList",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SearchState = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Result = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FindMetadataResult = struct {
    RecordingToken: []const u8 = "",
    TrackToken: []const u8 = "",
    Time: xsd.DateTime = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "FindMetadataResult",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .RecordingToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TrackToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Time = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FindObjectImageResultList = struct {
    SearchState: SearchState = .Queued,
    Result: []const FindObjectImageResult = &.{},
    pub const xml_meta = .{
        .element_name = "FindObjectImageResultList",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SearchState = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Result = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FindObjectImageResult = struct {
    ObjectUUID: []const u8 = "",
    TargetImageURI: []const u8 = "",
    Time: xsd.DateTime = .{},
    Similarity: f32 = 0.0,
    RecordingToken: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "FindObjectImageResult",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ObjectUUID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TargetImageURI = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Time = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Similarity = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RecordingToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FindNLSearchResultList = struct {
    SearchState: SearchState = .Queued,
    Result: []const FindNLSearchResult = &.{},
    pub const xml_meta = .{
        .element_name = "FindNLSearchResultList",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SearchState = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Result = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FindNLSearchResult = struct {
    ObjectUUID: []const u8 = "",
    TargetImageURI: []const u8 = "",
    Time: xsd.DateTime = .{},
    Similarity: f32 = 0.0,
    RecordingToken: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "FindNLSearchResult",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ObjectUUID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TargetImageURI = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Time = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Similarity = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RecordingToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingInformation = struct {
    RecordingToken: []const u8 = "",
    Source: RecordingSourceInformation = .{},
    EarliestRecording: ?xsd.DateTime = null,
    LatestRecording: ?xsd.DateTime = null,
    Content: []const u8 = "",
    Track: []const TrackInformation = &.{},
    RecordingStatus: RecordingStatus = .Initiated,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .RecordingToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Source = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EarliestRecording = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .LatestRecording = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Content = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Track = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RecordingStatus = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingSourceInformation = struct {
    SourceId: []const u8 = "",
    Name: []const u8 = "",
    Location: []const u8 = "",
    Description: []const u8 = "",
    Address: []const u8 = "",
    VideoSourceToken: ?[]const u8 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingSourceInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SourceId = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Location = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Description = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Address = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VideoSourceToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AsymmetricEncryption = struct {
    CertificateID: []const []const u8 = &.{},
    KeyRotationDuration: ?xsd.Duration = null,
    AdditionalInfo: ?[]const u8 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AsymmetricEncryption",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .CertificateID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .KeyRotationDuration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AdditionalInfo = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingEncryption = struct {
    Mode: []const u8 = "",
    KID: ?[]const u8 = null,
    Key: ?[]const u8 = null,
    Track: []const []const u8 = &.{},
    AsymmetricEncryption: ?AsymmetricEncryption = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingEncryption",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Mode"},
        .fields = .{
            .KID = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Key = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Track = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AsymmetricEncryption = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingTargetConfiguration = struct {
    pub const Inline_SegmentDurationOverride = struct {
        Duration: xsd.Duration = .{},
        Expiration: xsd.Duration = .{},
        pub const xml_meta = .{
            .element_name = "SegmentDurationOverride",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
            .fields = .{
                .Duration = .{ .ns = "http://www.onvif.org/ver10/schema" },
                .Expiration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            },
        };
    };

    Storage: []const u8 = "",
    Format: []const u8 = "",
    Prefix: ?[]const u8 = null,
    Postfix: ?[]const u8 = null,
    SpanDuration: ?xsd.Duration = null,
    SegmentDuration: xsd.Duration = .{},
    Encryption: []const RecordingEncryption = &.{},
    SegmentDurationOverride: ?Inline_SegmentDurationOverride = null,
    StorageStrategy: ?[]const u8 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingTargetConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Storage = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Format = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Prefix = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Postfix = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SpanDuration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SegmentDuration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Encryption = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SegmentDurationOverride = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .StorageStrategy = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const TrackInformation = struct {
    TrackToken: []const u8 = "",
    TrackType: TrackType = .Video,
    Description: []const u8 = "",
    DataFrom: xsd.DateTime = .{},
    DataTo: xsd.DateTime = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "TrackInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .TrackToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TrackType = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Description = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DataFrom = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DataTo = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MediaAttributes = struct {
    RecordingToken: []const u8 = "",
    TrackAttributes: []const TrackAttributes = &.{},
    From: xsd.DateTime = .{},
    Until: xsd.DateTime = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MediaAttributes",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .RecordingToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TrackAttributes = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .From = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Until = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const TrackAttributes = struct {
    TrackInformation: TrackInformation = .{},
    VideoAttributes: ?VideoAttributes = null,
    AudioAttributes: ?AudioAttributes = null,
    MetadataAttributes: ?MetadataAttributes = null,
    Extension: ?TrackAttributesExtension = null,
    pub const xml_meta = .{
        .element_name = "TrackAttributes",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .TrackInformation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VideoAttributes = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AudioAttributes = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MetadataAttributes = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const TrackAttributesExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "TrackAttributesExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const VideoAttributes = struct {
    Bitrate: ?i32 = null,
    Width: i32 = 0,
    Height: i32 = 0,
    Encoding: []const u8 = "",
    Framerate: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoAttributes",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Bitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Width = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Height = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Encoding = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Framerate = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioAttributes = struct {
    Bitrate: ?i32 = null,
    Encoding: []const u8 = "",
    Samplerate: i32 = 0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioAttributes",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Bitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Encoding = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Samplerate = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MetadataAttributes = struct {
    PtzSpaces: ?[]const u8 = null,
    CanContainPTZ: bool = false,
    CanContainAnalytics: bool = false,
    CanContainNotifications: bool = false,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MetadataAttributes",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"PtzSpaces"},
        .fields = .{
            .CanContainPTZ = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .CanContainAnalytics = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .CanContainNotifications = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingConfiguration = struct {
    Source: RecordingSourceInformation = .{},
    Content: []const u8 = "",
    MaximumRetentionTime: xsd.Duration = .{},
    Target: ?RecordingTargetConfiguration = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Source = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Content = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MaximumRetentionTime = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Target = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const TrackConfiguration = struct {
    TrackType: TrackType = .Video,
    Description: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "TrackConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .TrackType = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Description = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const GetRecordingsResponseItem = struct {
    RecordingToken: []const u8 = "",
    Configuration: RecordingConfiguration = .{},
    Tracks: GetTracksResponseList = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "GetRecordingsResponseItem",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .RecordingToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Configuration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Tracks = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const GetTracksResponseList = struct {
    Track: []const GetTracksResponseItem = &.{},
    pub const xml_meta = .{
        .element_name = "GetTracksResponseList",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Track = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const GetTracksResponseItem = struct {
    TrackToken: []const u8 = "",
    Configuration: TrackConfiguration = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "GetTracksResponseItem",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .TrackToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Configuration = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingJobConfiguration = struct {
    ScheduleToken: ?[]const u8 = null,
    RecordingToken: []const u8 = "",
    Mode: []const u8 = "",
    Priority: i32 = 0,
    Source: []const RecordingJobSource = &.{},
    Extension: ?RecordingJobConfigurationExtension = null,
    EventFilter: ?RecordingEventFilter = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingJobConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"ScheduleToken"},
        .fields = .{
            .RecordingToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Priority = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Source = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EventFilter = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingEventFilter = struct {
    pub const Inline_Filter = struct {
        Topic: []const u8 = "",
        Source: ?[]const u8 = null,
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Filter",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
            .fields = .{
                .Topic = .{ .ns = "http://www.onvif.org/ver10/schema" },
                .Source = .{ .ns = "http://www.onvif.org/ver10/schema" },
            },
        };
    };

    Filter: []const Inline_Filter = &.{},
    Before: ?xsd.Duration = null,
    After: ?xsd.Duration = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingEventFilter",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Filter = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Before = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .After = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingJobConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingJobConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const RecordingJobSource = struct {
    SourceToken: ?SourceReference = null,
    AutoCreateReceiver: ?bool = null,
    Tracks: []const RecordingJobTrack = &.{},
    Extension: ?RecordingJobSourceExtension = null,
    pub const xml_meta = .{
        .element_name = "RecordingJobSource",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SourceToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AutoCreateReceiver = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Tracks = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingJobSourceExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingJobSourceExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const RecordingJobTrack = struct {
    SourceTag: []const u8 = "",
    Destination: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingJobTrack",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SourceTag = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Destination = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingJobStateInformation = struct {
    RecordingToken: []const u8 = "",
    State: []const u8 = "",
    Sources: []const RecordingJobStateSource = &.{},
    Extension: ?RecordingJobStateInformationExtension = null,
    pub const xml_meta = .{
        .element_name = "RecordingJobStateInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .RecordingToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .State = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Sources = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingJobStateInformationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingJobStateInformationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const RecordingJobStateSource = struct {
    SourceToken: SourceReference = .{},
    State: []const u8 = "",
    Tracks: RecordingJobStateTracks = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingJobStateSource",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SourceToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .State = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Tracks = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingJobStateTracks = struct {
    Track: []const RecordingJobStateTrack = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingJobStateTracks",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Track = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const RecordingJobStateTrack = struct {
    SourceTag: []const u8 = "",
    Destination: []const u8 = "",
    Error: ?[]const u8 = null,
    State: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "RecordingJobStateTrack",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SourceTag = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Destination = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Error = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .State = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const GetRecordingJobsResponseItem = struct {
    JobToken: []const u8 = "",
    JobConfiguration: RecordingJobConfiguration = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "GetRecordingJobsResponseItem",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .JobToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .JobConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ReplayConfiguration = struct {
    SessionTimeout: xsd.Duration = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ReplayConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .SessionTimeout = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnalyticsEngine = struct {
    token: []const u8 = "",
    Name: []const u8 = "",
    UseCount: i32 = 0,
    AnalyticsEngineConfiguration: AnalyticsDeviceEngineConfiguration = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AnalyticsEngine",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AnalyticsEngineConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnalyticsDeviceEngineConfiguration = struct {
    EngineConfiguration: []const EngineConfiguration = &.{},
    Extension: ?AnalyticsDeviceEngineConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "AnalyticsDeviceEngineConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .EngineConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnalyticsDeviceEngineConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AnalyticsDeviceEngineConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const EngineConfiguration = struct {
    VideoAnalyticsConfiguration: VideoAnalyticsConfiguration = .{},
    AnalyticsEngineInputInfo: AnalyticsEngineInputInfo = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "EngineConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .VideoAnalyticsConfiguration = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AnalyticsEngineInputInfo = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnalyticsEngineInputInfo = struct {
    InputInfo: ?Config = null,
    Extension: ?AnalyticsEngineInputInfoExtension = null,
    pub const xml_meta = .{
        .element_name = "AnalyticsEngineInputInfo",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .InputInfo = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnalyticsEngineInputInfoExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AnalyticsEngineInputInfoExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const AnalyticsEngineInput = struct {
    token: []const u8 = "",
    Name: []const u8 = "",
    UseCount: i32 = 0,
    SourceIdentification: SourceIdentification = .{},
    VideoInput: VideoEncoderConfiguration = .{},
    MetadataInput: MetadataInput = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AnalyticsEngineInput",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SourceIdentification = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VideoInput = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .MetadataInput = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SourceIdentification = struct {
    Name: []const u8 = "",
    Token: []const []const u8 = &.{},
    Extension: ?SourceIdentificationExtension = null,
    pub const xml_meta = .{
        .element_name = "SourceIdentification",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Token = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const SourceIdentificationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SourceIdentificationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const MetadataInput = struct {
    MetadataConfig: []const Config = &.{},
    Extension: ?MetadataInputExtension = null,
    pub const xml_meta = .{
        .element_name = "MetadataInput",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .MetadataConfig = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MetadataInputExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MetadataInputExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const AnalyticsEngineControl = struct {
    token: []const u8 = "",
    Name: []const u8 = "",
    UseCount: i32 = 0,
    EngineToken: []const u8 = "",
    EngineConfigToken: []const u8 = "",
    InputToken: []const []const u8 = &.{},
    ReceiverToken: []const []const u8 = &.{},
    Multicast: ?MulticastConfiguration = null,
    Subscription: Config = .{},
    Mode: ModeOfOperation = .Idle,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AnalyticsEngineControl",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .Name = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .UseCount = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EngineToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .EngineConfigToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .InputToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ReceiverToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Multicast = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Subscription = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Mode = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnalyticsStateInformation = struct {
    AnalyticsEngineControlToken: []const u8 = "",
    State: AnalyticsState = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AnalyticsStateInformation",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AnalyticsEngineControlToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .State = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AnalyticsState = struct {
    Error: ?[]const u8 = null,
    State: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AnalyticsState",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Error = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .State = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ActionEngineEventPayload = struct {
    RequestInfo: ?xml_any.Any = null,
    ResponseInfo: ?xml_any.Any = null,
    Fault: ?xml_any.Any = null,
    Extension: ?ActionEngineEventPayloadExtension = null,
    pub const xml_meta = .{
        .element_name = "ActionEngineEventPayload",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .RequestInfo = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ResponseInfo = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Fault = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ActionEngineEventPayloadExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ActionEngineEventPayloadExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const AudioClassCandidate = struct {
    Type: AudioClassType = .gun_shot,
    Likelihood: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioClassCandidate",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Likelihood = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioClassDescriptor = struct {
    ClassCandidate: []const AudioClassCandidate = &.{},
    Extension: ?AudioClassDescriptorExtension = null,
    pub const xml_meta = .{
        .element_name = "AudioClassDescriptor",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ClassCandidate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioClassDescriptorExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioClassDescriptorExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ActiveConnection = struct {
    CurrentBitrate: f32 = 0.0,
    CurrentFps: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ActiveConnection",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .CurrentBitrate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .CurrentFps = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ProfileStatus = struct {
    ActiveConnections: []const ActiveConnection = &.{},
    Extension: ?ProfileStatusExtension = null,
    pub const xml_meta = .{
        .element_name = "ProfileStatus",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ActiveConnections = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ProfileStatusExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ProfileStatusExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const OSDReference = struct {
    _value: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "OSDReference",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const OSDPosConfiguration = struct {
    Type: []const u8 = "",
    Pos: ?Vector = null,
    Extension: ?OSDPosConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "OSDPosConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Pos = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const OSDPosConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "OSDPosConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const OSDColor = struct {
    Transparent: ?i32 = null,
    Color: Color = .{},
    pub const xml_meta = .{
        .element_name = "OSDColor",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Transparent"},
        .fields = .{
            .Color = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const OSDTextConfiguration = struct {
    IsPersistentText: ?bool = null,
    Type: []const u8 = "",
    DateFormat: ?[]const u8 = null,
    TimeFormat: ?[]const u8 = null,
    FontSize: ?i32 = null,
    FontColor: ?OSDColor = null,
    BackgroundColor: ?OSDColor = null,
    PlainText: ?[]const u8 = null,
    Extension: ?OSDTextConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "OSDTextConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"IsPersistentText"},
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DateFormat = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TimeFormat = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FontSize = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FontColor = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BackgroundColor = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PlainText = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const OSDTextConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "OSDTextConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const OSDImgConfiguration = struct {
    ImgPath: []const u8 = "",
    Extension: ?OSDImgConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "OSDImgConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ImgPath = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const OSDImgConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "OSDImgConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ColorspaceRange = struct {
    X: FloatRange = .{},
    Y: FloatRange = .{},
    Z: FloatRange = .{},
    Colorspace: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "ColorspaceRange",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .X = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Y = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Z = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Colorspace = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ColorOptions = struct {
    ColorList: []const Color = &.{},
    ColorspaceRange: []const ColorspaceRange = &.{},
    pub const xml_meta = .{
        .element_name = "ColorOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ColorList = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ColorspaceRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const OSDColorOptions = struct {
    Color: ?ColorOptions = null,
    Transparent: ?IntRange = null,
    Extension: ?OSDColorOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "OSDColorOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Color = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Transparent = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const OSDColorOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "OSDColorOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const OSDTextOptions = struct {
    Type: []const []const u8 = &.{},
    FontSizeRange: ?IntRange = null,
    DateFormat: []const []const u8 = &.{},
    TimeFormat: []const []const u8 = &.{},
    FontColor: ?OSDColorOptions = null,
    BackgroundColor: ?OSDColorOptions = null,
    Extension: ?OSDTextOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "OSDTextOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FontSizeRange = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .DateFormat = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TimeFormat = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .FontColor = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BackgroundColor = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const OSDTextOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "OSDTextOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const OSDImgOptions = struct {
    FormatsSupported: ?[]const u8 = null,
    MaxSize: ?i32 = null,
    MaxWidth: ?i32 = null,
    MaxHeight: ?i32 = null,
    ImagePath: []const []const u8 = &.{},
    Extension: ?OSDImgOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "OSDImgOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"FormatsSupported", "MaxSize", "MaxWidth", "MaxHeight"},
        .fields = .{
            .ImagePath = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const OSDImgOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "OSDImgOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const OSDConfiguration = struct {
    token: []const u8 = "",
    VideoSourceConfigurationToken: OSDReference = .{},
    Type: OSDType = .Text,
    Position: OSDPosConfiguration = .{},
    TextString: ?OSDTextConfiguration = null,
    Image: ?OSDImgConfiguration = null,
    Extension: ?OSDConfigurationExtension = null,
    pub const xml_meta = .{
        .element_name = "OSDConfiguration",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"token"},
        .fields = .{
            .VideoSourceConfigurationToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Position = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TextString = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Image = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const OSDConfigurationExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "OSDConfigurationExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const MaximumNumberOfOSDs = struct {
    Total: i32 = 0,
    Image: ?i32 = null,
    PlainText: ?i32 = null,
    Date: ?i32 = null,
    Time: ?i32 = null,
    DateAndTime: ?i32 = null,
    pub const xml_meta = .{
        .element_name = "MaximumNumberOfOSDs",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Total", "Image", "PlainText", "Date", "Time", "DateAndTime"},
    };
};

pub const OSDConfigurationOptions = struct {
    MaximumNumberOfOSDs: MaximumNumberOfOSDs = .{},
    Type: []const OSDType = &.{},
    PositionOption: []const []const u8 = &.{},
    TextOption: ?OSDTextOptions = null,
    ImageOption: ?OSDImgOptions = null,
    Extension: ?OSDConfigurationOptionsExtension = null,
    pub const xml_meta = .{
        .element_name = "OSDConfigurationOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .MaximumNumberOfOSDs = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PositionOption = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .TextOption = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ImageOption = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const OSDConfigurationOptionsExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "OSDConfigurationOptionsExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const FileProgress = struct {
    FileName: []const u8 = "",
    Progress: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "FileProgress",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .FileName = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Progress = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ArrayOfFileProgress = struct {
    FileProgress: []const FileProgress = &.{},
    Extension: ?ArrayOfFileProgressExtension = null,
    pub const xml_meta = .{
        .element_name = "ArrayOfFileProgress",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .FileProgress = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ArrayOfFileProgressExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ArrayOfFileProgressExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const StorageReferencePath = struct {
    StorageToken: []const u8 = "",
    RelativePath: ?[]const u8 = null,
    Extension: ?StorageReferencePathExtension = null,
    pub const xml_meta = .{
        .element_name = "StorageReferencePath",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .StorageToken = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .RelativePath = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const StorageReferencePathExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "StorageReferencePathExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PolygonOptions = struct {
    RectangleOnly: ?bool = null,
    VertexLimits: ?IntRange = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PolygonOptions",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .RectangleOnly = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VertexLimits = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Appearance = struct {
    Transformation: ?Transformation = null,
    Shape: ?ShapeDescriptor = null,
    Color: ?ColorDescriptor = null,
    Class: ?ClassDescriptor = null,
    Extension: ?AppearanceExtension = null,
    GeoLocation: ?GeoLocation = null,
    VehicleInfo: []const VehicleInfo = &.{},
    LicensePlateInfo: ?LicensePlateInfo = null,
    HumanFace: ?xml_any.Any = null,
    HumanBody: ?xml_any.Any = null,
    ImageRef: ?[]const u8 = null,
    Image: ?[]const u8 = null,
    BarcodeInfo: ?BarcodeInfo = null,
    SphericalCoordinate: ?SphericalCoordinate = null,
    Label: []const LabelInfo = &.{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Appearance",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Transformation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Shape = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Color = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Class = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .GeoLocation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .VehicleInfo = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .LicensePlateInfo = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .HumanFace = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .HumanBody = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ImageRef = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Image = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .BarcodeInfo = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SphericalCoordinate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Label = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AppearanceExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AppearanceExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const BarcodeInfo = struct {
    Data: StringLikelihood = .{},
    Type: ?StringLikelihood = null,
    PPM: ?f32 = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "BarcodeInfo",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Data = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PPM = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const LabelInfo = struct {
    Likelihood: ?f32 = null,
    Authority: []const u8 = "",
    ID: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "LabelInfo",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Likelihood"},
        .fields = .{
            .Authority = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ID = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VehicleInfo = struct {
    Type: StringLikelihood = .{},
    Brand: ?StringLikelihood = null,
    Model: ?StringLikelihood = null,
    Color: ?ColorDescriptor = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VehicleInfo",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Brand = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Model = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Color = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const LicensePlateInfo = struct {
    PlateNumber: StringLikelihood = .{},
    PlateType: ?StringLikelihood = null,
    CountryCode: ?StringLikelihood = null,
    IssuingEntity: ?StringLikelihood = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "LicensePlateInfo",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PlateNumber = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PlateType = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .CountryCode = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .IssuingEntity = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ShapeDescriptor = struct {
    BoundingBox: Rectangle = .{},
    CenterOfGravity: Vector = .{},
    Polygon: []const Polygon = &.{},
    Extension: ?ShapeDescriptorExtension = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ShapeDescriptor",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .BoundingBox = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .CenterOfGravity = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Polygon = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ShapeDescriptorExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ShapeDescriptorExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const StringLikelihood = struct {
    Likelihood: ?f32 = null,
    _value: []const u8 = "",
    pub const xml_meta = .{
        .element_name = "StringLikelihood",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Likelihood"},
    };
};

pub const ClassDescriptor = struct {
    ClassCandidate: []const ClassCandidate = &.{},
    Extension: ?ClassDescriptorExtension = null,
    Type: []const StringLikelihood = &.{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ClassDescriptor",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ClassCandidate = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ClassCandidate = struct {
    Type: ClassType = .Animal,
    Likelihood: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ClassCandidate",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Likelihood = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ClassDescriptorExtension = struct {
    any: []const xml_any.Any = &.{},
    OtherTypes: []const OtherType = &.{},
    pub const xml_meta = .{
        .element_name = "ClassDescriptorExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .OtherTypes = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const OtherType = struct {
    Type: []const u8 = "",
    Likelihood: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "OtherType",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Likelihood = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Object = struct {
    ObjectId: ?i64 = null,
    UUID: ?[]const u8 = null,
    Parent: ?i64 = null,
    ParentUUID: ?[]const u8 = null,
    Appearance: ?Appearance = null,
    Behaviour: ?Behaviour = null,
    Extension: ?ObjectExtension = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Object",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"ObjectId", "UUID", "Parent", "ParentUUID"},
        .fields = .{
            .Appearance = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Behaviour = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ObjectExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ObjectExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Frame = struct {
    UtcTime: xsd.DateTime = .{},
    Colorspace: ?[]const u8 = null,
    Source: ?[]const u8 = null,
    PTZStatus: ?PTZStatus = null,
    Transformation: ?Transformation = null,
    Object: []const Object = &.{},
    ObjectTree: ?ObjectTree = null,
    Extension: ?FrameExtension = null,
    SceneImageRef: ?[]const u8 = null,
    SceneImage: ?[]const u8 = null,
    AspectRatioTransformation: []const AspectRatioTransformation = &.{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Frame",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"UtcTime", "Colorspace", "Source"},
        .fields = .{
            .PTZStatus = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Transformation = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Object = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .ObjectTree = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SceneImageRef = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SceneImage = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .AspectRatioTransformation = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FrameExtension = struct {
    any: []const xml_any.Any = &.{},
    MotionInCells: ?MotionInCells = null,
    Extension: ?FrameExtension2 = null,
    pub const xml_meta = .{
        .element_name = "FrameExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .MotionInCells = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const FrameExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "FrameExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const Merge = struct {
    from: []const ObjectId = &.{},
    to: ObjectId = .{},
    pub const xml_meta = .{
        .element_name = "Merge",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .from = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .to = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Split = struct {
    from: ObjectId = .{},
    to: []const ObjectId = &.{},
    pub const xml_meta = .{
        .element_name = "Split",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .from = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .to = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const Rename = struct {
    from: ObjectId = .{},
    to: ObjectId = .{},
    pub const xml_meta = .{
        .element_name = "Rename",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .from = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .to = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ObjectId = struct {
    ObjectId: ?i64 = null,
    UUID: ?[]const u8 = null,
    pub const xml_meta = .{
        .element_name = "ObjectId",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"ObjectId", "UUID"},
    };
};

pub const Behaviour = struct {
    pub const Inline_Removed = struct {
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Removed",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
        };
    };

    pub const Inline_Idle = struct {
        any: []const xml_any.Any = &.{},
        pub const xml_meta = .{
            .element_name = "Idle",
            .namespace = "http://www.onvif.org/ver10/schema",
            .namespace_uri = "http://www.onvif.org/ver10/schema",
        };
    };

    Removed: ?Inline_Removed = null,
    Idle: ?Inline_Idle = null,
    Extension: ?BehaviourExtension = null,
    Speed: ?f32 = null,
    Direction: ?GeoOrientation = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "Behaviour",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Removed = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Idle = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Speed = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Direction = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const BehaviourExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "BehaviourExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const ObjectTree = struct {
    Rename: []const Rename = &.{},
    Split: []const Split = &.{},
    Merge: []const Merge = &.{},
    Delete: []const ObjectId = &.{},
    Extension: ?ObjectTreeExtension = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ObjectTree",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Rename = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Split = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Merge = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Delete = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ObjectTreeExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ObjectTreeExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const MotionInCells = struct {
    Columns: i64 = 0,
    Rows: i64 = 0,
    Cells: []const u8 = "",
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MotionInCells",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"Columns", "Rows", "Cells"},
    };
};

pub const ObjectTrack = struct {
    ObjectState: []const ObjectState = &.{},
    pub const xml_meta = .{
        .element_name = "ObjectTrack",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .ObjectState = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const ObjectState = struct {
    ObjectId: ?i64 = null,
    UUID: ?[]const u8 = null,
    Parent: ?i64 = null,
    ParentUUID: ?[]const u8 = null,
    CaptureTime: xsd.DateTime = .{},
    Appearance: ?Appearance = null,
    Behaviour: ?Behaviour = null,
    Extension: ?ObjectExtension = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "ObjectState",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"ObjectId", "UUID", "Parent", "ParentUUID", "CaptureTime"},
        .fields = .{
            .Appearance = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Behaviour = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MetadataStream = struct {
    VideoAnalytics: ?VideoAnalyticsStream = null,
    PTZ: ?PTZStream = null,
    Event: ?EventStream = null,
    Extension: ?MetadataStreamExtension = null,
    SensorData: []const SensorData = &.{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MetadataStream",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .VideoAnalytics = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .PTZ = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Event = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .SensorData = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MetadataStreamExtension = struct {
    any: []const xml_any.Any = &.{},
    AudioAnalyticsStream: ?AudioAnalyticsStream = null,
    Extension: ?MetadataStreamExtension2 = null,
    pub const xml_meta = .{
        .element_name = "MetadataStreamExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AudioAnalyticsStream = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const MetadataStreamExtension2 = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "MetadataStreamExtension2",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const SensorData = struct {
    UtcTime: xsd.DateTime = .{},
    SensorID: []const u8 = "",
    Type: []const u8 = "",
    Value: f32 = 0.0,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "SensorData",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"UtcTime", "SensorID"},
        .fields = .{
            .Type = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Value = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioAnalyticsStream = struct {
    AudioDescriptor: []const AudioDescriptor = &.{},
    Extension: ?AudioAnalyticsStreamExtension = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioAnalyticsStream",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .AudioDescriptor = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const AudioDescriptor = struct {
    UtcTime: xsd.DateTime = .{},
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioDescriptor",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .attributes = &.{"UtcTime"},
    };
};

pub const AudioAnalyticsStreamExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "AudioAnalyticsStreamExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const VideoAnalyticsStream = struct {
    Frame: ?Frame = null,
    Extension: ?VideoAnalyticsStreamExtension = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoAnalyticsStream",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .Frame = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const VideoAnalyticsStreamExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "VideoAnalyticsStreamExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const PTZStream = struct {
    PTZStatus: ?PTZStatus = null,
    Extension: ?PTZStreamExtension = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZStream",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .PTZStatus = .{ .ns = "http://www.onvif.org/ver10/schema" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const PTZStreamExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "PTZStreamExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

pub const EventStream = struct {
    NotificationMessage: ?xml_any.Any = null,
    Extension: ?EventStreamExtension = null,
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "EventStream",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
        .fields = .{
            .NotificationMessage = .{ .ns = "http://docs.oasis-open.org/wsn/b-2" },
            .Extension = .{ .ns = "http://www.onvif.org/ver10/schema" },
        },
    };
};

pub const EventStreamExtension = struct {
    any: []const xml_any.Any = &.{},
    pub const xml_meta = .{
        .element_name = "EventStreamExtension",
        .namespace = "http://www.onvif.org/ver10/schema",
        .namespace_uri = "http://www.onvif.org/ver10/schema",
    };
};

