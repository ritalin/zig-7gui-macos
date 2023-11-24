const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

pub const NSAttributedStringSelectors = struct {
    var _sel_string: ?objc.Sel = null;

    pub fn string() objc.Sel {
        if (_sel_string == null) {
            _sel_string = objc.Sel.registerName("string");
        }
        return _sel_string.?;
    }
};

pub const NSAttributedStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSAttributedString").?;
    }

    pub fn string(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, NSAttributedStringSelectors.string(), .{});
    }
};

pub const NSMutableAttributedStringSelectors = struct {};

pub const NSMutableAttributedStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSMutableAttributedString").?;
    }
};

pub const NSExtendedAttributedStringForNSAttributedStringSelectors = struct {
    var _sel_initWithString: ?objc.Sel = null;

    pub fn initWithString() objc.Sel {
        if (_sel_initWithString == null) {
            _sel_initWithString = objc.Sel.registerName("initWithString:");
        }
        return _sel_initWithString.?;
    }
};

pub const NSExtendedAttributedStringForNSAttributedStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSAttributedString").?;
    }

    pub fn initWithString(_class: objc.Class, _str: objc.Object) objc.Object {
        return runtime.backend_support.allocInstance(_class).msgSend(objc.Object, NSExtendedAttributedStringForNSAttributedStringSelectors.initWithString(), .{
            runtime.unwrapOptionalObject(_str),
        });
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

pub const NSExtendedMutableAttributedStringForNSMutableAttributedStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSMutableAttributedString").?;
    }

    pub fn setAttributedString(self: objc.Object, _attrString: objc.Object) void {
        return self.msgSend(void, NSExtendedMutableAttributedStringForNSMutableAttributedStringSelectors.setAttributedString(), .{
            runtime.unwrapOptionalObject(_attrString),
        });
    }
};
