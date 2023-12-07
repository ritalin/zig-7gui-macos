const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSResponderSelectors = struct {};

pub const NSStandardKeyBindingRespondingSelectors = struct {
    var _sel_insertTab: ?objc.Sel = null;
    var _sel_insertBacktab: ?objc.Sel = null;
    var _sel_insertNewline: ?objc.Sel = null;
    var _sel_insertParagraphSeparator: ?objc.Sel = null;
    var _sel_insertNewlineIgnoringFieldEditor: ?objc.Sel = null;
    var _sel_insertTabIgnoringFieldEditor: ?objc.Sel = null;
    var _sel_insertLineBreak: ?objc.Sel = null;
    var _sel_insertContainerBreak: ?objc.Sel = null;
    var _sel_insertSingleQuoteIgnoringSubstitution: ?objc.Sel = null;
    var _sel_insertDoubleQuoteIgnoringSubstitution: ?objc.Sel = null;

    pub fn insertTab() objc.Sel {
        if (_sel_insertTab == null) {
            _sel_insertTab = objc.Sel.registerName("insertTab:");
        }
        return _sel_insertTab.?;
    }

    pub fn insertBacktab() objc.Sel {
        if (_sel_insertBacktab == null) {
            _sel_insertBacktab = objc.Sel.registerName("insertBacktab:");
        }
        return _sel_insertBacktab.?;
    }

    pub fn insertNewline() objc.Sel {
        if (_sel_insertNewline == null) {
            _sel_insertNewline = objc.Sel.registerName("insertNewline:");
        }
        return _sel_insertNewline.?;
    }

    pub fn insertParagraphSeparator() objc.Sel {
        if (_sel_insertParagraphSeparator == null) {
            _sel_insertParagraphSeparator = objc.Sel.registerName("insertParagraphSeparator:");
        }
        return _sel_insertParagraphSeparator.?;
    }

    pub fn insertNewlineIgnoringFieldEditor() objc.Sel {
        if (_sel_insertNewlineIgnoringFieldEditor == null) {
            _sel_insertNewlineIgnoringFieldEditor = objc.Sel.registerName("insertNewlineIgnoringFieldEditor:");
        }
        return _sel_insertNewlineIgnoringFieldEditor.?;
    }

    pub fn insertTabIgnoringFieldEditor() objc.Sel {
        if (_sel_insertTabIgnoringFieldEditor == null) {
            _sel_insertTabIgnoringFieldEditor = objc.Sel.registerName("insertTabIgnoringFieldEditor:");
        }
        return _sel_insertTabIgnoringFieldEditor.?;
    }

    pub fn insertLineBreak() objc.Sel {
        if (_sel_insertLineBreak == null) {
            _sel_insertLineBreak = objc.Sel.registerName("insertLineBreak:");
        }
        return _sel_insertLineBreak.?;
    }

    pub fn insertContainerBreak() objc.Sel {
        if (_sel_insertContainerBreak == null) {
            _sel_insertContainerBreak = objc.Sel.registerName("insertContainerBreak:");
        }
        return _sel_insertContainerBreak.?;
    }

    pub fn insertSingleQuoteIgnoringSubstitution() objc.Sel {
        if (_sel_insertSingleQuoteIgnoringSubstitution == null) {
            _sel_insertSingleQuoteIgnoringSubstitution = objc.Sel.registerName("insertSingleQuoteIgnoringSubstitution:");
        }
        return _sel_insertSingleQuoteIgnoringSubstitution.?;
    }

    pub fn insertDoubleQuoteIgnoringSubstitution() objc.Sel {
        if (_sel_insertDoubleQuoteIgnoringSubstitution == null) {
            _sel_insertDoubleQuoteIgnoringSubstitution = objc.Sel.registerName("insertDoubleQuoteIgnoringSubstitution:");
        }
        return _sel_insertDoubleQuoteIgnoringSubstitution.?;
    }
};
