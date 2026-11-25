# onvif

A high-performance, zero-dependency, pure Zig 0.17 implementation of the **ONVIF™ (Open Network Video Interface Forum)** protocol stack. Designed for embedded IP camera firmware (NVT), video management systems (NVS/VMS), Network Video Recorders (NVR), and edge AI vision gateways.

Built from the ground up to leverage Zig 0.17's **colorless async (`std.Io`)**, **compile-time reflection (`comptime`)**, and **intrusive buffered I/O**, `onvif` delivers full ONVIF Profile S/G/T conformance without C libraries, external XML parsers, or runtime overhead.

---

## Key Features

- **Pure Zig 0.17**: Zero C dependencies (`@cImport` free). No `libxml2`, `gSOAP`, or `OpenSSL`.
- **Colorless Async (`std.Io`)**: Explicit async I/O via `io: std.Io`, concurrent task groups (`std.Io.Group`), and non-blocking timeout racing (`std.Io.Select`).
- **End-to-End Spec Generator (`onvif-gen`)**: Automatically parses official ONVIF WSDL and XSD schemas (integrated as a Zig package dependency from `specs`) to generate type-safe Zig structs, enums, unions, and SOAP RPC definitions.
- **Streaming XML Codec**: Fast pull-based XML reader ([Reader.zig](src/xml/Reader.zig)) and writer ([Writer.zig](src/xml/Writer.zig)) with namespace prefix stack resolution and zero-DOM parsing.
- **Comptime Serialization**: Zero-copy XML serialization and deserialization ([codec.zig](src/codec.zig)) using Zig 0.17 Struct-of-Arrays (SoA) reflection.
- **SOAP 1.1 / 1.2 Engine**: Full envelope wrapping, header parsing, WS-Addressing action routing, and SOAP Fault handling ([soap.zig](src/soap.zig)).
- **WS-Security & Digest Auth**: Cryptographic WS-Security `UsernameToken` with `PasswordDigest` (SHA-1, Nonce, ISO-8601 UTC timestamp) and RFC 7616 HTTP Digest Authentication ([auth.zig](src/transport/auth.zig)).
- **WS-Discovery**: UDP multicast discovery (`239.255.255.250:3702`) with probe formatting, target service filtering, and timed match collection ([Discovery.zig](src/transport/Discovery.zig)).
- **Compile-Time RPC Router & Server**: HTTP/SOAP server ([Server.zig](src/transport/Server.zig)) that verifies service implementations at compile time and dispatches incoming XML requests directly to Zig methods.
- **Profile S Mock Camera Server**: Ready-to-run mock camera server implementing all **25 mandatory Profile S Device & Media operations** ([mock_camera_server.zig](xamples/mock_camera_server.zig)).

---

## Architecture & Project Structure

The codebase is organized into modular layers:

```text
onvif/
├── build.zig                  # Zig build definition & code generator step
├── build.zig.zon              # Package manifest & ONVIF specs git dependency
├── src/
│   ├── root.zig               # Master library exports
│   ├── codec.zig              # Comptime XML <-> Zig reflection serializer
│   ├── soap.zig               # SOAP 1.1/1.2 Envelope, WS-Addressing, Faults
│   ├── xsd_types.zig          # XSD DateTime, Duration, Base64Binary helpers
│   ├── xml/
│   │   ├── Reader.zig         # Intrusive streaming XML pull reader
│   │   ├── Writer.zig         # Intrusive streaming XML element/attr writer
│   │   └── Any.zig            # DOM-fallback node capture for xs:any / xs:anyAttribute
│   ├── transport/
│   │   ├── auth.zig           # WS-Security UsernameToken & HTTP Digest Auth
│   │   ├── Client.zig         # Colorless async SOAP client with timeout racing
│   │   ├── Server.zig         # Typed compile-time RPC router & HTTP server
│   │   ├── Discovery.zig      # WS-Discovery multicast probe & match listener
│   │   └── PullPoint.zig      # WS-BaseNotification event queue
│   ├── gen/
│   │   ├── main.zig           # Code generator CLI executable (onvif-gen)
│   │   ├── xsd.zig            # XSD parser (complexType, simpleType, extensions)
│   │   ├── wsdl.zig           # WSDL parser (portType, operations, SOAP actions)
│   │   └── emitter.zig        # Zig code generator
│   └── spec/
│       ├── generated.zig      # Re-exports for generated schema and services
│       ├── schema.zig         # 480+ ONVIF XML Schema complex & simple types
│       └── services/          # 320+ typed ONVIF service operations
│           ├── device.zig     # Device Management service (103 operations)
│           ├── media.zig      # Media service v1.0 (79 operations)
│           ├── media2.zig     # Media service v2.0 (59 operations)
│           ├── ptz.zig        # PTZ service (29 operations)
│           ├── imaging.zig    # Imaging service (11 operations)
│           ├── event.zig      # Event / Notification service (10 operations)
│           └── deviceio.zig   # DeviceIO service (29 operations)
└── examples/
    ├── discover_and_probe.zig # CLI: WS-Discovery multicast search tool
    └── mock_camera_server.zig # CLI: Compliant Profile S mock camera server
```

