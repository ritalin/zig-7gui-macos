const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSScrollView = struct {
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

    pub fn documentVisibleRect(self: Self) NSRect {
        return backend.NSScrollViewMessages.documentVisibleRect(runtime_support.objectId(NSScrollView, self));
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
        return runtime_support.wrapEnum(NSBorderType, NSUInteger, backend.NSScrollViewMessages.borderType(runtime_support.objectId(NSScrollView, self)));
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

    pub fn addFloatingSubviewForAxis(self: Self, _view: NSView, _axis: NSEventGestureAxis) void {
        return backend.NSScrollViewMessages.addFloatingSubviewForAxis(runtime_support.objectId(NSScrollView, self), runtime_support.objectId(NSView, _view), runtime_support.unwrapEnum(NSEventGestureAxis, NSInteger, _axis));
    }

    pub fn automaticallyAdjustsContentInsets(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSScrollViewMessages.automaticallyAdjustsContentInsets(runtime_support.objectId(NSScrollView, self)));
    }

    pub fn setAutomaticallyAdjustsContentInsets(self: Self, _automaticallyAdjustsContentInsets: bool) void {
        return backend.NSScrollViewMessages.setAutomaticallyAdjustsContentInsets(runtime_support.objectId(NSScrollView, self), runtime_support.toBOOL(_automaticallyAdjustsContentInsets));
    }

    pub fn contentInsets(self: Self) NSEdgeInsets {
        return backend.NSScrollViewMessages.contentInsets(runtime_support.objectId(NSScrollView, self));
    }

    pub fn setContentInsets(self: Self, _contentInsets: NSEdgeInsets) void {
        return backend.NSScrollViewMessages.setContentInsets(runtime_support.objectId(NSScrollView, self), runtime_support.pass(NSEdgeInsets, _contentInsets));
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

    pub const Self = @This();
};

pub const NSScrollViewFindBarPosition = struct {
    _value: NSInteger,

    pub const AboveHorizontalRuler: NSScrollViewFindBarPosition = .{
        ._value = 0,
    };
    pub const AboveContent: NSScrollViewFindBarPosition = .{
        ._value = 1,
    };
    pub const BelowContent: NSScrollViewFindBarPosition = .{
        ._value = 2,
    };
};

pub const NSScrollElasticity = struct {
    _value: NSInteger,

    pub const Automatic: NSScrollElasticity = .{
        ._value = 0,
    };
    pub const None: NSScrollElasticity = .{
        ._value = 1,
    };
    pub const Allowed: NSScrollElasticity = .{
        ._value = 2,
    };
};

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSBorderType = appKit.NSBorderType;
const NSClipView = appKit.NSClipView;
const NSDraggingDestination = appKit.NSDraggingDestination;
const NSEventGestureAxis = appKit.NSEventGestureAxis;
const NSResponder = appKit.NSResponder;
const NSTextFinderBarContainer = appKit.NSTextFinderBarContainer;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSView = appKit.NSView;
const NSCoding = foundation.NSCoding;
const NSEdgeInsets = foundation.NSEdgeInsets;
const NSRect = foundation.NSRect;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
