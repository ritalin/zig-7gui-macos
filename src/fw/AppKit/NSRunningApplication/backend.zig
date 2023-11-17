const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

pub const NSRunningApplicationSelectors = struct {};

pub const NSRunningApplicationMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSRunningApplication").?;
    }
};
