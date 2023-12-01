const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSExceptionName = NSString;
pub const NSRunLoopMode = NSString;
const NSString = foundation.NSString;
const NSInteger = runtime.NSInteger;
const NSUInteger = runtime.NSUInteger;

pub const NSNotFound: NSInteger = 0x7fffffffffffffff;

pub const NSEnumerationOptions = std.enums.EnumSet(enum(NSUInteger) {
    Concurrent = (1 << 0),
    Reverse = (1 << 1),
});

pub const NSSortOptions = std.enums.EnumSet(enum(NSUInteger) {
    Concurrent = (1 << 0),
    Stable = (1 << 4),
});

pub const NSQualityOfService = struct {
    pub const UserInteractive: NSQualityOfService = .{
        ._value = 0x21,
    };
    pub const UserInitiated: NSQualityOfService = .{
        ._value = 0x19,
    };
    pub const Utility: NSQualityOfService = .{
        ._value = 0x11,
    };
    pub const Background: NSQualityOfService = .{
        ._value = 0x09,
    };
    pub const Default: NSQualityOfService = .{
        ._value = -1,
    };

    _value: NSInteger,
};

pub const NSComparisonResult = struct {
    pub const OrderedAscending: NSComparisonResult = .{
        ._value = -1,
    };
    pub const OrderedSame: NSComparisonResult = .{
        ._value = 0x0,
    };
    pub const OrderedDescending: NSComparisonResult = .{
        ._value = 0x1,
    };

    _value: NSInteger,
};
