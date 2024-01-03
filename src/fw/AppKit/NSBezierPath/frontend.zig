const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSBezierPath = struct {
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

    pub fn bezierPath() NSBezierPath {
        return runtime_support.wrapObject(NSBezierPath, backend.NSBezierPathMessages.bezierPath());
    }

    pub fn bezierPathWithOvalInRect(_rect: NSRect) NSBezierPath {
        return runtime_support.wrapObject(NSBezierPath, backend.NSBezierPathMessages.bezierPathWithOvalInRect(runtime_support.pass(NSRect, _rect)));
    }

    pub fn elementCount(self: Self) NSInteger {
        return backend.NSBezierPathMessages.elementCount(runtime_support.objectId(NSBezierPath, self));
    }

    pub fn elementAtIndexAssociatedPoints(self: Self, _index: NSInteger, _points: ?NSPointArray) NSBezierPathElement {
        return runtime_support.wrapEnum(NSBezierPathElement, NSUInteger, backend.NSBezierPathMessages.elementAtIndexAssociatedPoints(runtime_support.objectId(NSBezierPath, self), runtime_support.pass(NSInteger, _index), runtime_support.pass(?NSPointArray, _points)));
    }

    pub fn appendBezierPathWithOvalInRect(self: Self, _rect: NSRect) void {
        return backend.NSBezierPathMessages.appendBezierPathWithOvalInRect(runtime_support.objectId(NSBezierPath, self), runtime_support.pass(NSRect, _rect));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSBezierPathMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSBezierPath,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSCopying,
                NSSecureCoding,
                NSCoding,
            });
        }
    };

    pub const Self = @This();
};

pub const NSBezierPathElement = struct {
    _value: NSUInteger,

    pub const MoveTo: NSBezierPathElement = .{
        ._value = 0x0,
    };
    pub const LineTo: NSBezierPathElement = .{
        ._value = 0x1,
    };
    pub const CurveTo: NSBezierPathElement = .{
        ._value = 0x2,
    };
    pub const ClosePath: NSBezierPathElement = .{
        ._value = 0x3,
    };
};

pub const NSWindingRule = struct {
    _value: NSUInteger,

    pub const NonZero: NSWindingRule = .{
        ._value = 0,
    };
    pub const EvenOdd: NSWindingRule = .{
        ._value = 1,
    };
};

pub const NSLineCapStyle = struct {
    _value: NSUInteger,

    pub const Butt: NSLineCapStyle = .{
        ._value = 0,
    };
    pub const Round: NSLineCapStyle = .{
        ._value = 1,
    };
    pub const Square: NSLineCapStyle = .{
        ._value = 2,
    };
};

pub const NSLineJoinStyle = struct {
    _value: NSUInteger,

    pub const Miter: NSLineJoinStyle = .{
        ._value = 0,
    };
    pub const Round: NSLineJoinStyle = .{
        ._value = 1,
    };
    pub const Bevel: NSLineJoinStyle = .{
        ._value = 2,
    };
};

const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSPointArray = foundation.NSPointArray;
const NSRect = foundation.NSRect;
const NSSecureCoding = foundation.NSSecureCoding;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
