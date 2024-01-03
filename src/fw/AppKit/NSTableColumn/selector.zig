const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSTableColumnSelectors = struct {
    pub fn initWithIdentifier() objc.Sel {
        if (_sel_initWithIdentifier == null) {
            _sel_initWithIdentifier = objc.Sel.registerName("initWithIdentifier:");
        }
        return _sel_initWithIdentifier.?;
    }

    pub fn width() objc.Sel {
        if (_sel_width == null) {
            _sel_width = objc.Sel.registerName("width");
        }
        return _sel_width.?;
    }

    pub fn setWidth() objc.Sel {
        if (_sel_setWidth == null) {
            _sel_setWidth = objc.Sel.registerName("setWidth:");
        }
        return _sel_setWidth.?;
    }

    pub fn minWidth() objc.Sel {
        if (_sel_minWidth == null) {
            _sel_minWidth = objc.Sel.registerName("minWidth");
        }
        return _sel_minWidth.?;
    }

    pub fn setMinWidth() objc.Sel {
        if (_sel_setMinWidth == null) {
            _sel_setMinWidth = objc.Sel.registerName("setMinWidth:");
        }
        return _sel_setMinWidth.?;
    }

    pub fn maxWidth() objc.Sel {
        if (_sel_maxWidth == null) {
            _sel_maxWidth = objc.Sel.registerName("maxWidth");
        }
        return _sel_maxWidth.?;
    }

    pub fn setMaxWidth() objc.Sel {
        if (_sel_setMaxWidth == null) {
            _sel_setMaxWidth = objc.Sel.registerName("setMaxWidth:");
        }
        return _sel_setMaxWidth.?;
    }

    pub fn isEditable() objc.Sel {
        if (_sel_isEditable == null) {
            _sel_isEditable = objc.Sel.registerName("isEditable");
        }
        return _sel_isEditable.?;
    }

    pub fn setEditable() objc.Sel {
        if (_sel_setEditable == null) {
            _sel_setEditable = objc.Sel.registerName("setEditable:");
        }
        return _sel_setEditable.?;
    }

    var _sel_initWithIdentifier: ?objc.Sel = null;
    var _sel_width: ?objc.Sel = null;
    var _sel_setWidth: ?objc.Sel = null;
    var _sel_minWidth: ?objc.Sel = null;
    var _sel_setMinWidth: ?objc.Sel = null;
    var _sel_maxWidth: ?objc.Sel = null;
    var _sel_setMaxWidth: ?objc.Sel = null;
    var _sel_isEditable: ?objc.Sel = null;
    var _sel_setEditable: ?objc.Sel = null;
};
