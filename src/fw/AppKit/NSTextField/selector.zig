const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSTextFieldSelectors = struct {
    pub fn backgroundColor() objc.Sel {
        if (_sel_backgroundColor == null) {
            _sel_backgroundColor = objc.Sel.registerName("backgroundColor");
        }
        return _sel_backgroundColor.?;
    }

    pub fn setBackgroundColor() objc.Sel {
        if (_sel_setBackgroundColor == null) {
            _sel_setBackgroundColor = objc.Sel.registerName("setBackgroundColor:");
        }
        return _sel_setBackgroundColor.?;
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

    var _sel_backgroundColor: ?objc.Sel = null;
    var _sel_setBackgroundColor: ?objc.Sel = null;
    var _sel_isEditable: ?objc.Sel = null;
    var _sel_setEditable: ?objc.Sel = null;
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;
};

pub const NSTextFieldConvenienceForNSTextFieldSelectors = struct {
    pub fn labelWithString() objc.Sel {
        if (_sel_labelWithString == null) {
            _sel_labelWithString = objc.Sel.registerName("labelWithString:");
        }
        return _sel_labelWithString.?;
    }

    pub fn wrappingLabelWithString() objc.Sel {
        if (_sel_wrappingLabelWithString == null) {
            _sel_wrappingLabelWithString = objc.Sel.registerName("wrappingLabelWithString:");
        }
        return _sel_wrappingLabelWithString.?;
    }

    pub fn textFieldWithString() objc.Sel {
        if (_sel_textFieldWithString == null) {
            _sel_textFieldWithString = objc.Sel.registerName("textFieldWithString:");
        }
        return _sel_textFieldWithString.?;
    }

    var _sel_labelWithString: ?objc.Sel = null;
    var _sel_wrappingLabelWithString: ?objc.Sel = null;
    var _sel_textFieldWithString: ?objc.Sel = null;
};

pub const NSTextFieldDelegateSelectors = struct {};
