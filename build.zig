const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // ObjC Runtime
    const dep_objc = b.dependency("objc", .{
        .target = target,
        .optimize = optimize,
    });
    const mod_objc = dep_objc.module("objc");

    const dep_sparse_enumset = b.dependency("sparse_enumset", .{});
    const mod_sparse_enumset = dep_sparse_enumset.module("sparse_enumset");

    // Core modules (NSObject, etc...)
    const mod_runtime = b.createModule(.{ .root_source_file = .{ .path = "src/fw/Runtime.zig" }, .imports = &.{
        .{ .name = "objc", .module = mod_objc },
    } });
    mod_runtime.addImport("Runtime", mod_runtime);

    const mod_runtime_support = b.createModule(.{ .root_source_file = .{ .path = "src/fw/Support/RuntimeSupport.zig" }, .imports = &.{
        .{ .name = "objc", .module = mod_objc },
        .{ .name = "sparse-enumset", .module = mod_sparse_enumset },
        .{ .name = "Runtime", .module = mod_runtime },
    } });
    mod_runtime_support.addImport("Runtime-Support", mod_runtime_support);
    mod_runtime.addImport("Runtime-Support", mod_runtime_support);

    // QuartzCore.framework (referencing from AppKit.framework)
    const mod_quartz = b.createModule(.{
        .root_source_file = .{ .path = "src/fw/QuartzCore.zig" },
        .imports = &.{
            .{ .name = "objc", .module = mod_objc },
            .{ .name = "Runtime", .module = mod_runtime },
            .{ .name = "Runtime-Support", .module = mod_runtime_support },
        },
    });
    mod_quartz.addImport("QuartzCore", mod_quartz);
    // CoreGraphics.framework (referencing from AppKit.framework)
    const mod_coreGraphics = b.createModule(.{
        .root_source_file = .{ .path = "src/fw/CoreGraphics.zig" },
        .imports = &.{
            .{ .name = "objc", .module = mod_objc },
            .{ .name = "Runtime", .module = mod_runtime },
            .{ .name = "QuartzCore", .module = mod_quartz },
            .{ .name = "Runtime-Support", .module = mod_runtime_support },
        },
    });
    mod_coreGraphics.addImport("CoreGraphics", mod_coreGraphics);
    // QuartzCore and CoreGraphics has been depended each other.
    mod_quartz.addImport("CoreGraphics", mod_coreGraphics);

    // Foundation.framework
    const mod_foundation = b.createModule(.{
        .root_source_file = .{ .path = "src/fw/Foundation.zig" },
        .imports = &.{
            .{ .name = "objc", .module = mod_objc },
            .{ .name = "Runtime", .module = mod_runtime },
            .{ .name = "CoreGraphics", .module = mod_coreGraphics },
            .{ .name = "Runtime-Support", .module = mod_runtime_support },
        },
    });
    mod_foundation.addImport("Foundation", mod_foundation);
    mod_coreGraphics.addImport("Foundation", mod_foundation);
    mod_quartz.addImport("Foundation", mod_foundation);

    // AppKit.framework
    const mod_appKit = b.createModule(.{
        .root_source_file = .{ .path = "src/fw/AppKit.zig" },
        .imports = &.{
            .{ .name = "objc", .module = mod_objc },
            .{ .name = "Runtime", .module = mod_runtime },
            .{ .name = "Foundation", .module = mod_foundation },
            .{ .name = "QuartzCore", .module = mod_quartz },
            .{ .name = "CoreGraphics", .module = mod_coreGraphics },
            .{ .name = "Runtime-Support", .module = mod_runtime_support },
        },
    });
    mod_appKit.addImport("AppKit", mod_appKit);

    // AppKit support package (event handling, etc..)
    const mod_appKit_support = b.createModule(.{ .root_source_file = .{ .path = "src/fw/Support/AppKitSupport.zig" }, .imports = &.{
        .{ .name = "objc", .module = mod_objc },
        .{ .name = "Runtime", .module = mod_runtime },
        .{ .name = "CoreGraphics", .module = mod_coreGraphics },
        .{ .name = "Foundation", .module = mod_foundation },
        .{ .name = "AppKit", .module = mod_appKit },
        .{ .name = "Runtime-Support", .module = mod_runtime_support },
    } });

    const dep_time_formatter = b.dependency("time_formatter", .{
        // .target = target,
        // .optimize = optimize,
    });
    const mod_time_formatter = dep_time_formatter.module("time-formatter");

    const dep_time_parser = b.dependency("time_parser", .{});
    const mod_time_parser = dep_time_parser.module("time-parser");

    const examples = &[_](struct {[]const u8, []const u8}){
        .{ "counter", "src/examples/01_counter/main.zig" },
        .{ "temp_conv", "src/examples/02_temp_conv/main.zig" },
        .{ "book_flight", "src/examples/03_book_flight/main.zig" },
        .{ "timer", "src/examples/04_timer/main.zig" },
        .{ "crud", "src/examples/05_crud/main.zig" },
        .{ "circle_drawer", "src/examples/06_circle_drawer/main.zig" },
        .{ "cells", "src/examples/07_cells/main.zig" },
    };

    // create example step
    const example_cmd = try @import("example_step").RunExample.create(b);

    for (examples) |kv| {
        const exe = b.addExecutable(.{
            .name = kv[0],
            // In this case the main source file is merely a path, however, in more
            // complicated build scripts, this could be a generated file.
            .root_source_file = .{ .path = kv[1] },
            .target = target,
            .optimize = optimize,
        });

        exe.root_module.addImport("objc", mod_objc);
        exe.root_module.addImport("Runtime", mod_runtime);
        exe.root_module.addImport("CoreGraphics", mod_coreGraphics);
        exe.root_module.addImport("QuartzCore", mod_quartz);
        exe.root_module.addImport("Foundation", mod_foundation);
        exe.root_module.addImport("AppKit", mod_appKit);
        exe.root_module.addImport("Runtime-Support", mod_runtime_support);
        exe.root_module.addImport("AppKit-Support", mod_appKit_support);

        // exe.addModule("time", mod_time);
        exe.root_module.addImport("time-parser", mod_time_parser);
        exe.root_module.addImport("time-formatter", mod_time_formatter);

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
