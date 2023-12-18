const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const coreGraphics = @import("CoreGraphics");
const runtime_support = @import("Runtime-Support");

pub const CGMutablePathRef = *CGPath;
pub const CGPathRef = *CGPath;
pub const CGPathApplierFunction = fn (_: ?*void, _: *const CGPathElement) void;
pub const CGPathApplyBlock = fn (_: *const CGPathElement) void;
const CGPoint = coreGraphics.CGPoint;

const CGPath = anyopaque;

pub const CGPathElement = extern struct {
    type: CGPathElementType,
    points: *CGPoint,
};

pub const CGLineJoin = struct {
    pub const kCGLineJoinMiter: CGLineJoin = .{
        ._value = 0x0,
    };
    pub const kCGLineJoinRound: CGLineJoin = .{
        ._value = 0x1,
    };
    pub const kCGLineJoinBevel: CGLineJoin = .{
        ._value = 0x2,
    };

    _value: i32,
};

pub const CGPathElementType = struct {
    pub const kCGPathElementMoveToPoint: CGPathElementType = .{
        ._value = 0x0,
    };
    pub const kCGPathElementAddLineToPoint: CGPathElementType = .{
        ._value = 0x1,
    };
    pub const kCGPathElementAddQuadCurveToPoint: CGPathElementType = .{
        ._value = 0x2,
    };
    pub const kCGPathElementAddCurveToPoint: CGPathElementType = .{
        ._value = 0x3,
    };
    pub const kCGPathElementCloseSubpath: CGPathElementType = .{
        ._value = 0x4,
    };

    _value: i32,
};

pub const CGLineCap = struct {
    pub const kCGLineCapButt: CGLineCap = .{
        ._value = 0x0,
    };
    pub const kCGLineCapRound: CGLineCap = .{
        ._value = 0x1,
    };
    pub const kCGLineCapSquare: CGLineCap = .{
        ._value = 0x2,
    };

    _value: i32,
};
