const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const quartzCore = @import("QuartzCore");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSAutoresizingMaskOptions = runtime_support.EnumOptions(enum(NSUInteger) {
    ViewMinXMargin = 1,
    ViewWidthSizable = 2,
    ViewMaxXMargin = 4,
    ViewMinYMargin = 8,
    ViewHeightSizable = 16,
    ViewMaxYMargin = 32,
});

pub const NSView = struct {
    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub inline fn as(self: Self, comptime DesiredType: type) DesiredType {
        return runtime_support.ObjectUpperCast(Self, Self.Constructor).as(self, DesiredType);
    }

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.ObjectUpperCast(Self, Self.Constructor).of(DesiredType);
    }

    pub fn superview(self: Self) ?NSView {
        return runtime_support.wrapObject(?NSView, backend.NSViewMessages.superview(runtime_support.objectId(NSView, self)));
    }

    pub fn addSubview(self: Self, _view: NSView) void {
        return backend.NSViewMessages.addSubview(runtime_support.objectId(NSView, self), runtime_support.objectId(NSView, _view));
    }

    pub fn setFrameOrigin(self: Self, _newOrigin: NSPoint) void {
        return backend.NSViewMessages.setFrameOrigin(runtime_support.objectId(NSView, self), runtime_support.pass(NSPoint, _newOrigin));
    }

    pub fn setFrameSize(self: Self, _newSize: NSSize) void {
        return backend.NSViewMessages.setFrameSize(runtime_support.objectId(NSView, self), runtime_support.pass(NSSize, _newSize));
    }

    pub fn frame(self: Self) NSRect {
        return backend.NSViewMessages.frame(runtime_support.objectId(NSView, self));
    }

    pub fn setFrame(self: Self, _frame: NSRect) void {
        return backend.NSViewMessages.setFrame(runtime_support.objectId(NSView, self), runtime_support.pass(NSRect, _frame));
    }

    pub fn bounds(self: Self) NSRect {
        return backend.NSViewMessages.bounds(runtime_support.objectId(NSView, self));
    }

    pub fn setBounds(self: Self, _bounds: NSRect) void {
        return backend.NSViewMessages.setBounds(runtime_support.objectId(NSView, self), runtime_support.pass(NSRect, _bounds));
    }

    pub fn wantsLayer(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSViewMessages.wantsLayer(runtime_support.objectId(NSView, self)));
    }

    pub fn setWantsLayer(self: Self, _wantsLayer: bool) void {
        return backend.NSViewMessages.setWantsLayer(runtime_support.objectId(NSView, self), runtime_support.toBOOL(_wantsLayer));
    }

    pub fn layer(self: Self) CALayer {
        return runtime_support.wrapObject(CALayer, backend.NSViewMessages.layer(runtime_support.objectId(NSView, self)));
    }

    pub fn setLayer(self: Self, _layer: CALayer) void {
        return backend.NSViewMessages.setLayer(runtime_support.objectId(NSView, self), runtime_support.objectId(CALayer, _layer));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithFrame(_frameRect: NSRect) DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(DesiredType, backend.NSViewMessages.initWithFrame(_class, runtime_support.pass(NSRect, _frameRect)));
            }
        };
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSViewMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSView,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSAccessibility,
                NSAccessibilityElement,
                NSAnimatablePropertyContainer,
                NSAppearanceCustomization,
                NSDraggingDestination,
                NSUserInterfaceItemIdentification,
                NSObjectProtocol,
            });
        }
    };

    pub const ForNSObject = struct {
        pub const LayerDelegateContentsScaleUpdating = NSLayerDelegateContentsScaleUpdatingForNSObject;
    };

    pub const Self = @This();
    pub const GestureRecognizer = NSGestureRecognizerForNSView;
};

const NSGestureRecognizerForNSView = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    pub fn addGestureRecognizer(self: Category, _gestureRecognizer: NSGestureRecognizer) void {
        return backend.NSGestureRecognizerForNSViewMessages.addGestureRecognizer(runtime_support.objectId(NSGestureRecognizerForNSView, self), runtime_support.objectId(NSGestureRecognizer, _gestureRecognizer));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSView;
};

const NSLayerDelegateContentsScaleUpdatingForNSObject = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSObject;
};

pub const NSViewLayerContentsRedrawPolicy = struct {
    _value: NSInteger,

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
};

pub const NSViewLayerContentsPlacement = struct {
    _value: NSInteger,

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
};

pub const NSBorderType = struct {
    _value: NSUInteger,

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
};

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSDraggingDestination = appKit.NSDraggingDestination;
const NSGestureRecognizer = appKit.NSGestureRecognizer;
const NSResponder = appKit.NSResponder;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSCoding = foundation.NSCoding;
const NSNotificationName = foundation.NSNotificationName;
const NSPoint = foundation.NSPoint;
const NSRect = foundation.NSRect;
const NSSize = foundation.NSSize;
const CALayer = quartzCore.CALayer;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
