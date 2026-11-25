const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const specs_dep = b.dependency("specs", .{});

    const onvif_mod = b.addModule("onvif", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const tests = b.addTest(.{
        .root_module = onvif_mod,
    });
    const run_tests = b.addRunArtifact(tests);
    const test_step = b.step("test", "Run library unit tests");
    test_step.dependOn(&run_tests.step);

    const xml_mod = b.createModule(.{
        .root_source_file = b.path("src/xml/Reader.zig"),
        .target = target,
        .optimize = optimize,
    });
    const gen_exe = b.addExecutable(.{
        .name = "onvif-gen",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/gen/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "xml_reader", .module = xml_mod },
            },
        }),
    });
    b.installArtifact(gen_exe);

    const gen_step = b.step("gen", "Run the WSDL/XSD code generator");
    const run_gen = b.addRunArtifact(gen_exe);
    run_gen.addDirectoryArg(specs_dep.path("wsdl"));
    gen_step.dependOn(&run_gen.step);

    const example_disc = b.addExecutable(.{
        .name = "discover_and_probe",
        .root_module = b.createModule(.{
            .root_source_file = b.path("examples/discover_and_probe.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "onvif", .module = onvif_mod },
            },
        }),
    });
    b.installArtifact(example_disc);

    const example_mock = b.addExecutable(.{
        .name = "mock_camera_server",
        .root_module = b.createModule(.{
            .root_source_file = b.path("examples/mock_camera_server.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "onvif", .module = onvif_mod },
            },
        }),
    });
    b.installArtifact(example_mock);

    const example_client = b.addExecutable(.{
        .name = "client_demo",
        .root_module = b.createModule(.{
            .root_source_file = b.path("examples/client_demo.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "onvif", .module = onvif_mod },
            },
        }),
    });
    b.installArtifact(example_client);

    const mock_tests = b.addTest(.{
        .root_module = example_mock.root_module,
    });
    const run_mock_tests = b.addRunArtifact(mock_tests);
    test_step.dependOn(&run_mock_tests.step);
}
