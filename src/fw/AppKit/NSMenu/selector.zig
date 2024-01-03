const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSMenuSelectors = struct {
    pub fn popUpContextMenuWithEventForView() objc.Sel {
        if (_sel_popUpContextMenuWithEventForView == null) {
            _sel_popUpContextMenuWithEventForView = objc.Sel.registerName("popUpContextMenu:withEvent:forView:");
        }
        return _sel_popUpContextMenuWithEventForView.?;
    }

    pub fn addItemWithTitleActionKeyEquivalent() objc.Sel {
        if (_sel_addItemWithTitleActionKeyEquivalent == null) {
            _sel_addItemWithTitleActionKeyEquivalent = objc.Sel.registerName("addItemWithTitle:action:keyEquivalent:");
        }
        return _sel_addItemWithTitleActionKeyEquivalent.?;
    }

    var _sel_popUpContextMenuWithEventForView: ?objc.Sel = null;
    var _sel_addItemWithTitleActionKeyEquivalent: ?objc.Sel = null;
};

pub const NSMenuItemValidationSelectors = struct {};
