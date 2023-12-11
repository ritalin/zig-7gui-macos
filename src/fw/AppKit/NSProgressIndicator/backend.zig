const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSProgressIndicatorMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSProgressIndicator").?;
    }

    pub fn isIndeterminate(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSProgressIndicatorSelectors.isIndeterminate(), .{});
    }

    pub fn setIndeterminate(self: objc.Object, _indeterminate: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSProgressIndicatorSelectors.setIndeterminate(), .{
            _indeterminate,
        });
    }

    pub fn doubleValue(self: objc.Object) f64 {
        return self.msgSend(f64, selector.NSProgressIndicatorSelectors.doubleValue(), .{});
    }

    pub fn setDoubleValue(self: objc.Object, _doubleValue: f64) void {
        return self.msgSend(void, selector.NSProgressIndicatorSelectors.setDoubleValue(), .{
            _doubleValue,
        });
    }

    pub fn incrementBy(self: objc.Object, _delta: f64) void {
        return self.msgSend(void, selector.NSProgressIndicatorSelectors.incrementBy(), .{
            _delta,
        });
    }

    pub fn minValue(self: objc.Object) f64 {
        return self.msgSend(f64, selector.NSProgressIndicatorSelectors.minValue(), .{});
    }

    pub fn setMinValue(self: objc.Object, _minValue: f64) void {
        return self.msgSend(void, selector.NSProgressIndicatorSelectors.setMinValue(), .{
            _minValue,
        });
    }

    pub fn maxValue(self: objc.Object) f64 {
        return self.msgSend(f64, selector.NSProgressIndicatorSelectors.maxValue(), .{});
    }

    pub fn setMaxValue(self: objc.Object, _maxValue: f64) void {
        return self.msgSend(void, selector.NSProgressIndicatorSelectors.setMaxValue(), .{
            _maxValue,
        });
    }

    pub fn startAnimation(self: objc.Object, _sender: ?objc.Object) void {
        return self.msgSend(void, selector.NSProgressIndicatorSelectors.startAnimation(), .{
            runtime_support.unwrapOptionalObject(_sender),
        });
    }

    pub fn stopAnimation(self: objc.Object, _sender: ?objc.Object) void {
        return self.msgSend(void, selector.NSProgressIndicatorSelectors.stopAnimation(), .{
            runtime_support.unwrapOptionalObject(_sender),
        });
    }

    pub fn isDisplayedWhenStopped(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSProgressIndicatorSelectors.isDisplayedWhenStopped(), .{});
    }

    pub fn setDisplayedWhenStopped(self: objc.Object, _displayedWhenStopped: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSProgressIndicatorSelectors.setDisplayedWhenStopped(), .{
            _displayedWhenStopped,
        });
    }
};
