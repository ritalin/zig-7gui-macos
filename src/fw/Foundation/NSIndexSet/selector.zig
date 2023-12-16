const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSMutableIndexSetSelectors = struct {
    var _sel_addIndex: ?objc.Sel = null;

    pub fn addIndex() objc.Sel {
        if (_sel_addIndex == null) {
            _sel_addIndex = objc.Sel.registerName("addIndex:");
        }
        return _sel_addIndex.?;
    }
};

pub const NSIndexSetSelectors = struct {
    var _sel_indexSet: ?objc.Sel = null;
    var _sel_indexSetWithIndex: ?objc.Sel = null;
    var _sel_count: ?objc.Sel = null;
    var _sel_containsIndex: ?objc.Sel = null;

    pub fn indexSet() objc.Sel {
        if (_sel_indexSet == null) {
            _sel_indexSet = objc.Sel.registerName("indexSet");
        }
        return _sel_indexSet.?;
    }

    pub fn indexSetWithIndex() objc.Sel {
        if (_sel_indexSetWithIndex == null) {
            _sel_indexSetWithIndex = objc.Sel.registerName("indexSetWithIndex:");
        }
        return _sel_indexSetWithIndex.?;
    }

    pub fn count() objc.Sel {
        if (_sel_count == null) {
            _sel_count = objc.Sel.registerName("count");
        }
        return _sel_count.?;
    }

    pub fn containsIndex() objc.Sel {
        if (_sel_containsIndex == null) {
            _sel_containsIndex = objc.Sel.registerName("containsIndex:");
        }
        return _sel_containsIndex.?;
    }
};
