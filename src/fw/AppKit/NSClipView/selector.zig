const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSClipViewSelectors = struct {
    var _sel_scrollToPoint: ?objc.Sel = null;

    pub fn scrollToPoint() objc.Sel {
        if (_sel_scrollToPoint == null) {
            _sel_scrollToPoint = objc.Sel.registerName("scrollToPoint:");
        }
        return _sel_scrollToPoint.?;
    }
};
