const std = @import("std");

pub usingnamespace @import("./sparse-enumset.zig");

test "main" {
    std.testing.refAllDecls(@This());
}
