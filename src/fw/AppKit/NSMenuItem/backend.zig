const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSMenuItemMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSMenuItem").?;
    }

    pub fn target(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSMenuItemSelectors.target(), .{}));
    }

    pub fn setTarget(self: objc.Object, _target: ?objc.Object) void {
        return self.msgSend(void, selector.NSMenuItemSelectors.setTarget(), .{
            runtime_support.unwrapOptionalObject(_target),
        });
    }

    pub fn action(self: objc.Object) ?objc.Sel {
        return runtime_support.wrapOptionalSelValue(self.msgSend(objc.c.SEL, selector.NSMenuItemSelectors.action(), .{}));
    }

    pub fn setAction(self: objc.Object, _action: ?objc.Sel) void {
        return self.msgSend(void, selector.NSMenuItemSelectors.setAction(), .{
            runtime_support.unwrapOptionalSelValue(_action),
        });
    }
};
