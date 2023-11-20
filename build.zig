const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) !void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    // ObjC Runtime
    const dep_objc = b.dependency("objc", .{
        .target = target,
        .optimize = optimize,
    });
    const mod_objc = dep_objc.module("objc");
    // UUID
    const dep_uuid = b.dependency("uuid", .{
        .target = target,
        .optimize = optimize,
    });
    const mod_uuid = dep_uuid.module("uuid");
    // Core modules (NSObject, etc...)
    const mod_runtime = b.createModule(.{ .source_file = .{ .path = "src/fw/Runtime.zig" }, .dependencies = &.{
        .{ .name = "objc", .module = mod_objc },
    } });
    try mod_runtime.dependencies.put("Runtime", mod_runtime);
    // QuartzCore.framework (referencing from AppKit.framework)
    const mod_quartz = b.createModule(.{
        .source_file = .{ .path = "src/fw/QuartzCore.zig" },
        .dependencies = &.{
            .{ .name = "objc", .module = mod_objc },
            .{ .name = "Runtime", .module = mod_runtime },
        },
    });
    try mod_quartz.dependencies.put("QuartzCore", mod_quartz);
    // CoreGraphics.framework (referencing from AppKit.framework)
    const mod_coreGraphics = b.createModule(.{
        .source_file = .{ .path = "src/fw/CoreGraphics.zig" },
        .dependencies = &.{
            .{ .name = "objc", .module = mod_objc },
            .{ .name = "Runtime", .module = mod_runtime },
            .{ .name = "QuartzCore", .module = mod_quartz },
        },
    });
    try mod_coreGraphics.dependencies.put("CoreGraphics", mod_coreGraphics);
    // CoreGraphics and CoreGraphics has been depended each other.
    try mod_quartz.dependencies.put("CoreGraphics", mod_coreGraphics);

    // Foundation.framework
    const mod_foundation = b.createModule(.{
        .source_file = .{ .path = "src/fw/Foundation.zig" },
        .dependencies = &.{
            .{ .name = "objc", .module = mod_objc },
            .{ .name = "Runtime", .module = mod_runtime },
            .{ .name = "CoreGraphics", .module = mod_coreGraphics },
        },
    });
    try mod_foundation.dependencies.put("Foundation", mod_coreGraphics);

    // AppKit.framework
    const mod_appKit = b.createModule(.{
        .source_file = .{ .path = "src/fw/AppKit.zig" },
        .dependencies = &.{
            .{ .name = "objc", .module = mod_objc },
            .{ .name = "Runtime", .module = mod_runtime },
            .{ .name = "Foundation", .module = mod_foundation },
            .{ .name = "QuartzCore", .module = mod_quartz },
            .{ .name = "CoreGraphics", .module = mod_coreGraphics },
        },
    });
    try mod_appKit.dependencies.put("AppKit", mod_appKit);

    // AppKit support package (event handling, etc..)
    const mod_appKit_support = b.createModule(.{
        .source_file = .{ .path = "src/fw/Support/AppKitSupport.zig" },
        .dependencies = &.{
            .{ .name = "objc", .module = mod_objc },
            .{ .name = "Runtime", .module = mod_runtime },
            .{ .name = "AppKit", .module = mod_appKit },
        }
    });

    const examples = std.ComptimeStringMap([]const u8, .{
        .{"counter", "src/examples/01_counter/main.zig"},
        .{"temp_conv", "src/examples/02_temp_conv/main.zig"},
    });

    // create example step
    const example_cmd = try @import("example_step").RunExample.create(b);

    for (examples.kvs) |kv| {
        const exe = b.addExecutable(.{
            .name = kv.key,
            // In this case the main source file is merely a path, however, in more
            // complicated build scripts, this could be a generated file.
            .root_source_file = .{ .path = kv.value },
            .target = target,
            .optimize = optimize,
        });

        exe.addModule("objc", mod_objc);
        exe.addModule("uuid", mod_uuid);
        exe.addModule("Runtime", mod_runtime);
        exe.addModule("AppKit", mod_appKit);
        exe.addModule("Foundation", mod_foundation);
        exe.addModule("AppKit-Support", mod_appKit_support);

        exe.addSystemIncludePath(.{ .path = "/usr/include" });
        exe.addFrameworkPath(.{ .path = "/System/Library/Frameworks" });
        exe.linkFramework("AppKit");

        // For default step (build install)
        b.installArtifact(exe);
        // For example step
        example_cmd.addExample(exe, .{});
    }

    // Creates a step for unit testing. This only builds the test executable
    // but does not run it.
    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);

    // Similar to creating the run step earlier, this exposes a `test` step to
    // the `zig build --help` menu, providing a way for the user to request
    // running the unit tests.
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
}
