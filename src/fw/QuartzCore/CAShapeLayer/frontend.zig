const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const coreGraphics = @import("CoreGraphics");
const foundation = @import("Foundation");
const quartzCore = @import("QuartzCore");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const CAShapeLayer = struct {
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

    pub fn path(self: Self) ?CGPathRef {
        return backend.CAShapeLayerMessages.path(runtime_support.objectId(CAShapeLayer, self));
    }

    pub fn setPath(self: Self, _path: ?CGPathRef) void {
        return backend.CAShapeLayerMessages.setPath(runtime_support.objectId(CAShapeLayer, self), runtime_support.pass(?CGPathRef, _path));
    }

    pub fn fillColor(self: Self) ?CGColorRef {
        return backend.CAShapeLayerMessages.fillColor(runtime_support.objectId(CAShapeLayer, self));
    }

    pub fn setFillColor(self: Self, _fillColor: ?CGColorRef) void {
        return backend.CAShapeLayerMessages.setFillColor(runtime_support.objectId(CAShapeLayer, self), runtime_support.pass(?CGColorRef, _fillColor));
    }

    pub fn strokeColor(self: Self) ?CGColorRef {
        return backend.CAShapeLayerMessages.strokeColor(runtime_support.objectId(CAShapeLayer, self));
    }

    pub fn setStrokeColor(self: Self, _strokeColor: ?CGColorRef) void {
        return backend.CAShapeLayerMessages.setStrokeColor(runtime_support.objectId(CAShapeLayer, self), runtime_support.pass(?CGColorRef, _strokeColor));
    }

    pub fn lineWidth(self: Self) CGFloat {
        return backend.CAShapeLayerMessages.lineWidth(runtime_support.objectId(CAShapeLayer, self));
    }

    pub fn setLineWidth(self: Self, _lineWidth: CGFloat) void {
        return backend.CAShapeLayerMessages.setLineWidth(runtime_support.objectId(CAShapeLayer, self), runtime_support.pass(CGFloat, _lineWidth));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.CAShapeLayerMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                CAShapeLayer,
                CALayer,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const Self = @This();
};

const CGColorRef = coreGraphics.CGColorRef;
const CGFloat = coreGraphics.CGFloat;
const CGPathRef = coreGraphics.CGPathRef;
const NSCoding = foundation.NSCoding;
const NSSecureCoding = foundation.NSSecureCoding;
const CALayer = quartzCore.CALayer;
const CAMediaTiming = quartzCore.CAMediaTiming;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
