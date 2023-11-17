const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const quartzCore = @import("QuartzCore");
const runtime = @import("Runtime");

pub const NSTrackingRectTag = NSInteger;
pub const NSToolTipTag = NSInteger;
pub const NSViewFullScreenModeOptionKey = NSString;
pub const NSDefinitionOptionKey = NSString;
pub const NSDefinitionPresentationType = NSString;
const NSNotificationName = foundation.NSNotificationName;
const NSPoint = foundation.NSPoint;
const NSRect = foundation.NSRect;
const NSSize = foundation.NSSize;
const NSString = foundation.NSString;
const CALayer = quartzCore.CALayer;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSUInteger = runtime.NSUInteger;

pub const NSAutoresizingMaskOptions = std.enums.EnumSet(enum(NSUInteger) {
    ViewMinXMargin = 1,
    ViewWidthSizable = 2,
    ViewMaxXMargin = 4,
    ViewMinYMargin = 8,
    ViewHeightSizable = 16,
    ViewMaxYMargin = 32,
});

pub const NSView = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub inline fn as(self: Self, comptime DesiredType: type) DesiredType {
        return runtime.ObjectUpperCast(Self, Self.Constructor).as(self, DesiredType);
    }

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.ObjectUpperCast(Self, Self.Constructor).of(DesiredType);
    }

    pub fn superview(self: Self) ?NSView {
        return runtime.wrapOptionalObject(NSView, backend.NSViewMessages.superview(runtime.objectId(NSView, self)));
    }

    pub fn subviews(self: Self) NSView {
        return runtime.wrapObject(NSView, backend.NSViewMessages.subviews(runtime.objectId(NSView, self)));
    }

    pub fn addSubview(self: Self, _view: NSView) void {
        return backend.NSViewMessages.addSubview(runtime.objectId(NSView, self), runtime.objectId(NSView, _view));
    }

    pub fn setFrameOrigin(self: Self, _newOrigin: NSPoint) void {
        return backend.NSViewMessages.setFrameOrigin(runtime.objectId(NSView, self), runtime.pass(NSPoint, _newOrigin));
    }

    pub fn setFrameSize(self: Self, _newSize: NSSize) void {
        return backend.NSViewMessages.setFrameSize(runtime.objectId(NSView, self), runtime.pass(NSSize, _newSize));
    }

    pub fn frame(self: Self) NSRect {
        return backend.NSViewMessages.frame(runtime.objectId(NSView, self));
    }

    pub fn setFrame(self: Self, _frame: NSRect) void {
        return backend.NSViewMessages.setFrame(runtime.objectId(NSView, self), runtime.pass(NSRect, _frame));
    }

    pub fn wantsLayer(self: Self) bool {
        return runtime.fromBOOL(backend.NSViewMessages.wantsLayer(runtime.objectId(NSView, self)));
    }

    pub fn setWantsLayer(self: Self, _wantsLayer: bool) void {
        return backend.NSViewMessages.setWantsLayer(runtime.objectId(NSView, self), runtime.toBOOL(_wantsLayer));
    }

    pub fn layer(self: Self) CALayer {
        return runtime.wrapObject(CALayer, backend.NSViewMessages.layer(runtime.objectId(NSView, self)));
    }

    pub fn setLayer(self: Self, _layer: CALayer) void {
        return backend.NSViewMessages.setLayer(runtime.objectId(NSView, self), runtime.objectId(CALayer, _layer));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithFrame(_frameRect: NSRect) DesiredType {
                var _class = DesiredType.Support.getClass();
                return runtime.wrapObject(DesiredType, backend.NSViewMessages.initWithFrame(_class, runtime.pass(NSRect, _frameRect)));
            }
        };
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSViewMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSView,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const ForNSObject = struct {
        pub const LayerDelegateContentsScaleUpdating = NSLayerDelegateContentsScaleUpdatingForNSObject;
    };
};

const NSLayerDelegateContentsScaleUpdatingForNSObject = struct {
    const Category = @This();
    pub const Self = NSObject;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

pub const NSViewLayerContentsRedrawPolicy = struct {
    pub const Never: NSViewLayerContentsRedrawPolicy = .{
        ._value = 0,
    };
    pub const OnSetNeedsDisplay: NSViewLayerContentsRedrawPolicy = .{
        ._value = 1,
    };
    pub const DuringViewResize: NSViewLayerContentsRedrawPolicy = .{
        ._value = 2,
    };
    pub const BeforeViewResize: NSViewLayerContentsRedrawPolicy = .{
        ._value = 3,
    };
    pub const Crossfade: NSViewLayerContentsRedrawPolicy = .{
        ._value = 4,
    };

    _value: NSInteger,
};

pub const NSViewLayerContentsPlacement = struct {
    pub const ScaleAxesIndependently: NSViewLayerContentsPlacement = .{
        ._value = 0,
    };
    pub const ScaleProportionallyToFit: NSViewLayerContentsPlacement = .{
        ._value = 1,
    };
    pub const ScaleProportionallyToFill: NSViewLayerContentsPlacement = .{
        ._value = 2,
    };
    pub const Center: NSViewLayerContentsPlacement = .{
        ._value = 3,
    };
    pub const Top: NSViewLayerContentsPlacement = .{
        ._value = 4,
    };
    pub const TopRight: NSViewLayerContentsPlacement = .{
        ._value = 5,
    };
    pub const Right: NSViewLayerContentsPlacement = .{
        ._value = 6,
    };
    pub const BottomRight: NSViewLayerContentsPlacement = .{
        ._value = 7,
    };
    pub const Bottom: NSViewLayerContentsPlacement = .{
        ._value = 8,
    };
    pub const BottomLeft: NSViewLayerContentsPlacement = .{
        ._value = 9,
    };
    pub const Left: NSViewLayerContentsPlacement = .{
        ._value = 10,
    };
    pub const TopLeft: NSViewLayerContentsPlacement = .{
        ._value = 11,
    };

    _value: NSInteger,
};

pub const NSBorderType = struct {
    pub const No: NSBorderType = .{
        ._value = 0,
    };
    pub const Line: NSBorderType = .{
        ._value = 1,
    };
    pub const Bezel: NSBorderType = .{
        ._value = 2,
    };
    pub const Groove: NSBorderType = .{
        ._value = 3,
    };

    _value: NSUInteger,
};
