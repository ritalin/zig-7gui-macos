const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime_support = @import("Runtime-Support");

pub const CFAllocatorContext = extern struct {
    version: CFIndex,
    info: *anyopaque,
    retain: CFAllocatorRetainCallBack,
    release: CFAllocatorReleaseCallBack,
    copyDescription: CFAllocatorCopyDescriptionCallBack,
    allocate: CFAllocatorAllocateCallBack,
    reallocate: CFAllocatorReallocateCallBack,
    deallocate: CFAllocatorDeallocateCallBack,
    preferredSize: CFAllocatorPreferredSizeCallBack,
};

pub const CFRange = extern struct {
    location: CFIndex,
    length: CFIndex,
};

pub const CFComparisonResult = struct {
    _value: CFIndex,

    pub const kCFCompareLessThan: CFComparisonResult = .{
        ._value = -1,
    };
    pub const kCFCompareEqualTo: CFComparisonResult = .{
        ._value = 0,
    };
    pub const kCFCompareGreaterThan: CFComparisonResult = .{
        ._value = 1,
    };
};

pub const kCFNotFound: CFIndex = -1;
