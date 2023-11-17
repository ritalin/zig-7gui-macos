const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");

const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const NSApplicationActivationOptions = std.enums.EnumSet(enum(NSUInteger) {
    ActivateAllWindows = 1 << 0,
    ActivateIgnoringOtherApps = 1 << 1,
});

pub const NSRunningApplication = struct {
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
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSRunningApplicationMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSObject,
                NSRunningApplication,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};

pub const NSApplicationActivationPolicy = struct {
    pub const Regular: NSApplicationActivationPolicy = .{
        ._value = 0x0,
    };
    pub const Accessory: NSApplicationActivationPolicy = .{
        ._value = 0x1,
    };
    pub const Prohibited: NSApplicationActivationPolicy = .{
        ._value = 0x2,
    };

    _value: NSInteger,
};
