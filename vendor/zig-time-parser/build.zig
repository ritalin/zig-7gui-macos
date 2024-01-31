const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const dep_time_formatter = b.dependency("time_formatter", .{});
    const mod_time_formatter = dep_time_formatter.module("time-formatter");

    const mod_time_parser = b.addModule(
        "time-parser",
        .{
            .root_source_file = .{ .path = "src/main.zig" },
            .imports = &.{
                .{ .name = "time-formatter", .module = mod_time_formatter },
            },
        },
    );

    const exe = b.addExecutable(.{
        .name = "time-parser",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .path = "./src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("time-parser", mod_time_parser);
    exe.root_module.addImport("time-formatter", mod_time_formatter);

    b.installArtifact(exe);
    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run unit tests");
    run_step.dependOn(&run_cmd.step);

    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    unit_tests.root_module.addImport("time-parser", mod_time_parser);
    unit_tests.root_module.addImport("time-formatter", mod_time_formatter);

    const run_unit_tests = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);

}
