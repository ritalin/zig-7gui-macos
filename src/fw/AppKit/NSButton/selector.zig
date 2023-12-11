const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSButtonSelectors = struct {
    var _sel_buttonWithTitleTargetAction: ?objc.Sel = null;
    var _sel_setButtonType: ?objc.Sel = null;
    var _sel_title: ?objc.Sel = null;
    var _sel_setTitle: ?objc.Sel = null;
    var _sel_bezelStyle: ?objc.Sel = null;
    var _sel_setBezelStyle: ?objc.Sel = null;

    pub fn buttonWithTitleTargetAction() objc.Sel {
        if (_sel_buttonWithTitleTargetAction == null) {
            _sel_buttonWithTitleTargetAction = objc.Sel.registerName("buttonWithTitle:target:action:");
        }
        return _sel_buttonWithTitleTargetAction.?;
    }

    pub fn setButtonType() objc.Sel {
        if (_sel_setButtonType == null) {
            _sel_setButtonType = objc.Sel.registerName("setButtonType:");
        }
        return _sel_setButtonType.?;
    }

    pub fn title() objc.Sel {
        if (_sel_title == null) {
            _sel_title = objc.Sel.registerName("title");
        }
        return _sel_title.?;
    }

    pub fn setTitle() objc.Sel {
        if (_sel_setTitle == null) {
            _sel_setTitle = objc.Sel.registerName("setTitle:");
        }
        return _sel_setTitle.?;
    }

    pub fn bezelStyle() objc.Sel {
        if (_sel_bezelStyle == null) {
            _sel_bezelStyle = objc.Sel.registerName("bezelStyle");
        }
        return _sel_bezelStyle.?;
    }

    pub fn setBezelStyle() objc.Sel {
        if (_sel_setBezelStyle == null) {
            _sel_setBezelStyle = objc.Sel.registerName("setBezelStyle:");
        }
        return _sel_setBezelStyle.?;
    }
};
