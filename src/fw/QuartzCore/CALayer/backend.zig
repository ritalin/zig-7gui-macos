const std = @import("std");
const objc = @import("objc");
const coreGraphics = @import("CoreGraphics");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const CGColorRef = coreGraphics.CGColorRef;

pub const CALayerSelectors = struct {
    var _sel_backgroundColor: ?objc.Sel = null;
    var _sel_setBackgroundColor: ?objc.Sel = null;

    pub fn backgroundColor() objc.Sel {
        if (_sel_backgroundColor == null) {
            _sel_backgroundColor = objc.Sel.registerName("backgroundColor");
        }
        return _sel_backgroundColor.?;
    }

    pub fn setBackgroundColor() objc.Sel {
        if (_sel_setBackgroundColor == null) {
            _sel_setBackgroundColor = objc.Sel.registerName("setBackgroundColor:");
        }
        return _sel_setBackgroundColor.?;
    }
};

pub const CALayerMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("CALayer").?;
    }

    pub fn backgroundColor(self: objc.Object) ?CGColorRef {
        return self.msgSend(?CGColorRef, CALayerSelectors.backgroundColor(), .{});
    }

    pub fn setBackgroundColor(self: objc.Object, _backgroundColor: ?CGColorRef) void {
        return self.msgSend(void, CALayerSelectors.setBackgroundColor(), .{
            _backgroundColor,
        });
    }
};
