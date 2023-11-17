const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

pub const NSDateSelectors = struct {};

pub const NSDateMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSDate").?;
    }
};

pub const NSDateCreationForNSDateSelectors = struct {};

pub const NSDateCreationForNSDateMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSDate").?;
    }
};

pub const NSExtendedDateForNSDateSelectors = struct {};

pub const NSExtendedDateForNSDateMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSDate").?;
    }
};
