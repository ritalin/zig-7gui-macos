const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSNotificationMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSNotification").?;
    }
};

pub const NSNotificationCenterMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSNotificationCenter").?;
    }
};

pub const NSNotificationCreationForNSNotificationMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSNotification").?;
    }
};
