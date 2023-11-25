const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

pub const NSObjectSelectors = struct {
    var _sel_init: ?objc.Sel = null;
    var _sel_dealloc: ?objc.Sel = null;

    pub fn init() objc.Sel {
        if (_sel_init == null) {
            _sel_init = objc.Sel.registerName("init");
        }
        return _sel_init.?;
    }

    pub fn dealloc() objc.Sel {
        if (_sel_dealloc == null) {
            _sel_dealloc = objc.Sel.registerName("dealloc");
        }
        return _sel_dealloc.?;
    }
};

pub const NSObjectMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSObject").?;
    }

    pub fn init(_class: objc.Class) objc.Object {
        return runtime.backend_support.allocInstance(_class).msgSend(objc.Object, NSObjectSelectors.init(), .{});
    }

    pub fn dealloc(self: objc.Object) void {
        return self.msgSend(void, NSObjectSelectors.dealloc(), .{});
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
