const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const coreGraphics = @import("CoreGraphics");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSAlignmentOptions = runtime_support.EnumOptions(enum(c_ulonglong) {
    AlignMinXInward = 1 << 0,
    AlignMinYInward = 1 << 1,
    AlignMaxXInward = 1 << 2,
    AlignMaxYInward = 1 << 3,
    AlignWidthInward = 1 << 4,
    AlignHeightInward = 1 << 5,
    AlignMinXOutward = 1 << 8,
    AlignMinYOutward = 1 << 9,
    AlignMaxXOutward = 1 << 10,
    AlignMaxYOutward = 1 << 11,
    AlignWidthOutward = 1 << 12,
    AlignHeightOutward = 1 << 13,
    AlignMinXNearest = 1 << 16,
    AlignMinYNearest = 1 << 17,
    AlignMaxXNearest = 1 << 18,
    AlignMaxYNearest = 1 << 19,
    AlignWidthNearest = 1 << 20,
    AlignHeightNearest = 1 << 21,
    AlignRectFlipped = 1 << 63,
});

pub const NSEdgeInsets = extern struct {
    top: CGFloat,
    left: CGFloat,
    bottom: CGFloat,
    right: CGFloat,
};

pub const NSRectEdge = struct {
    _value: NSUInteger,

    pub const MinX: NSRectEdge = .{
        ._value = CGRectEdge.MinX._value,
    };
    pub const MinY: NSRectEdge = .{
        ._value = CGRectEdge.MinY._value,
    };
    pub const MaxX: NSRectEdge = .{
        ._value = CGRectEdge.MaxX._value,
    };
    pub const MaxY: NSRectEdge = .{
        ._value = CGRectEdge.MaxY._value,
    };
    pub const MinXEdge: NSRectEdge = .{
        ._value = NSRectEdge.MinX._value,
    };
    pub const MinYEdge: NSRectEdge = .{
        ._value = NSRectEdge.MinY._value,
    };
    pub const MaxXEdge: NSRectEdge = .{
        ._value = NSRectEdge.MaxX._value,
    };
    pub const MaxYEdge: NSRectEdge = .{
        ._value = NSRectEdge.MaxY._value,
    };
};

pub const NSPoint = *const CGPoint;
pub const NSPointPointer = *const *NSPoint;
pub const NSPointArray = *const *NSPoint;
pub const NSSize = *const CGSize;
pub const NSRect = *const CGRect;
const CGFloat = coreGraphics.CGFloat;
const CGPoint = coreGraphics.CGPoint;
const CGRect = coreGraphics.CGRect;
const CGRectEdge = coreGraphics.CGRectEdge;
const CGSize = coreGraphics.CGSize;
const NSUInteger = runtime.NSUInteger;
