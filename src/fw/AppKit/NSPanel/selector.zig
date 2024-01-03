const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSPanelSelectors = struct {
    pub fn isFloatingPanel() objc.Sel {
        if (_sel_isFloatingPanel == null) {
            _sel_isFloatingPanel = objc.Sel.registerName("isFloatingPanel");
        }
        return _sel_isFloatingPanel.?;
    }

    pub fn setFloatingPanel() objc.Sel {
        if (_sel_setFloatingPanel == null) {
            _sel_setFloatingPanel = objc.Sel.registerName("setFloatingPanel:");
        }
        return _sel_setFloatingPanel.?;
    }

    var _sel_isFloatingPanel: ?objc.Sel = null;
    var _sel_setFloatingPanel: ?objc.Sel = null;
};
