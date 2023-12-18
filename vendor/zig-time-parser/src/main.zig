const std = @import("std");

pub const fromISO8601 = @import("./iso8601_parser.zig").fromISO8601;

const testingTimestampMili = @import("./iso8601_parser.zig").testingTimestampMili;

// ----

const time_formatter = @import("time-formatter");

pub fn main() !void {
    const expect = testingTimestampMili(.{
        .years = 2023, .months = 3, .days = 9,
        .hours = 0, .minutes = 0, .seconds = 0, .ms = 0,
    });
    std.debug.print("Debug.Expect: {yyyy-MM-dd}\n", .{ time_formatter.FormattableTime{ .with_offset = expect } });

    const actual = try fromISO8601("2023-11-23T01:23:45");
    std.debug.print("Debug.Actual: {yyyy-MM-dd}\n", .{ time_formatter.FormattableTime{ .with_offset = actual } });

        // try std.testing.expectError(error.InvalidMonthDay, v);

}

test "root" {
    comptime {
        std.testing.refAllDecls(@This());
    }
}