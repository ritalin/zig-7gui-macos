const std = @import("std");

pub fn FixValueSeed(comptime value: []const u8) type {
    return struct {
        pub fn generateIdentifier() []const u8 {
            return value;
        }
    };
}
