const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const coreGraphics = @import("CoreGraphics");
const runtime_support = @import("Runtime-Support");

const CGFloat = coreGraphics.CGFloat;

pub const CGPoint = extern struct {
    x: CGFloat,
    y: CGFloat,
};

pub const CGSize = extern struct {
    width: CGFloat,
    height: CGFloat,
};

pub const CGVector = extern struct {
    dx: CGFloat,
    dy: CGFloat,
};

pub const CGRect = extern struct {
    origin: CGPoint,
    size: CGSize,
};

pub const CGRectEdge = struct {
    pub const MinX: CGRectEdge = .{
        ._value = 0x0,
    };
    pub const MinY: CGRectEdge = .{
        ._value = 0x1,
    };
    pub const MaxX: CGRectEdge = .{
        ._value = 0x2,
    };
    pub const MaxY: CGRectEdge = .{
        ._value = 0x3,
    };

    _value: u32,
};
