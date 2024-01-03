const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSClickGestureRecognizerMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSClickGestureRecognizer").?;
    }

    pub fn buttonMask(self: objc.Object) NSUInteger {
        return self.msgSend(NSUInteger, selector.NSClickGestureRecognizerSelectors.buttonMask(), .{});
    }

    pub fn setButtonMask(self: objc.Object, _buttonMask: NSUInteger) void {
        return self.msgSend(void, selector.NSClickGestureRecognizerSelectors.setButtonMask(), .{
            _buttonMask,
        });
    }

    pub fn numberOfClicksRequired(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSClickGestureRecognizerSelectors.numberOfClicksRequired(), .{});
    }

    pub fn setNumberOfClicksRequired(self: objc.Object, _numberOfClicksRequired: NSInteger) void {
        return self.msgSend(void, selector.NSClickGestureRecognizerSelectors.setNumberOfClicksRequired(), .{
            _numberOfClicksRequired,
        });
    }
};

const NSInteger = runtime.NSInteger;
const NSUInteger = runtime.NSUInteger;
