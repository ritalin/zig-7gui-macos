const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSPressureConfiguration = struct {
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

    pub fn pressureBehavior(self: Self) NSPressureBehavior {
        return runtime_support.wrapEnum(NSPressureBehavior, NSInteger, backend.NSPressureConfigurationMessages.pressureBehavior(runtime_support.objectId(NSPressureConfiguration, self)));
    }

    pub fn set(self: Self) void {
        return backend.NSPressureConfigurationMessages.set(runtime_support.objectId(NSPressureConfiguration, self));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithPressureBehavior(_pressureBehavior: NSPressureBehavior) DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(DesiredType, backend.NSPressureConfigurationMessages.initWithPressureBehavior(_class, runtime_support.unwrapEnum(NSPressureBehavior, NSInteger, _pressureBehavior)));
            }
        };
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSPressureConfigurationMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSPressureConfiguration,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const ForNSView = struct {
        pub const PressureConfiguration = NSPressureConfigurationForNSView;
    };

    pub const Self = @This();
};

const NSPressureConfigurationForNSView = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    pub fn pressureConfiguration(self: Category) NSPressureConfiguration {
        return runtime_support.wrapObject(NSPressureConfiguration, backend.NSPressureConfigurationForNSViewMessages.pressureConfiguration(runtime_support.objectId(NSPressureConfigurationForNSView, self)));
    }

    pub fn setPressureConfiguration(self: Category, _pressureConfiguration: NSPressureConfiguration) void {
        return backend.NSPressureConfigurationForNSViewMessages.setPressureConfiguration(runtime_support.objectId(NSPressureConfigurationForNSView, self), runtime_support.objectId(NSPressureConfiguration, _pressureConfiguration));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSView;
};

const NSPressureBehavior = appKit.NSPressureBehavior;
const NSView = appKit.NSView;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
