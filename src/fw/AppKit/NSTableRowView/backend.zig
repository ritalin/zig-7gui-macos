const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTableRowViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTableRowView").?;
    }
};
