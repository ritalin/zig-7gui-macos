const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

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
};
