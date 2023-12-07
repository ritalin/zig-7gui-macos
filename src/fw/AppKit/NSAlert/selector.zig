const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

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
