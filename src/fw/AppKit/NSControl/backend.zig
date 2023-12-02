const std = @import("std");
const objc = @import("objc");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSRect = foundation.NSRect;
const NSInteger = runtime.NSInteger;

pub const NSControlSelectors = struct {
    var _sel_initWithFrame: ?objc.Sel = null;
    var _sel_target: ?objc.Sel = null;
    var _sel_setTarget: ?objc.Sel = null;
    var _sel_action: ?objc.Sel = null;
    var _sel_setAction: ?objc.Sel = null;
    var _sel_isEnabled: ?objc.Sel = null;
    var _sel_setEnabled: ?objc.Sel = null;
    var _sel_stringValue: ?objc.Sel = null;
    var _sel_setStringValue: ?objc.Sel = null;
    var _sel_intValue: ?objc.Sel = null;
    var _sel_setIntValue: ?objc.Sel = null;
    var _sel_integerValue: ?objc.Sel = null;
    var _sel_setIntegerValue: ?objc.Sel = null;
    var _sel_floatValue: ?objc.Sel = null;
    var _sel_setFloatValue: ?objc.Sel = null;
    var _sel_doubleValue: ?objc.Sel = null;
    var _sel_setDoubleValue: ?objc.Sel = null;
    var _sel_alignment: ?objc.Sel = null;
    var _sel_setAlignment: ?objc.Sel = null;

    pub fn initWithFrame() objc.Sel {
        if (_sel_initWithFrame == null) {
            _sel_initWithFrame = objc.Sel.registerName("initWithFrame:");
        }
        return _sel_initWithFrame.?;
    }

    pub fn target() objc.Sel {
        if (_sel_target == null) {
            _sel_target = objc.Sel.registerName("target");
        }
        return _sel_target.?;
    }

    pub fn setTarget() objc.Sel {
        if (_sel_setTarget == null) {
            _sel_setTarget = objc.Sel.registerName("setTarget:");
        }
        return _sel_setTarget.?;
    }

    pub fn action() objc.Sel {
        if (_sel_action == null) {
            _sel_action = objc.Sel.registerName("action");
        }
        return _sel_action.?;
    }

    pub fn setAction() objc.Sel {
        if (_sel_setAction == null) {
            _sel_setAction = objc.Sel.registerName("setAction:");
        }
        return _sel_setAction.?;
    }

    pub fn isEnabled() objc.Sel {
        if (_sel_isEnabled == null) {
            _sel_isEnabled = objc.Sel.registerName("isEnabled");
        }
        return _sel_isEnabled.?;
    }

    pub fn setEnabled() objc.Sel {
        if (_sel_setEnabled == null) {
            _sel_setEnabled = objc.Sel.registerName("setEnabled:");
        }
        return _sel_setEnabled.?;
    }

    pub fn stringValue() objc.Sel {
        if (_sel_stringValue == null) {
            _sel_stringValue = objc.Sel.registerName("stringValue");
        }
        return _sel_stringValue.?;
    }

    pub fn setStringValue() objc.Sel {
        if (_sel_setStringValue == null) {
            _sel_setStringValue = objc.Sel.registerName("setStringValue:");
        }
        return _sel_setStringValue.?;
    }

    pub fn intValue() objc.Sel {
        if (_sel_intValue == null) {
            _sel_intValue = objc.Sel.registerName("intValue");
        }
        return _sel_intValue.?;
    }

    pub fn setIntValue() objc.Sel {
        if (_sel_setIntValue == null) {
            _sel_setIntValue = objc.Sel.registerName("setIntValue:");
        }
        return _sel_setIntValue.?;
    }

    pub fn integerValue() objc.Sel {
        if (_sel_integerValue == null) {
            _sel_integerValue = objc.Sel.registerName("integerValue");
        }
        return _sel_integerValue.?;
    }

    pub fn setIntegerValue() objc.Sel {
        if (_sel_setIntegerValue == null) {
            _sel_setIntegerValue = objc.Sel.registerName("setIntegerValue:");
        }
        return _sel_setIntegerValue.?;
    }

    pub fn floatValue() objc.Sel {
        if (_sel_floatValue == null) {
            _sel_floatValue = objc.Sel.registerName("floatValue");
        }
        return _sel_floatValue.?;
    }

    pub fn setFloatValue() objc.Sel {
        if (_sel_setFloatValue == null) {
            _sel_setFloatValue = objc.Sel.registerName("setFloatValue:");
        }
        return _sel_setFloatValue.?;
    }

    pub fn doubleValue() objc.Sel {
        if (_sel_doubleValue == null) {
            _sel_doubleValue = objc.Sel.registerName("doubleValue");
        }
        return _sel_doubleValue.?;
    }

    pub fn setDoubleValue() objc.Sel {
        if (_sel_setDoubleValue == null) {
            _sel_setDoubleValue = objc.Sel.registerName("setDoubleValue:");
        }
        return _sel_setDoubleValue.?;
    }

    pub fn alignment() objc.Sel {
        if (_sel_alignment == null) {
            _sel_alignment = objc.Sel.registerName("alignment");
        }
        return _sel_alignment.?;
    }

    pub fn setAlignment() objc.Sel {
        if (_sel_setAlignment == null) {
            _sel_setAlignment = objc.Sel.registerName("setAlignment:");
        }
        return _sel_setAlignment.?;
    }
};

