const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const dep_time = b.dependency("time", .{
        .target = target,
        .optimize = optimize,
    });
    const mod_time = dep_time.module("time");

    const mod_time_parser = b.addModule(
        "time-parser",
        .{
            .source_file = .{ .path = "src/main.zig" },
            .dependencies = &.{
                .{ .name = "time", .module = mod_time },
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
    exe.addModule("time-parser", mod_time_parser);
    exe.addModule("time", mod_time);

    b.installArtifact(exe);
    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run unit tests");
    run_step.dependOn(&run_cmd.step);

    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    unit_tests.addModule("time-parser", mod_time_parser);
    unit_tests.addModule("time", mod_time);

    const run_unit_tests = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);

}
