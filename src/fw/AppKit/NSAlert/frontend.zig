const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSModalResponse = appKit.NSModalResponse;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const ObjectResolver = runtime.ObjectResolver;

pub const NSAlertFirstButtonReturn: NSModalResponse = 1000;
pub const NSAlertSecondButtonReturn: NSModalResponse = 1001;
pub const NSAlertThirdButtonReturn: NSModalResponse = 1002;

pub const NSAlert = struct {
    pub const Self = @This();

    var DelegateResolver: ?*ObjectResolver(NSAlert) = null;

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

    pub fn messageText(self: Self) NSString {
        return runtime.wrapObject(NSString, backend.NSAlertMessages.messageText(runtime.objectId(NSAlert, self)));
    }

    pub fn setMessageText(self: Self, _messageText: NSString) void {
        return backend.NSAlertMessages.setMessageText(runtime.objectId(NSAlert, self), runtime.objectId(NSString, _messageText));
    }

    pub fn runModal(self: Self) NSModalResponse {
        return backend.NSAlertMessages.runModal(runtime.objectId(NSAlert, self));
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
            return runtime.typeConstraints(DesiredType.Self, .{
                NSAlert,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};
