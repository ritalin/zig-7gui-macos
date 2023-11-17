const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSNotificationName = foundation.NSNotificationName;
const NSString = foundation.NSString;
const NSInteger = runtime.NSInteger;

pub const NSEnterCharacter: u16 = 0x0003;
pub const NSBackspaceCharacter: u16 = 0x0008;
pub const NSTabCharacter: u16 = 0x0009;
pub const NSNewlineCharacter: u16 = 0x000a;
pub const NSFormFeedCharacter: u16 = 0x000c;
pub const NSCarriageReturnCharacter: u16 = 0x000d;
pub const NSBackTabCharacter: u16 = 0x0019;
pub const NSDeleteCharacter: u16 = 0x007f;
pub const NSLineSeparatorCharacter: u16 = 0x2028;
pub const NSParagraphSeparatorCharacter: u16 = 0x2029;
pub const NSIllegalTextMovement: u16 = 0;
pub const NSReturnTextMovement: u16 = 0x10;
pub const NSTabTextMovement: u16 = 0x11;
pub const NSBacktabTextMovement: u16 = 0x12;
pub const NSLeftTextMovement: u16 = 0x13;
pub const NSRightTextMovement: u16 = 0x14;
pub const NSUpTextMovement: u16 = 0x15;
pub const NSDownTextMovement: u16 = 0x16;
pub const NSCancelTextMovement: u16 = 0x17;
pub const NSOtherTextMovement: u16 = 0;
pub const NSTextWritingDirectionEmbedding: u16 = (0 << 1);
pub const NSTextWritingDirectionOverride: u16 = (1 << 1);

pub const NSTextAlignment = struct {
    pub const Left: NSTextAlignment = .{
        ._value = 0,
    };
    pub const Right: NSTextAlignment = .{
        ._value = 1,
    };
    pub const Center: NSTextAlignment = .{
        ._value = 2,
    };
    pub const Justified: NSTextAlignment = .{
        ._value = 3,
    };
    pub const Natural: NSTextAlignment = .{
        ._value = 4,
    };

    _value: NSInteger,
};

pub const NSTextMovement = struct {
    pub const Return: NSTextMovement = .{
        ._value = 0x10,
    };
    pub const Tab: NSTextMovement = .{
        ._value = 0x11,
    };
    pub const Backtab: NSTextMovement = .{
        ._value = 0x12,
    };
    pub const Left: NSTextMovement = .{
        ._value = 0x13,
    };
    pub const Right: NSTextMovement = .{
        ._value = 0x14,
    };
    pub const Up: NSTextMovement = .{
        ._value = 0x15,
    };
    pub const Down: NSTextMovement = .{
        ._value = 0x16,
    };
    pub const Cancel: NSTextMovement = .{
        ._value = 0x17,
    };
    pub const Other: NSTextMovement = .{
        ._value = 0,
    };

    _value: NSInteger,
};

pub const NSWritingDirection = struct {
    pub const Natural: NSWritingDirection = .{
        ._value = -1,
    };
    pub const LeftToRight: NSWritingDirection = .{
        ._value = 0,
    };
    pub const RightToLeft: NSWritingDirection = .{
        ._value = 1,
    };

    _value: NSInteger,
};
