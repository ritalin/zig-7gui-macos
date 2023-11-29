const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

pub const NSResponderSelectors = struct {};

pub const NSResponderMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSResponder").?;
    }
};

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

pub const NSStandardKeyBindingRespondingMessages = struct {
    pub const init = runtime.backend_support.newInstance;
    pub const dealloc = runtime.backend_support.destroyInstance;
    pub const registerMessage = runtime.backend_support.ObjectRegistry.registerMessage;

    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime.backend_support.ObjectRegistry.newDelegateClass(_class_name, "");
        }
        return class.?;
    }

    pub fn registerInsertTab(_class: objc.Class, _handler: *runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "insertTab:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertBacktab(_class: objc.Class, _handler: *runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "insertBacktab:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertNewline(_class: objc.Class, _handler: *runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "insertNewline:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertParagraphSeparator(_class: objc.Class, _handler: *runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "insertParagraphSeparator:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertNewlineIgnoringFieldEditor(_class: objc.Class, _handler: *runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "insertNewlineIgnoringFieldEditor:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertTabIgnoringFieldEditor(_class: objc.Class, _handler: *runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "insertTabIgnoringFieldEditor:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertLineBreak(_class: objc.Class, _handler: *runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "insertLineBreak:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertContainerBreak(_class: objc.Class, _handler: *runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "insertContainerBreak:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertSingleQuoteIgnoringSubstitution(_class: objc.Class, _handler: *runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "insertSingleQuoteIgnoringSubstitution:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertDoubleQuoteIgnoringSubstitution(_class: objc.Class, _handler: *runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "insertDoubleQuoteIgnoringSubstitution:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }
};
