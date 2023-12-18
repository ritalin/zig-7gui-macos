const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const CALayerSelectors = struct {
    var _sel_layer: ?objc.Sel = null;
    var _sel_init: ?objc.Sel = null;
    var _sel_bounds: ?objc.Sel = null;
    var _sel_setBounds: ?objc.Sel = null;
    var _sel_position: ?objc.Sel = null;
    var _sel_setPosition: ?objc.Sel = null;
    var _sel_addSublayer: ?objc.Sel = null;
    var _sel_backgroundColor: ?objc.Sel = null;
    var _sel_setBackgroundColor: ?objc.Sel = null;
    var _sel_cornerRadius: ?objc.Sel = null;
    var _sel_setCornerRadius: ?objc.Sel = null;
    var _sel_borderWidth: ?objc.Sel = null;
    var _sel_setBorderWidth: ?objc.Sel = null;
    var _sel_borderColor: ?objc.Sel = null;
    var _sel_setBorderColor: ?objc.Sel = null;

    pub fn layer() objc.Sel {
        if (_sel_layer == null) {
            _sel_layer = objc.Sel.registerName("layer");
        }
        return _sel_layer.?;
    }

    pub fn init() objc.Sel {
        if (_sel_init == null) {
            _sel_init = objc.Sel.registerName("init");
        }
        return _sel_init.?;
    }

    pub fn bounds() objc.Sel {
        if (_sel_bounds == null) {
            _sel_bounds = objc.Sel.registerName("bounds");
        }
        return _sel_bounds.?;
    }

    pub fn setBounds() objc.Sel {
        if (_sel_setBounds == null) {
            _sel_setBounds = objc.Sel.registerName("setBounds:");
        }
        return _sel_setBounds.?;
    }

    pub fn position() objc.Sel {
        if (_sel_position == null) {
            _sel_position = objc.Sel.registerName("position");
        }
        return _sel_position.?;
    }

    pub fn setPosition() objc.Sel {
        if (_sel_setPosition == null) {
            _sel_setPosition = objc.Sel.registerName("setPosition:");
        }
        return _sel_setPosition.?;
    }

    pub fn addSublayer() objc.Sel {
        if (_sel_addSublayer == null) {
            _sel_addSublayer = objc.Sel.registerName("addSublayer:");
        }
        return _sel_addSublayer.?;
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
