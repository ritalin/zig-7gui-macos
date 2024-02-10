const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const _NSRange = extern struct {
    location: NSUInteger,
    length: NSUInteger,
};

pub const NSRange = *const _NSRange;
const NSUInteger = runtime.NSUInteger;

pub extern fn NSMakeRange(loc: NSUInteger, len: NSUInteger) callconv(.C) NSRange;
