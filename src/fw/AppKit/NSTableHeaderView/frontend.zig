const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTableHeaderView = struct {
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
            return backend.NSTableHeaderViewMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSTableHeaderView,
                NSView,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSViewToolTipOwner,
                NSObjectProtocol,
            });
        }
    };

    pub const Self = @This();
};

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSDraggingDestination = appKit.NSDraggingDestination;
const NSResponder = appKit.NSResponder;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSView = appKit.NSView;
const NSViewToolTipOwner = appKit.NSViewToolTipOwner;
const NSCoding = foundation.NSCoding;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
