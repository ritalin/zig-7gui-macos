const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTextFieldMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTextField").?;
    }

    pub fn backgroundColor(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSTextFieldSelectors.backgroundColor(), .{}));
    }

    pub fn setBackgroundColor(self: objc.Object, _backgroundColor: ?objc.Object) void {
        return self.msgSend(void, selector.NSTextFieldSelectors.setBackgroundColor(), .{
            runtime_support.unwrapOptionalObject(_backgroundColor),
        });
    }

    pub fn isEditable(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSTextFieldSelectors.isEditable(), .{});
    }

    pub fn setEditable(self: objc.Object, _editable: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSTextFieldSelectors.setEditable(), .{
            _editable,
        });
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSTextFieldSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, selector.NSTextFieldSelectors.setDelegate(), .{
            runtime_support.unwrapOptionalObject(_delegate),
        });
    }
};

pub const NSTextFieldConvenienceForNSTextFieldMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTextField").?;
    }

    pub fn labelWithString(_class: objc.Class, _stringValue: objc.Object) objc.Object {
        return _class.msgSend(objc.Object, selector.NSTextFieldConvenienceForNSTextFieldSelectors.labelWithString(), .{
            runtime_support.unwrapOptionalObject(_stringValue),
        });
    }

    pub fn wrappingLabelWithString(_class: objc.Class, _stringValue: objc.Object) objc.Object {
        return _class.msgSend(objc.Object, selector.NSTextFieldConvenienceForNSTextFieldSelectors.wrappingLabelWithString(), .{
            runtime_support.unwrapOptionalObject(_stringValue),
        });
    }

    pub fn textFieldWithString(_class: objc.Class, _stringValue: objc.Object) objc.Object {
        return _class.msgSend(objc.Object, selector.NSTextFieldConvenienceForNSTextFieldSelectors.textFieldWithString(), .{
            runtime_support.unwrapOptionalObject(_stringValue),
        });
    }
};

pub const NSTextFieldDelegateMessages = struct {
    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSTextFieldDelegate");
        }
        return class.?;
    }

    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;
};
