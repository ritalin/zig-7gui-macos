const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSRect = foundation.NSRect;
const NSInteger = runtime.NSInteger;

pub const NSControlMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSControl").?;
    }

    pub fn initWithFrame(_class: objc.Class, _frameRect: NSRect) objc.Object {
        return runtime_support.backend_support.allocInstance(_class).msgSend(objc.Object, selector.NSControlSelectors.initWithFrame(), .{
            _frameRect,
        });
    }

    pub fn target(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSControlSelectors.target(), .{}));
    }

    pub fn setTarget(self: objc.Object, _target: ?objc.Object) void {
        return self.msgSend(void, selector.NSControlSelectors.setTarget(), .{
            runtime_support.unwrapOptionalObject(_target),
        });
    }

    pub fn action(self: objc.Object) ?objc.Sel {
        return self.msgSend(?objc.Sel, selector.NSControlSelectors.action(), .{});
    }

    pub fn setAction(self: objc.Object, _action: ?objc.Sel) void {
        return self.msgSend(void, selector.NSControlSelectors.setAction(), .{
            runtime_support.unwrapOptionalSelValue(_action),
        });
    }

    pub fn isEnabled(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSControlSelectors.isEnabled(), .{});
    }

    pub fn setEnabled(self: objc.Object, _enabled: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSControlSelectors.setEnabled(), .{
            _enabled,
        });
    }

    pub fn stringValue(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSControlSelectors.stringValue(), .{});
    }

    pub fn setStringValue(self: objc.Object, _stringValue: objc.Object) void {
        return self.msgSend(void, selector.NSControlSelectors.setStringValue(), .{
            runtime_support.unwrapOptionalObject(_stringValue),
        });
    }

    pub fn intValue(self: objc.Object) c_int {
        return self.msgSend(c_int, selector.NSControlSelectors.intValue(), .{});
    }

    pub fn setIntValue(self: objc.Object, _intValue: c_int) void {
        return self.msgSend(void, selector.NSControlSelectors.setIntValue(), .{
            _intValue,
        });
    }

    pub fn integerValue(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSControlSelectors.integerValue(), .{});
    }

    pub fn setIntegerValue(self: objc.Object, _integerValue: NSInteger) void {
        return self.msgSend(void, selector.NSControlSelectors.setIntegerValue(), .{
            _integerValue,
        });
    }

    pub fn floatValue(self: objc.Object) f32 {
        return self.msgSend(f32, selector.NSControlSelectors.floatValue(), .{});
    }

    pub fn setFloatValue(self: objc.Object, _floatValue: f32) void {
        return self.msgSend(void, selector.NSControlSelectors.setFloatValue(), .{
            _floatValue,
        });
    }

    pub fn doubleValue(self: objc.Object) f64 {
        return self.msgSend(f64, selector.NSControlSelectors.doubleValue(), .{});
    }

    pub fn setDoubleValue(self: objc.Object, _doubleValue: f64) void {
        return self.msgSend(void, selector.NSControlSelectors.setDoubleValue(), .{
            _doubleValue,
        });
    }

    pub fn alignment(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSControlSelectors.alignment(), .{});
    }

    pub fn setAlignment(self: objc.Object, _alignment: NSInteger) void {
        return self.msgSend(void, selector.NSControlSelectors.setAlignment(), .{
            _alignment,
        });
    }
};

pub const NSControlTextEditingDelegateMessages = struct {
    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;

    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSControlTextEditingDelegate");
        }
        return class.?;
    }

    pub fn registerControlTextDidChange(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "controlTextDidChange:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }
};
