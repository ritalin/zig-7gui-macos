const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSObjectSelectors = struct {
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

    pub fn conformsToProtocol() objc.Sel {
        if (_sel_conformsToProtocol == null) {
            _sel_conformsToProtocol = objc.Sel.registerName("conformsToProtocol:");
        }
        return _sel_conformsToProtocol.?;
    }

    var _sel_init: ?objc.Sel = null;
    var _sel_dealloc: ?objc.Sel = null;
    var _sel_conformsToProtocol: ?objc.Sel = null;
};

pub const NSObjectProtocolSelectors = struct {};
