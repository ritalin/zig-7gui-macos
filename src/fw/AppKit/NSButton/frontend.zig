const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityButton = appKit.NSAccessibilityButton;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
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

pub const NSButton = struct {
    pub const Self = @This();

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

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn buttonWithTitleTargetAction(_title: NSString, _target: ?objc.Object, _action: ?objc.Sel) DesiredType {
                var _class = DesiredType.Support.getClass();
                return runtime.wrapObject(DesiredType, backend.NSButtonMessages.buttonWithTitleTargetAction(_class, runtime.objectId(NSString, _title), runtime.pass(?objc.Object, _target), runtime.pass(?objc.Sel, _action)));
            }
        };
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSButtonMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSButton,
                NSControl,
                NSView,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSAccessibilityButton,
                NSUserInterfaceCompression,
                NSUserInterfaceValidations,
                NSAccessibilityElement,
                NSObjectProtocol,
            });
        }
    };
};
