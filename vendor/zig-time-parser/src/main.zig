const std = @import("std");

pub usingnamespace @import("./iso8601_parser.zig");

pub fn main() !void {
    var v = @import("./iso8601_parser.zig").fromISO8601("2023-abc");

        // try std.testing.expectError(error.InvalidMonthDay, v);

    _ = try v;
}

test "root" {
    comptime {
        std.testing.refAllDecls(@This());
    }
}