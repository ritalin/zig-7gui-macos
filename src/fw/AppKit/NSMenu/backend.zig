const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSMenuMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSMenu").?;
    }

    pub fn popUpContextMenuWithEventForView(_menu: objc.Object, _event: objc.Object, _view: objc.Object) void {
        return getClass().msgSend(void, selector.NSMenuSelectors.popUpContextMenuWithEventForView(), .{
            runtime_support.unwrapOptionalObject(_menu),
            runtime_support.unwrapOptionalObject(_event),
            runtime_support.unwrapOptionalObject(_view),
        });
    }

    pub fn addItemWithTitleActionKeyEquivalent(self: objc.Object, _string: objc.Object, _selector: ?objc.Sel, _charCode: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSMenuSelectors.addItemWithTitleActionKeyEquivalent(), .{
            runtime_support.unwrapOptionalObject(_string),
            runtime_support.unwrapOptionalSelValue(_selector),
            runtime_support.unwrapOptionalObject(_charCode),
        });
    }
};

pub const NSMenuItemValidationMessages = struct {
    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSMenuItemValidation");
        }
        return class.?;
    }

    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;
};
