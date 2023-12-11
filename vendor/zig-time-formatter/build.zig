const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // const target = b.standardTargetOptions(.{});
    // const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule(
        "time-formatter",
        .{
            .source_file = .{ .path = "src/main.zig" },
            .dependencies = &.{},
        }
    );
}
