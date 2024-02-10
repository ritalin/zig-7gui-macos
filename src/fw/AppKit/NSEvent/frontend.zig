const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSEventModifierFlags = runtime_support.EnumOptions(enum(NSUInteger) {
    FlagCapsLock = 1 << 16,
    FlagShift = 1 << 17,
    FlagControl = 1 << 18,
    FlagOption = 1 << 19,
    FlagCommand = 1 << 20,
    FlagNumericPad = 1 << 21,
    FlagHelp = 1 << 22,
    FlagFunction = 1 << 23,
});

pub const NSEventMask = runtime_support.EnumOptions(enum(c_ulonglong) {
    LeftMouseDown = 1 << NSEventType.LeftMouseDown._value,
    LeftMouseUp = 1 << NSEventType.LeftMouseUp._value,
    RightMouseDown = 1 << NSEventType.RightMouseDown._value,
    RightMouseUp = 1 << NSEventType.RightMouseUp._value,
    MouseMoved = 1 << NSEventType.MouseMoved._value,
    LeftMouseDragged = 1 << NSEventType.LeftMouseDragged._value,
    RightMouseDragged = 1 << NSEventType.RightMouseDragged._value,
    MouseEntered = 1 << NSEventType.MouseEntered._value,
    MouseExited = 1 << NSEventType.MouseExited._value,
    KeyDown = 1 << NSEventType.KeyDown._value,
    KeyUp = 1 << NSEventType.KeyUp._value,
    FlagsChanged = 1 << NSEventType.FlagsChanged._value,
    AppKitDefined = 1 << NSEventType.AppKitDefined._value,
    SystemDefined = 1 << NSEventType.SystemDefined._value,
    ApplicationDefined = 1 << NSEventType.ApplicationDefined._value,
    Periodic = 1 << NSEventType.Periodic._value,
    CursorUpdate = 1 << NSEventType.CursorUpdate._value,
    ScrollWheel = 1 << NSEventType.ScrollWheel._value,
    TabletPoint = 1 << NSEventType.TabletPoint._value,
    TabletProximity = 1 << NSEventType.TabletProximity._value,
    OtherMouseDown = 1 << NSEventType.OtherMouseDown._value,
    OtherMouseUp = 1 << NSEventType.OtherMouseUp._value,
    OtherMouseDragged = 1 << NSEventType.OtherMouseDragged._value,
    Gesture = 1 << NSEventType.Gesture._value,
    Magnify = 1 << NSEventType.Magnify._value,
    Swipe = 1 << NSEventType.Swipe._value,
    Rotate = 1 << NSEventType.Rotate._value,
    BeginGesture = 1 << NSEventType.BeginGesture._value,
    EndGesture = 1 << NSEventType.EndGesture._value,
    SmartMagnify = 1 << NSEventType.SmartMagnify._value,
    Pressure = 1 << NSEventType.Pressure._value,
    DirectTouch = 1 << NSEventType.DirectTouch._value,
    ChangeMode = 1 << NSEventType.ChangeMode._value,
});

