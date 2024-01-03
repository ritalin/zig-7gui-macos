const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSPressureConfigurationMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSPressureConfiguration").?;
    }

    pub fn pressureBehavior(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSPressureConfigurationSelectors.pressureBehavior(), .{});
    }

    pub fn initWithPressureBehavior(_class: objc.Class, _pressureBehavior: NSInteger) objc.Object {
        return runtime_support.backend_support.allocInstance(_class).msgSend(objc.Object, selector.NSPressureConfigurationSelectors.initWithPressureBehavior(), .{
            _pressureBehavior,
        });
    }

    pub fn set(self: objc.Object) void {
        return self.msgSend(void, selector.NSPressureConfigurationSelectors.set(), .{});
    }
};

pub const NSPressureConfigurationForNSViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSView").?;
    }

    pub fn pressureConfiguration(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSPressureConfigurationForNSViewSelectors.pressureConfiguration(), .{});
    }

    pub fn setPressureConfiguration(self: objc.Object, _pressureConfiguration: objc.Object) void {
        return self.msgSend(void, selector.NSPressureConfigurationForNSViewSelectors.setPressureConfiguration(), .{
            runtime_support.unwrapOptionalObject(_pressureConfiguration),
        });
    }
};

const NSInteger = runtime.NSInteger;
