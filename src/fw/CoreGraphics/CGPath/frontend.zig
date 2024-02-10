const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const coreGraphics = @import("CoreGraphics");
const runtime_support = @import("Runtime-Support");

pub const CGPathElement = extern struct {
    type: CGPathElementType,
    points: *CGPoint,
};

pub const CGLineJoin = struct {
    _value: i32,

    pub const kCGLineJoinMiter: CGLineJoin = .{
        ._value = 0x0,
    };
    pub const kCGLineJoinRound: CGLineJoin = .{
        ._value = 0x1,
    };
    pub const kCGLineJoinBevel: CGLineJoin = .{
        ._value = 0x2,
    };
};

pub const CGPathElementType = struct {
    _value: i32,

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
};

pub const CGLineCap = struct {
    _value: i32,

    pub const kCGLineCapButt: CGLineCap = .{
        ._value = 0x0,
    };
    pub const kCGLineCapRound: CGLineCap = .{
        ._value = 0x1,
    };
    pub const kCGLineCapSquare: CGLineCap = .{
        ._value = 0x2,
    };
};

pub const CGMutablePathRef = *const *CGPath;
pub const CGPathRef = *const *CGPath;
const CGAffineTransform = coreGraphics.CGAffineTransform;
const CGFloat = coreGraphics.CGFloat;
const CGPoint = coreGraphics.CGPoint;

const CGPath = anyopaque;
pub extern fn CGPathCreateMutable() callconv(.C) CGMutablePathRef;
pub extern fn CGPathRelease(path: ?CGPathRef) callconv(.C) void;
pub extern fn CGPathMoveToPoint(path: ?CGMutablePathRef, m: ?*const CGAffineTransform, x: CGFloat, y: CGFloat) callconv(.C) void;
pub extern fn CGPathAddLineToPoint(path: ?CGMutablePathRef, m: ?*const CGAffineTransform, x: CGFloat, y: CGFloat) callconv(.C) void;
pub extern fn CGPathAddCurveToPoint(path: ?CGMutablePathRef, m: ?*const CGAffineTransform, cp1x: CGFloat, cp1y: CGFloat, cp2x: CGFloat, cp2y: CGFloat, x: CGFloat, y: CGFloat) callconv(.C) void;
pub extern fn CGPathCloseSubpath(path: ?CGMutablePathRef) callconv(.C) void;
