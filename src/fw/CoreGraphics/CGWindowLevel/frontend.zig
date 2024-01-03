const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime_support = @import("Runtime-Support");

pub const CGWindowLevelKey = struct {
    _value: i32,

    pub const kCGBaseWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0,
    };
    pub const kCGMinimumWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x1,
    };
    pub const kCGDesktopWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x2,
    };
    pub const kCGBackstopMenuLevelKey: CGWindowLevelKey = .{
        ._value = 0x3,
    };
    pub const kCGNormalWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x4,
    };
    pub const kCGFloatingWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x5,
    };
    pub const kCGTornOffMenuWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x6,
    };
    pub const kCGDockWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x7,
    };
    pub const kCGMainMenuWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x8,
    };
    pub const kCGStatusWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x9,
    };
    pub const kCGModalPanelWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0xA,
    };
    pub const kCGPopUpMenuWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0xB,
    };
    pub const kCGDraggingWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0xC,
    };
    pub const kCGScreenSaverWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0xD,
    };
    pub const kCGMaximumWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0xE,
    };
    pub const kCGOverlayWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0xF,
    };
    pub const kCGHelpWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x10,
    };
    pub const kCGUtilityWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x11,
    };
    pub const kCGDesktopIconWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x12,
    };
    pub const kCGCursorWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x13,
    };
    pub const kCGAssistiveTechHighWindowLevelKey: CGWindowLevelKey = .{
        ._value = 0x14,
    };
    pub const kCGNumberOfWindowLevelKeys: CGWindowLevelKey = .{
        ._value = 0x15,
    };
};
