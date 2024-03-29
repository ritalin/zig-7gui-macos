const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSClipViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSClipView").?;
    }

    pub fn documentVisibleRect(self: objc.Object) NSRect {
        return self.msgSend(NSRect, selector.NSClipViewSelectors.documentVisibleRect(), .{});
    }

    pub fn scrollToPoint(self: objc.Object, _newOrigin: NSPoint) void {
        return self.msgSend(void, selector.NSClipViewSelectors.scrollToPoint(), .{
            _newOrigin,
        });
    }
};

const NSPoint = foundation.NSPoint;
const NSRect = foundation.NSRect;
