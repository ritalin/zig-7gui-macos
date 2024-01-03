const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSPressGestureRecognizerSelectors = struct {
    pub fn buttonMask() objc.Sel {
        if (_sel_buttonMask == null) {
            _sel_buttonMask = objc.Sel.registerName("buttonMask");
        }
        return _sel_buttonMask.?;
    }

    pub fn setButtonMask() objc.Sel {
        if (_sel_setButtonMask == null) {
            _sel_setButtonMask = objc.Sel.registerName("setButtonMask:");
        }
        return _sel_setButtonMask.?;
    }

    pub fn minimumPressDuration() objc.Sel {
        if (_sel_minimumPressDuration == null) {
            _sel_minimumPressDuration = objc.Sel.registerName("minimumPressDuration");
        }
        return _sel_minimumPressDuration.?;
    }

    pub fn setMinimumPressDuration() objc.Sel {
        if (_sel_setMinimumPressDuration == null) {
            _sel_setMinimumPressDuration = objc.Sel.registerName("setMinimumPressDuration:");
        }
        return _sel_setMinimumPressDuration.?;
    }

    pub fn allowableMovement() objc.Sel {
        if (_sel_allowableMovement == null) {
            _sel_allowableMovement = objc.Sel.registerName("allowableMovement");
        }
        return _sel_allowableMovement.?;
    }

    pub fn setAllowableMovement() objc.Sel {
        if (_sel_setAllowableMovement == null) {
            _sel_setAllowableMovement = objc.Sel.registerName("setAllowableMovement:");
        }
        return _sel_setAllowableMovement.?;
    }

    var _sel_buttonMask: ?objc.Sel = null;
    var _sel_setButtonMask: ?objc.Sel = null;
    var _sel_minimumPressDuration: ?objc.Sel = null;
    var _sel_setMinimumPressDuration: ?objc.Sel = null;
    var _sel_allowableMovement: ?objc.Sel = null;
    var _sel_setAllowableMovement: ?objc.Sel = null;
};
