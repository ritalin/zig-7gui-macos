const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const coreGraphics = @import("CoreGraphics");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSPressGestureRecognizerMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSPressGestureRecognizer").?;
    }

    pub fn buttonMask(self: objc.Object) NSUInteger {
        return self.msgSend(NSUInteger, selector.NSPressGestureRecognizerSelectors.buttonMask(), .{});
    }

    pub fn setButtonMask(self: objc.Object, _buttonMask: NSUInteger) void {
        return self.msgSend(void, selector.NSPressGestureRecognizerSelectors.setButtonMask(), .{
            _buttonMask,
        });
    }

    pub fn minimumPressDuration(self: objc.Object) NSTimeInterval {
        return self.msgSend(NSTimeInterval, selector.NSPressGestureRecognizerSelectors.minimumPressDuration(), .{});
    }

    pub fn setMinimumPressDuration(self: objc.Object, _minimumPressDuration: NSTimeInterval) void {
        return self.msgSend(void, selector.NSPressGestureRecognizerSelectors.setMinimumPressDuration(), .{
            _minimumPressDuration,
        });
    }

    pub fn allowableMovement(self: objc.Object) CGFloat {
        return self.msgSend(CGFloat, selector.NSPressGestureRecognizerSelectors.allowableMovement(), .{});
    }

    pub fn setAllowableMovement(self: objc.Object, _allowableMovement: CGFloat) void {
        return self.msgSend(void, selector.NSPressGestureRecognizerSelectors.setAllowableMovement(), .{
            _allowableMovement,
        });
    }
};

const CGFloat = coreGraphics.CGFloat;
const NSTimeInterval = foundation.NSTimeInterval;
const NSUInteger = runtime.NSUInteger;
