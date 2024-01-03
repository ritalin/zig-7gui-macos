const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const coreGraphics = @import("CoreGraphics");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSPressGestureRecognizer = struct {
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

    pub fn buttonMask(self: Self) NSUInteger {
        return backend.NSPressGestureRecognizerMessages.buttonMask(runtime_support.objectId(NSPressGestureRecognizer, self));
    }

    pub fn setButtonMask(self: Self, _buttonMask: NSUInteger) void {
        return backend.NSPressGestureRecognizerMessages.setButtonMask(runtime_support.objectId(NSPressGestureRecognizer, self), runtime_support.pass(NSUInteger, _buttonMask));
    }

    pub fn minimumPressDuration(self: Self) NSTimeInterval {
        return backend.NSPressGestureRecognizerMessages.minimumPressDuration(runtime_support.objectId(NSPressGestureRecognizer, self));
    }

    pub fn setMinimumPressDuration(self: Self, _minimumPressDuration: NSTimeInterval) void {
        return backend.NSPressGestureRecognizerMessages.setMinimumPressDuration(runtime_support.objectId(NSPressGestureRecognizer, self), runtime_support.pass(NSTimeInterval, _minimumPressDuration));
    }

    pub fn allowableMovement(self: Self) CGFloat {
        return backend.NSPressGestureRecognizerMessages.allowableMovement(runtime_support.objectId(NSPressGestureRecognizer, self));
    }

    pub fn setAllowableMovement(self: Self, _allowableMovement: CGFloat) void {
        return backend.NSPressGestureRecognizerMessages.setAllowableMovement(runtime_support.objectId(NSPressGestureRecognizer, self), runtime_support.pass(CGFloat, _allowableMovement));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSPressGestureRecognizerMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSPressGestureRecognizer,
                NSGestureRecognizer,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSCoding,
            });
        }
    };

    pub const Self = @This();
};

const NSGestureRecognizer = appKit.NSGestureRecognizer;
const CGFloat = coreGraphics.CGFloat;
const NSCoding = foundation.NSCoding;
const NSTimeInterval = foundation.NSTimeInterval;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
