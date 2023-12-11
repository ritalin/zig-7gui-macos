const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSSliderSelectors = struct {
    var _sel_minValue: ?objc.Sel = null;
    var _sel_setMinValue: ?objc.Sel = null;
    var _sel_maxValue: ?objc.Sel = null;
    var _sel_setMaxValue: ?objc.Sel = null;

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
};
