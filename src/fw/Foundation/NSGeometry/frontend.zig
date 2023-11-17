const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const coreGraphics = @import("CoreGraphics");
const runtime = @import("Runtime");

pub const NSPoint = CGPoint;
pub const NSPointPointer = *NSPoint;
pub const NSPointArray = *NSPoint;
pub const NSSize = CGSize;
pub const NSSizePointer = *NSSize;
pub const NSSizeArray = *NSSize;
pub const NSRect = CGRect;
pub const NSRectPointer = *NSRect;
pub const NSRectArray = *NSRect;
const CGFloat = coreGraphics.CGFloat;
const CGPoint = coreGraphics.CGPoint;
const CGRect = coreGraphics.CGRect;
const CGRectEdge = coreGraphics.CGRectEdge;
const CGSize = coreGraphics.CGSize;
const NSUInteger = runtime.NSUInteger;

pub const NSAlignmentOptions = std.enums.EnumSet(enum(c_ulonglong) {
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
    pub const MinX: NSRectEdge = .{
        ._value = CGRectEdge.MinX,
    };
    pub const MinY: NSRectEdge = .{
        ._value = CGRectEdge.MinY,
    };
    pub const MaxX: NSRectEdge = .{
        ._value = CGRectEdge.MaxX,
    };
    pub const MaxY: NSRectEdge = .{
        ._value = CGRectEdge.MaxY,
    };
    pub const MinXEdge: NSRectEdge = .{
        ._value = NSRectEdge.MinX,
    };
    pub const MinYEdge: NSRectEdge = .{
        ._value = NSRectEdge.MinY,
    };
    pub const MaxXEdge: NSRectEdge = .{
        ._value = NSRectEdge.MaxX,
    };
    pub const MaxYEdge: NSRectEdge = .{
        ._value = NSRectEdge.MaxY,
    };

    _value: NSUInteger,
};
