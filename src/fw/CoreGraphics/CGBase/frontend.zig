const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime_support = @import("Runtime-Support");

pub const CGFloat = f64;
pub const IOSurfaceRef = *__IOSurface;

const __IOSurface = anyopaque;
