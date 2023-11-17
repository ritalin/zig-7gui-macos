const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");

pub const CGFloat = f64;
pub const IOSurfaceRef = *__IOSurface;

const __IOSurface = anyopaque;
