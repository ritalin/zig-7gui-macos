const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

pub const NSTextViewSelectors = struct {
    var _sel_textStorage: ?objc.Sel = null;

    pub fn textStorage() objc.Sel {
        if (_sel_textStorage == null) {
            _sel_textStorage = objc.Sel.registerName("textStorage");
        }
        return _sel_textStorage.?;
    }
};

pub const NSTextViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTextView").?;
    }

    pub fn textStorage(self: objc.Object) ?objc.Object {
        return runtime.wrapOptionalObjectId(self.msgSend(objc.c.id, NSTextViewSelectors.textStorage(), .{}));
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

pub const NSSharingForNSTextViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTextView").?;
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime.wrapOptionalObjectId(self.msgSend(objc.c.id, NSSharingForNSTextViewSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, NSSharingForNSTextViewSelectors.setDelegate(), .{
            runtime.unwrapOptionalObject(_delegate),
        });
    }

    pub fn isEditable(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, NSSharingForNSTextViewSelectors.isEditable(), .{});
    }

    pub fn setEditable(self: objc.Object, _editable: objc.c.BOOL) void {
        return self.msgSend(void, NSSharingForNSTextViewSelectors.setEditable(), .{
            _editable,
        });
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

pub const NSTextViewDelegateMessages = struct {
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

    pub fn registerTextViewDoCommandBySelector(_class: objc.Class, _handler: *const runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "textView:doCommandBySelector:", runtime.wrapDelegateHandler(_handler), "c32@0:8@16:24");
    }
};
