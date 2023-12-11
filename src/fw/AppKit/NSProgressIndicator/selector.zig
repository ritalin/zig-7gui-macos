const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSProgressIndicatorSelectors = struct {
    var _sel_isIndeterminate: ?objc.Sel = null;
    var _sel_setIndeterminate: ?objc.Sel = null;
    var _sel_doubleValue: ?objc.Sel = null;
    var _sel_setDoubleValue: ?objc.Sel = null;
    var _sel_incrementBy: ?objc.Sel = null;
    var _sel_minValue: ?objc.Sel = null;
    var _sel_setMinValue: ?objc.Sel = null;
    var _sel_maxValue: ?objc.Sel = null;
    var _sel_setMaxValue: ?objc.Sel = null;
    var _sel_startAnimation: ?objc.Sel = null;
    var _sel_stopAnimation: ?objc.Sel = null;
    var _sel_isDisplayedWhenStopped: ?objc.Sel = null;
    var _sel_setDisplayedWhenStopped: ?objc.Sel = null;

    pub fn isIndeterminate() objc.Sel {
        if (_sel_isIndeterminate == null) {
            _sel_isIndeterminate = objc.Sel.registerName("isIndeterminate");
        }
        return _sel_isIndeterminate.?;
    }

    pub fn setIndeterminate() objc.Sel {
        if (_sel_setIndeterminate == null) {
            _sel_setIndeterminate = objc.Sel.registerName("setIndeterminate:");
        }
        return _sel_setIndeterminate.?;
    }

    pub fn doubleValue() objc.Sel {
        if (_sel_doubleValue == null) {
            _sel_doubleValue = objc.Sel.registerName("doubleValue");
        }
        return _sel_doubleValue.?;
    }

    pub fn setDoubleValue() objc.Sel {
        if (_sel_setDoubleValue == null) {
            _sel_setDoubleValue = objc.Sel.registerName("setDoubleValue:");
        }
        return _sel_setDoubleValue.?;
    }

    pub fn incrementBy() objc.Sel {
        if (_sel_incrementBy == null) {
            _sel_incrementBy = objc.Sel.registerName("incrementBy:");
        }
        return _sel_incrementBy.?;
    }

    pub fn minValue() objc.Sel {
        if (_sel_minValue == null) {
            _sel_minValue = objc.Sel.registerName("minValue");
        }
        return _sel_minValue.?;
    }

    pub fn setMinValue() objc.Sel {
        if (_sel_setMinValue == null) {
            _sel_setMinValue = objc.Sel.registerName("setMinValue:");
        }
        return _sel_setMinValue.?;
    }

    pub fn maxValue() objc.Sel {
        if (_sel_maxValue == null) {
            _sel_maxValue = objc.Sel.registerName("maxValue");
        }
        return _sel_maxValue.?;
    }

    pub fn setMaxValue() objc.Sel {
        if (_sel_setMaxValue == null) {
            _sel_setMaxValue = objc.Sel.registerName("setMaxValue:");
        }
        return _sel_setMaxValue.?;
    }

    pub fn startAnimation() objc.Sel {
        if (_sel_startAnimation == null) {
            _sel_startAnimation = objc.Sel.registerName("startAnimation:");
        }
        return _sel_startAnimation.?;
    }

    pub fn stopAnimation() objc.Sel {
        if (_sel_stopAnimation == null) {
            _sel_stopAnimation = objc.Sel.registerName("stopAnimation:");
        }
        return _sel_stopAnimation.?;
    }

    pub fn isDisplayedWhenStopped() objc.Sel {
        if (_sel_isDisplayedWhenStopped == null) {
            _sel_isDisplayedWhenStopped = objc.Sel.registerName("isDisplayedWhenStopped");
        }
        return _sel_isDisplayedWhenStopped.?;
    }

    pub fn setDisplayedWhenStopped() objc.Sel {
        if (_sel_setDisplayedWhenStopped == null) {
            _sel_setDisplayedWhenStopped = objc.Sel.registerName("setDisplayedWhenStopped:");
        }
        return _sel_setDisplayedWhenStopped.?;
    }
};
