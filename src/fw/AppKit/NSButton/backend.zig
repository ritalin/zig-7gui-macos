const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSUInteger = runtime.NSUInteger;

pub const NSButtonMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSButton").?;
    }

    pub fn buttonWithTitleTargetAction(_class: objc.Class, _title: objc.Object, _target: ?objc.Object, _action: ?objc.Sel) objc.Object {
        return _class.msgSend(objc.Object, selector.NSButtonSelectors.buttonWithTitleTargetAction(), .{
            runtime_support.unwrapOptionalObject(_title),
            runtime_support.unwrapOptionalObject(_target),
            runtime_support.unwrapOptionalSelValue(_action),
        });
    }

    pub fn setButtonType(self: objc.Object, _type: NSUInteger) void {
        return self.msgSend(void, selector.NSButtonSelectors.setButtonType(), .{
            _type,
        });
    }

    pub fn title(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSButtonSelectors.title(), .{});
    }

    pub fn setTitle(self: objc.Object, _title: objc.Object) void {
        return self.msgSend(void, selector.NSButtonSelectors.setTitle(), .{
            runtime_support.unwrapOptionalObject(_title),
        });
    }

    pub fn bezelStyle(self: objc.Object) NSUInteger {
        return self.msgSend(NSUInteger, selector.NSButtonSelectors.bezelStyle(), .{});
    }

    pub fn setBezelStyle(self: objc.Object, _bezelStyle: NSUInteger) void {
        return self.msgSend(void, selector.NSButtonSelectors.setBezelStyle(), .{
            _bezelStyle,
        });
    }
};
