const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSEventMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSEvent").?;
    }

    pub fn @"type"(self: objc.Object) NSUInteger {
        return self.msgSend(NSUInteger, selector.NSEventSelectors.type(), .{});
    }

    pub fn modifierFlags(self: objc.Object) NSUInteger {
        return self.msgSend(NSUInteger, selector.NSEventSelectors.modifierFlags(), .{});
    }

    pub fn window(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSEventSelectors.window(), .{}));
    }

    pub fn clickCount(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSEventSelectors.clickCount(), .{});
    }

    pub fn locationInWindow(self: objc.Object) NSPoint {
        return self.msgSend(NSPoint, selector.NSEventSelectors.locationInWindow(), .{});
    }

    pub fn modifierFlagsCurrent() NSUInteger {
        return getClass().msgSend(NSUInteger, selector.NSEventSelectors.modifierFlagsCurrent(), .{});
    }
};

const NSPoint = foundation.NSPoint;
const NSInteger = runtime.NSInteger;
const NSUInteger = runtime.NSUInteger;
