const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSAttributedStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSAttributedString").?;
    }

    pub fn string(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSAttributedStringSelectors.string(), .{});
    }
};

pub const NSMutableAttributedStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSMutableAttributedString").?;
    }
};

pub const NSExtendedAttributedStringForNSAttributedStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSAttributedString").?;
    }

    pub fn initWithString(_class: objc.Class, _str: objc.Object) objc.Object {
        return runtime_support.backend_support.allocInstance(_class).msgSend(objc.Object, selector.NSExtendedAttributedStringForNSAttributedStringSelectors.initWithString(), .{
            runtime_support.unwrapOptionalObject(_str),
        });
    }
};

pub const NSExtendedMutableAttributedStringForNSMutableAttributedStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSMutableAttributedString").?;
    }

    pub fn setAttributedString(self: objc.Object, _attrString: objc.Object) void {
        return self.msgSend(void, selector.NSExtendedMutableAttributedStringForNSMutableAttributedStringSelectors.setAttributedString(), .{
            runtime_support.unwrapOptionalObject(_attrString),
        });
    }
};