pub const NSEvent = struct {
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

    pub fn @"type"(self: Self) NSEventType {
        return runtime_support.wrapEnum(NSEventType, NSUInteger, backend.NSEventMessages.type(runtime_support.objectId(NSEvent, self)));
    }

    pub fn modifierFlags(self: Self) NSEventModifierFlags {
        return runtime_support.unpackOptions(NSEventModifierFlags, NSUInteger, backend.NSEventMessages.modifierFlags(runtime_support.objectId(NSEvent, self)));
    }

    pub fn window(self: Self) ?NSWindow {
        return runtime_support.wrapObject(?NSWindow, backend.NSEventMessages.window(runtime_support.objectId(NSEvent, self)));
    }

    pub fn clickCount(self: Self) NSInteger {
        return backend.NSEventMessages.clickCount(runtime_support.objectId(NSEvent, self));
    }

    pub fn locationInWindow(self: Self) NSPoint {
        return backend.NSEventMessages.locationInWindow(runtime_support.objectId(NSEvent, self));
    }

    pub fn modifierFlagsCurrent() NSEventModifierFlags {
        return runtime_support.unpackOptions(NSEventModifierFlags, NSUInteger, backend.NSEventMessages.modifierFlagsCurrent());
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSEventMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSEvent,
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
};

pub const NSEventType = struct {
    _value: NSUInteger,

    pub const LeftMouseDown: NSEventType = .{
        ._value = 1,
    };
    pub const LeftMouseUp: NSEventType = .{
        ._value = 2,
    };
    pub const RightMouseDown: NSEventType = .{
        ._value = 3,
    };
    pub const RightMouseUp: NSEventType = .{
        ._value = 4,
    };
    pub const MouseMoved: NSEventType = .{
        ._value = 5,
    };
    pub const LeftMouseDragged: NSEventType = .{
        ._value = 6,
    };
    pub const RightMouseDragged: NSEventType = .{
        ._value = 7,
    };
    pub const MouseEntered: NSEventType = .{
        ._value = 8,
    };
    pub const MouseExited: NSEventType = .{
        ._value = 9,
    };
    pub const KeyDown: NSEventType = .{
        ._value = 10,
    };
    pub const KeyUp: NSEventType = .{
        ._value = 11,
    };
    pub const FlagsChanged: NSEventType = .{
        ._value = 12,
    };
    pub const AppKitDefined: NSEventType = .{
        ._value = 13,
    };
    pub const SystemDefined: NSEventType = .{
        ._value = 14,
    };
    pub const ApplicationDefined: NSEventType = .{
        ._value = 15,
    };
    pub const Periodic: NSEventType = .{
        ._value = 16,
    };
    pub const CursorUpdate: NSEventType = .{
        ._value = 17,
    };
    pub const ScrollWheel: NSEventType = .{
        ._value = 22,
    };
    pub const TabletPoint: NSEventType = .{
        ._value = 23,
    };
    pub const TabletProximity: NSEventType = .{
        ._value = 24,
    };
    pub const OtherMouseDown: NSEventType = .{
        ._value = 25,
    };
    pub const OtherMouseUp: NSEventType = .{
        ._value = 26,
    };
    pub const OtherMouseDragged: NSEventType = .{
        ._value = 27,
    };
    pub const Gesture: NSEventType = .{
        ._value = 29,
    };
    pub const Magnify: NSEventType = .{
        ._value = 30,
    };
    pub const Swipe: NSEventType = .{
        ._value = 31,
    };
    pub const Rotate: NSEventType = .{
        ._value = 18,
    };
    pub const BeginGesture: NSEventType = .{
        ._value = 19,
    };
    pub const EndGesture: NSEventType = .{
        ._value = 20,
    };
    pub const SmartMagnify: NSEventType = .{
        ._value = 32,
    };
    pub const QuickLook: NSEventType = .{
        ._value = 33,
    };
    pub const Pressure: NSEventType = .{
        ._value = 34,
    };
    pub const DirectTouch: NSEventType = .{
        ._value = 37,
    };
    pub const ChangeMode: NSEventType = .{
        ._value = 38,
    };
};

pub const NSPressureBehavior = struct {
    _value: NSInteger,

    pub const Unknown: NSPressureBehavior = .{
        ._value = -1,
    };
    pub const PrimaryDefault: NSPressureBehavior = .{
        ._value = 0,
    };
    pub const PrimaryClick: NSPressureBehavior = .{
        ._value = 1,
    };
    pub const PrimaryGeneric: NSPressureBehavior = .{
        ._value = 2,
    };
    pub const PrimaryAccelerator: NSPressureBehavior = .{
        ._value = 3,
    };
    pub const PrimaryDeepClick: NSPressureBehavior = .{
        ._value = 5,
    };
    pub const PrimaryDeepDrag: NSPressureBehavior = .{
        ._value = 6,
    };
};

pub const NSEventGestureAxis = struct {
    _value: NSInteger,

    pub const None: NSEventGestureAxis = .{
        ._value = 0,
    };
    pub const Horizontal: NSEventGestureAxis = .{
        ._value = 0x1,
    };
    pub const Vertical: NSEventGestureAxis = .{
        ._value = 0x2,
    };
};

const NSWindow = appKit.NSWindow;
const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSPoint = foundation.NSPoint;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
