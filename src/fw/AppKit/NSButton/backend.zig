const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSButtonSelectors = struct {
    var _sel_buttonWithTitleTargetAction: ?objc.Sel = null;

    pub fn buttonWithTitleTargetAction() objc.Sel {
        if (_sel_buttonWithTitleTargetAction == null) {
            _sel_buttonWithTitleTargetAction = objc.Sel.registerName("buttonWithTitle:target:action:");
        }
        return _sel_buttonWithTitleTargetAction.?;
    }
};

pub const NSButtonMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSButton").?;
    }

    pub fn buttonWithTitleTargetAction(_class: objc.Class, _title: objc.Object, _target: ?objc.Object, _action: ?objc.Sel) objc.Object {
        return _class.msgSend(objc.Object, NSButtonSelectors.buttonWithTitleTargetAction(), .{
            runtime_support.unwrapOptionalObject(_title),
            runtime_support.unwrapOptionalObject(_target),
            runtime_support.unwrapOptionalSelValue(_action),
        });
    }
};
