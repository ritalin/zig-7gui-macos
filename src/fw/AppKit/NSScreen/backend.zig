const std = @import("std");
const objc = @import("objc");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSRect = foundation.NSRect;

pub const NSScreenSelectors = struct {
    var _sel_mainScreen: ?objc.Sel = null;
    var _sel_frame: ?objc.Sel = null;
    var _sel_visibleFrame: ?objc.Sel = null;

    pub fn mainScreen() objc.Sel {
        if (_sel_mainScreen == null) {
            _sel_mainScreen = objc.Sel.registerName("mainScreen");
        }
        return _sel_mainScreen.?;
    }

    pub fn frame() objc.Sel {
        if (_sel_frame == null) {
            _sel_frame = objc.Sel.registerName("frame");
        }
        return _sel_frame.?;
    }

    pub fn visibleFrame() objc.Sel {
        if (_sel_visibleFrame == null) {
            _sel_visibleFrame = objc.Sel.registerName("visibleFrame");
        }
        return _sel_visibleFrame.?;
    }
};

pub const NSScreenMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSScreen").?;
    }

    pub fn mainScreen() ?objc.Object {
        return runtime.wrapOptionalObjectId(getClass().msgSend(objc.c.id, NSScreenSelectors.mainScreen(), .{}));
    }

    pub fn frame(self: objc.Object) NSRect {
        return self.msgSend(NSRect, NSScreenSelectors.frame(), .{});
    }

    pub fn visibleFrame(self: objc.Object) NSRect {
        return self.msgSend(NSRect, NSScreenSelectors.visibleFrame(), .{});
    }
};

pub const ExtensionsForNSScreenSelectors = struct {};

pub const ExtensionsForNSScreenMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSScreen").?;
    }
};

pub const NSDeprecatedForNSScreenSelectors = struct {};

pub const NSDeprecatedForNSScreenMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSScreen").?;
    }
};
