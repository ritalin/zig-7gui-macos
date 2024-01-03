const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
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

const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const NSUpArrowFunctionKey: c_uint = 0xF700;
pub const NSDownArrowFunctionKey: c_uint = 0xF701;
pub const NSLeftArrowFunctionKey: c_uint = 0xF702;
pub const NSRightArrowFunctionKey: c_uint = 0xF703;
pub const NSF1FunctionKey: c_uint = 0xF704;
pub const NSF2FunctionKey: c_uint = 0xF705;
pub const NSF3FunctionKey: c_uint = 0xF706;
pub const NSF4FunctionKey: c_uint = 0xF707;
pub const NSF5FunctionKey: c_uint = 0xF708;
pub const NSF6FunctionKey: c_uint = 0xF709;
pub const NSF7FunctionKey: c_uint = 0xF70A;
pub const NSF8FunctionKey: c_uint = 0xF70B;
pub const NSF9FunctionKey: c_uint = 0xF70C;
pub const NSF10FunctionKey: c_uint = 0xF70D;
pub const NSF11FunctionKey: c_uint = 0xF70E;
pub const NSF12FunctionKey: c_uint = 0xF70F;
pub const NSF13FunctionKey: c_uint = 0xF710;
pub const NSF14FunctionKey: c_uint = 0xF711;
pub const NSF15FunctionKey: c_uint = 0xF712;
pub const NSF16FunctionKey: c_uint = 0xF713;
pub const NSF17FunctionKey: c_uint = 0xF714;
pub const NSF18FunctionKey: c_uint = 0xF715;
pub const NSF19FunctionKey: c_uint = 0xF716;
pub const NSF20FunctionKey: c_uint = 0xF717;
pub const NSF21FunctionKey: c_uint = 0xF718;
pub const NSF22FunctionKey: c_uint = 0xF719;
pub const NSF23FunctionKey: c_uint = 0xF71A;
pub const NSF24FunctionKey: c_uint = 0xF71B;
pub const NSF25FunctionKey: c_uint = 0xF71C;
pub const NSF26FunctionKey: c_uint = 0xF71D;
pub const NSF27FunctionKey: c_uint = 0xF71E;
pub const NSF28FunctionKey: c_uint = 0xF71F;
pub const NSF29FunctionKey: c_uint = 0xF720;
pub const NSF30FunctionKey: c_uint = 0xF721;
pub const NSF31FunctionKey: c_uint = 0xF722;
pub const NSF32FunctionKey: c_uint = 0xF723;
pub const NSF33FunctionKey: c_uint = 0xF724;
pub const NSF34FunctionKey: c_uint = 0xF725;
pub const NSF35FunctionKey: c_uint = 0xF726;
pub const NSInsertFunctionKey: c_uint = 0xF727;
pub const NSDeleteFunctionKey: c_uint = 0xF728;
pub const NSHomeFunctionKey: c_uint = 0xF729;
pub const NSBeginFunctionKey: c_uint = 0xF72A;
pub const NSEndFunctionKey: c_uint = 0xF72B;
pub const NSPageUpFunctionKey: c_uint = 0xF72C;
pub const NSPageDownFunctionKey: c_uint = 0xF72D;
pub const NSPrintScreenFunctionKey: c_uint = 0xF72E;
pub const NSScrollLockFunctionKey: c_uint = 0xF72F;
pub const NSPauseFunctionKey: c_uint = 0xF730;
pub const NSSysReqFunctionKey: c_uint = 0xF731;
pub const NSBreakFunctionKey: c_uint = 0xF732;
pub const NSResetFunctionKey: c_uint = 0xF733;
pub const NSStopFunctionKey: c_uint = 0xF734;
pub const NSMenuFunctionKey: c_uint = 0xF735;
pub const NSUserFunctionKey: c_uint = 0xF736;
pub const NSSystemFunctionKey: c_uint = 0xF737;
pub const NSPrintFunctionKey: c_uint = 0xF738;
pub const NSClearLineFunctionKey: c_uint = 0xF739;
pub const NSClearDisplayFunctionKey: c_uint = 0xF73A;
pub const NSInsertLineFunctionKey: c_uint = 0xF73B;
pub const NSDeleteLineFunctionKey: c_uint = 0xF73C;
pub const NSInsertCharFunctionKey: c_uint = 0xF73D;
pub const NSDeleteCharFunctionKey: c_uint = 0xF73E;
pub const NSPrevFunctionKey: c_uint = 0xF73F;
pub const NSNextFunctionKey: c_uint = 0xF740;
pub const NSSelectFunctionKey: c_uint = 0xF741;
pub const NSExecuteFunctionKey: c_uint = 0xF742;
pub const NSUndoFunctionKey: c_uint = 0xF743;
pub const NSRedoFunctionKey: c_uint = 0xF744;
pub const NSFindFunctionKey: c_uint = 0xF745;
pub const NSHelpFunctionKey: c_uint = 0xF746;
pub const NSModeSwitchFunctionKey: c_uint = 0xF747;
