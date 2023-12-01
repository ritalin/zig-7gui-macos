const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSModalResponse = appKit.NSModalResponse;
const NSWindow = appKit.NSWindow;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;

pub const NSAlertFirstButtonReturn: NSModalResponse = 1000;
pub const NSAlertSecondButtonReturn: NSModalResponse = 1001;
pub const NSAlertThirdButtonReturn: NSModalResponse = 1002;

pub const NSAlert = struct {
    pub const Self = @This();

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

    pub fn messageText(self: Self) NSString {
        return runtime_support.wrapObject(NSString, backend.NSAlertMessages.messageText(runtime_support.objectId(NSAlert, self)));
    }

    pub fn setMessageText(self: Self, _messageText: NSString) void {
        return backend.NSAlertMessages.setMessageText(runtime_support.objectId(NSAlert, self), runtime_support.objectId(NSString, _messageText));
    }

    pub fn runModal(self: Self) NSModalResponse {
        return backend.NSAlertMessages.runModal(runtime_support.objectId(NSAlert, self));
    }

    pub fn beginSheetModalForWindowCompletionHandler(self: Self, _sheetWindow: NSWindow, _handler: ?runtime_support.ApiBlock(fn (_: NSModalResponse) void)) void {
        return backend.NSAlertMessages.beginSheetModalForWindowCompletionHandler(runtime_support.objectId(NSAlert, self), runtime_support.objectId(NSWindow, _sheetWindow), runtime_support.unwrapApiBlock(?runtime_support.ApiBlock(fn (_: NSModalResponse) void), _handler));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSAlertMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSAlert,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };
};
