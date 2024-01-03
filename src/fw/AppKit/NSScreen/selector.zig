const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSScreenSelectors = struct {
    pub fn mainScreen() objc.Sel {
        if (_sel_mainScreen == null) {
            _sel_mainScreen = objc.Sel.registerName("mainScreen");
        }
        return _sel_mainScreen.?;
    }

    pub fn frame() objc.Sel {
        if (_sel_frame == null) {
            _sel_frame = objc.Sel.registerName("frame");
        }
        return _sel_frame.?;
    }

    pub fn visibleFrame() objc.Sel {
        if (_sel_visibleFrame == null) {
            _sel_visibleFrame = objc.Sel.registerName("visibleFrame");
        }
        return _sel_visibleFrame.?;
    }

    var _sel_mainScreen: ?objc.Sel = null;
    var _sel_frame: ?objc.Sel = null;
    var _sel_visibleFrame: ?objc.Sel = null;
};

pub const ExtensionsForNSScreenSelectors = struct {};
