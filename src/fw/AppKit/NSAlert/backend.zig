const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

const NSInteger = runtime.NSInteger;

pub const NSAlertSelectors = struct {
    var _sel_messageText: ?objc.Sel = null;
    var _sel_setMessageText: ?objc.Sel = null;
    var _sel_runModal: ?objc.Sel = null;

    pub fn messageText() objc.Sel {
        if (_sel_messageText == null) {
            _sel_messageText = objc.Sel.registerName("messageText");
        }
        return _sel_messageText.?;
    }

    pub fn setMessageText() objc.Sel {
        if (_sel_setMessageText == null) {
            _sel_setMessageText = objc.Sel.registerName("setMessageText:");
        }
        return _sel_setMessageText.?;
    }

    pub fn runModal() objc.Sel {
        if (_sel_runModal == null) {
            _sel_runModal = objc.Sel.registerName("runModal");
        }
        return _sel_runModal.?;
    }
};

pub const NSAlertMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSAlert").?;
    }

    pub fn messageText(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, NSAlertSelectors.messageText(), .{});
    }

    pub fn setMessageText(self: objc.Object, _messageText: objc.Object) void {
        return self.msgSend(void, NSAlertSelectors.setMessageText(), .{
            runtime.unwrapOptionalObject(_messageText),
        });
    }

    pub fn runModal(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, NSAlertSelectors.runModal(), .{});
    }
};
