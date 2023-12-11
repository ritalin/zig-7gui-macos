const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSSliderMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSSlider").?;
    }

    pub fn minValue(self: objc.Object) f64 {
        return self.msgSend(f64, selector.NSSliderSelectors.minValue(), .{});
    }

    pub fn setMinValue(self: objc.Object, _minValue: f64) void {
        return self.msgSend(void, selector.NSSliderSelectors.setMinValue(), .{
            _minValue,
        });
    }

    pub fn maxValue(self: objc.Object) f64 {
        return self.msgSend(f64, selector.NSSliderSelectors.maxValue(), .{});
    }

    pub fn setMaxValue(self: objc.Object, _maxValue: f64) void {
        return self.msgSend(void, selector.NSSliderSelectors.setMaxValue(), .{
            _maxValue,
        });
    }
};
