const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const CALayerSelectors = struct {
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

    pub fn superlayer() objc.Sel {
        if (_sel_superlayer == null) {
            _sel_superlayer = objc.Sel.registerName("superlayer");
        }
        return _sel_superlayer.?;
    }

    pub fn removeFromSuperlayer() objc.Sel {
        if (_sel_removeFromSuperlayer == null) {
            _sel_removeFromSuperlayer = objc.Sel.registerName("removeFromSuperlayer");
        }
        return _sel_removeFromSuperlayer.?;
    }

    pub fn addSublayer() objc.Sel {
        if (_sel_addSublayer == null) {
            _sel_addSublayer = objc.Sel.registerName("addSublayer:");
        }
        return _sel_addSublayer.?;
    }

    pub fn insertSublayerAtIndex() objc.Sel {
        if (_sel_insertSublayerAtIndex == null) {
            _sel_insertSublayerAtIndex = objc.Sel.registerName("insertSublayer:atIndex:");
        }
        return _sel_insertSublayerAtIndex.?;
    }

    pub fn convertPointFromLayer() objc.Sel {
        if (_sel_convertPointFromLayer == null) {
            _sel_convertPointFromLayer = objc.Sel.registerName("convertPoint:fromLayer:");
        }
        return _sel_convertPointFromLayer.?;
    }

    pub fn convertPointToLayer() objc.Sel {
        if (_sel_convertPointToLayer == null) {
            _sel_convertPointToLayer = objc.Sel.registerName("convertPoint:toLayer:");
        }
        return _sel_convertPointToLayer.?;
    }

    pub fn hitTest() objc.Sel {
        if (_sel_hitTest == null) {
            _sel_hitTest = objc.Sel.registerName("hitTest:");
        }
        return _sel_hitTest.?;
    }

    pub fn containsPoint() objc.Sel {
        if (_sel_containsPoint == null) {
            _sel_containsPoint = objc.Sel.registerName("containsPoint:");
        }
        return _sel_containsPoint.?;
    }

    pub fn needsDisplay() objc.Sel {
        if (_sel_needsDisplay == null) {
            _sel_needsDisplay = objc.Sel.registerName("needsDisplay");
        }
        return _sel_needsDisplay.?;
    }

    pub fn displayIfNeeded() objc.Sel {
        if (_sel_displayIfNeeded == null) {
            _sel_displayIfNeeded = objc.Sel.registerName("displayIfNeeded");
        }
        return _sel_displayIfNeeded.?;
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

    pub fn autoresizingMask() objc.Sel {
        if (_sel_autoresizingMask == null) {
            _sel_autoresizingMask = objc.Sel.registerName("autoresizingMask");
        }
        return _sel_autoresizingMask.?;
    }

    pub fn setAutoresizingMask() objc.Sel {
        if (_sel_setAutoresizingMask == null) {
            _sel_setAutoresizingMask = objc.Sel.registerName("setAutoresizingMask:");
        }
        return _sel_setAutoresizingMask.?;
    }

    pub fn name() objc.Sel {
        if (_sel_name == null) {
            _sel_name = objc.Sel.registerName("name");
        }
        return _sel_name.?;
    }

    pub fn setName() objc.Sel {
        if (_sel_setName == null) {
            _sel_setName = objc.Sel.registerName("setName:");
        }
        return _sel_setName.?;
    }

    pub fn delegate() objc.Sel {
        if (_sel_delegate == null) {
            _sel_delegate = objc.Sel.registerName("delegate");
        }
        return _sel_delegate.?;
    }

    pub fn setDelegate() objc.Sel {
        if (_sel_setDelegate == null) {
            _sel_setDelegate = objc.Sel.registerName("setDelegate:");
        }
        return _sel_setDelegate.?;
    }

    var _sel_layer: ?objc.Sel = null;
    var _sel_init: ?objc.Sel = null;
    var _sel_bounds: ?objc.Sel = null;
    var _sel_setBounds: ?objc.Sel = null;
    var _sel_position: ?objc.Sel = null;
    var _sel_setPosition: ?objc.Sel = null;
    var _sel_frame: ?objc.Sel = null;
    var _sel_setFrame: ?objc.Sel = null;
    var _sel_superlayer: ?objc.Sel = null;
    var _sel_removeFromSuperlayer: ?objc.Sel = null;
    var _sel_addSublayer: ?objc.Sel = null;
    var _sel_insertSublayerAtIndex: ?objc.Sel = null;
    var _sel_convertPointFromLayer: ?objc.Sel = null;
    var _sel_convertPointToLayer: ?objc.Sel = null;
    var _sel_hitTest: ?objc.Sel = null;
    var _sel_containsPoint: ?objc.Sel = null;
    var _sel_needsDisplay: ?objc.Sel = null;
    var _sel_displayIfNeeded: ?objc.Sel = null;
    var _sel_backgroundColor: ?objc.Sel = null;
    var _sel_setBackgroundColor: ?objc.Sel = null;
    var _sel_cornerRadius: ?objc.Sel = null;
    var _sel_setCornerRadius: ?objc.Sel = null;
    var _sel_borderWidth: ?objc.Sel = null;
    var _sel_setBorderWidth: ?objc.Sel = null;
    var _sel_borderColor: ?objc.Sel = null;
    var _sel_setBorderColor: ?objc.Sel = null;
    var _sel_autoresizingMask: ?objc.Sel = null;
    var _sel_setAutoresizingMask: ?objc.Sel = null;
    var _sel_name: ?objc.Sel = null;
    var _sel_setName: ?objc.Sel = null;
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;
};

pub const CALayerDelegateSelectors = struct {
    pub fn displayLayer() objc.Sel {
        if (_sel_displayLayer == null) {
            _sel_displayLayer = objc.Sel.registerName("displayLayer:");
        }
        return _sel_displayLayer.?;
    }

    pub fn layoutSublayersOfLayer() objc.Sel {
        if (_sel_layoutSublayersOfLayer == null) {
            _sel_layoutSublayersOfLayer = objc.Sel.registerName("layoutSublayersOfLayer:");
        }
        return _sel_layoutSublayersOfLayer.?;
    }

    var _sel_displayLayer: ?objc.Sel = null;
    var _sel_layoutSublayersOfLayer: ?objc.Sel = null;
};
