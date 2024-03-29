const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSScrollViewSelectors = struct {
    pub fn documentVisibleRect() objc.Sel {
        if (_sel_documentVisibleRect == null) {
            _sel_documentVisibleRect = objc.Sel.registerName("documentVisibleRect");
        }
        return _sel_documentVisibleRect.?;
    }

    pub fn documentView() objc.Sel {
        if (_sel_documentView == null) {
            _sel_documentView = objc.Sel.registerName("documentView");
        }
        return _sel_documentView.?;
    }

    pub fn setDocumentView() objc.Sel {
        if (_sel_setDocumentView == null) {
            _sel_setDocumentView = objc.Sel.registerName("setDocumentView:");
        }
        return _sel_setDocumentView.?;
    }

    pub fn contentView() objc.Sel {
        if (_sel_contentView == null) {
            _sel_contentView = objc.Sel.registerName("contentView");
        }
        return _sel_contentView.?;
    }

    pub fn setContentView() objc.Sel {
        if (_sel_setContentView == null) {
            _sel_setContentView = objc.Sel.registerName("setContentView:");
        }
        return _sel_setContentView.?;
    }

    pub fn borderType() objc.Sel {
        if (_sel_borderType == null) {
            _sel_borderType = objc.Sel.registerName("borderType");
        }
        return _sel_borderType.?;
    }

    pub fn setBorderType() objc.Sel {
        if (_sel_setBorderType == null) {
            _sel_setBorderType = objc.Sel.registerName("setBorderType:");
        }
        return _sel_setBorderType.?;
    }

    pub fn drawsBackground() objc.Sel {
        if (_sel_drawsBackground == null) {
            _sel_drawsBackground = objc.Sel.registerName("drawsBackground");
        }
        return _sel_drawsBackground.?;
    }

    pub fn setDrawsBackground() objc.Sel {
        if (_sel_setDrawsBackground == null) {
            _sel_setDrawsBackground = objc.Sel.registerName("setDrawsBackground:");
        }
        return _sel_setDrawsBackground.?;
    }

    pub fn hasVerticalScroller() objc.Sel {
        if (_sel_hasVerticalScroller == null) {
            _sel_hasVerticalScroller = objc.Sel.registerName("hasVerticalScroller");
        }
        return _sel_hasVerticalScroller.?;
    }

    pub fn setHasVerticalScroller() objc.Sel {
        if (_sel_setHasVerticalScroller == null) {
            _sel_setHasVerticalScroller = objc.Sel.registerName("setHasVerticalScroller:");
        }
        return _sel_setHasVerticalScroller.?;
    }

    pub fn hasHorizontalScroller() objc.Sel {
        if (_sel_hasHorizontalScroller == null) {
            _sel_hasHorizontalScroller = objc.Sel.registerName("hasHorizontalScroller");
        }
        return _sel_hasHorizontalScroller.?;
    }

    pub fn setHasHorizontalScroller() objc.Sel {
        if (_sel_setHasHorizontalScroller == null) {
            _sel_setHasHorizontalScroller = objc.Sel.registerName("setHasHorizontalScroller:");
        }
        return _sel_setHasHorizontalScroller.?;
    }

    pub fn autohidesScrollers() objc.Sel {
        if (_sel_autohidesScrollers == null) {
            _sel_autohidesScrollers = objc.Sel.registerName("autohidesScrollers");
        }
        return _sel_autohidesScrollers.?;
    }

    pub fn setAutohidesScrollers() objc.Sel {
        if (_sel_setAutohidesScrollers == null) {
            _sel_setAutohidesScrollers = objc.Sel.registerName("setAutohidesScrollers:");
        }
        return _sel_setAutohidesScrollers.?;
    }

    pub fn addFloatingSubviewForAxis() objc.Sel {
        if (_sel_addFloatingSubviewForAxis == null) {
            _sel_addFloatingSubviewForAxis = objc.Sel.registerName("addFloatingSubview:forAxis:");
        }
        return _sel_addFloatingSubviewForAxis.?;
    }

    pub fn automaticallyAdjustsContentInsets() objc.Sel {
        if (_sel_automaticallyAdjustsContentInsets == null) {
            _sel_automaticallyAdjustsContentInsets = objc.Sel.registerName("automaticallyAdjustsContentInsets");
        }
        return _sel_automaticallyAdjustsContentInsets.?;
    }

    pub fn setAutomaticallyAdjustsContentInsets() objc.Sel {
        if (_sel_setAutomaticallyAdjustsContentInsets == null) {
            _sel_setAutomaticallyAdjustsContentInsets = objc.Sel.registerName("setAutomaticallyAdjustsContentInsets:");
        }
        return _sel_setAutomaticallyAdjustsContentInsets.?;
    }

    pub fn contentInsets() objc.Sel {
        if (_sel_contentInsets == null) {
            _sel_contentInsets = objc.Sel.registerName("contentInsets");
        }
        return _sel_contentInsets.?;
    }

    pub fn setContentInsets() objc.Sel {
        if (_sel_setContentInsets == null) {
            _sel_setContentInsets = objc.Sel.registerName("setContentInsets:");
        }
        return _sel_setContentInsets.?;
    }

    var _sel_documentVisibleRect: ?objc.Sel = null;
    var _sel_documentView: ?objc.Sel = null;
    var _sel_setDocumentView: ?objc.Sel = null;
    var _sel_contentView: ?objc.Sel = null;
    var _sel_setContentView: ?objc.Sel = null;
    var _sel_borderType: ?objc.Sel = null;
    var _sel_setBorderType: ?objc.Sel = null;
    var _sel_drawsBackground: ?objc.Sel = null;
    var _sel_setDrawsBackground: ?objc.Sel = null;
    var _sel_hasVerticalScroller: ?objc.Sel = null;
    var _sel_setHasVerticalScroller: ?objc.Sel = null;
    var _sel_hasHorizontalScroller: ?objc.Sel = null;
    var _sel_setHasHorizontalScroller: ?objc.Sel = null;
    var _sel_autohidesScrollers: ?objc.Sel = null;
    var _sel_setAutohidesScrollers: ?objc.Sel = null;
    var _sel_addFloatingSubviewForAxis: ?objc.Sel = null;
    var _sel_automaticallyAdjustsContentInsets: ?objc.Sel = null;
    var _sel_setAutomaticallyAdjustsContentInsets: ?objc.Sel = null;
    var _sel_contentInsets: ?objc.Sel = null;
    var _sel_setContentInsets: ?objc.Sel = null;
};
