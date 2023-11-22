const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSResponder = appKit.NSResponder;
const NSTextAlignment = appKit.NSTextAlignment;
const NSView = appKit.NSView;
const NSNotificationName = foundation.NSNotificationName;
const NSRect = foundation.NSRect;
const NSString = foundation.NSString;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;

pub const NSControl = struct {
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

    pub fn stringValue(self: Self) NSString {
        return runtime.wrapObject(NSString, backend.NSControlMessages.stringValue(runtime.objectId(NSControl, self)));
    }

    pub fn setStringValue(self: Self, _stringValue: NSString) void {
        return backend.NSControlMessages.setStringValue(runtime.objectId(NSControl, self), runtime.objectId(NSString, _stringValue));
    }

    pub fn intValue(self: Self) c_int {
        return backend.NSControlMessages.intValue(runtime.objectId(NSControl, self));
    }

    pub fn setIntValue(self: Self, _intValue: c_int) void {
        return backend.NSControlMessages.setIntValue(runtime.objectId(NSControl, self), _intValue);
    }

    pub fn integerValue(self: Self) NSInteger {
        return backend.NSControlMessages.integerValue(runtime.objectId(NSControl, self));
    }

    pub fn setIntegerValue(self: Self, _integerValue: NSInteger) void {
        return backend.NSControlMessages.setIntegerValue(runtime.objectId(NSControl, self), runtime.pass(NSInteger, _integerValue));
    }

    pub fn floatValue(self: Self) f32 {
        return backend.NSControlMessages.floatValue(runtime.objectId(NSControl, self));
    }

    pub fn setFloatValue(self: Self, _floatValue: f32) void {
        return backend.NSControlMessages.setFloatValue(runtime.objectId(NSControl, self), _floatValue);
    }

    pub fn doubleValue(self: Self) f64 {
        return backend.NSControlMessages.doubleValue(runtime.objectId(NSControl, self));
    }

    pub fn setDoubleValue(self: Self, _doubleValue: f64) void {
        return backend.NSControlMessages.setDoubleValue(runtime.objectId(NSControl, self), _doubleValue);
    }

    pub fn alignment(self: Self) NSTextAlignment {
        return runtime.toEnum(NSTextAlignment, backend.NSControlMessages.alignment(runtime.objectId(NSControl, self)));
    }

    pub fn setAlignment(self: Self, _alignment: NSTextAlignment) void {
        return backend.NSControlMessages.setAlignment(runtime.objectId(NSControl, self), runtime.unwrapEnum(NSTextAlignment, NSInteger, _alignment));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithFrame(_frameRect: NSRect) DesiredType {
                var _class = DesiredType.Support.getClass();
                return runtime.wrapObject(DesiredType, backend.NSControlMessages.initWithFrame(_class, runtime.pass(NSRect, _frameRect)));
            }
        };
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSControlMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSControl,
                NSObject,
                NSResponder,
                NSView,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};
