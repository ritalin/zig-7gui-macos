const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const CATransactionMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("CATransaction").?;
    }

    pub fn begin() void {
        return getClass().msgSend(void, selector.CATransactionSelectors.begin(), .{});
    }

    pub fn commit() void {
        return getClass().msgSend(void, selector.CATransactionSelectors.commit(), .{});
    }
};
