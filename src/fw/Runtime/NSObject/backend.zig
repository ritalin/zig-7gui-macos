const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

pub const NSObjectSelectors = struct {};

pub const NSObjectMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSObject").?;
    }
};

pub const NSObjectProtocolSelectors = struct {};

pub const NSObjectProtocolMessages = struct {
    pub const init = runtime.backend_support.newInstance;
    pub const dealloc = runtime.backend_support.destroyInstance;
    pub const registerMessage = runtime.backend_support.ObjectRegistry.registerMessage;

    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime.backend_support.ObjectRegistry.newDelegateClass(_class_name, "");
        }
        return class.?;
    }
};