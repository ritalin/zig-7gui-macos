const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const coreGraphics = @import("CoreGraphics");
const foundation = @import("Foundation");
const quartzCore = @import("QuartzCore");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const CGColorRef = coreGraphics.CGColorRef;
const CGFloat = coreGraphics.CGFloat;
const NSCoding = foundation.NSCoding;
const NSSecureCoding = foundation.NSSecureCoding;
const CAMediaTiming = quartzCore.CAMediaTiming;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const CAAutoresizingMask = std.enums.EnumSet(enum(c_uint) {
    kCALayerMinXMargin = 1 << 0,
    kCALayerWidthSizable = 1 << 1,
    kCALayerMaxXMargin = 1 << 2,
    kCALayerMinYMargin = 1 << 3,
    kCALayerHeightSizable = 1 << 4,
    kCALayerMaxYMargin = 1 << 5,
});

pub const CAEdgeAntialiasingMask = std.enums.EnumSet(enum(c_uint) {
    kCALayerLeftEdge = 1 << 0,
    kCALayerRightEdge = 1 << 1,
    kCALayerBottomEdge = 1 << 2,
    kCALayerTopEdge = 1 << 3,
});

pub const CACornerMask = std.enums.EnumSet(enum(NSUInteger) {
    kCALayerMinXMinYCorner = 1 << 0,
    kCALayerMaxXMinYCorner = 1 << 1,
    kCALayerMinXMaxYCorner = 1 << 2,
    kCALayerMaxXMaxYCorner = 1 << 3,
});

pub const CALayer = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub inline fn as(self: Self, comptime DesiredType: type) DesiredType {
        return runtime_support.ObjectUpperCast(Self, Self.Constructor).as(self, DesiredType);
    }

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.ObjectUpperCast(Self, Self.Constructor).of(DesiredType);
    }

    pub fn masksToBounds(self: Self) bool {
        return runtime_support.fromBOOL(backend.CALayerMessages.masksToBounds(runtime_support.objectId(CALayer, self)));
    }

    pub fn setMasksToBounds(self: Self, _masksToBounds: bool) void {
        return backend.CALayerMessages.setMasksToBounds(runtime_support.objectId(CALayer, self), runtime_support.toBOOL(_masksToBounds));
    }

    pub fn backgroundColor(self: Self) ?CGColorRef {
        return backend.CALayerMessages.backgroundColor(runtime_support.objectId(CALayer, self));
    }

    pub fn setBackgroundColor(self: Self, _backgroundColor: ?CGColorRef) void {
        return backend.CALayerMessages.setBackgroundColor(runtime_support.objectId(CALayer, self), runtime_support.pass(?CGColorRef, _backgroundColor));
    }

    pub fn cornerRadius(self: Self) CGFloat {
        return backend.CALayerMessages.cornerRadius(runtime_support.objectId(CALayer, self));
    }

    pub fn setCornerRadius(self: Self, _cornerRadius: CGFloat) void {
        return backend.CALayerMessages.setCornerRadius(runtime_support.objectId(CALayer, self), runtime_support.pass(CGFloat, _cornerRadius));
    }

    pub fn borderWidth(self: Self) CGFloat {
        return backend.CALayerMessages.borderWidth(runtime_support.objectId(CALayer, self));
    }

    pub fn setBorderWidth(self: Self, _borderWidth: CGFloat) void {
        return backend.CALayerMessages.setBorderWidth(runtime_support.objectId(CALayer, self), runtime_support.pass(CGFloat, _borderWidth));
    }

    pub fn borderColor(self: Self) ?CGColorRef {
        return backend.CALayerMessages.borderColor(runtime_support.objectId(CALayer, self));
    }

    pub fn setBorderColor(self: Self, _borderColor: ?CGColorRef) void {
        return backend.CALayerMessages.setBorderColor(runtime_support.objectId(CALayer, self), runtime_support.pass(?CGColorRef, _borderColor));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.CALayerMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                CALayer,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                CAMediaTiming,
                NSSecureCoding,
                NSCoding,
            });
        }
    };
};
