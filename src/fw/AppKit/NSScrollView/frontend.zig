const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSBorderType = appKit.NSBorderType;
const NSClipView = appKit.NSClipView;
const NSDraggingDestination = appKit.NSDraggingDestination;
const NSResponder = appKit.NSResponder;
const NSTextFinderBarContainer = appKit.NSTextFinderBarContainer;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSView = appKit.NSView;
const NSCoding = foundation.NSCoding;
const NSNotificationName = foundation.NSNotificationName;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const NSScrollView = struct {
    pub const Self = @This();

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

    pub fn documentView(self: Self) ?NSView {
        return runtime_support.wrapObject(?NSView, backend.NSScrollViewMessages.documentView(runtime_support.objectId(NSScrollView, self)));
    }

    pub fn setDocumentView(self: Self, _documentView: ?NSView) void {
        return backend.NSScrollViewMessages.setDocumentView(runtime_support.objectId(NSScrollView, self), runtime_support.objectId(?NSView, _documentView));
    }

    pub fn contentView(self: Self) NSClipView {
        return runtime_support.wrapObject(NSClipView, backend.NSScrollViewMessages.contentView(runtime_support.objectId(NSScrollView, self)));
    }

    pub fn setContentView(self: Self, _contentView: NSClipView) void {
        return backend.NSScrollViewMessages.setContentView(runtime_support.objectId(NSScrollView, self), runtime_support.objectId(NSClipView, _contentView));
    }

    pub fn borderType(self: Self) NSBorderType {
        return runtime_support.toEnum(NSBorderType, backend.NSScrollViewMessages.borderType(runtime_support.objectId(NSScrollView, self)));
    }

    pub fn setBorderType(self: Self, _borderType: NSBorderType) void {
        return backend.NSScrollViewMessages.setBorderType(runtime_support.objectId(NSScrollView, self), runtime_support.unwrapEnum(NSBorderType, NSUInteger, _borderType));
    }

    pub fn drawsBackground(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSScrollViewMessages.drawsBackground(runtime_support.objectId(NSScrollView, self)));
    }

    pub fn setDrawsBackground(self: Self, _drawsBackground: bool) void {
        return backend.NSScrollViewMessages.setDrawsBackground(runtime_support.objectId(NSScrollView, self), runtime_support.toBOOL(_drawsBackground));
    }

    pub fn hasVerticalScroller(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSScrollViewMessages.hasVerticalScroller(runtime_support.objectId(NSScrollView, self)));
    }

    pub fn setHasVerticalScroller(self: Self, _hasVerticalScroller: bool) void {
        return backend.NSScrollViewMessages.setHasVerticalScroller(runtime_support.objectId(NSScrollView, self), runtime_support.toBOOL(_hasVerticalScroller));
    }

    pub fn hasHorizontalScroller(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSScrollViewMessages.hasHorizontalScroller(runtime_support.objectId(NSScrollView, self)));
    }

    pub fn setHasHorizontalScroller(self: Self, _hasHorizontalScroller: bool) void {
        return backend.NSScrollViewMessages.setHasHorizontalScroller(runtime_support.objectId(NSScrollView, self), runtime_support.toBOOL(_hasHorizontalScroller));
    }

    pub fn autohidesScrollers(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSScrollViewMessages.autohidesScrollers(runtime_support.objectId(NSScrollView, self)));
    }

    pub fn setAutohidesScrollers(self: Self, _autohidesScrollers: bool) void {
        return backend.NSScrollViewMessages.setAutohidesScrollers(runtime_support.objectId(NSScrollView, self), runtime_support.toBOOL(_autohidesScrollers));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSScrollViewMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSScrollView,
                NSView,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSTextFinderBarContainer,
                NSObjectProtocol,
            });
        }
    };
};

pub const NSScrollViewFindBarPosition = struct {
    pub const AboveHorizontalRuler: NSScrollViewFindBarPosition = .{
        ._value = 0,
    };
    pub const AboveContent: NSScrollViewFindBarPosition = .{
        ._value = 1,
    };
    pub const BelowContent: NSScrollViewFindBarPosition = .{
        ._value = 2,
    };

    _value: NSInteger,
};

pub const NSScrollElasticity = struct {
    pub const Automatic: NSScrollElasticity = .{
        ._value = 0,
    };
    pub const None: NSScrollElasticity = .{
        ._value = 1,
    };
    pub const Allowed: NSScrollElasticity = .{
        ._value = 2,
    };

    _value: NSInteger,
};
