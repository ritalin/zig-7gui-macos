const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const coreGraphics = @import("CoreGraphics");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const CGColorRef = coreGraphics.CGColorRef;
const NSInteger = runtime.NSInteger;

pub const NSColorMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSColor").?;
    }

    pub fn @"type"(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSColorSelectors.type(), .{});
    }

    pub fn blackColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.blackColor(), .{});
    }

    pub fn darkGrayColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.darkGrayColor(), .{});
    }

    pub fn lightGrayColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.lightGrayColor(), .{});
    }

    pub fn whiteColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.whiteColor(), .{});
    }

    pub fn grayColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.grayColor(), .{});
    }

    pub fn redColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.redColor(), .{});
    }

    pub fn greenColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.greenColor(), .{});
    }

    pub fn blueColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.blueColor(), .{});
    }

    pub fn cyanColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.cyanColor(), .{});
    }

    pub fn yellowColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.yellowColor(), .{});
    }

    pub fn magentaColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.magentaColor(), .{});
    }

    pub fn orangeColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.orangeColor(), .{});
    }

    pub fn purpleColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.purpleColor(), .{});
    }

    pub fn brownColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.brownColor(), .{});
    }

    pub fn clearColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.clearColor(), .{});
    }

    pub fn labelColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.labelColor(), .{});
    }

    pub fn secondaryLabelColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.secondaryLabelColor(), .{});
    }

    pub fn tertiaryLabelColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.tertiaryLabelColor(), .{});
    }

    pub fn quaternaryLabelColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.quaternaryLabelColor(), .{});
    }

    pub fn linkColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.linkColor(), .{});
    }

    pub fn placeholderTextColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.placeholderTextColor(), .{});
    }

    pub fn windowFrameTextColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.windowFrameTextColor(), .{});
    }

    pub fn selectedMenuItemTextColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.selectedMenuItemTextColor(), .{});
    }

    pub fn alternateSelectedControlTextColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.alternateSelectedControlTextColor(), .{});
    }

    pub fn headerTextColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.headerTextColor(), .{});
    }

    pub fn separatorColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.separatorColor(), .{});
    }

    pub fn gridColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.gridColor(), .{});
    }

    pub fn windowBackgroundColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.windowBackgroundColor(), .{});
    }

    pub fn underPageBackgroundColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.underPageBackgroundColor(), .{});
    }

    pub fn controlBackgroundColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.controlBackgroundColor(), .{});
    }

    pub fn selectedContentBackgroundColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.selectedContentBackgroundColor(), .{});
    }

    pub fn unemphasizedSelectedContentBackgroundColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.unemphasizedSelectedContentBackgroundColor(), .{});
    }

    pub fn findHighlightColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.findHighlightColor(), .{});
    }

    pub fn textColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.textColor(), .{});
    }

    pub fn textBackgroundColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.textBackgroundColor(), .{});
    }

    pub fn selectedTextColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.selectedTextColor(), .{});
    }

    pub fn selectedTextBackgroundColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.selectedTextBackgroundColor(), .{});
    }

    pub fn unemphasizedSelectedTextBackgroundColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.unemphasizedSelectedTextBackgroundColor(), .{});
    }

    pub fn unemphasizedSelectedTextColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.unemphasizedSelectedTextColor(), .{});
    }

    pub fn controlColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.controlColor(), .{});
    }

    pub fn controlTextColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.controlTextColor(), .{});
    }

    pub fn selectedControlColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.selectedControlColor(), .{});
    }

    pub fn selectedControlTextColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.selectedControlTextColor(), .{});
    }

    pub fn disabledControlTextColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.disabledControlTextColor(), .{});
    }

    pub fn keyboardFocusIndicatorColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.keyboardFocusIndicatorColor(), .{});
    }

    pub fn scrubberTexturedBackgroundColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.scrubberTexturedBackgroundColor(), .{});
    }

    pub fn systemRedColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.systemRedColor(), .{});
    }

    pub fn systemGreenColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.systemGreenColor(), .{});
    }

    pub fn systemBlueColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.systemBlueColor(), .{});
    }

    pub fn systemOrangeColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.systemOrangeColor(), .{});
    }

    pub fn systemYellowColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.systemYellowColor(), .{});
    }

    pub fn systemBrownColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.systemBrownColor(), .{});
    }

    pub fn systemPinkColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.systemPinkColor(), .{});
    }

    pub fn systemPurpleColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.systemPurpleColor(), .{});
    }

    pub fn systemGrayColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.systemGrayColor(), .{});
    }

    pub fn systemTealColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.systemTealColor(), .{});
    }

    pub fn systemIndigoColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.systemIndigoColor(), .{});
    }

    pub fn controlAccentColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.controlAccentColor(), .{});
    }

    pub fn highlightColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.highlightColor(), .{});
    }

    pub fn shadowColor() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSColorSelectors.shadowColor(), .{});
    }

    pub fn colorWithCGColor(_cgColor: CGColorRef) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(getClass().msgSend(objc.c.id, selector.NSColorSelectors.colorWithCGColor(), .{
            _cgColor,
        }));
    }

    pub fn cgColor(self: objc.Object) CGColorRef {
        return self.msgSend(CGColorRef, selector.NSColorSelectors.cgColor(), .{});
    }
};
