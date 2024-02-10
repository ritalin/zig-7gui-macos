const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSViewSelectors = struct {
    pub fn initWithFrame() objc.Sel {
        if (_sel_initWithFrame == null) {
            _sel_initWithFrame = objc.Sel.registerName("initWithFrame:");
        }
        return _sel_initWithFrame.?;
    }

    pub fn superview() objc.Sel {
        if (_sel_superview == null) {
            _sel_superview = objc.Sel.registerName("superview");
        }
        return _sel_superview.?;
    }

    pub fn addSubview() objc.Sel {
        if (_sel_addSubview == null) {
            _sel_addSubview = objc.Sel.registerName("addSubview:");
        }
        return _sel_addSubview.?;
    }

    pub fn removeFromSuperview() objc.Sel {
        if (_sel_removeFromSuperview == null) {
            _sel_removeFromSuperview = objc.Sel.registerName("removeFromSuperview");
        }
        return _sel_removeFromSuperview.?;
    }

    pub fn setFrameOrigin() objc.Sel {
        if (_sel_setFrameOrigin == null) {
            _sel_setFrameOrigin = objc.Sel.registerName("setFrameOrigin:");
        }
        return _sel_setFrameOrigin.?;
    }

    pub fn setFrameSize() objc.Sel {
        if (_sel_setFrameSize == null) {
            _sel_setFrameSize = objc.Sel.registerName("setFrameSize:");
        }
        return _sel_setFrameSize.?;
    }

    pub fn frame() objc.Sel {
        if (_sel_frame == null) {
            _sel_frame = objc.Sel.registerName("frame");
        }
        return _sel_frame.?;
    }

    pub fn setFrame() objc.Sel {
        if (_sel_setFrame == null) {
            _sel_setFrame = objc.Sel.registerName("setFrame:");
        }
        return _sel_setFrame.?;
    }

    pub fn setBoundsOrigin() objc.Sel {
        if (_sel_setBoundsOrigin == null) {
            _sel_setBoundsOrigin = objc.Sel.registerName("setBoundsOrigin:");
        }
        return _sel_setBoundsOrigin.?;
    }

    pub fn setBoundsSize() objc.Sel {
        if (_sel_setBoundsSize == null) {
            _sel_setBoundsSize = objc.Sel.registerName("setBoundsSize:");
        }
        return _sel_setBoundsSize.?;
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

    pub fn convertPointFromView() objc.Sel {
        if (_sel_convertPointFromView == null) {
            _sel_convertPointFromView = objc.Sel.registerName("convertPoint:fromView:");
        }
        return _sel_convertPointFromView.?;
    }

    pub fn wantsLayer() objc.Sel {
        if (_sel_wantsLayer == null) {
            _sel_wantsLayer = objc.Sel.registerName("wantsLayer");
        }
        return _sel_wantsLayer.?;
    }

    pub fn setWantsLayer() objc.Sel {
        if (_sel_setWantsLayer == null) {
            _sel_setWantsLayer = objc.Sel.registerName("setWantsLayer:");
        }
        return _sel_setWantsLayer.?;
    }

    pub fn layer() objc.Sel {
        if (_sel_layer == null) {
            _sel_layer = objc.Sel.registerName("layer");
        }
        return _sel_layer.?;
    }

    pub fn setLayer() objc.Sel {
        if (_sel_setLayer == null) {
            _sel_setLayer = objc.Sel.registerName("setLayer:");
        }
        return _sel_setLayer.?;
    }

    var _sel_initWithFrame: ?objc.Sel = null;
    var _sel_superview: ?objc.Sel = null;
    var _sel_addSubview: ?objc.Sel = null;
    var _sel_removeFromSuperview: ?objc.Sel = null;
    var _sel_setFrameOrigin: ?objc.Sel = null;
    var _sel_setFrameSize: ?objc.Sel = null;
    var _sel_frame: ?objc.Sel = null;
    var _sel_setFrame: ?objc.Sel = null;
    var _sel_setBoundsOrigin: ?objc.Sel = null;
    var _sel_setBoundsSize: ?objc.Sel = null;
    var _sel_bounds: ?objc.Sel = null;
    var _sel_setBounds: ?objc.Sel = null;
    var _sel_convertPointFromView: ?objc.Sel = null;
    var _sel_wantsLayer: ?objc.Sel = null;
    var _sel_setWantsLayer: ?objc.Sel = null;
    var _sel_layer: ?objc.Sel = null;
    var _sel_setLayer: ?objc.Sel = null;
};

pub const NSGestureRecognizerForNSViewSelectors = struct {
    pub fn addGestureRecognizer() objc.Sel {
        if (_sel_addGestureRecognizer == null) {
            _sel_addGestureRecognizer = objc.Sel.registerName("addGestureRecognizer:");
        }
        return _sel_addGestureRecognizer.?;
    }

    var _sel_addGestureRecognizer: ?objc.Sel = null;
};

pub const NSLayerDelegateContentsScaleUpdatingForNSObjectSelectors = struct {};
