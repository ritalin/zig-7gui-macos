const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSAttributedStringSelectors = struct {
    var _sel_string: ?objc.Sel = null;

    pub fn string() objc.Sel {
        if (_sel_string == null) {
            _sel_string = objc.Sel.registerName("string");
        }
        return _sel_string.?;
    }
};

pub const NSMutableAttributedStringSelectors = struct {};

pub const NSExtendedAttributedStringForNSAttributedStringSelectors = struct {
    var _sel_initWithString: ?objc.Sel = null;

    pub fn initWithString() objc.Sel {
        if (_sel_initWithString == null) {
            _sel_initWithString = objc.Sel.registerName("initWithString:");
        }
        return _sel_initWithString.?;
    }
};

pub const NSExtendedMutableAttributedStringForNSMutableAttributedStringSelectors = struct {
    var _sel_setAttributedString: ?objc.Sel = null;

    pub fn setAttributedString() objc.Sel {
        if (_sel_setAttributedString == null) {
            _sel_setAttributedString = objc.Sel.registerName("setAttributedString:");
        }
        return _sel_setAttributedString.?;
    }
};
