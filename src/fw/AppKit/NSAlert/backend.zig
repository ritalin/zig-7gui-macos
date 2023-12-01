const std = @import("std");
const objc = @import("objc");
const appKit = @import("AppKit");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSModalResponse = appKit.NSModalResponse;

pub const NSAlertSelectors = struct {
    var _sel_messageText: ?objc.Sel = null;
    var _sel_setMessageText: ?objc.Sel = null;
    var _sel_runModal: ?objc.Sel = null;
    var _sel_beginSheetModalForWindowCompletionHandler: ?objc.Sel = null;

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

    pub fn beginSheetModalForWindowCompletionHandler() objc.Sel {
        if (_sel_beginSheetModalForWindowCompletionHandler == null) {
            _sel_beginSheetModalForWindowCompletionHandler = objc.Sel.registerName("beginSheetModalForWindow:completionHandler:");
        }
        return _sel_beginSheetModalForWindowCompletionHandler.?;
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
            runtime_support.unwrapOptionalObject(_messageText),
        });
    }

    pub fn runModal(self: objc.Object) NSModalResponse {
        return self.msgSend(NSModalResponse, NSAlertSelectors.runModal(), .{});
    }

    pub fn beginSheetModalForWindowCompletionHandler(self: objc.Object, _sheetWindow: objc.Object, _handler: ?runtime_support.BlockContextRef) void {
        return self.msgSend(void, NSAlertSelectors.beginSheetModalForWindowCompletionHandler(), .{
            runtime_support.unwrapOptionalObject(_sheetWindow),
            _handler,
        });
    }
};
