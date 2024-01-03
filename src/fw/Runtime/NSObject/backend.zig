const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSObjectMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSObject").?;
    }

    pub fn init(_class: objc.Class) objc.Object {
        return runtime_support.backend_support.allocInstance(_class).msgSend(objc.Object, selector.NSObjectSelectors.init(), .{});
    }

    pub fn dealloc(self: objc.Object) void {
        return self.msgSend(void, selector.NSObjectSelectors.dealloc(), .{});
    }

    pub fn conformsToProtocol(_protocol: objc.Protocol) objc.c.BOOL {
        return getClass().msgSend(objc.c.BOOL, selector.NSObjectSelectors.conformsToProtocol(), .{
            runtime_support.unwrapOptionalProtocol(_protocol),
        });
    }
};

pub const NSObjectProtocolMessages = struct {
    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSObject");
        }
        return class.?;
    }

    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;
};
