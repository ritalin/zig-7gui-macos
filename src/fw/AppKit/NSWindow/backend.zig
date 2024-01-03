const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSWindowMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSWindow").?;
    }

    pub fn initWithContentRectStyleMaskBacking(_class: objc.Class, _contentRect: NSRect, _style: NSUInteger, _backingStoreType: NSUInteger, _flag: objc.c.BOOL, _screen: ?objc.Object) objc.Object {
        return runtime_support.backend_support.allocInstance(_class).msgSend(objc.Object, selector.NSWindowSelectors.initWithContentRectStyleMaskBacking(), .{
            _contentRect,
            _style,
            _backingStoreType,
            _flag,
            runtime_support.unwrapOptionalObject(_screen),
        });
    }

    pub fn title(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSWindowSelectors.title(), .{});
    }

    pub fn setTitle(self: objc.Object, _title: objc.Object) void {
        return self.msgSend(void, selector.NSWindowSelectors.setTitle(), .{
            runtime_support.unwrapOptionalObject(_title),
        });
    }

    pub fn contentView(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSWindowSelectors.contentView(), .{}));
    }

    pub fn setContentView(self: objc.Object, _contentView: ?objc.Object) void {
        return self.msgSend(void, selector.NSWindowSelectors.setContentView(), .{
            runtime_support.unwrapOptionalObject(_contentView),
        });
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSWindowSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, selector.NSWindowSelectors.setDelegate(), .{
            runtime_support.unwrapOptionalObject(_delegate),
        });
    }

    pub fn displayIfNeeded(self: objc.Object) void {
        return self.msgSend(void, selector.NSWindowSelectors.displayIfNeeded(), .{});
    }

    pub fn display(self: objc.Object) void {
        return self.msgSend(void, selector.NSWindowSelectors.display(), .{});
    }

    pub fn makeFirstResponder(self: objc.Object, _responder: ?objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSWindowSelectors.makeFirstResponder(), .{
            runtime_support.unwrapOptionalObject(_responder),
        });
    }

    pub fn firstResponder(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSWindowSelectors.firstResponder(), .{}));
    }

    pub fn backgroundColor(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSWindowSelectors.backgroundColor(), .{});
    }

    pub fn setBackgroundColor(self: objc.Object, _backgroundColor: ?objc.Object) void {
        return self.msgSend(void, selector.NSWindowSelectors.setBackgroundColor(), .{
            runtime_support.unwrapOptionalObject(_backgroundColor),
        });
    }

    pub fn makeKeyAndOrderFront(self: objc.Object, _sender: ?objc.Object) void {
        return self.msgSend(void, selector.NSWindowSelectors.makeKeyAndOrderFront(), .{
            runtime_support.unwrapOptionalObject(_sender),
        });
    }

    pub fn initialFirstResponder(_class: objc.Class) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(runtime_support.backend_support.allocInstance(_class).msgSend(objc.c.id, selector.NSWindowSelectors.initialFirstResponder(), .{}));
    }

    pub fn setInitialFirstResponder(self: objc.Object, _initialFirstResponder: ?objc.Object) void {
        return self.msgSend(void, selector.NSWindowSelectors.setInitialFirstResponder(), .{
            runtime_support.unwrapOptionalObject(_initialFirstResponder),
        });
    }

    pub fn selectNextKeyView(self: objc.Object, _sender: ?objc.Object) void {
        return self.msgSend(void, selector.NSWindowSelectors.selectNextKeyView(), .{
            runtime_support.unwrapOptionalObject(_sender),
        });
    }

    pub fn selectPreviousKeyView(self: objc.Object, _sender: ?objc.Object) void {
        return self.msgSend(void, selector.NSWindowSelectors.selectPreviousKeyView(), .{
            runtime_support.unwrapOptionalObject(_sender),
        });
    }
};

pub const NSCursorRectForNSWindowMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSWindow").?;
    }
};

pub const NSCarbonExtensionsForNSWindowMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSWindow").?;
    }
};

pub const NSEventForNSWindowMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSWindow").?;
    }
};

pub const NSDragForNSWindowMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSWindow").?;
    }
};

pub const NSWindowDelegateMessages = struct {
    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSWindowDelegate");
        }
        return class.?;
    }

    pub fn registerWindowWillClose(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "windowWillClose:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;
};

const NSRect = foundation.NSRect;
const NSUInteger = runtime.NSUInteger;
