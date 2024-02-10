const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSView").?;
    }

    pub fn initWithFrame(_class: objc.Class, _frameRect: NSRect) objc.Object {
        return runtime_support.backend_support.allocInstance(_class).msgSend(objc.Object, selector.NSViewSelectors.initWithFrame(), .{
            _frameRect,
        });
    }

    pub fn superview(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSViewSelectors.superview(), .{}));
    }

    pub fn addSubview(self: objc.Object, _view: objc.Object) void {
        return self.msgSend(void, selector.NSViewSelectors.addSubview(), .{
            runtime_support.unwrapOptionalObject(_view),
        });
    }

    pub fn removeFromSuperview(self: objc.Object) void {
        return self.msgSend(void, selector.NSViewSelectors.removeFromSuperview(), .{});
    }

    pub fn setFrameOrigin(self: objc.Object, _newOrigin: NSPoint) void {
        return self.msgSend(void, selector.NSViewSelectors.setFrameOrigin(), .{
            _newOrigin,
        });
    }

    pub fn setFrameSize(self: objc.Object, _newSize: NSSize) void {
        return self.msgSend(void, selector.NSViewSelectors.setFrameSize(), .{
            _newSize,
        });
    }

    pub fn frame(self: objc.Object) NSRect {
        return self.msgSend(NSRect, selector.NSViewSelectors.frame(), .{});
    }

    pub fn setFrame(self: objc.Object, _frame: NSRect) void {
        return self.msgSend(void, selector.NSViewSelectors.setFrame(), .{
            _frame,
        });
    }

    pub fn setBoundsOrigin(self: objc.Object, _newOrigin: NSPoint) void {
        return self.msgSend(void, selector.NSViewSelectors.setBoundsOrigin(), .{
            _newOrigin,
        });
    }

    pub fn setBoundsSize(self: objc.Object, _newSize: NSSize) void {
        return self.msgSend(void, selector.NSViewSelectors.setBoundsSize(), .{
            _newSize,
        });
    }

    pub fn bounds(self: objc.Object) NSRect {
        return self.msgSend(NSRect, selector.NSViewSelectors.bounds(), .{});
    }

    pub fn setBounds(self: objc.Object, _bounds: NSRect) void {
        return self.msgSend(void, selector.NSViewSelectors.setBounds(), .{
            _bounds,
        });
    }

    pub fn convertPointFromView(self: objc.Object, _point: NSPoint, _view: ?objc.Object) NSPoint {
        return self.msgSend(NSPoint, selector.NSViewSelectors.convertPointFromView(), .{
            _point,
            runtime_support.unwrapOptionalObject(_view),
        });
    }

    pub fn wantsLayer(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSViewSelectors.wantsLayer(), .{});
    }

    pub fn setWantsLayer(self: objc.Object, _wantsLayer: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSViewSelectors.setWantsLayer(), .{
            _wantsLayer,
        });
    }

    pub fn layer(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSViewSelectors.layer(), .{});
    }

    pub fn setLayer(self: objc.Object, _layer: objc.Object) void {
        return self.msgSend(void, selector.NSViewSelectors.setLayer(), .{
            runtime_support.unwrapOptionalObject(_layer),
        });
    }
};

pub const NSGestureRecognizerForNSViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSView").?;
    }

    pub fn addGestureRecognizer(self: objc.Object, _gestureRecognizer: objc.Object) void {
        return self.msgSend(void, selector.NSGestureRecognizerForNSViewSelectors.addGestureRecognizer(), .{
            runtime_support.unwrapOptionalObject(_gestureRecognizer),
        });
    }
};

pub const NSLayerDelegateContentsScaleUpdatingForNSObjectMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSObject").?;
    }
};

pub extern var NSViewBoundsDidChangeNotification: objc.c.id;

const NSPoint = foundation.NSPoint;
const NSRect = foundation.NSRect;
const NSSize = foundation.NSSize;
