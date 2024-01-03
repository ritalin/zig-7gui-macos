const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const appKit = @import("AppKit");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSAlertMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSAlert").?;
    }

    pub fn messageText(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSAlertSelectors.messageText(), .{});
    }

    pub fn setMessageText(self: objc.Object, _messageText: objc.Object) void {
        return self.msgSend(void, selector.NSAlertSelectors.setMessageText(), .{
            runtime_support.unwrapOptionalObject(_messageText),
        });
    }

    pub fn runModal(self: objc.Object) NSModalResponse {
        return self.msgSend(NSModalResponse, selector.NSAlertSelectors.runModal(), .{});
    }

    pub fn beginSheetModalForWindowCompletionHandler(self: objc.Object, _sheetWindow: objc.Object, _handler: ?runtime_support.BlockContextRef) void {
        return self.msgSend(void, selector.NSAlertSelectors.beginSheetModalForWindowCompletionHandler(), .{
            runtime_support.unwrapOptionalObject(_sheetWindow),
            _handler,
        });
    }
};

const NSModalResponse = appKit.NSModalResponse;
