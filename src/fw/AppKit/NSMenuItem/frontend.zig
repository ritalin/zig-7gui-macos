const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSMenuItem = struct {
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

    pub fn target(self: Self) ?objc.Object {
        return backend.NSMenuItemMessages.target(runtime_support.objectId(NSMenuItem, self));
    }

    pub fn setTarget(self: Self, _target: ?objc.Object) void {
        return backend.NSMenuItemMessages.setTarget(runtime_support.objectId(NSMenuItem, self), runtime_support.pass(?objc.Object, _target));
    }

    pub fn action(self: Self) ?objc.Sel {
        return backend.NSMenuItemMessages.action(runtime_support.objectId(NSMenuItem, self));
    }

    pub fn setAction(self: Self, _action: ?objc.Sel) void {
        return backend.NSMenuItemMessages.setAction(runtime_support.objectId(NSMenuItem, self), runtime_support.pass(?objc.Sel, _action));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSMenuItemMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSMenuItem,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSAccessibility,
                NSAccessibilityElement,
                NSCoding,
                NSCopying,
                NSUserInterfaceItemIdentification,
                NSValidatedUserInterfaceItem,
                NSObjectProtocol,
            });
        }
    };

    pub const Self = @This();
};

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSValidatedUserInterfaceItem = appKit.NSValidatedUserInterfaceItem;
const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
