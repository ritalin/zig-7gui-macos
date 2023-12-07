const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSRect = foundation.NSRect;

pub const NSScreenMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSScreen").?;
    }

    pub fn mainScreen() ?objc.Object {
        return runtime_support.wrapOptionalObjectId(getClass().msgSend(objc.c.id, selector.NSScreenSelectors.mainScreen(), .{}));
    }

    pub fn frame(self: objc.Object) NSRect {
        return self.msgSend(NSRect, selector.NSScreenSelectors.frame(), .{});
    }

    pub fn visibleFrame(self: objc.Object) NSRect {
        return self.msgSend(NSRect, selector.NSScreenSelectors.visibleFrame(), .{});
    }
};

pub const ExtensionsForNSScreenMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSScreen").?;
    }
};

pub const NSDeprecatedForNSScreenMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSScreen").?;
    }
};
