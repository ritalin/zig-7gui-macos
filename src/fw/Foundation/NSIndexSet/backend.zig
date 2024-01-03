const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSMutableIndexSetMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSMutableIndexSet").?;
    }

    pub fn addIndex(self: objc.Object, _value: NSUInteger) void {
        return self.msgSend(void, selector.NSMutableIndexSetSelectors.addIndex(), .{
            _value,
        });
    }
};

pub const NSIndexSetMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSIndexSet").?;
    }

    pub fn indexSet(_class: objc.Class) objc.Object {
        return _class.msgSend(objc.Object, selector.NSIndexSetSelectors.indexSet(), .{});
    }

    pub fn indexSetWithIndex(_class: objc.Class, _value: NSUInteger) objc.Object {
        return _class.msgSend(objc.Object, selector.NSIndexSetSelectors.indexSetWithIndex(), .{
            _value,
        });
    }

    pub fn count(self: objc.Object) NSUInteger {
        return self.msgSend(NSUInteger, selector.NSIndexSetSelectors.count(), .{});
    }

    pub fn containsIndex(self: objc.Object, _value: NSUInteger) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSIndexSetSelectors.containsIndex(), .{
            _value,
        });
    }
};

const NSUInteger = runtime.NSUInteger;
