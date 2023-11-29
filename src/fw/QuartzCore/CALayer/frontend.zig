const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const coreGraphics = @import("CoreGraphics");
const foundation = @import("Foundation");
const quartzCore = @import("QuartzCore");
const runtime = @import("Runtime");

const CGColorRef = coreGraphics.CGColorRef;
const NSCoding = foundation.NSCoding;
const NSSecureCoding = foundation.NSSecureCoding;
const CAMediaTiming = quartzCore.CAMediaTiming;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
const ObjectResolver = runtime.ObjectResolver;

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

    var DelegateResolver: ?*ObjectResolver(CALayer) = null;

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub inline fn as(self: Self, comptime DesiredType: type) DesiredType {
        return runtime.ObjectUpperCast(Self, Self.Constructor).as(self, DesiredType);
    }

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.ObjectUpperCast(Self, Self.Constructor).of(DesiredType);
    }

    pub fn backgroundColor(self: Self) ?CGColorRef {
        return backend.CALayerMessages.backgroundColor(runtime.objectId(CALayer, self));
    }

    pub fn setBackgroundColor(self: Self, _backgroundColor: ?CGColorRef) void {
        return backend.CALayerMessages.setBackgroundColor(runtime.objectId(CALayer, self), runtime.pass(?CGColorRef, _backgroundColor));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.CALayerMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                CALayer,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                CAMediaTiming,
                NSSecureCoding,
                NSCoding,
            });
        }
    };
};

pub const _CALayerIvars = extern struct {
    refcount: i32,
    magic: u32,
    layer: *anyopaque,
};
