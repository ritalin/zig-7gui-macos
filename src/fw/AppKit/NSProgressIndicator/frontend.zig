const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSProgressIndicator = struct {
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

    pub fn isIndeterminate(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSProgressIndicatorMessages.isIndeterminate(runtime_support.objectId(NSProgressIndicator, self)));
    }

    pub fn setIndeterminate(self: Self, _indeterminate: bool) void {
        return backend.NSProgressIndicatorMessages.setIndeterminate(runtime_support.objectId(NSProgressIndicator, self), runtime_support.toBOOL(_indeterminate));
    }

    pub fn doubleValue(self: Self) f64 {
        return backend.NSProgressIndicatorMessages.doubleValue(runtime_support.objectId(NSProgressIndicator, self));
    }

    pub fn setDoubleValue(self: Self, _doubleValue: f64) void {
        return backend.NSProgressIndicatorMessages.setDoubleValue(runtime_support.objectId(NSProgressIndicator, self), _doubleValue);
    }

    pub fn incrementBy(self: Self, _delta: f64) void {
        return backend.NSProgressIndicatorMessages.incrementBy(runtime_support.objectId(NSProgressIndicator, self), _delta);
    }

    pub fn minValue(self: Self) f64 {
        return backend.NSProgressIndicatorMessages.minValue(runtime_support.objectId(NSProgressIndicator, self));
    }

    pub fn setMinValue(self: Self, _minValue: f64) void {
        return backend.NSProgressIndicatorMessages.setMinValue(runtime_support.objectId(NSProgressIndicator, self), _minValue);
    }

    pub fn maxValue(self: Self) f64 {
        return backend.NSProgressIndicatorMessages.maxValue(runtime_support.objectId(NSProgressIndicator, self));
    }

    pub fn setMaxValue(self: Self, _maxValue: f64) void {
        return backend.NSProgressIndicatorMessages.setMaxValue(runtime_support.objectId(NSProgressIndicator, self), _maxValue);
    }

    pub fn startAnimation(self: Self, _sender: ?objc.Object) void {
        return backend.NSProgressIndicatorMessages.startAnimation(runtime_support.objectId(NSProgressIndicator, self), runtime_support.pass(?objc.Object, _sender));
    }

    pub fn stopAnimation(self: Self, _sender: ?objc.Object) void {
        return backend.NSProgressIndicatorMessages.stopAnimation(runtime_support.objectId(NSProgressIndicator, self), runtime_support.pass(?objc.Object, _sender));
    }

    pub fn isDisplayedWhenStopped(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSProgressIndicatorMessages.isDisplayedWhenStopped(runtime_support.objectId(NSProgressIndicator, self)));
    }

    pub fn setDisplayedWhenStopped(self: Self, _displayedWhenStopped: bool) void {
        return backend.NSProgressIndicatorMessages.setDisplayedWhenStopped(runtime_support.objectId(NSProgressIndicator, self), runtime_support.toBOOL(_displayedWhenStopped));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSProgressIndicatorMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSProgressIndicator,
                NSView,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSAccessibilityProgressIndicator,
                NSAccessibilityGroup,
                NSAccessibilityElement,
                NSObjectProtocol,
            });
        }
    };

    pub const Self = @This();
};

pub const NSProgressIndicatorStyle = struct {
    _value: NSUInteger,

    pub const Bar: NSProgressIndicatorStyle = .{
        ._value = 0,
    };
    pub const Spinning: NSProgressIndicatorStyle = .{
        ._value = 1,
    };
};

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAccessibilityGroup = appKit.NSAccessibilityGroup;
const NSAccessibilityProgressIndicator = appKit.NSAccessibilityProgressIndicator;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSDraggingDestination = appKit.NSDraggingDestination;
const NSResponder = appKit.NSResponder;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSView = appKit.NSView;
const NSCoding = foundation.NSCoding;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
