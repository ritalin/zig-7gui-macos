const std = @import("std");

pub const BlockContextRef = *anyopaque;

pub fn ApiBlock(comptime Args: type) type {
    _ = Args;

    return struct {
        context: BlockContextRef,
    };
}

pub fn BlockCaptures(comptime UserContext: type) type {
    return struct { context: *UserContext };
}