---

## Installation & Integration

### Adding as a Dependency (`build.zig.zon`)

Add `onvif` to your project's [build.zig.zon](build.zig.zon):

```shell
zig fetch --save git+https://github.com/binarycraft007/onvif.git
```

### Using in `build.zig`

Import and link the `onvif` module in your [build.zig](build.zig):

```zig
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const onvif_dep = b.dependency("onvif", .{
        .target = target,
        .optimize = optimize,
    });
    const onvif_mod = onvif_dep.module("onvif");

    const exe = b.addExecutable(.{
        .name = "my_app",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "onvif", .module = onvif_mod },
            },
        }),
    });
    b.installArtifact(exe);
}
```

---

## Build & Test Commands

`onvif` requires **Zig 0.17.x**.

```bash
# Build the library, generator, and examples
zig build

# Run all 24 unit and integration test suites (0 leaks)
zig build test --summary all

# Regenerate ONVIF types and services from official WSDL/XSD schemas
zig build gen

# Run the WS-Discovery tool to probe for network cameras
./zig-out/bin/discover_and_probe

# Start the mock camera server on http://127.0.0.1:8080
./zig-out/bin/mock_camera_server
```

---

## Code Examples

### 1. ONVIF Client: Calling a Remote Camera

Call any typed ONVIF operation with automatic WS-Security authentication and timeout racing:

```zig
const std = @import("std");
const onvif = @import("onvif");
const spec = onvif.spec;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const gpa = init.gpa;
    const arena = init.arena;

    var client = onvif.transport.Client.init(gpa, io);
    defer client.deinit();

    const device_uri = try std.Uri.parse("http://192.168.1.100/onvif/device_service");

    // Call GetDeviceInformation with WS-Security credentials
    const info = try client.call(
        spec.Device.GetDeviceInformation,
        arena.allocator(),
        device_uri,
        .{},
        .{
            .timeout_ms = 5000,
            .credentials = .{
                .username = "admin",
                .password = "pass1234",
                .auth_mode = .ws_security,
            },
        },
    );

    std.debug.print("Manufacturer: {s}\n", .{info.Manufacturer});
    std.debug.print("Model:        {s}\n", .{info.Model});
    std.debug.print("Firmware:     {s}\n", .{info.FirmwareVersion});
    std.debug.print("Serial:       {s}\n", .{info.SerialNumber});
}
```

### 2. Camera Server: Implementing Profile S Device & Media Services

Implement your camera handler struct and mount it using `onvif.transport.Server`:

