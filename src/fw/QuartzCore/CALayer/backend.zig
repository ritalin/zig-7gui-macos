const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const coreGraphics = @import("CoreGraphics");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

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

    pub fn frame(self: objc.Object) CGRect {
        return self.msgSend(CGRect, selector.CALayerSelectors.frame(), .{});
    }

    pub fn setFrame(self: objc.Object, _frame: CGRect) void {
        return self.msgSend(void, selector.CALayerSelectors.setFrame(), .{
            _frame,
        });
    }

    pub fn superlayer(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.CALayerSelectors.superlayer(), .{}));
    }

    pub fn removeFromSuperlayer(self: objc.Object) void {
        return self.msgSend(void, selector.CALayerSelectors.removeFromSuperlayer(), .{});
    }

    pub fn addSublayer(self: objc.Object, _layer: objc.Object) void {
        return self.msgSend(void, selector.CALayerSelectors.addSublayer(), .{
            runtime_support.unwrapOptionalObject(_layer),
        });
    }

    pub fn insertSublayerAtIndex(self: objc.Object, _layer: objc.Object, _idx: c_uint) void {
        return self.msgSend(void, selector.CALayerSelectors.insertSublayerAtIndex(), .{
            runtime_support.unwrapOptionalObject(_layer),
            _idx,
        });
    }

    pub fn convertPointFromLayer(self: objc.Object, _p: CGPoint, _l: ?objc.Object) CGPoint {
        return self.msgSend(CGPoint, selector.CALayerSelectors.convertPointFromLayer(), .{
            _p,
            runtime_support.unwrapOptionalObject(_l),
        });
    }

    pub fn convertPointToLayer(self: objc.Object, _p: CGPoint, _l: ?objc.Object) CGPoint {
        return self.msgSend(CGPoint, selector.CALayerSelectors.convertPointToLayer(), .{
            _p,
            runtime_support.unwrapOptionalObject(_l),
        });
    }

    pub fn hitTest(self: objc.Object, _p: CGPoint) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.CALayerSelectors.hitTest(), .{
            _p,
        }));
    }

    pub fn containsPoint(self: objc.Object, _p: CGPoint) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.CALayerSelectors.containsPoint(), .{
            _p,
        });
    }

    pub fn needsDisplay(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.CALayerSelectors.needsDisplay(), .{});
    }

    pub fn displayIfNeeded(self: objc.Object) void {
        return self.msgSend(void, selector.CALayerSelectors.displayIfNeeded(), .{});
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

    pub fn autoresizingMask(self: objc.Object) c_uint {
        return self.msgSend(c_uint, selector.CALayerSelectors.autoresizingMask(), .{});
    }

    pub fn setAutoresizingMask(self: objc.Object, _autoresizingMask: c_uint) void {
        return self.msgSend(void, selector.CALayerSelectors.setAutoresizingMask(), .{
            _autoresizingMask,
        });
    }

    pub fn name(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.CALayerSelectors.name(), .{}));
    }

    pub fn setName(self: objc.Object, _name: ?objc.Object) void {
        return self.msgSend(void, selector.CALayerSelectors.setName(), .{
            runtime_support.unwrapOptionalObject(_name),
        });
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.CALayerSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, selector.CALayerSelectors.setDelegate(), .{
            runtime_support.unwrapOptionalObject(_delegate),
        });
    }
};

pub const CALayerDelegateMessages = struct {
    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "CALayerDelegate");
        }
        return class.?;
    }

    pub fn registerDisplayLayer(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "displayLayer:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerLayoutSublayersOfLayer(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "layoutSublayersOfLayer:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;
};

const CGColorRef = coreGraphics.CGColorRef;
const CGFloat = coreGraphics.CGFloat;
const CGPoint = coreGraphics.CGPoint;
const CGRect = coreGraphics.CGRect;
