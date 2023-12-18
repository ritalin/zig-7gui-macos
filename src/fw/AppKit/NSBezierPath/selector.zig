const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSBezierPathSelectors = struct {
    var _sel_bezierPath: ?objc.Sel = null;
    var _sel_bezierPathWithOvalInRect: ?objc.Sel = null;
    var _sel_elementCount: ?objc.Sel = null;
    var _sel_elementAtIndexAssociatedPoints: ?objc.Sel = null;
    var _sel_appendBezierPathWithOvalInRect: ?objc.Sel = null;

    pub fn bezierPath() objc.Sel {
        if (_sel_bezierPath == null) {
            _sel_bezierPath = objc.Sel.registerName("bezierPath");
        }
        return _sel_bezierPath.?;
    }

    pub fn bezierPathWithOvalInRect() objc.Sel {
        if (_sel_bezierPathWithOvalInRect == null) {
            _sel_bezierPathWithOvalInRect = objc.Sel.registerName("bezierPathWithOvalInRect:");
        }
        return _sel_bezierPathWithOvalInRect.?;
    }

    pub fn elementCount() objc.Sel {
        if (_sel_elementCount == null) {
            _sel_elementCount = objc.Sel.registerName("elementCount");
        }
        return _sel_elementCount.?;
    }

    pub fn elementAtIndexAssociatedPoints() objc.Sel {
        if (_sel_elementAtIndexAssociatedPoints == null) {
            _sel_elementAtIndexAssociatedPoints = objc.Sel.registerName("elementAtIndex:associatedPoints:");
        }
        return _sel_elementAtIndexAssociatedPoints.?;
    }

    pub fn appendBezierPathWithOvalInRect() objc.Sel {
        if (_sel_appendBezierPathWithOvalInRect == null) {
            _sel_appendBezierPathWithOvalInRect = objc.Sel.registerName("appendBezierPathWithOvalInRect:");
        }
        return _sel_appendBezierPathWithOvalInRect.?;
    }
};
