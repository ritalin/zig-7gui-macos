const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSTimeInterval = foundation.NSTimeInterval;

pub const NSTimerMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTimer").?;
    }

    pub fn timerWithTimeIntervalRepeatsBlock(_interval: NSTimeInterval, _repeats: objc.c.BOOL, _block: runtime_support.BlockContextRef) objc.Object {
        return getClass().msgSend(objc.Object, selector.NSTimerSelectors.timerWithTimeIntervalRepeatsBlock(), .{
            _interval,
            _repeats,
            _block,
        });
    }

    pub fn scheduledTimerWithTimeIntervalRepeatsBlock(_interval: NSTimeInterval, _repeats: objc.c.BOOL, _block: runtime_support.BlockContextRef) objc.Object {
        return getClass().msgSend(objc.Object, selector.NSTimerSelectors.scheduledTimerWithTimeIntervalRepeatsBlock(), .{
            _interval,
            _repeats,
            _block,
        });
    }

    pub fn tolerance(self: objc.Object) NSTimeInterval {
        return self.msgSend(NSTimeInterval, selector.NSTimerSelectors.tolerance(), .{});
    }

    pub fn setTolerance(self: objc.Object, _tolerance: NSTimeInterval) void {
        return self.msgSend(void, selector.NSTimerSelectors.setTolerance(), .{
            _tolerance,
        });
    }

    pub fn invalidate(self: objc.Object) void {
        return self.msgSend(void, selector.NSTimerSelectors.invalidate(), .{});
    }
};
