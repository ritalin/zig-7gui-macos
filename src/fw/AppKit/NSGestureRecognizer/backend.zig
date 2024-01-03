const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSGestureRecognizerMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSGestureRecognizer").?;
    }

    pub fn initWithTargetAction(_class: objc.Class, _target: ?objc.Object, _action: ?objc.Sel) objc.Object {
        return runtime_support.backend_support.allocInstance(_class).msgSend(objc.Object, selector.NSGestureRecognizerSelectors.initWithTargetAction(), .{
            runtime_support.unwrapOptionalObject(_target),
            runtime_support.unwrapOptionalSelValue(_action),
        });
    }

    pub fn target(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSGestureRecognizerSelectors.target(), .{}));
    }

    pub fn setTarget(self: objc.Object, _target: ?objc.Object) void {
        return self.msgSend(void, selector.NSGestureRecognizerSelectors.setTarget(), .{
            runtime_support.unwrapOptionalObject(_target),
        });
    }

    pub fn action(self: objc.Object) ?objc.Sel {
        return self.msgSend(?objc.Sel, selector.NSGestureRecognizerSelectors.action(), .{});
    }

    pub fn setAction(self: objc.Object, _action: ?objc.Sel) void {
        return self.msgSend(void, selector.NSGestureRecognizerSelectors.setAction(), .{
            runtime_support.unwrapOptionalSelValue(_action),
        });
    }

    pub fn state(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSGestureRecognizerSelectors.state(), .{});
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSGestureRecognizerSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, selector.NSGestureRecognizerSelectors.setDelegate(), .{
            runtime_support.unwrapOptionalObject(_delegate),
        });
    }

    pub fn pressureConfiguration(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSGestureRecognizerSelectors.pressureConfiguration(), .{});
    }

    pub fn setPressureConfiguration(self: objc.Object, _pressureConfiguration: objc.Object) void {
        return self.msgSend(void, selector.NSGestureRecognizerSelectors.setPressureConfiguration(), .{
            runtime_support.unwrapOptionalObject(_pressureConfiguration),
        });
    }

    pub fn locationInView(self: objc.Object, _view: ?objc.Object) NSPoint {
        return self.msgSend(NSPoint, selector.NSGestureRecognizerSelectors.locationInView(), .{
            runtime_support.unwrapOptionalObject(_view),
        });
    }
};

pub const NSTouchBarForNSGestureRecognizerMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSGestureRecognizer").?;
    }
};

pub const NSSubclassUseForNSGestureRecognizerMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSGestureRecognizer").?;
    }
};

pub const NSGestureRecognizerDelegateMessages = struct {
    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSGestureRecognizerDelegate");
        }
        return class.?;
    }

    pub fn registerGestureRecognizerShouldAttemptToRecognizeWithEvent(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "gestureRecognizer:shouldAttemptToRecognizeWithEvent:", runtime_support.wrapDelegateHandler(_handler), "c32@0:8@16@24");
    }

    pub fn registerGestureRecognizerShouldBegin(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "gestureRecognizerShouldBegin:", runtime_support.wrapDelegateHandler(_handler), "c24@0:8@16");
    }

    pub fn registerGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:", runtime_support.wrapDelegateHandler(_handler), "c32@0:8@16@24");
    }

    pub fn registerGestureRecognizerShouldRequireFailureOfGestureRecognizer(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "gestureRecognizer:shouldRequireFailureOfGestureRecognizer:", runtime_support.wrapDelegateHandler(_handler), "c32@0:8@16@24");
    }

    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;
};

const NSPoint = foundation.NSPoint;
const NSInteger = runtime.NSInteger;
