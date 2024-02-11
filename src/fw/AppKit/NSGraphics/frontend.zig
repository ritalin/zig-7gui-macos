const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSAnimationEffect = struct {
    _value: NSUInteger,

    pub const DisappearingItemDefault: NSAnimationEffect = .{
        ._value = 0,
    };
    pub const Poof: NSAnimationEffect = .{
        ._value = 10,
    };
};

pub const NSWindowOrderingMode = struct {
    _value: NSInteger,

    pub const Above: NSWindowOrderingMode = .{
        ._value = 1,
    };
    pub const Below: NSWindowOrderingMode = .{
        ._value = -1,
    };
    pub const Out: NSWindowOrderingMode = .{
        ._value = 0,
    };
};

pub const NSDisplayGamut = struct {
    _value: NSInteger,

    pub const SRGB: NSDisplayGamut = .{
        ._value = 1,
    };
    pub const P3: NSDisplayGamut = .{
        ._value = 0x0,
    };
};

pub const NSFocusRingPlacement = struct {
    _value: NSUInteger,

    pub const Only: NSFocusRingPlacement = .{
        ._value = 0,
    };
    pub const Below: NSFocusRingPlacement = .{
        ._value = 1,
    };
    pub const Above: NSFocusRingPlacement = .{
        ._value = 2,
    };
};

pub const NSWindowDepth = struct {
    _value: i32,

    pub const TwentyfourBitRGB: NSWindowDepth = .{
        ._value = 0x208,
    };
    pub const SixtyfourBitRGB: NSWindowDepth = .{
        ._value = 0x210,
    };
    pub const OnehundredtwentyeightBitRGB: NSWindowDepth = .{
        ._value = 0x220,
    };
};

pub const NSBackingStoreType = struct {
    _value: NSUInteger,

    pub const Buffered: NSBackingStoreType = .{
        ._value = 2,
    };
};

pub const NSCompositingOperation = struct {
    _value: NSUInteger,

    pub const Clear: NSCompositingOperation = .{
        ._value = 0x0,
    };
    pub const Copy: NSCompositingOperation = .{
        ._value = 0x1,
    };
    pub const SourceOver: NSCompositingOperation = .{
        ._value = 0x2,
    };
    pub const SourceIn: NSCompositingOperation = .{
        ._value = 0x3,
    };
    pub const SourceOut: NSCompositingOperation = .{
        ._value = 0x4,
    };
    pub const SourceAtop: NSCompositingOperation = .{
        ._value = 0x5,
    };
    pub const DestinationOver: NSCompositingOperation = .{
        ._value = 0x6,
    };
    pub const DestinationIn: NSCompositingOperation = .{
        ._value = 0x7,
    };
    pub const DestinationOut: NSCompositingOperation = .{
        ._value = 0x8,
    };
    pub const DestinationAtop: NSCompositingOperation = .{
        ._value = 0x9,
    };
    pub const XOR: NSCompositingOperation = .{
        ._value = 0xA,
    };
    pub const PlusDarker: NSCompositingOperation = .{
        ._value = 0xB,
    };
    pub const PlusLighter: NSCompositingOperation = .{
        ._value = 0xC,
    };
    pub const Multiply: NSCompositingOperation = .{
        ._value = 0xD,
    };
    pub const Screen: NSCompositingOperation = .{
        ._value = 0xE,
    };
    pub const Overlay: NSCompositingOperation = .{
        ._value = 0xF,
    };
    pub const Darken: NSCompositingOperation = .{
        ._value = 0x10,
    };
    pub const Lighten: NSCompositingOperation = .{
        ._value = 0x11,
    };
    pub const ColorDodge: NSCompositingOperation = .{
        ._value = 0x12,
    };
    pub const ColorBurn: NSCompositingOperation = .{
        ._value = 0x13,
    };
    pub const SoftLight: NSCompositingOperation = .{
        ._value = 0x14,
    };
    pub const HardLight: NSCompositingOperation = .{
        ._value = 0x15,
    };
    pub const Difference: NSCompositingOperation = .{
        ._value = 0x16,
    };
    pub const Exclusion: NSCompositingOperation = .{
        ._value = 0x17,
    };
    pub const Hue: NSCompositingOperation = .{
        ._value = 0x18,
    };
    pub const Saturation: NSCompositingOperation = .{
        ._value = 0x19,
    };
    pub const Color: NSCompositingOperation = .{
        ._value = 0x1A,
    };
    pub const Luminosity: NSCompositingOperation = .{
        ._value = 0x1B,
    };
};

pub const NSColorRenderingIntent = struct {
    _value: NSInteger,

    pub const Default: NSColorRenderingIntent = .{
        ._value = 0x0,
    };
    pub const AbsoluteColorimetric: NSColorRenderingIntent = .{
        ._value = 0x1,
    };
    pub const RelativeColorimetric: NSColorRenderingIntent = .{
        ._value = 0x2,
    };
    pub const Perceptual: NSColorRenderingIntent = .{
        ._value = 0x3,
    };
    pub const Saturation: NSColorRenderingIntent = .{
        ._value = 0x4,
    };
};

pub const NSFocusRingType = struct {
    _value: NSUInteger,

    pub const Default: NSFocusRingType = .{
        ._value = 0,
    };
    pub const None: NSFocusRingType = .{
        ._value = 1,
    };
    pub const Exterior: NSFocusRingType = .{
        ._value = 2,
    };
};

pub const NSColorSpaceName = NSString;
const NSString = foundation.NSString;
const NSInteger = runtime.NSInteger;
const NSUInteger = runtime.NSUInteger;
