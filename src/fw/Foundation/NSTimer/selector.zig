const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSTimerSelectors = struct {
    pub fn timerWithTimeIntervalRepeatsBlock() objc.Sel {
        if (_sel_timerWithTimeIntervalRepeatsBlock == null) {
            _sel_timerWithTimeIntervalRepeatsBlock = objc.Sel.registerName("timerWithTimeInterval:repeats:block:");
        }
        return _sel_timerWithTimeIntervalRepeatsBlock.?;
    }

    pub fn scheduledTimerWithTimeIntervalRepeatsBlock() objc.Sel {
        if (_sel_scheduledTimerWithTimeIntervalRepeatsBlock == null) {
            _sel_scheduledTimerWithTimeIntervalRepeatsBlock = objc.Sel.registerName("scheduledTimerWithTimeInterval:repeats:block:");
        }
        return _sel_scheduledTimerWithTimeIntervalRepeatsBlock.?;
    }

    pub fn tolerance() objc.Sel {
        if (_sel_tolerance == null) {
            _sel_tolerance = objc.Sel.registerName("tolerance");
        }
        return _sel_tolerance.?;
    }

    pub fn setTolerance() objc.Sel {
        if (_sel_setTolerance == null) {
            _sel_setTolerance = objc.Sel.registerName("setTolerance:");
        }
        return _sel_setTolerance.?;
    }

    pub fn invalidate() objc.Sel {
        if (_sel_invalidate == null) {
            _sel_invalidate = objc.Sel.registerName("invalidate");
        }
        return _sel_invalidate.?;
    }

    var _sel_timerWithTimeIntervalRepeatsBlock: ?objc.Sel = null;
    var _sel_scheduledTimerWithTimeIntervalRepeatsBlock: ?objc.Sel = null;
    var _sel_tolerance: ?objc.Sel = null;
    var _sel_setTolerance: ?objc.Sel = null;
    var _sel_invalidate: ?objc.Sel = null;
};
