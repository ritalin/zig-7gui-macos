const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

pub const NSTextStorageSelectors = struct {};

pub const NSTextStorageMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTextStorage").?;
    }
};
