const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime_support = @import("Runtime-Support");

pub const NSTimeInterval = f64;
const NSNotificationName = foundation.NSNotificationName;
