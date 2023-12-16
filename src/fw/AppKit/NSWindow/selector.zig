const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSWindowSelectors = struct {
    var _sel_initWithContentRectStyleMaskBacking: ?objc.Sel = null;
    var _sel_title: ?objc.Sel = null;
    var _sel_setTitle: ?objc.Sel = null;
    var _sel_contentView: ?objc.Sel = null;
    var _sel_setContentView: ?objc.Sel = null;
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;
    var _sel_makeFirstResponder: ?objc.Sel = null;
    var _sel_firstResponder: ?objc.Sel = null;
    var _sel_backgroundColor: ?objc.Sel = null;
    var _sel_setBackgroundColor: ?objc.Sel = null;
    var _sel_makeKeyAndOrderFront: ?objc.Sel = null;
    var _sel_initialFirstResponder: ?objc.Sel = null;
    var _sel_setInitialFirstResponder: ?objc.Sel = null;
    var _sel_selectNextKeyView: ?objc.Sel = null;
    var _sel_selectPreviousKeyView: ?objc.Sel = null;

    pub fn initWithContentRectStyleMaskBacking() objc.Sel {
        if (_sel_initWithContentRectStyleMaskBacking == null) {
            _sel_initWithContentRectStyleMaskBacking = objc.Sel.registerName("initWithContentRect:styleMask:backing:defer:screen:");
        }
        return _sel_initWithContentRectStyleMaskBacking.?;
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

    pub fn contentView() objc.Sel {
        if (_sel_contentView == null) {
            _sel_contentView = objc.Sel.registerName("contentView");
        }
        return _sel_contentView.?;
    }

    pub fn setContentView() objc.Sel {
        if (_sel_setContentView == null) {
            _sel_setContentView = objc.Sel.registerName("setContentView:");
        }
        return _sel_setContentView.?;
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

    pub fn makeFirstResponder() objc.Sel {
        if (_sel_makeFirstResponder == null) {
            _sel_makeFirstResponder = objc.Sel.registerName("makeFirstResponder:");
        }
        return _sel_makeFirstResponder.?;
    }

    pub fn firstResponder() objc.Sel {
        if (_sel_firstResponder == null) {
            _sel_firstResponder = objc.Sel.registerName("firstResponder");
        }
        return _sel_firstResponder.?;
    }

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

    pub fn makeKeyAndOrderFront() objc.Sel {
        if (_sel_makeKeyAndOrderFront == null) {
            _sel_makeKeyAndOrderFront = objc.Sel.registerName("makeKeyAndOrderFront:");
        }
        return _sel_makeKeyAndOrderFront.?;
    }

    pub fn initialFirstResponder() objc.Sel {
        if (_sel_initialFirstResponder == null) {
            _sel_initialFirstResponder = objc.Sel.registerName("initialFirstResponder");
        }
        return _sel_initialFirstResponder.?;
    }

    pub fn setInitialFirstResponder() objc.Sel {
        if (_sel_setInitialFirstResponder == null) {
            _sel_setInitialFirstResponder = objc.Sel.registerName("setInitialFirstResponder:");
        }
        return _sel_setInitialFirstResponder.?;
    }

    pub fn selectNextKeyView() objc.Sel {
        if (_sel_selectNextKeyView == null) {
            _sel_selectNextKeyView = objc.Sel.registerName("selectNextKeyView:");
        }
        return _sel_selectNextKeyView.?;
    }

    pub fn selectPreviousKeyView() objc.Sel {
        if (_sel_selectPreviousKeyView == null) {
            _sel_selectPreviousKeyView = objc.Sel.registerName("selectPreviousKeyView:");
        }
        return _sel_selectPreviousKeyView.?;
    }
};

pub const NSCursorRectForNSWindowSelectors = struct {};

pub const NSCarbonExtensionsForNSWindowSelectors = struct {};

pub const NSEventForNSWindowSelectors = struct {};

pub const NSDragForNSWindowSelectors = struct {};

pub const NSWindowDelegateSelectors = struct {
    var _sel_windowWillClose: ?objc.Sel = null;

    pub fn windowWillClose() objc.Sel {
        if (_sel_windowWillClose == null) {
            _sel_windowWillClose = objc.Sel.registerName("windowWillClose:");
        }
        return _sel_windowWillClose.?;
    }
};
