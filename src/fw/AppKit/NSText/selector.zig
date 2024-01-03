const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSTextSelectors = struct {
    pub fn string() objc.Sel {
        if (_sel_string == null) {
            _sel_string = objc.Sel.registerName("string");
        }
        return _sel_string.?;
    }

    pub fn setString() objc.Sel {
        if (_sel_setString == null) {
            _sel_setString = objc.Sel.registerName("setString:");
        }
        return _sel_setString.?;
    }

    pub fn delegate() objc.Sel {
        if (_sel_delegate == null) {
            _sel_delegate = objc.Sel.registerName("delegate");
        }
        return _sel_delegate.?;
    }

    pub fn setDelegate() objc.Sel {
        if (_sel_setDelegate == null) {
            _sel_setDelegate = objc.Sel.registerName("setDelegate:");
        }
        return _sel_setDelegate.?;
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

    var _sel_string: ?objc.Sel = null;
    var _sel_setString: ?objc.Sel = null;
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;
    var _sel_isEditable: ?objc.Sel = null;
    var _sel_setEditable: ?objc.Sel = null;
};

pub const NSTextDelegateSelectors = struct {
    pub fn textDidChange() objc.Sel {
        if (_sel_textDidChange == null) {
            _sel_textDidChange = objc.Sel.registerName("textDidChange:");
        }
        return _sel_textDidChange.?;
    }

    var _sel_textDidChange: ?objc.Sel = null;
};