```zig
const std = @import("std");
const onvif = @import("onvif");
const spec = onvif.spec;
const schema = spec.schema;

pub const MyCamera = struct {
    // 1. Implement Device.GetDeviceInformation
    pub fn GetDeviceInformation(
        self: *MyCamera,
        arena: std.mem.Allocator,
        _: spec.Device.GetDeviceInformation.Request,
    ) !spec.Device.GetDeviceInformation.Response {
        _ = self;
        return .{
            .Manufacturer = try arena.dupe(u8, "Acme Vision"),
            .Model = try arena.dupe(u8, "ACME-4K-PRO"),
            .FirmwareVersion = try arena.dupe(u8, "v1.0.0"),
            .SerialNumber = try arena.dupe(u8, "SN-0012345"),
            .HardwareId = try arena.dupe(u8, "HW-REV-A"),
        };
    }

    // 2. Implement Media.GetStreamUri (RTSP stream)
    pub fn GetStreamUri(
        self: *MyCamera,
        arena: std.mem.Allocator,
        req: spec.Media.GetStreamUri.Request,
    ) !spec.Media.GetStreamUri.Response {
        _ = self;
        _ = req;
        return .{
            .MediaUri = .{
                .Uri = try arena.dupe(u8, "rtsp://192.168.1.100:554/live/main"),
                .InvalidAfterConnect = false,
                .InvalidAfterReboot = false,
                .Timeout = try onvif.xsd.Duration.parse("PT30S"),
            },
        };
    }

    // Add other required Device and Media operations...
};

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const gpa = init.gpa;

    var camera = MyCamera{};
    const addr = std.Io.net.IpAddress{ .ip4 = std.Io.net.Ip4Address.any(8080) };

    // Create typed server mounting Device and Media services
    const ServerType = onvif.transport.Server(MyCamera, &.{ spec.Device, spec.Media });
    var server = ServerType.init(io, gpa, &camera, addr);
    defer server.deinit();

    try server.listen();
    std.debug.print("ONVIF server running on port 8080...\n", .{});
}
```

### 3. WS-Discovery: Scanning for Network Cameras

Send WS-Discovery multicast probes and receive IP address endpoints:

```zig
const std = @import("std");
const onvif = @import("onvif");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const gpa = init.gpa;

    // Send multicast probe and gather responses for 2 seconds
    const devices = try onvif.transport.Discovery.discover(io, gpa, .{
        .timeout_ms = 2000,
        .types_filter = "dn:NetworkVideoTransmitter",
    });
    defer gpa.free(devices);

    for (devices, 0..) |dev, i| {
        std.debug.print("[Camera {d}] Endpoint: {s}\n", .{ i + 1, dev.endpoint_reference });
        for (dev.xaddrs) |xaddr| {
            std.debug.print("  Service URL: {s}\n", .{xaddr});
        }
    }
}
```

### 4. Streaming XML Serialization & Deserialization

Directly encode and decode typed Zig structs without intermediate DOM trees:

```zig
const std = @import("std");
const onvif = @import("onvif");

const VideoResolution = struct {
    Width: i32,
    Height: i32,
};

test "roundtrip XML codec" {
    const alloc = std.testing.allocator;

    // Serialize
    var out: std.Io.Writer.Allocating = .init(alloc);
    defer out.deinit();
    var writer = onvif.xml.Writer.init(alloc, &out.writer);
    defer writer.deinit();

    const original = VideoResolution{ .Width = 3840, .Height = 2160 };
    try onvif.codec.encode(VideoResolution, original, &writer, "Resolution", "http://www.onvif.org/ver10/schema");
    try writer.flush();
    try out.writer.flush();

    // Deserialize
    var reader_stream: std.Io.Reader = .fixed(out.written());
    var reader = onvif.xml.Reader.init(alloc, &reader_stream);
    defer reader.deinit();

    const decoded = try onvif.codec.decode(VideoResolution, &reader, alloc);
    try std.testing.expectEqual(original.Width, decoded.Width);
    try std.testing.expectEqual(original.Height, decoded.Height);
}
```

---

## Profile S Conformance Matrix

The following table summarizes the implementation of mandatory Profile S operations in the included mock camera server ([mock_camera_server.zig](examples/mock_camera_server.zig)):

