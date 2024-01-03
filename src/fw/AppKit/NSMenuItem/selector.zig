const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSMenuItemSelectors = struct {
    pub fn target() objc.Sel {
        if (_sel_target == null) {
            _sel_target = objc.Sel.registerName("target");
        }
        return _sel_target.?;
    }

    pub fn setTarget() objc.Sel {
        if (_sel_setTarget == null) {
            _sel_setTarget = objc.Sel.registerName("setTarget:");
        }
        return _sel_setTarget.?;
    }

    pub fn action() objc.Sel {
        if (_sel_action == null) {
            _sel_action = objc.Sel.registerName("action");
        }
        return _sel_action.?;
    }

    pub fn setAction() objc.Sel {
        if (_sel_setAction == null) {
            _sel_setAction = objc.Sel.registerName("setAction:");
        }
        return _sel_setAction.?;
    }

    var _sel_target: ?objc.Sel = null;
    var _sel_setTarget: ?objc.Sel = null;
    var _sel_action: ?objc.Sel = null;
    var _sel_setAction: ?objc.Sel = null;
};
