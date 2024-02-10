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

pub const CFOptionFlags = *const c_ulong;
pub const CFIndex = *const c_long;
pub const CFStringRef = *const *__CFString;
pub const CFAllocatorRetainCallBack = *const fn (_: *const void) *const void;
pub const CFAllocatorReleaseCallBack = *const fn (_: *const void) void;
pub const CFAllocatorCopyDescriptionCallBack = *const fn (_: *const void) CFStringRef;
pub const CFAllocatorAllocateCallBack = *const fn (_: CFIndex, _: CFOptionFlags, _: *void) *void;
pub const CFAllocatorReallocateCallBack = *const fn (_: *void, _: CFIndex, _: CFOptionFlags, _: *void) *void;
pub const CFAllocatorDeallocateCallBack = *const fn (_: *void, _: *void) void;
pub const CFAllocatorPreferredSizeCallBack = *const fn (_: CFIndex, _: CFOptionFlags, _: *void) CFIndex;

const __CFString = anyopaque;
pub const kCFNotFound: CFIndex = -1;
