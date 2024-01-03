const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSBezierPathMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSBezierPath").?;
    }

    pub fn bezierPath() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSBezierPathSelectors.bezierPath(), .{});
    }

    pub fn bezierPathWithOvalInRect(_rect: NSRect) objc.Object {
        return getClass().msgSend(objc.Object, selector.NSBezierPathSelectors.bezierPathWithOvalInRect(), .{
            _rect,
        });
    }

    pub fn elementCount(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSBezierPathSelectors.elementCount(), .{});
    }

    pub fn elementAtIndexAssociatedPoints(self: objc.Object, _index: NSInteger, _points: ?NSPointArray) NSUInteger {
        return self.msgSend(NSUInteger, selector.NSBezierPathSelectors.elementAtIndexAssociatedPoints(), .{
            _index,
            _points,
        });
    }

    pub fn appendBezierPathWithOvalInRect(self: objc.Object, _rect: NSRect) void {
        return self.msgSend(void, selector.NSBezierPathSelectors.appendBezierPathWithOvalInRect(), .{
            _rect,
        });
    }
};

const NSPointArray = foundation.NSPointArray;
const NSRect = foundation.NSRect;
const NSInteger = runtime.NSInteger;
const NSUInteger = runtime.NSUInteger;
