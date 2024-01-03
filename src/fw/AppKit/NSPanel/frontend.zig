const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSPanel = struct {
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

    pub fn isFloatingPanel(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSPanelMessages.isFloatingPanel(runtime_support.objectId(NSPanel, self)));
    }

    pub fn setFloatingPanel(self: Self, _floatingPanel: bool) void {
        return backend.NSPanelMessages.setFloatingPanel(runtime_support.objectId(NSPanel, self), runtime_support.toBOOL(_floatingPanel));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSPanelMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSPanel,
                NSWindow,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const Self = @This();
};

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSMenuItemValidation = appKit.NSMenuItemValidation;
const NSResponder = appKit.NSResponder;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSUserInterfaceValidations = appKit.NSUserInterfaceValidations;
const NSWindow = appKit.NSWindow;
const NSCoding = foundation.NSCoding;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;

pub const NSAlertDefaultReturn: c_int = 1;
pub const NSAlertAlternateReturn: c_int = 0;
pub const NSAlertOtherReturn: c_int = -1;
pub const NSAlertErrorReturn: c_int = -2;
