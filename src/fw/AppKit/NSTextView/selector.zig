const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSTextViewSelectors = struct {
    var _sel_textStorage: ?objc.Sel = null;

    pub fn textStorage() objc.Sel {
        if (_sel_textStorage == null) {
            _sel_textStorage = objc.Sel.registerName("textStorage");
        }
        return _sel_textStorage.?;
    }
};

pub const NSSharingForNSTextViewSelectors = struct {
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;
    var _sel_isEditable: ?objc.Sel = null;
    var _sel_setEditable: ?objc.Sel = null;

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
};

pub const NSTextViewDelegateSelectors = struct {
    var _sel_textViewDoCommandBySelector: ?objc.Sel = null;

    pub fn textViewDoCommandBySelector() objc.Sel {
        if (_sel_textViewDoCommandBySelector == null) {
            _sel_textViewDoCommandBySelector = objc.Sel.registerName("textView:doCommandBySelector:");
        }
        return _sel_textViewDoCommandBySelector.?;
    }
};
