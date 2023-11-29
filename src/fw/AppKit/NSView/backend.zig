const std = @import("std");
const objc = @import("objc");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSPoint = foundation.NSPoint;
const NSRect = foundation.NSRect;
const NSSize = foundation.NSSize;

pub const NSViewSelectors = struct {
    var _sel_initWithFrame: ?objc.Sel = null;
    var _sel_superview: ?objc.Sel = null;
    var _sel_addSubview: ?objc.Sel = null;
    var _sel_setFrameOrigin: ?objc.Sel = null;
    var _sel_setFrameSize: ?objc.Sel = null;
    var _sel_frame: ?objc.Sel = null;
    var _sel_setFrame: ?objc.Sel = null;
    var _sel_wantsLayer: ?objc.Sel = null;
    var _sel_setWantsLayer: ?objc.Sel = null;
    var _sel_layer: ?objc.Sel = null;
    var _sel_setLayer: ?objc.Sel = null;

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
};

pub const NSViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSView").?;
    }

    pub fn initWithFrame(_class: objc.Class, _frameRect: NSRect) objc.Object {
        return runtime.backend_support.allocInstance(_class).msgSend(objc.Object, NSViewSelectors.initWithFrame(), .{
            _frameRect,
        });
    }

    pub fn superview(self: objc.Object) ?objc.Object {
        return runtime.wrapOptionalObjectId(self.msgSend(objc.c.id, NSViewSelectors.superview(), .{}));
    }

    pub fn addSubview(self: objc.Object, _view: objc.Object) void {
        return self.msgSend(void, NSViewSelectors.addSubview(), .{
            runtime.unwrapOptionalObject(_view),
        });
    }

    pub fn setFrameOrigin(self: objc.Object, _newOrigin: NSPoint) void {
        return self.msgSend(void, NSViewSelectors.setFrameOrigin(), .{
            _newOrigin,
        });
    }

    pub fn setFrameSize(self: objc.Object, _newSize: NSSize) void {
        return self.msgSend(void, NSViewSelectors.setFrameSize(), .{
            _newSize,
        });
    }

    pub fn frame(self: objc.Object) NSRect {
        return self.msgSend(NSRect, NSViewSelectors.frame(), .{});
    }

    pub fn setFrame(self: objc.Object, _frame: NSRect) void {
        return self.msgSend(void, NSViewSelectors.setFrame(), .{
            _frame,
        });
    }

    pub fn wantsLayer(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, NSViewSelectors.wantsLayer(), .{});
    }

    pub fn setWantsLayer(self: objc.Object, _wantsLayer: objc.c.BOOL) void {
        return self.msgSend(void, NSViewSelectors.setWantsLayer(), .{
            _wantsLayer,
        });
    }

    pub fn layer(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, NSViewSelectors.layer(), .{});
    }

    pub fn setLayer(self: objc.Object, _layer: objc.Object) void {
        return self.msgSend(void, NSViewSelectors.setLayer(), .{
            runtime.unwrapOptionalObject(_layer),
        });
    }
};

pub const NSLayerDelegateContentsScaleUpdatingForNSObjectSelectors = struct {};

pub const NSLayerDelegateContentsScaleUpdatingForNSObjectMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSObject").?;
    }
};
