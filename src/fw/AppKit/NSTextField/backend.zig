const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTextFieldSelectors = struct {
    var _sel_backgroundColor: ?objc.Sel = null;
    var _sel_setBackgroundColor: ?objc.Sel = null;
    var _sel_isEditable: ?objc.Sel = null;
    var _sel_setEditable: ?objc.Sel = null;
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;

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
};

pub const NSTextFieldMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTextField").?;
    }

    pub fn backgroundColor(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, NSTextFieldSelectors.backgroundColor(), .{}));
    }

    pub fn setBackgroundColor(self: objc.Object, _backgroundColor: ?objc.Object) void {
        return self.msgSend(void, NSTextFieldSelectors.setBackgroundColor(), .{
            runtime_support.unwrapOptionalObject(_backgroundColor),
        });
    }

    pub fn isEditable(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, NSTextFieldSelectors.isEditable(), .{});
    }

    pub fn setEditable(self: objc.Object, _editable: objc.c.BOOL) void {
        return self.msgSend(void, NSTextFieldSelectors.setEditable(), .{
            _editable,
        });
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, NSTextFieldSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, NSTextFieldSelectors.setDelegate(), .{
            runtime_support.unwrapOptionalObject(_delegate),
        });
    }
};

pub const NSTextFieldConvenienceForNSTextFieldSelectors = struct {
    var _sel_labelWithString: ?objc.Sel = null;
    var _sel_wrappingLabelWithString: ?objc.Sel = null;
    var _sel_textFieldWithString: ?objc.Sel = null;

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
};

pub const NSTextFieldConvenienceForNSTextFieldMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTextField").?;
    }

    pub fn labelWithString(_class: objc.Class, _stringValue: objc.Object) objc.Object {
        return _class.msgSend(objc.Object, NSTextFieldConvenienceForNSTextFieldSelectors.labelWithString(), .{
            runtime_support.unwrapOptionalObject(_stringValue),
        });
    }

    pub fn wrappingLabelWithString(_class: objc.Class, _stringValue: objc.Object) objc.Object {
        return _class.msgSend(objc.Object, NSTextFieldConvenienceForNSTextFieldSelectors.wrappingLabelWithString(), .{
            runtime_support.unwrapOptionalObject(_stringValue),
        });
    }

    pub fn textFieldWithString(_class: objc.Class, _stringValue: objc.Object) objc.Object {
        return _class.msgSend(objc.Object, NSTextFieldConvenienceForNSTextFieldSelectors.textFieldWithString(), .{
            runtime_support.unwrapOptionalObject(_stringValue),
        });
    }
};

pub const NSTextFieldDelegateSelectors = struct {};

pub const NSTextFieldDelegateMessages = struct {
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
};
