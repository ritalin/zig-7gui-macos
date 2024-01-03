const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const coreFoundation = @import("CoreFoundation");
const runtime_support = @import("Runtime-Support");

pub const CGColorRef = *CGColor;
const CFStringRef = coreFoundation.CFStringRef;

const CGColor = anyopaque;
