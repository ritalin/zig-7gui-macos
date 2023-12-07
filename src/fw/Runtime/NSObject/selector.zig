const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

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

pub const NSObjectProtocolSelectors = struct {};
