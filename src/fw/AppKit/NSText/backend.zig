const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTextSelectors = struct {
    var _sel_string: ?objc.Sel = null;
    var _sel_setString: ?objc.Sel = null;
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;
    var _sel_isEditable: ?objc.Sel = null;
    var _sel_setEditable: ?objc.Sel = null;

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
};

pub const NSTextMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSText").?;
    }

    pub fn string(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, NSTextSelectors.string(), .{});
    }

    pub fn setString(self: objc.Object, _string: objc.Object) void {
        return self.msgSend(void, NSTextSelectors.setString(), .{
            runtime_support.unwrapOptionalObject(_string),
        });
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, NSTextSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, NSTextSelectors.setDelegate(), .{
            runtime_support.unwrapOptionalObject(_delegate),
        });
    }

    pub fn isEditable(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, NSTextSelectors.isEditable(), .{});
    }

    pub fn setEditable(self: objc.Object, _editable: objc.c.BOOL) void {
        return self.msgSend(void, NSTextSelectors.setEditable(), .{
            _editable,
        });
    }
};

pub const NSTextDelegateSelectors = struct {
    var _sel_textDidChange: ?objc.Sel = null;

    pub fn textDidChange() objc.Sel {
        if (_sel_textDidChange == null) {
            _sel_textDidChange = objc.Sel.registerName("textDidChange:");
        }
        return _sel_textDidChange.?;
    }
};

pub const NSTextDelegateMessages = struct {
    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;

    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "");
        }
        return class.?;
    }

    pub fn registerTextDidChange(_class: objc.Class, _handler: *runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "textDidChange:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }
};
