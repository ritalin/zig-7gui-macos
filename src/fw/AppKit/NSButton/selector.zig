const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSButtonSelectors = struct {
    var _sel_buttonWithTitleTargetAction: ?objc.Sel = null;

    pub fn buttonWithTitleTargetAction() objc.Sel {
        if (_sel_buttonWithTitleTargetAction == null) {
            _sel_buttonWithTitleTargetAction = objc.Sel.registerName("buttonWithTitle:target:action:");
        }
        return _sel_buttonWithTitleTargetAction.?;
    }
};
