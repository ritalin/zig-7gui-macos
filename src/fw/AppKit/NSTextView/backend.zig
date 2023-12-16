const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTextViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTextView").?;
    }

    pub fn textStorage(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSTextViewSelectors.textStorage(), .{}));
    }
};

pub const NSSharingForNSTextViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTextView").?;
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSSharingForNSTextViewSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, selector.NSSharingForNSTextViewSelectors.setDelegate(), .{
            runtime_support.unwrapOptionalObject(_delegate),
        });
    }

    pub fn isEditable(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSSharingForNSTextViewSelectors.isEditable(), .{});
    }

    pub fn setEditable(self: objc.Object, _editable: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSSharingForNSTextViewSelectors.setEditable(), .{
            _editable,
        });
    }
};

pub const NSTextViewDelegateMessages = struct {
    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;

    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSTextViewDelegate");
        }
        return class.?;
    }

    pub fn registerTextViewDoCommandBySelector(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "textView:doCommandBySelector:", runtime_support.wrapDelegateHandler(_handler), "c32@0:8@16:24");
    }
};
