const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

pub const NSNotificationSelectors = struct {};

pub const NSNotificationMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSNotification").?;
    }
};

pub const NSNotificationCenterSelectors = struct {};

pub const NSNotificationCenterMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSNotificationCenter").?;
    }
};

pub const NSNotificationCreationForNSNotificationSelectors = struct {};

pub const NSNotificationCreationForNSNotificationMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSNotification").?;
    }
};
