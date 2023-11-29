const std = @import("std");
const objc = @import("objc");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSRect = foundation.NSRect;
const NSUInteger = runtime.NSUInteger;

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

pub const NSWindowMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSWindow").?;
    }

    pub fn initWithContentRectStyleMaskBacking(_class: objc.Class, _contentRect: NSRect, _style: NSUInteger, _backingStoreType: NSUInteger, _flag: objc.c.BOOL, _screen: ?objc.Object) objc.Object {
        return runtime.backend_support.allocInstance(_class).msgSend(objc.Object, NSWindowSelectors.initWithContentRectStyleMaskBacking(), .{
            _contentRect,
            _style,
            _backingStoreType,
            _flag,
            runtime.unwrapOptionalObject(_screen),
        });
    }

    pub fn title(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, NSWindowSelectors.title(), .{});
    }

    pub fn setTitle(self: objc.Object, _title: objc.Object) void {
        return self.msgSend(void, NSWindowSelectors.setTitle(), .{
            runtime.unwrapOptionalObject(_title),
        });
    }

    pub fn contentView(self: objc.Object) ?objc.Object {
        return runtime.wrapOptionalObjectId(self.msgSend(objc.c.id, NSWindowSelectors.contentView(), .{}));
    }

    pub fn setContentView(self: objc.Object, _contentView: ?objc.Object) void {
        return self.msgSend(void, NSWindowSelectors.setContentView(), .{
            runtime.unwrapOptionalObject(_contentView),
        });
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime.wrapOptionalObjectId(self.msgSend(objc.c.id, NSWindowSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, NSWindowSelectors.setDelegate(), .{
            runtime.unwrapOptionalObject(_delegate),
        });
    }

    pub fn makeFirstResponder(self: objc.Object, _responder: ?objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, NSWindowSelectors.makeFirstResponder(), .{
            runtime.unwrapOptionalObject(_responder),
        });
    }

    pub fn firstResponder(self: objc.Object) ?objc.Object {
        return runtime.wrapOptionalObjectId(self.msgSend(objc.c.id, NSWindowSelectors.firstResponder(), .{}));
    }

    pub fn backgroundColor(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, NSWindowSelectors.backgroundColor(), .{});
    }

    pub fn setBackgroundColor(self: objc.Object, _backgroundColor: ?objc.Object) void {
        return self.msgSend(void, NSWindowSelectors.setBackgroundColor(), .{
            runtime.unwrapOptionalObject(_backgroundColor),
        });
    }

    pub fn makeKeyAndOrderFront(self: objc.Object, _sender: ?objc.Object) void {
        return self.msgSend(void, NSWindowSelectors.makeKeyAndOrderFront(), .{
            runtime.unwrapOptionalObject(_sender),
        });
    }

    pub fn initialFirstResponder(_class: objc.Class) ?objc.Object {
        return runtime.wrapOptionalObjectId(runtime.backend_support.allocInstance(_class).msgSend(objc.c.id, NSWindowSelectors.initialFirstResponder(), .{}));
    }

    pub fn setInitialFirstResponder(self: objc.Object, _initialFirstResponder: ?objc.Object) void {
        return self.msgSend(void, NSWindowSelectors.setInitialFirstResponder(), .{
            runtime.unwrapOptionalObject(_initialFirstResponder),
        });
    }

    pub fn selectNextKeyView(self: objc.Object, _sender: ?objc.Object) void {
        return self.msgSend(void, NSWindowSelectors.selectNextKeyView(), .{
            runtime.unwrapOptionalObject(_sender),
        });
    }

    pub fn selectPreviousKeyView(self: objc.Object, _sender: ?objc.Object) void {
        return self.msgSend(void, NSWindowSelectors.selectPreviousKeyView(), .{
            runtime.unwrapOptionalObject(_sender),
        });
    }
};

pub const NSCursorRectForNSWindowSelectors = struct {};

pub const NSCursorRectForNSWindowMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSWindow").?;
    }
};

pub const NSDeprecatedForNSWindowSelectors = struct {};

pub const NSDeprecatedForNSWindowMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSWindow").?;
    }
};

pub const NSCarbonExtensionsForNSWindowSelectors = struct {};

pub const NSCarbonExtensionsForNSWindowMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSWindow").?;
    }
};

pub const NSEventForNSWindowSelectors = struct {};

pub const NSEventForNSWindowMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSWindow").?;
    }
};

pub const NSDragForNSWindowSelectors = struct {};

pub const NSDragForNSWindowMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSWindow").?;
    }
};

pub const NSWindowDelegateSelectors = struct {
    var _sel_windowWillClose: ?objc.Sel = null;

    pub fn windowWillClose() objc.Sel {
        if (_sel_windowWillClose == null) {
            _sel_windowWillClose = objc.Sel.registerName("windowWillClose:");
        }
        return _sel_windowWillClose.?;
    }
};

pub const NSWindowDelegateMessages = struct {
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

    pub fn registerWindowWillClose(_class: objc.Class, _handler: *runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "windowWillClose:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }
};
