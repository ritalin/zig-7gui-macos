const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const coreGraphics = @import("CoreGraphics");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const CGColorRef = coreGraphics.CGColorRef;
const CGFloat = coreGraphics.CGFloat;

pub const CALayerMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("CALayer").?;
    }

    pub fn masksToBounds(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.CALayerSelectors.masksToBounds(), .{});
    }

    pub fn setMasksToBounds(self: objc.Object, _masksToBounds: objc.c.BOOL) void {
        return self.msgSend(void, selector.CALayerSelectors.setMasksToBounds(), .{
            _masksToBounds,
        });
    }

    pub fn backgroundColor(self: objc.Object) ?CGColorRef {
        return self.msgSend(?CGColorRef, selector.CALayerSelectors.backgroundColor(), .{});
    }

    pub fn setBackgroundColor(self: objc.Object, _backgroundColor: ?CGColorRef) void {
        return self.msgSend(void, selector.CALayerSelectors.setBackgroundColor(), .{
            _backgroundColor,
        });
    }

    pub fn cornerRadius(self: objc.Object) CGFloat {
        return self.msgSend(CGFloat, selector.CALayerSelectors.cornerRadius(), .{});
    }

    pub fn setCornerRadius(self: objc.Object, _cornerRadius: CGFloat) void {
        return self.msgSend(void, selector.CALayerSelectors.setCornerRadius(), .{
            _cornerRadius,
        });
    }

    pub fn borderWidth(self: objc.Object) CGFloat {
        return self.msgSend(CGFloat, selector.CALayerSelectors.borderWidth(), .{});
    }

    pub fn setBorderWidth(self: objc.Object, _borderWidth: CGFloat) void {
        return self.msgSend(void, selector.CALayerSelectors.setBorderWidth(), .{
            _borderWidth,
        });
    }

    pub fn borderColor(self: objc.Object) ?CGColorRef {
        return self.msgSend(?CGColorRef, selector.CALayerSelectors.borderColor(), .{});
    }

    pub fn setBorderColor(self: objc.Object, _borderColor: ?CGColorRef) void {
        return self.msgSend(void, selector.CALayerSelectors.setBorderColor(), .{
            _borderColor,
        });
    }
};
