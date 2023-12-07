const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const CALayerSelectors = struct {
    var _sel_backgroundColor: ?objc.Sel = null;
    var _sel_setBackgroundColor: ?objc.Sel = null;

    pub fn backgroundColor() objc.Sel {
        if (_sel_backgroundColor == null) {
            _sel_backgroundColor = objc.Sel.registerName("backgroundColor");
        }
        return _sel_backgroundColor.?;
    }

    pub fn setBackgroundColor() objc.Sel {
        if (_sel_setBackgroundColor == null) {
            _sel_setBackgroundColor = objc.Sel.registerName("setBackgroundColor:");
        }
        return _sel_setBackgroundColor.?;
    }
};
