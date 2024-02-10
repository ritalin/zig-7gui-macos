const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSEventSelectors = struct {
    pub fn @"type"() objc.Sel {
        if (_sel_type == null) {
            _sel_type = objc.Sel.registerName("type");
        }
        return _sel_type.?;
    }

    pub fn modifierFlags() objc.Sel {
        if (_sel_modifierFlags == null) {
            _sel_modifierFlags = objc.Sel.registerName("modifierFlags");
        }
        return _sel_modifierFlags.?;
    }

    pub fn window() objc.Sel {
        if (_sel_window == null) {
            _sel_window = objc.Sel.registerName("window");
        }
        return _sel_window.?;
    }

    pub fn clickCount() objc.Sel {
        if (_sel_clickCount == null) {
            _sel_clickCount = objc.Sel.registerName("clickCount");
        }
        return _sel_clickCount.?;
    }

    pub fn locationInWindow() objc.Sel {
        if (_sel_locationInWindow == null) {
            _sel_locationInWindow = objc.Sel.registerName("locationInWindow");
        }
        return _sel_locationInWindow.?;
    }

    pub fn modifierFlagsCurrent() objc.Sel {
        if (_sel_modifierFlagsCurrent == null) {
            _sel_modifierFlagsCurrent = objc.Sel.registerName("modifierFlags");
        }
        return _sel_modifierFlagsCurrent.?;
    }

    var _sel_type: ?objc.Sel = null;
    var _sel_modifierFlags: ?objc.Sel = null;
    var _sel_window: ?objc.Sel = null;
    var _sel_clickCount: ?objc.Sel = null;
    var _sel_locationInWindow: ?objc.Sel = null;
    var _sel_modifierFlagsCurrent: ?objc.Sel = null;
};
