const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const CAShapeLayerSelectors = struct {
    var _sel_path: ?objc.Sel = null;
    var _sel_setPath: ?objc.Sel = null;
    var _sel_fillColor: ?objc.Sel = null;
    var _sel_setFillColor: ?objc.Sel = null;
    var _sel_strokeColor: ?objc.Sel = null;
    var _sel_setStrokeColor: ?objc.Sel = null;
    var _sel_lineWidth: ?objc.Sel = null;
    var _sel_setLineWidth: ?objc.Sel = null;

    pub fn path() objc.Sel {
        if (_sel_path == null) {
            _sel_path = objc.Sel.registerName("path");
        }
        return _sel_path.?;
    }

    pub fn setPath() objc.Sel {
        if (_sel_setPath == null) {
            _sel_setPath = objc.Sel.registerName("setPath:");
        }
        return _sel_setPath.?;
    }

    pub fn fillColor() objc.Sel {
        if (_sel_fillColor == null) {
            _sel_fillColor = objc.Sel.registerName("fillColor");
        }
        return _sel_fillColor.?;
    }

    pub fn setFillColor() objc.Sel {
        if (_sel_setFillColor == null) {
            _sel_setFillColor = objc.Sel.registerName("setFillColor:");
        }
        return _sel_setFillColor.?;
    }

    pub fn strokeColor() objc.Sel {
        if (_sel_strokeColor == null) {
            _sel_strokeColor = objc.Sel.registerName("strokeColor");
        }
        return _sel_strokeColor.?;
    }

    pub fn setStrokeColor() objc.Sel {
        if (_sel_setStrokeColor == null) {
            _sel_setStrokeColor = objc.Sel.registerName("setStrokeColor:");
        }
        return _sel_setStrokeColor.?;
    }

    pub fn lineWidth() objc.Sel {
        if (_sel_lineWidth == null) {
            _sel_lineWidth = objc.Sel.registerName("lineWidth");
        }
        return _sel_lineWidth.?;
    }

    pub fn setLineWidth() objc.Sel {
        if (_sel_setLineWidth == null) {
            _sel_setLineWidth = objc.Sel.registerName("setLineWidth:");
        }
        return _sel_setLineWidth.?;
    }
};
