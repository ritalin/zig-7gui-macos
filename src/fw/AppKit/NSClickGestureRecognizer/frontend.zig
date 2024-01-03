const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSClickGestureRecognizer = struct {
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
        return backend.NSClickGestureRecognizerMessages.buttonMask(runtime_support.objectId(NSClickGestureRecognizer, self));
    }

    pub fn setButtonMask(self: Self, _buttonMask: NSUInteger) void {
        return backend.NSClickGestureRecognizerMessages.setButtonMask(runtime_support.objectId(NSClickGestureRecognizer, self), runtime_support.pass(NSUInteger, _buttonMask));
    }

    pub fn numberOfClicksRequired(self: Self) NSInteger {
        return backend.NSClickGestureRecognizerMessages.numberOfClicksRequired(runtime_support.objectId(NSClickGestureRecognizer, self));
    }

    pub fn setNumberOfClicksRequired(self: Self, _numberOfClicksRequired: NSInteger) void {
        return backend.NSClickGestureRecognizerMessages.setNumberOfClicksRequired(runtime_support.objectId(NSClickGestureRecognizer, self), runtime_support.pass(NSInteger, _numberOfClicksRequired));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSClickGestureRecognizerMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSClickGestureRecognizer,
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
const NSCoding = foundation.NSCoding;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
