const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSClipViewSelectors = struct {
    pub fn documentVisibleRect() objc.Sel {
        if (_sel_documentVisibleRect == null) {
            _sel_documentVisibleRect = objc.Sel.registerName("documentVisibleRect");
        }
        return _sel_documentVisibleRect.?;
    }

    pub fn scrollToPoint() objc.Sel {
        if (_sel_scrollToPoint == null) {
            _sel_scrollToPoint = objc.Sel.registerName("scrollToPoint:");
        }
        return _sel_scrollToPoint.?;
    }

    var _sel_documentVisibleRect: ?objc.Sel = null;
    var _sel_scrollToPoint: ?objc.Sel = null;
};
