const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
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

    pub fn modifierFlagsCurrent() NSUInteger {
        return getClass().msgSend(NSUInteger, selector.NSEventSelectors.modifierFlagsCurrent(), .{});
    }
};

const NSUInteger = runtime.NSUInteger;
