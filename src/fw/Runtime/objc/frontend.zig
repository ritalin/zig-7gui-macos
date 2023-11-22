const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");

pub const BOOL = i8;
pub const objc_objectptr_t = *anyopaque;

pub const objc_object = extern struct {};
