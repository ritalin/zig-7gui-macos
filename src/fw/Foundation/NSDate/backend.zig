const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSDateMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSDate").?;
    }
};

pub const NSDateCreationForNSDateMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSDate").?;
    }
};

pub const NSExtendedDateForNSDateMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSDate").?;
    }
};
