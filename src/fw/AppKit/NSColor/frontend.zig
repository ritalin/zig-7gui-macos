const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const coreGraphics = @import("CoreGraphics");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSAppKitVersion = appKit.NSAppKitVersion;
const NSPasteboardReading = appKit.NSPasteboardReading;
const NSPasteboardWriting = appKit.NSPasteboardWriting;
const CGColorRef = coreGraphics.CGColorRef;
const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSNotificationName = foundation.NSNotificationName;
const NSSecureCoding = foundation.NSSecureCoding;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;

pub const NSAppKitVersionNumberWithPatternColorLeakFix: NSAppKitVersion = 641.0;

pub const NSColor = struct {
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

    pub fn @"type"(self: Self) NSColorType {
        return runtime_support.toEnum(NSColorType, backend.NSColorMessages.type(runtime_support.objectId(NSColor, self)));
    }

    pub fn blackColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.blackColor());
    }

    pub fn darkGrayColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.darkGrayColor());
    }

    pub fn lightGrayColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.lightGrayColor());
    }

    pub fn whiteColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.whiteColor());
    }

    pub fn grayColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.grayColor());
    }

    pub fn redColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.redColor());
    }

    pub fn greenColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.greenColor());
    }

    pub fn blueColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.blueColor());
    }

    pub fn cyanColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.cyanColor());
    }

    pub fn yellowColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.yellowColor());
    }

    pub fn magentaColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.magentaColor());
    }

    pub fn orangeColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.orangeColor());
    }

    pub fn purpleColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.purpleColor());
    }

    pub fn brownColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.brownColor());
    }

    pub fn clearColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.clearColor());
    }

    pub fn labelColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.labelColor());
    }

    pub fn secondaryLabelColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.secondaryLabelColor());
    }

    pub fn tertiaryLabelColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.tertiaryLabelColor());
    }

    pub fn quaternaryLabelColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.quaternaryLabelColor());
    }

    pub fn linkColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.linkColor());
    }

    pub fn placeholderTextColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.placeholderTextColor());
    }

    pub fn windowFrameTextColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.windowFrameTextColor());
    }

    pub fn selectedMenuItemTextColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.selectedMenuItemTextColor());
    }

    pub fn alternateSelectedControlTextColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.alternateSelectedControlTextColor());
    }

    pub fn headerTextColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.headerTextColor());
    }

    pub fn separatorColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.separatorColor());
    }

    pub fn gridColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.gridColor());
    }

    pub fn windowBackgroundColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.windowBackgroundColor());
    }

    pub fn underPageBackgroundColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.underPageBackgroundColor());
    }

    pub fn controlBackgroundColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.controlBackgroundColor());
    }

    pub fn selectedContentBackgroundColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.selectedContentBackgroundColor());
    }

    pub fn unemphasizedSelectedContentBackgroundColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.unemphasizedSelectedContentBackgroundColor());
    }

    pub fn findHighlightColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.findHighlightColor());
    }

    pub fn textColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.textColor());
    }

    pub fn textBackgroundColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.textBackgroundColor());
    }

    pub fn selectedTextColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.selectedTextColor());
    }

    pub fn selectedTextBackgroundColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.selectedTextBackgroundColor());
    }

    pub fn unemphasizedSelectedTextBackgroundColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.unemphasizedSelectedTextBackgroundColor());
    }

    pub fn unemphasizedSelectedTextColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.unemphasizedSelectedTextColor());
    }

    pub fn controlColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.controlColor());
    }

    pub fn controlTextColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.controlTextColor());
    }

    pub fn selectedControlColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.selectedControlColor());
    }

    pub fn selectedControlTextColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.selectedControlTextColor());
    }

    pub fn disabledControlTextColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.disabledControlTextColor());
    }

    pub fn keyboardFocusIndicatorColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.keyboardFocusIndicatorColor());
    }

    pub fn scrubberTexturedBackgroundColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.scrubberTexturedBackgroundColor());
    }

    pub fn systemRedColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.systemRedColor());
    }

    pub fn systemGreenColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.systemGreenColor());
    }

    pub fn systemBlueColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.systemBlueColor());
    }

    pub fn systemOrangeColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.systemOrangeColor());
    }

    pub fn systemYellowColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.systemYellowColor());
    }

    pub fn systemBrownColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.systemBrownColor());
    }

    pub fn systemPinkColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.systemPinkColor());
    }

    pub fn systemPurpleColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.systemPurpleColor());
    }

    pub fn systemGrayColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.systemGrayColor());
    }

    pub fn systemTealColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.systemTealColor());
    }

    pub fn systemIndigoColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.systemIndigoColor());
    }

    pub fn controlAccentColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.controlAccentColor());
    }

    pub fn highlightColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.highlightColor());
    }

    pub fn shadowColor() NSColor {
        return runtime_support.wrapObject(NSColor, backend.NSColorMessages.shadowColor());
    }

    pub fn colorWithCGColor(_cgColor: CGColorRef) ?NSColor {
        return runtime_support.wrapObject(?NSColor, backend.NSColorMessages.colorWithCGColor(runtime_support.pass(CGColorRef, _cgColor)));
    }

    pub fn cgColor(self: Self) CGColorRef {
        return backend.NSColorMessages.cgColor(runtime_support.objectId(NSColor, self));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSColorMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSColor,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSCopying,
                NSPasteboardReading,
                NSPasteboardWriting,
                NSSecureCoding,
                NSCoding,
                NSObjectProtocol,
            });
        }
    };
};

pub const NSColorSystemEffect = struct {
    pub const None: NSColorSystemEffect = .{
        ._value = 0x0,
    };
    pub const Pressed: NSColorSystemEffect = .{
        ._value = 0x1,
    };
    pub const DeepPressed: NSColorSystemEffect = .{
        ._value = 0x2,
    };
    pub const Disabled: NSColorSystemEffect = .{
        ._value = 0x3,
    };
    pub const Rollover: NSColorSystemEffect = .{
        ._value = 0x4,
    };

    _value: NSInteger,
};

pub const NSColorType = struct {
    pub const ComponentBased: NSColorType = .{
        ._value = 0x0,
    };
    pub const Pattern: NSColorType = .{
        ._value = 0x1,
    };
    pub const Catalog: NSColorType = .{
        ._value = 0x2,
    };

    _value: NSInteger,
};
