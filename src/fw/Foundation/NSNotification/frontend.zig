const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSNotification = struct {
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

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSNotificationMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSNotification,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSCoding,
                NSCopying,
            });
        }
    };

    pub const Self = @This();
    pub const Creation = NSNotificationCreationForNSNotification;
};

pub const NSNotificationCenter = struct {
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

    pub fn defaultCenter() NSNotificationCenter {
        return runtime_support.wrapObject(NSNotificationCenter, backend.NSNotificationCenterMessages.defaultCenter());
    }

    pub fn addObserverSelectorName(self: Self, _observer: objc.Object, _aSelector: objc.Sel, _aName: ?NSNotificationName, _anObject: ?objc.Object) void {
        return backend.NSNotificationCenterMessages.addObserverSelectorName(runtime_support.objectId(NSNotificationCenter, self), runtime_support.pass(objc.Object, _observer), runtime_support.pass(objc.Sel, _aSelector), runtime_support.objectId(?NSString, _aName), runtime_support.pass(?objc.Object, _anObject));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSNotificationCenterMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSNotificationCenter,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const Self = @This();
};

const NSNotificationCreationForNSNotification = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSNotification;
};

pub const NSNotificationName = *const NSString;
const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
