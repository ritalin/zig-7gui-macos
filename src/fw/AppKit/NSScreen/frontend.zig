const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSScreen = struct {
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

    pub fn mainScreen() ?NSScreen {
        return runtime_support.wrapObject(?NSScreen, backend.NSScreenMessages.mainScreen());
    }

    pub fn frame(self: Self) NSRect {
        return backend.NSScreenMessages.frame(runtime_support.objectId(NSScreen, self));
    }

    pub fn visibleFrame(self: Self) NSRect {
        return backend.NSScreenMessages.visibleFrame(runtime_support.objectId(NSScreen, self));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSScreenMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSScreen,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const Self = @This();
    pub const Extensions = ExtensionsForNSScreen;
};

const ExtensionsForNSScreen = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSScreen;
};

const NSRect = foundation.NSRect;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
