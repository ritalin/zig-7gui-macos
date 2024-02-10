const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const coreFoundation = @import("CoreFoundation");
const coreGraphics = @import("CoreGraphics");
const runtime_support = @import("Runtime-Support");

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
    _value: u32,

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
};

const CFDictionaryRef = coreFoundation.CFDictionaryRef;
const CGFloat = coreGraphics.CGFloat;

pub extern fn CGRectGetMinX(rect: CGRect) callconv(.C) CGFloat;
pub extern fn CGRectGetMidX(rect: CGRect) callconv(.C) CGFloat;
pub extern fn CGRectGetMaxX(rect: CGRect) callconv(.C) CGFloat;
pub extern fn CGRectGetMinY(rect: CGRect) callconv(.C) CGFloat;
pub extern fn CGRectGetMidY(rect: CGRect) callconv(.C) CGFloat;
pub extern fn CGRectGetMaxY(rect: CGRect) callconv(.C) CGFloat;
pub extern fn CGRectGetWidth(rect: CGRect) callconv(.C) CGFloat;
pub extern fn CGRectGetHeight(rect: CGRect) callconv(.C) CGFloat;
pub extern fn CGPointEqualToPoint(point1: CGPoint, point2: CGPoint) callconv(.C) c_int;
pub extern fn CGSizeEqualToSize(size1: CGSize, size2: CGSize) callconv(.C) c_int;
pub extern fn CGRectEqualToRect(rect1: CGRect, rect2: CGRect) callconv(.C) c_int;
pub extern fn CGRectStandardize(rect: CGRect) callconv(.C) CGRect;
pub extern fn CGRectIsEmpty(rect: CGRect) callconv(.C) c_int;
pub extern fn CGRectIsNull(rect: CGRect) callconv(.C) c_int;
pub extern fn CGRectIsInfinite(rect: CGRect) callconv(.C) c_int;
pub extern fn CGRectInset(rect: CGRect, dx: CGFloat, dy: CGFloat) callconv(.C) CGRect;
pub extern fn CGRectIntegral(rect: CGRect) callconv(.C) CGRect;
pub extern fn CGRectUnion(r1: CGRect, r2: CGRect) callconv(.C) CGRect;
pub extern fn CGRectIntersection(r1: CGRect, r2: CGRect) callconv(.C) CGRect;
pub extern fn CGRectOffset(rect: CGRect, dx: CGFloat, dy: CGFloat) callconv(.C) CGRect;
pub extern fn CGRectDivide(rect: CGRect, slice: *CGRect, remainder: *CGRect, amount: CGFloat, edge: CGRectEdge) callconv(.C) void;
pub extern fn CGRectContainsPoint(rect: CGRect, point: CGPoint) callconv(.C) c_int;
pub extern fn CGRectContainsRect(rect1: CGRect, rect2: CGRect) callconv(.C) c_int;
pub extern fn CGRectIntersectsRect(rect1: CGRect, rect2: CGRect) callconv(.C) c_int;
pub extern fn CGPointCreateDictionaryRepresentation(point: CGPoint) callconv(.C) CFDictionaryRef;
pub extern fn CGPointMakeWithDictionaryRepresentation(dict: ?CFDictionaryRef, point: ?*CGPoint) callconv(.C) c_int;
pub extern fn CGSizeCreateDictionaryRepresentation(size: CGSize) callconv(.C) CFDictionaryRef;
pub extern fn CGSizeMakeWithDictionaryRepresentation(dict: ?CFDictionaryRef, size: ?*CGSize) callconv(.C) c_int;
pub extern fn CGRectCreateDictionaryRepresentation(p0: CGRect) callconv(.C) CFDictionaryRef;
pub extern fn CGRectMakeWithDictionaryRepresentation(dict: ?CFDictionaryRef, rect: ?*CGRect) callconv(.C) c_int;
