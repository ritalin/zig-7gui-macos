const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSEventSelectors = struct {
    pub fn @"type"() objc.Sel {
        if (_sel_type == null) {
            _sel_type = objc.Sel.registerName("type");
        }
        return _sel_type.?;
    }

    pub fn modifierFlags() objc.Sel {
        if (_sel_modifierFlags == null) {
            _sel_modifierFlags = objc.Sel.registerName("modifierFlags");
        }
        return _sel_modifierFlags.?;
    }

    pub fn modifierFlagsCurrent() objc.Sel {
        if (_sel_modifierFlagsCurrent == null) {
            _sel_modifierFlagsCurrent = objc.Sel.registerName("modifierFlags");
        }
        return _sel_modifierFlagsCurrent.?;
    }

    var _sel_type: ?objc.Sel = null;
    var _sel_modifierFlags: ?objc.Sel = null;
    var _sel_modifierFlagsCurrent: ?objc.Sel = null;
};
