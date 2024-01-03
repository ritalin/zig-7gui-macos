const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const CATransactionSelectors = struct {
    pub fn begin() objc.Sel {
        if (_sel_begin == null) {
            _sel_begin = objc.Sel.registerName("begin");
        }
        return _sel_begin.?;
    }

    pub fn commit() objc.Sel {
        if (_sel_commit == null) {
            _sel_commit = objc.Sel.registerName("commit");
        }
        return _sel_commit.?;
    }

    var _sel_begin: ?objc.Sel = null;
    var _sel_commit: ?objc.Sel = null;
};
