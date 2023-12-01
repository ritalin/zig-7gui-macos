const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSRunningApplicationSelectors = struct {};

pub const NSRunningApplicationMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSRunningApplication").?;
    }
};
