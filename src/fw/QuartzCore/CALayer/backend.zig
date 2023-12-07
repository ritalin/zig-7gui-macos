const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const coreGraphics = @import("CoreGraphics");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const CGColorRef = coreGraphics.CGColorRef;

pub const CALayerMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("CALayer").?;
    }

    pub fn backgroundColor(self: objc.Object) ?CGColorRef {
        return self.msgSend(?CGColorRef, selector.CALayerSelectors.backgroundColor(), .{});
    }

    pub fn setBackgroundColor(self: objc.Object, _backgroundColor: ?CGColorRef) void {
        return self.msgSend(void, selector.CALayerSelectors.setBackgroundColor(), .{
            _backgroundColor,
        });
    }
};
