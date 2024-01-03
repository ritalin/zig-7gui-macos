const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const appKit = @import("AppKit");
const coreGraphics = @import("CoreGraphics");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTableColumnMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTableColumn").?;
    }

    pub fn initWithIdentifier(_class: objc.Class, _identifier: NSUserInterfaceItemIdentifier) objc.Object {
        return runtime_support.backend_support.allocInstance(_class).msgSend(objc.Object, selector.NSTableColumnSelectors.initWithIdentifier(), .{
            _identifier,
        });
    }

    pub fn width(self: objc.Object) CGFloat {
        return self.msgSend(CGFloat, selector.NSTableColumnSelectors.width(), .{});
    }

    pub fn setWidth(self: objc.Object, _width: CGFloat) void {
        return self.msgSend(void, selector.NSTableColumnSelectors.setWidth(), .{
            _width,
        });
    }

    pub fn minWidth(self: objc.Object) CGFloat {
        return self.msgSend(CGFloat, selector.NSTableColumnSelectors.minWidth(), .{});
    }

    pub fn setMinWidth(self: objc.Object, _minWidth: CGFloat) void {
        return self.msgSend(void, selector.NSTableColumnSelectors.setMinWidth(), .{
            _minWidth,
        });
    }

    pub fn maxWidth(self: objc.Object) CGFloat {
        return self.msgSend(CGFloat, selector.NSTableColumnSelectors.maxWidth(), .{});
    }

    pub fn setMaxWidth(self: objc.Object, _maxWidth: CGFloat) void {
        return self.msgSend(void, selector.NSTableColumnSelectors.setMaxWidth(), .{
            _maxWidth,
        });
    }

    pub fn isEditable(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSTableColumnSelectors.isEditable(), .{});
    }

    pub fn setEditable(self: objc.Object, _editable: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSTableColumnSelectors.setEditable(), .{
            _editable,
        });
    }
};

const NSUserInterfaceItemIdentifier = appKit.NSUserInterfaceItemIdentifier;
const CGFloat = coreGraphics.CGFloat;
