const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime_support = @import("Runtime-Support");

pub const BOOL = c_char;
pub const objc_objectptr_t = *anyopaque;

pub const objc_object = extern struct {};