pub const NSControlMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSControl").?;
    }

    pub fn initWithFrame(_class: objc.Class, _frameRect: NSRect) objc.Object {
        return runtime_support.backend_support.allocInstance(_class).msgSend(objc.Object, NSControlSelectors.initWithFrame(), .{
            _frameRect,
        });
    }

    pub fn target(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, NSControlSelectors.target(), .{}));
    }

    pub fn setTarget(self: objc.Object, _target: ?objc.Object) void {
        return self.msgSend(void, NSControlSelectors.setTarget(), .{
            runtime_support.unwrapOptionalObject(_target),
        });
    }

    pub fn action(self: objc.Object) ?objc.Sel {
        return self.msgSend(?objc.Sel, NSControlSelectors.action(), .{});
    }

    pub fn setAction(self: objc.Object, _action: ?objc.Sel) void {
        return self.msgSend(void, NSControlSelectors.setAction(), .{
            runtime_support.unwrapOptionalSelValue(_action),
        });
    }

    pub fn isEnabled(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, NSControlSelectors.isEnabled(), .{});
    }

    pub fn setEnabled(self: objc.Object, _enabled: objc.c.BOOL) void {
        return self.msgSend(void, NSControlSelectors.setEnabled(), .{
            _enabled,
        });
    }

    pub fn stringValue(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, NSControlSelectors.stringValue(), .{});
    }

    pub fn setStringValue(self: objc.Object, _stringValue: objc.Object) void {
        return self.msgSend(void, NSControlSelectors.setStringValue(), .{
            runtime_support.unwrapOptionalObject(_stringValue),
        });
    }

    pub fn intValue(self: objc.Object) c_int {
        return self.msgSend(c_int, NSControlSelectors.intValue(), .{});
    }

    pub fn setIntValue(self: objc.Object, _intValue: c_int) void {
        return self.msgSend(void, NSControlSelectors.setIntValue(), .{
            _intValue,
        });
    }

    pub fn integerValue(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, NSControlSelectors.integerValue(), .{});
    }

    pub fn setIntegerValue(self: objc.Object, _integerValue: NSInteger) void {
        return self.msgSend(void, NSControlSelectors.setIntegerValue(), .{
            _integerValue,
        });
    }

    pub fn floatValue(self: objc.Object) f32 {
        return self.msgSend(f32, NSControlSelectors.floatValue(), .{});
    }

    pub fn setFloatValue(self: objc.Object, _floatValue: f32) void {
        return self.msgSend(void, NSControlSelectors.setFloatValue(), .{
            _floatValue,
        });
    }

    pub fn doubleValue(self: objc.Object) f64 {
        return self.msgSend(f64, NSControlSelectors.doubleValue(), .{});
    }

    pub fn setDoubleValue(self: objc.Object, _doubleValue: f64) void {
        return self.msgSend(void, NSControlSelectors.setDoubleValue(), .{
            _doubleValue,
        });
    }

    pub fn alignment(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, NSControlSelectors.alignment(), .{});
    }

    pub fn setAlignment(self: objc.Object, _alignment: NSInteger) void {
        return self.msgSend(void, NSControlSelectors.setAlignment(), .{
            _alignment,
        });
    }
};

pub const NSControlTextEditingDelegateSelectors = struct {
    var _sel_controlTextDidChange: ?objc.Sel = null;

    pub fn controlTextDidChange() objc.Sel {
        if (_sel_controlTextDidChange == null) {
            _sel_controlTextDidChange = objc.Sel.registerName("controlTextDidChange:");
        }
        return _sel_controlTextDidChange.?;
    }
};

pub const NSControlTextEditingDelegateMessages = struct {
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

    pub fn registerControlTextDidChange(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "controlTextDidChange:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }
};
