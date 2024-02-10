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

    pub fn defaultCenter() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSNotificationCenterSelectors.defaultCenter(), .{});
    }

    pub fn addObserverSelectorName(self: objc.Object, _observer: objc.Object, _aSelector: objc.Sel, _aName: ?objc.Object, _anObject: ?objc.Object) void {
        return self.msgSend(void, selector.NSNotificationCenterSelectors.addObserverSelectorName(), .{
            runtime_support.unwrapOptionalObject(_observer),
            runtime_support.unwrapOptionalSelValue(_aSelector),
            runtime_support.unwrapOptionalObject(_aName),
            runtime_support.unwrapOptionalObject(_anObject),
        });
    }
};

pub const NSNotificationCreationForNSNotificationMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSNotification").?;
    }
};
