const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const coreGraphics = @import("CoreGraphics");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const CGColorRef = coreGraphics.CGColorRef;
const CGFloat = coreGraphics.CGFloat;
const CGPoint = coreGraphics.CGPoint;
const CGRect = coreGraphics.CGRect;

pub const CALayerMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("CALayer").?;
    }

    pub fn layer(_class: objc.Class) objc.Object {
        return _class.msgSend(objc.Object, selector.CALayerSelectors.layer(), .{});
    }

    pub fn init(_class: objc.Class) objc.Object {
        return runtime_support.backend_support.allocInstance(_class).msgSend(objc.Object, selector.CALayerSelectors.init(), .{});
    }

    pub fn bounds(self: objc.Object) CGRect {
        return self.msgSend(CGRect, selector.CALayerSelectors.bounds(), .{});
    }

    pub fn setBounds(self: objc.Object, _bounds: CGRect) void {
        return self.msgSend(void, selector.CALayerSelectors.setBounds(), .{
            _bounds,
        });
    }

    pub fn position(self: objc.Object) CGPoint {
        return self.msgSend(CGPoint, selector.CALayerSelectors.position(), .{});
    }

    pub fn setPosition(self: objc.Object, _position: CGPoint) void {
        return self.msgSend(void, selector.CALayerSelectors.setPosition(), .{
            _position,
        });
    }

    pub fn addSublayer(self: objc.Object, _layer: objc.Object) void {
        return self.msgSend(void, selector.CALayerSelectors.addSublayer(), .{
            runtime_support.unwrapOptionalObject(_layer),
        });
    }

    pub fn backgroundColor(self: objc.Object) ?CGColorRef {
        return self.msgSend(?CGColorRef, selector.CALayerSelectors.backgroundColor(), .{});
    }

    pub fn setBackgroundColor(self: objc.Object, _backgroundColor: ?CGColorRef) void {
        return self.msgSend(void, selector.CALayerSelectors.setBackgroundColor(), .{
            _backgroundColor,
        });
    }

    pub fn cornerRadius(self: objc.Object) CGFloat {
        return self.msgSend(CGFloat, selector.CALayerSelectors.cornerRadius(), .{});
    }

    pub fn setCornerRadius(self: objc.Object, _cornerRadius: CGFloat) void {
        return self.msgSend(void, selector.CALayerSelectors.setCornerRadius(), .{
            _cornerRadius,
        });
    }

    pub fn borderWidth(self: objc.Object) CGFloat {
        return self.msgSend(CGFloat, selector.CALayerSelectors.borderWidth(), .{});
    }

    pub fn setBorderWidth(self: objc.Object, _borderWidth: CGFloat) void {
        return self.msgSend(void, selector.CALayerSelectors.setBorderWidth(), .{
            _borderWidth,
        });
    }

    pub fn borderColor(self: objc.Object) ?CGColorRef {
        return self.msgSend(?CGColorRef, selector.CALayerSelectors.borderColor(), .{});
    }

    pub fn setBorderColor(self: objc.Object, _borderColor: ?CGColorRef) void {
        return self.msgSend(void, selector.CALayerSelectors.setBorderColor(), .{
            _borderColor,
        });
    }
};
