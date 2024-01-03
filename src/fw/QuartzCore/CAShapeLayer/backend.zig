const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const coreGraphics = @import("CoreGraphics");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const CAShapeLayerMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("CAShapeLayer").?;
    }

    pub fn path(self: objc.Object) ?CGPathRef {
        return self.msgSend(?CGPathRef, selector.CAShapeLayerSelectors.path(), .{});
    }

    pub fn setPath(self: objc.Object, _path: ?CGPathRef) void {
        return self.msgSend(void, selector.CAShapeLayerSelectors.setPath(), .{
            _path,
        });
    }

    pub fn fillColor(self: objc.Object) ?CGColorRef {
        return self.msgSend(?CGColorRef, selector.CAShapeLayerSelectors.fillColor(), .{});
    }

    pub fn setFillColor(self: objc.Object, _fillColor: ?CGColorRef) void {
        return self.msgSend(void, selector.CAShapeLayerSelectors.setFillColor(), .{
            _fillColor,
        });
    }

    pub fn strokeColor(self: objc.Object) ?CGColorRef {
        return self.msgSend(?CGColorRef, selector.CAShapeLayerSelectors.strokeColor(), .{});
    }

    pub fn setStrokeColor(self: objc.Object, _strokeColor: ?CGColorRef) void {
        return self.msgSend(void, selector.CAShapeLayerSelectors.setStrokeColor(), .{
            _strokeColor,
        });
    }

    pub fn lineWidth(self: objc.Object) CGFloat {
        return self.msgSend(CGFloat, selector.CAShapeLayerSelectors.lineWidth(), .{});
    }

    pub fn setLineWidth(self: objc.Object, _lineWidth: CGFloat) void {
        return self.msgSend(void, selector.CAShapeLayerSelectors.setLineWidth(), .{
            _lineWidth,
        });
    }
};

const CGColorRef = coreGraphics.CGColorRef;
const CGFloat = coreGraphics.CGFloat;
const CGPathRef = coreGraphics.CGPathRef;
