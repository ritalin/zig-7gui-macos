const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSUInteger = runtime.NSUInteger;

pub const NSBezelStyle = struct {
    pub const Rounded: NSBezelStyle = .{
        ._value = 1,
    };
    pub const RegularSquare: NSBezelStyle = .{
        ._value = 2,
    };
    pub const Disclosure: NSBezelStyle = .{
        ._value = 5,
    };
    pub const ShadowlessSquare: NSBezelStyle = .{
        ._value = 6,
    };
    pub const Circular: NSBezelStyle = .{
        ._value = 7,
    };
    pub const TexturedSquare: NSBezelStyle = .{
        ._value = 8,
    };
    pub const HelpButton: NSBezelStyle = .{
        ._value = 9,
    };
    pub const SmallSquare: NSBezelStyle = .{
        ._value = 10,
    };
    pub const TexturedRounded: NSBezelStyle = .{
        ._value = 11,
    };
    pub const RoundRect: NSBezelStyle = .{
        ._value = 12,
    };
    pub const Recessed: NSBezelStyle = .{
        ._value = 13,
    };
    pub const RoundedDisclosure: NSBezelStyle = .{
        ._value = 14,
    };
    pub const Inline: NSBezelStyle = .{
        ._value = 15,
    };

    _value: NSUInteger,
};

pub const NSButtonType = struct {
    pub const MomentaryLight: NSButtonType = .{
        ._value = 0,
    };
    pub const PushOnPushOff: NSButtonType = .{
        ._value = 1,
    };
    pub const Toggle: NSButtonType = .{
        ._value = 2,
    };
    pub const Switch: NSButtonType = .{
        ._value = 3,
    };
    pub const Radio: NSButtonType = .{
        ._value = 4,
    };
    pub const MomentaryChange: NSButtonType = .{
        ._value = 5,
    };
    pub const OnOff: NSButtonType = .{
        ._value = 6,
    };
    pub const MomentaryPushIn: NSButtonType = .{
        ._value = 7,
    };
    pub const Accelerator: NSButtonType = .{
        ._value = 8,
    };
    pub const MultiLevelAccelerator: NSButtonType = .{
        ._value = 9,
    };

    _value: NSUInteger,
};