### Device Management Service (`/ver10/device/wsdl`)
| Operation | Profile S Requirement | Implementation Status | Description |
| :--- | :---: | :---: | :--- |
| `GetSystemDateAndTime` | **Mandatory** | Supported | Retrieves camera UTC clock, NTP settings, and time zone |
| `SetSystemDateAndTime` | **Mandatory** | Supported | Sets manual or NTP-synchronized date and time |
| `GetDeviceInformation` | **Mandatory** | Supported | Returns manufacturer, model, firmware, serial number |
| `GetCapabilities` | **Mandatory** | Supported | Returns device, media, PTZ, imaging, and event service XAddrs |
| `GetServices` | **Mandatory** | Supported | Returns enumerated services and version capabilities |
| `GetServiceCapabilities` | **Mandatory** | Supported | Returns device service feature flags |
| `GetScopes` | **Mandatory** | Supported | Returns WS-Discovery scopes (Profile/S, hardware, location) |
| `SetScopes` | **Mandatory** | Supported | Updates configurable device discovery scopes |
| `GetNetworkInterfaces` | **Mandatory** | Supported | Queries network adapters, MAC addresses, IPv4 configs |
| `GetHostname` | **Mandatory** | Supported | Returns device network hostname |
| `GetDNS` | **Mandatory** | Supported | Returns DNS server addresses and search domains |
| `GetNTP` | **Mandatory** | Supported | Returns configured NTP time servers |
| `SystemReboot` | **Mandatory** | Supported | Initiates device reboot sequence |

### Media Service (`/ver10/media/wsdl`)
| Operation | Profile S Requirement | Implementation Status | Description |
| :--- | :---: | :---: | :--- |
| `GetProfiles` | **Mandatory** | Supported | Returns all configured media profiles (4K & 1080P) |
| `GetProfile` | **Mandatory** | Supported | Retrieves a single profile by token |
| `GetStreamUri` | **Mandatory** | Supported | Returns RTSP streaming URI for a media profile |
| `GetSnapshotUri` | **Mandatory** | Supported | Returns JPEG snapshot HTTP URI for a profile |
| `GetVideoSources` | **Mandatory** | Supported | Returns physical video input sensors |
| `GetVideoSourceConfigurations` | **Mandatory** | Supported | Returns all video capture configurations |
| `GetVideoSourceConfiguration` | **Mandatory** | Supported | Returns specific video source configuration |
| `GetVideoEncoderConfigurations` | **Mandatory** | Supported | Returns all video compression configurations |
| `GetVideoEncoderConfiguration` | **Mandatory** | Supported | Returns specific encoder settings (H.264/H.265) |
| `GetVideoEncoderConfigurationOptions` | **Mandatory** | Supported | Returns valid resolution, framerate, and bitrate ranges |
| `GetCompatibleVideoEncoderConfigurations` | **Mandatory** | Supported | Returns encoder configurations valid for a profile |

---

## Code Generator (`onvif-gen`)

`onvif-zig` includes a built-in WSDL and XSD code generator located in [src/gen/](src/gen/).

### Highlights
- Reads `.xsd` and `.wsdl` files directly from the official ONVIF specifications repository.
- Resolves XML Schema types:
  - `<xs:complexType>` with `<xs:sequence>`, `<xs:all>`, and `<xs:choice>` into Zig `struct` and `union(enum)`.
  - `<xs:complexContent>` / `<xs:extension>` flattened with parent base fields.
  - `<xs:simpleType>` restrictions and enums into Zig `enum`.
  - Cardinality (`minOccurs="0"`, `maxOccurs="unbounded"`) mapped to `?T` and `[]const T`.
  - Attributes (`<xs:attribute>`) mapped to `xml_meta.attributes`.
- Emits clean, formatted Zig source code with zero compile warnings.

To run the generator manually:
```bash
zig build gen
```

---

## Testing & Quality Assurance

Unit and integration tests verify all critical paths:
```bash
zig build test --summary all
```

Test coverage includes:
- **XML Parsing & Writing**: Self-closing tags, namespace scope stacking, entity escaping, invalid markup detection.
- **Serialization Roundtrips**: Structs, choices, optionals, slices, and custom date/duration types.
- **WS-Security Vector Testing**: Password digest hashing against official test vectors.
- **SOAP Faults**: Fault code and subcode serialization and deserialization.
- **Loopback RPC Dispatch**: Dispatching requests across all 25 mandatory Profile S APIs with zero memory leaks.

---

## License

This project is licensed under the MIT License.
