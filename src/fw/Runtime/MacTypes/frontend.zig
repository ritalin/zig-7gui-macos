const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime_support = @import("Runtime-Support");

pub const NumVersion = extern struct {
    nonRelRev: UInt8,
    stage: UInt8,
    minorAndBugRev: UInt8,
    majorRev: UInt8,
};

pub const ProcessSerialNumber = extern struct {
    highLongOfPSN: UInt32,
    lowLongOfPSN: UInt32,
};

pub const FixedRect = extern struct {
    left: Fixed,
    top: Fixed,
    right: Fixed,
    bottom: Fixed,
};

pub const VersRec = extern struct {
    numericVersion: NumVersion,
    countryCode: c_short,
    shortVersion: Str255,
    reserved: Str255,
};

pub const Rect = extern struct {
    top: c_short,
    left: c_short,
    bottom: c_short,
    right: c_short,
};

pub const wide = extern struct {
    lo: UInt32,
    hi: SInt32,
};

pub const UnsignedWide = extern struct {
    lo: UInt32,
    hi: UInt32,
};

pub const FixedPoint = extern struct {
    x: Fixed,
    y: Fixed,
};

pub const TimeRecord = extern struct {
    value: CompTimeValue,
    scale: TimeScale,
    base: TimeBase,
};

pub const Point = extern struct {
    v: c_short,
    h: c_short,
};

pub const Float96 = extern struct {
    exp: SInt16,
    man: UInt16,
};

pub const Float80 = extern struct {
    exp: SInt16,
    man: UInt16,
};

pub const Float32Point = extern struct {
    x: Float32,
    y: Float32,
};

pub const noErr: c_uint = 0;
pub const kNilOptions: c_uint = 0;
pub const kVariableLengthArray: c_uint = 1;
pub const kUnknownType: c_uint = 0x3F3F3F3F;
pub const normal: c_uint = 0;
pub const bold: c_uint = 1;
pub const italic: c_uint = 2;
pub const underline: c_uint = 4;
pub const outline: c_uint = 8;
pub const shadow: c_uint = 0x10;
pub const condense: c_uint = 0x20;
pub const extend: c_uint = 0x40;
pub const developStage: c_uint = 0x20;
pub const alphaStage: c_uint = 0x40;
pub const betaStage: c_uint = 0x60;
pub const finalStage: c_uint = 0x80;
