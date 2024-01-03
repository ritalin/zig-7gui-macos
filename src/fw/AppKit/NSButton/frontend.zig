const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSButton = struct {
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

    pub fn setButtonType(self: Self, _type: NSButtonType) void {
        return backend.NSButtonMessages.setButtonType(runtime_support.objectId(NSButton, self), runtime_support.unwrapEnum(NSButtonType, NSUInteger, _type));
    }

    pub fn title(self: Self) NSString {
        return runtime_support.wrapObject(NSString, backend.NSButtonMessages.title(runtime_support.objectId(NSButton, self)));
    }

    pub fn setTitle(self: Self, _title: NSString) void {
        return backend.NSButtonMessages.setTitle(runtime_support.objectId(NSButton, self), runtime_support.objectId(NSString, _title));
    }

    pub fn bezelStyle(self: Self) NSBezelStyle {
        return runtime_support.wrapEnum(NSBezelStyle, NSUInteger, backend.NSButtonMessages.bezelStyle(runtime_support.objectId(NSButton, self)));
    }

    pub fn setBezelStyle(self: Self, _bezelStyle: NSBezelStyle) void {
        return backend.NSButtonMessages.setBezelStyle(runtime_support.objectId(NSButton, self), runtime_support.unwrapEnum(NSBezelStyle, NSUInteger, _bezelStyle));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn buttonWithTitleTargetAction(_title: NSString, _target: ?objc.Object, _action: ?objc.Sel) DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(DesiredType, backend.NSButtonMessages.buttonWithTitleTargetAction(_class, runtime_support.objectId(NSString, _title), runtime_support.pass(?objc.Object, _target), runtime_support.pass(?objc.Sel, _action)));
            }
        };
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSButtonMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSButton,
                NSControl,
                NSView,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSAccessibilityButton,
                NSUserInterfaceCompression,
                NSUserInterfaceValidations,
                NSAccessibilityElement,
                NSObjectProtocol,
            });
        }
    };

    pub const Self = @This();
};

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityButton = appKit.NSAccessibilityButton;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSBezelStyle = appKit.NSBezelStyle;
const NSButtonType = appKit.NSButtonType;
const NSControl = appKit.NSControl;
const NSDraggingDestination = appKit.NSDraggingDestination;
const NSResponder = appKit.NSResponder;
const NSUserInterfaceCompression = appKit.NSUserInterfaceCompression;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSUserInterfaceValidations = appKit.NSUserInterfaceValidations;
const NSView = appKit.NSView;
const NSCoding = foundation.NSCoding;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
