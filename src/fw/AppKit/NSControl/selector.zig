const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSControlSelectors = struct {
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

    pub fn sendActionOn() objc.Sel {
        if (_sel_sendActionOn == null) {
            _sel_sendActionOn = objc.Sel.registerName("sendActionOn:");
        }
        return _sel_sendActionOn.?;
    }

    pub fn sendActionTo() objc.Sel {
        if (_sel_sendActionTo == null) {
            _sel_sendActionTo = objc.Sel.registerName("sendAction:to:");
        }
        return _sel_sendActionTo.?;
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
    var _sel_sendActionOn: ?objc.Sel = null;
    var _sel_sendActionTo: ?objc.Sel = null;
    var _sel_alignment: ?objc.Sel = null;
    var _sel_setAlignment: ?objc.Sel = null;
};

pub const NSControlTextEditingDelegateSelectors = struct {
    pub fn controlTextDidChange() objc.Sel {
        if (_sel_controlTextDidChange == null) {
            _sel_controlTextDidChange = objc.Sel.registerName("controlTextDidChange:");
        }
        return _sel_controlTextDidChange.?;
    }

    var _sel_controlTextDidChange: ?objc.Sel = null;
};
