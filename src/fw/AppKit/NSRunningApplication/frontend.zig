const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSApplicationActivationOptions = runtime_support.EnumOptions(enum(NSUInteger) {
    ActivateAllWindows = 1 << 0,
    ActivateIgnoringOtherApps = 1 << 1,
});

pub const NSRunningApplication = struct {
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

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSRunningApplicationMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSRunningApplication,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const Self = @This();
};

pub const NSApplicationActivationPolicy = struct {
    _value: NSInteger,

    pub const Regular: NSApplicationActivationPolicy = .{
        ._value = 0x0,
    };
    pub const Accessory: NSApplicationActivationPolicy = .{
        ._value = 0x1,
    };
    pub const Prohibited: NSApplicationActivationPolicy = .{
        ._value = 0x2,
    };
};

const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
