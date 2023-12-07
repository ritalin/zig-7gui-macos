const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSResponderMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSResponder").?;
    }
};

pub const NSStandardKeyBindingRespondingMessages = struct {
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

    pub fn registerInsertTab(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "insertTab:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertBacktab(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "insertBacktab:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertNewline(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "insertNewline:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertParagraphSeparator(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "insertParagraphSeparator:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertNewlineIgnoringFieldEditor(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "insertNewlineIgnoringFieldEditor:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertTabIgnoringFieldEditor(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "insertTabIgnoringFieldEditor:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertLineBreak(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "insertLineBreak:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertContainerBreak(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "insertContainerBreak:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertSingleQuoteIgnoringSubstitution(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "insertSingleQuoteIgnoringSubstitution:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerInsertDoubleQuoteIgnoringSubstitution(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "insertDoubleQuoteIgnoringSubstitution:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }
};
