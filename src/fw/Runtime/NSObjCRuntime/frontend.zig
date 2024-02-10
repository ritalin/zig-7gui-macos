const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime_support = @import("Runtime-Support");

pub const NSInteger = *const c_long;
pub const NSUInteger = *const c_ulong;
