const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const CALayerSelectors = struct {
    var _sel_masksToBounds: ?objc.Sel = null;
    var _sel_setMasksToBounds: ?objc.Sel = null;
    var _sel_backgroundColor: ?objc.Sel = null;
    var _sel_setBackgroundColor: ?objc.Sel = null;
    var _sel_cornerRadius: ?objc.Sel = null;
    var _sel_setCornerRadius: ?objc.Sel = null;
    var _sel_borderWidth: ?objc.Sel = null;
    var _sel_setBorderWidth: ?objc.Sel = null;
    var _sel_borderColor: ?objc.Sel = null;
    var _sel_setBorderColor: ?objc.Sel = null;

    pub fn masksToBounds() objc.Sel {
        if (_sel_masksToBounds == null) {
            _sel_masksToBounds = objc.Sel.registerName("masksToBounds");
        }
        return _sel_masksToBounds.?;
    }

    pub fn setMasksToBounds() objc.Sel {
        if (_sel_setMasksToBounds == null) {
            _sel_setMasksToBounds = objc.Sel.registerName("setMasksToBounds:");
        }
        return _sel_setMasksToBounds.?;
    }

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

    pub fn cornerRadius() objc.Sel {
        if (_sel_cornerRadius == null) {
            _sel_cornerRadius = objc.Sel.registerName("cornerRadius");
        }
        return _sel_cornerRadius.?;
    }

    pub fn setCornerRadius() objc.Sel {
        if (_sel_setCornerRadius == null) {
            _sel_setCornerRadius = objc.Sel.registerName("setCornerRadius:");
        }
        return _sel_setCornerRadius.?;
    }

    pub fn borderWidth() objc.Sel {
        if (_sel_borderWidth == null) {
            _sel_borderWidth = objc.Sel.registerName("borderWidth");
        }
        return _sel_borderWidth.?;
    }

    pub fn setBorderWidth() objc.Sel {
        if (_sel_setBorderWidth == null) {
            _sel_setBorderWidth = objc.Sel.registerName("setBorderWidth:");
        }
        return _sel_setBorderWidth.?;
    }

    pub fn borderColor() objc.Sel {
        if (_sel_borderColor == null) {
            _sel_borderColor = objc.Sel.registerName("borderColor");
        }
        return _sel_borderColor.?;
    }

    pub fn setBorderColor() objc.Sel {
        if (_sel_setBorderColor == null) {
            _sel_setBorderColor = objc.Sel.registerName("setBorderColor:");
        }
        return _sel_setBorderColor.?;
    }
};
