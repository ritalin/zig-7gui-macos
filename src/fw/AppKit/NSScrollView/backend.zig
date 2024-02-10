const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSScrollViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSScrollView").?;
    }

    pub fn documentVisibleRect(self: objc.Object) NSRect {
        return self.msgSend(NSRect, selector.NSScrollViewSelectors.documentVisibleRect(), .{});
    }

    pub fn documentView(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSScrollViewSelectors.documentView(), .{}));
    }

    pub fn setDocumentView(self: objc.Object, _documentView: ?objc.Object) void {
        return self.msgSend(void, selector.NSScrollViewSelectors.setDocumentView(), .{
            runtime_support.unwrapOptionalObject(_documentView),
        });
    }

    pub fn contentView(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSScrollViewSelectors.contentView(), .{});
    }

    pub fn setContentView(self: objc.Object, _contentView: objc.Object) void {
        return self.msgSend(void, selector.NSScrollViewSelectors.setContentView(), .{
            runtime_support.unwrapOptionalObject(_contentView),
        });
    }

    pub fn borderType(self: objc.Object) NSUInteger {
        return self.msgSend(NSUInteger, selector.NSScrollViewSelectors.borderType(), .{});
    }

    pub fn setBorderType(self: objc.Object, _borderType: NSUInteger) void {
        return self.msgSend(void, selector.NSScrollViewSelectors.setBorderType(), .{
            _borderType,
        });
    }

    pub fn drawsBackground(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSScrollViewSelectors.drawsBackground(), .{});
    }

    pub fn setDrawsBackground(self: objc.Object, _drawsBackground: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSScrollViewSelectors.setDrawsBackground(), .{
            _drawsBackground,
        });
    }

    pub fn hasVerticalScroller(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSScrollViewSelectors.hasVerticalScroller(), .{});
    }

    pub fn setHasVerticalScroller(self: objc.Object, _hasVerticalScroller: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSScrollViewSelectors.setHasVerticalScroller(), .{
            _hasVerticalScroller,
        });
    }

    pub fn hasHorizontalScroller(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSScrollViewSelectors.hasHorizontalScroller(), .{});
    }

    pub fn setHasHorizontalScroller(self: objc.Object, _hasHorizontalScroller: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSScrollViewSelectors.setHasHorizontalScroller(), .{
            _hasHorizontalScroller,
        });
    }

    pub fn autohidesScrollers(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSScrollViewSelectors.autohidesScrollers(), .{});
    }

    pub fn setAutohidesScrollers(self: objc.Object, _autohidesScrollers: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSScrollViewSelectors.setAutohidesScrollers(), .{
            _autohidesScrollers,
        });
    }

    pub fn addFloatingSubviewForAxis(self: objc.Object, _view: objc.Object, _axis: NSInteger) void {
        return self.msgSend(void, selector.NSScrollViewSelectors.addFloatingSubviewForAxis(), .{
            runtime_support.unwrapOptionalObject(_view),
            _axis,
        });
    }

    pub fn automaticallyAdjustsContentInsets(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSScrollViewSelectors.automaticallyAdjustsContentInsets(), .{});
    }

    pub fn setAutomaticallyAdjustsContentInsets(self: objc.Object, _automaticallyAdjustsContentInsets: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSScrollViewSelectors.setAutomaticallyAdjustsContentInsets(), .{
            _automaticallyAdjustsContentInsets,
        });
    }

    pub fn contentInsets(self: objc.Object) NSEdgeInsets {
        return self.msgSend(NSEdgeInsets, selector.NSScrollViewSelectors.contentInsets(), .{});
    }

    pub fn setContentInsets(self: objc.Object, _contentInsets: NSEdgeInsets) void {
        return self.msgSend(void, selector.NSScrollViewSelectors.setContentInsets(), .{
            _contentInsets,
        });
    }
};

const NSEdgeInsets = foundation.NSEdgeInsets;
const NSRect = foundation.NSRect;
const NSInteger = runtime.NSInteger;
const NSUInteger = runtime.NSUInteger;
