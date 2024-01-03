const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSPanelMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSPanel").?;
    }

    pub fn isFloatingPanel(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSPanelSelectors.isFloatingPanel(), .{});
    }

    pub fn setFloatingPanel(self: objc.Object, _floatingPanel: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSPanelSelectors.setFloatingPanel(), .{
            _floatingPanel,
        });
    }
};
