const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSNotificationName = foundation.NSNotificationName;
const NSRect = foundation.NSRect;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;

pub const NSScreen = struct {
    pub const Self = @This();
    pub const Extensions = ExtensionsForNSScreen;
    pub const Deprecated = NSDeprecatedForNSScreen;

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

    pub fn mainScreen() ?NSScreen {
        return runtime.wrapOptionalObject(NSScreen, backend.NSScreenMessages.mainScreen());
    }

    pub fn frame(self: Self) NSRect {
        return backend.NSScreenMessages.frame(runtime.objectId(NSScreen, self));
    }

    pub fn visibleFrame(self: Self) NSRect {
        return backend.NSScreenMessages.visibleFrame(runtime.objectId(NSScreen, self));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSScreenMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSObject,
                NSScreen,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};

const ExtensionsForNSScreen = struct {
    const Category = @This();
    pub const Self = NSScreen;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSDeprecatedForNSScreen = struct {
    const Category = @This();
    pub const Self = NSScreen;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};
