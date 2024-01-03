const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSClickGestureRecognizerSelectors = struct {
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

    pub fn numberOfClicksRequired() objc.Sel {
        if (_sel_numberOfClicksRequired == null) {
            _sel_numberOfClicksRequired = objc.Sel.registerName("numberOfClicksRequired");
        }
        return _sel_numberOfClicksRequired.?;
    }

    pub fn setNumberOfClicksRequired() objc.Sel {
        if (_sel_setNumberOfClicksRequired == null) {
            _sel_setNumberOfClicksRequired = objc.Sel.registerName("setNumberOfClicksRequired:");
        }
        return _sel_setNumberOfClicksRequired.?;
    }

    var _sel_buttonMask: ?objc.Sel = null;
    var _sel_setButtonMask: ?objc.Sel = null;
    var _sel_numberOfClicksRequired: ?objc.Sel = null;
    var _sel_setNumberOfClicksRequired: ?objc.Sel = null;
};
