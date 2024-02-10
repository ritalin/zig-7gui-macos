const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime_support = @import("Runtime-Support");

pub const CFDictionaryRef = *const *__CFDictionary;

const __CFDictionary = anyopaque;
