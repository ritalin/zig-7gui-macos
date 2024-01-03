const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSColorSelectors = struct {
    pub fn @"type"() objc.Sel {
        if (_sel_type == null) {
            _sel_type = objc.Sel.registerName("type");
        }
        return _sel_type.?;
    }

    pub fn blackColor() objc.Sel {
        if (_sel_blackColor == null) {
            _sel_blackColor = objc.Sel.registerName("blackColor");
        }
        return _sel_blackColor.?;
    }

    pub fn darkGrayColor() objc.Sel {
        if (_sel_darkGrayColor == null) {
            _sel_darkGrayColor = objc.Sel.registerName("darkGrayColor");
        }
        return _sel_darkGrayColor.?;
    }

    pub fn lightGrayColor() objc.Sel {
        if (_sel_lightGrayColor == null) {
            _sel_lightGrayColor = objc.Sel.registerName("lightGrayColor");
        }
        return _sel_lightGrayColor.?;
    }

    pub fn whiteColor() objc.Sel {
        if (_sel_whiteColor == null) {
            _sel_whiteColor = objc.Sel.registerName("whiteColor");
        }
        return _sel_whiteColor.?;
    }

    pub fn grayColor() objc.Sel {
        if (_sel_grayColor == null) {
            _sel_grayColor = objc.Sel.registerName("grayColor");
        }
        return _sel_grayColor.?;
    }

    pub fn redColor() objc.Sel {
        if (_sel_redColor == null) {
            _sel_redColor = objc.Sel.registerName("redColor");
        }
        return _sel_redColor.?;
    }

    pub fn greenColor() objc.Sel {
        if (_sel_greenColor == null) {
            _sel_greenColor = objc.Sel.registerName("greenColor");
        }
        return _sel_greenColor.?;
    }

    pub fn blueColor() objc.Sel {
        if (_sel_blueColor == null) {
            _sel_blueColor = objc.Sel.registerName("blueColor");
        }
        return _sel_blueColor.?;
    }

    pub fn cyanColor() objc.Sel {
        if (_sel_cyanColor == null) {
            _sel_cyanColor = objc.Sel.registerName("cyanColor");
        }
        return _sel_cyanColor.?;
    }

    pub fn yellowColor() objc.Sel {
        if (_sel_yellowColor == null) {
            _sel_yellowColor = objc.Sel.registerName("yellowColor");
        }
        return _sel_yellowColor.?;
    }

    pub fn magentaColor() objc.Sel {
        if (_sel_magentaColor == null) {
            _sel_magentaColor = objc.Sel.registerName("magentaColor");
        }
        return _sel_magentaColor.?;
    }

    pub fn orangeColor() objc.Sel {
        if (_sel_orangeColor == null) {
            _sel_orangeColor = objc.Sel.registerName("orangeColor");
        }
        return _sel_orangeColor.?;
    }

    pub fn purpleColor() objc.Sel {
        if (_sel_purpleColor == null) {
            _sel_purpleColor = objc.Sel.registerName("purpleColor");
        }
        return _sel_purpleColor.?;
    }

    pub fn brownColor() objc.Sel {
        if (_sel_brownColor == null) {
            _sel_brownColor = objc.Sel.registerName("brownColor");
        }
        return _sel_brownColor.?;
    }

    pub fn clearColor() objc.Sel {
        if (_sel_clearColor == null) {
            _sel_clearColor = objc.Sel.registerName("clearColor");
        }
        return _sel_clearColor.?;
    }

    pub fn labelColor() objc.Sel {
        if (_sel_labelColor == null) {
            _sel_labelColor = objc.Sel.registerName("labelColor");
        }
        return _sel_labelColor.?;
    }

    pub fn secondaryLabelColor() objc.Sel {
        if (_sel_secondaryLabelColor == null) {
            _sel_secondaryLabelColor = objc.Sel.registerName("secondaryLabelColor");
        }
        return _sel_secondaryLabelColor.?;
    }

    pub fn tertiaryLabelColor() objc.Sel {
        if (_sel_tertiaryLabelColor == null) {
            _sel_tertiaryLabelColor = objc.Sel.registerName("tertiaryLabelColor");
        }
        return _sel_tertiaryLabelColor.?;
    }

    pub fn quaternaryLabelColor() objc.Sel {
        if (_sel_quaternaryLabelColor == null) {
            _sel_quaternaryLabelColor = objc.Sel.registerName("quaternaryLabelColor");
        }
        return _sel_quaternaryLabelColor.?;
    }

    pub fn linkColor() objc.Sel {
        if (_sel_linkColor == null) {
            _sel_linkColor = objc.Sel.registerName("linkColor");
        }
        return _sel_linkColor.?;
    }

    pub fn placeholderTextColor() objc.Sel {
        if (_sel_placeholderTextColor == null) {
            _sel_placeholderTextColor = objc.Sel.registerName("placeholderTextColor");
        }
        return _sel_placeholderTextColor.?;
    }

    pub fn windowFrameTextColor() objc.Sel {
        if (_sel_windowFrameTextColor == null) {
            _sel_windowFrameTextColor = objc.Sel.registerName("windowFrameTextColor");
        }
        return _sel_windowFrameTextColor.?;
    }

    pub fn selectedMenuItemTextColor() objc.Sel {
        if (_sel_selectedMenuItemTextColor == null) {
            _sel_selectedMenuItemTextColor = objc.Sel.registerName("selectedMenuItemTextColor");
        }
        return _sel_selectedMenuItemTextColor.?;
    }

    pub fn alternateSelectedControlTextColor() objc.Sel {
        if (_sel_alternateSelectedControlTextColor == null) {
            _sel_alternateSelectedControlTextColor = objc.Sel.registerName("alternateSelectedControlTextColor");
        }
        return _sel_alternateSelectedControlTextColor.?;
    }

    pub fn headerTextColor() objc.Sel {
        if (_sel_headerTextColor == null) {
            _sel_headerTextColor = objc.Sel.registerName("headerTextColor");
        }
        return _sel_headerTextColor.?;
    }

    pub fn separatorColor() objc.Sel {
        if (_sel_separatorColor == null) {
            _sel_separatorColor = objc.Sel.registerName("separatorColor");
        }
        return _sel_separatorColor.?;
    }

    pub fn gridColor() objc.Sel {
        if (_sel_gridColor == null) {
            _sel_gridColor = objc.Sel.registerName("gridColor");
        }
        return _sel_gridColor.?;
    }

    pub fn windowBackgroundColor() objc.Sel {
        if (_sel_windowBackgroundColor == null) {
            _sel_windowBackgroundColor = objc.Sel.registerName("windowBackgroundColor");
        }
        return _sel_windowBackgroundColor.?;
    }

    pub fn underPageBackgroundColor() objc.Sel {
        if (_sel_underPageBackgroundColor == null) {
            _sel_underPageBackgroundColor = objc.Sel.registerName("underPageBackgroundColor");
        }
        return _sel_underPageBackgroundColor.?;
    }

    pub fn controlBackgroundColor() objc.Sel {
        if (_sel_controlBackgroundColor == null) {
            _sel_controlBackgroundColor = objc.Sel.registerName("controlBackgroundColor");
        }
        return _sel_controlBackgroundColor.?;
    }

    pub fn selectedContentBackgroundColor() objc.Sel {
        if (_sel_selectedContentBackgroundColor == null) {
            _sel_selectedContentBackgroundColor = objc.Sel.registerName("selectedContentBackgroundColor");
        }
        return _sel_selectedContentBackgroundColor.?;
    }

    pub fn unemphasizedSelectedContentBackgroundColor() objc.Sel {
        if (_sel_unemphasizedSelectedContentBackgroundColor == null) {
            _sel_unemphasizedSelectedContentBackgroundColor = objc.Sel.registerName("unemphasizedSelectedContentBackgroundColor");
        }
        return _sel_unemphasizedSelectedContentBackgroundColor.?;
    }

    pub fn findHighlightColor() objc.Sel {
        if (_sel_findHighlightColor == null) {
            _sel_findHighlightColor = objc.Sel.registerName("findHighlightColor");
        }
        return _sel_findHighlightColor.?;
    }

    pub fn textColor() objc.Sel {
        if (_sel_textColor == null) {
            _sel_textColor = objc.Sel.registerName("textColor");
        }
        return _sel_textColor.?;
    }

    pub fn textBackgroundColor() objc.Sel {
        if (_sel_textBackgroundColor == null) {
            _sel_textBackgroundColor = objc.Sel.registerName("textBackgroundColor");
        }
        return _sel_textBackgroundColor.?;
    }

    pub fn selectedTextColor() objc.Sel {
        if (_sel_selectedTextColor == null) {
            _sel_selectedTextColor = objc.Sel.registerName("selectedTextColor");
        }
        return _sel_selectedTextColor.?;
    }

    pub fn selectedTextBackgroundColor() objc.Sel {
        if (_sel_selectedTextBackgroundColor == null) {
            _sel_selectedTextBackgroundColor = objc.Sel.registerName("selectedTextBackgroundColor");
        }
        return _sel_selectedTextBackgroundColor.?;
    }

    pub fn unemphasizedSelectedTextBackgroundColor() objc.Sel {
        if (_sel_unemphasizedSelectedTextBackgroundColor == null) {
            _sel_unemphasizedSelectedTextBackgroundColor = objc.Sel.registerName("unemphasizedSelectedTextBackgroundColor");
        }
        return _sel_unemphasizedSelectedTextBackgroundColor.?;
    }

    pub fn unemphasizedSelectedTextColor() objc.Sel {
        if (_sel_unemphasizedSelectedTextColor == null) {
            _sel_unemphasizedSelectedTextColor = objc.Sel.registerName("unemphasizedSelectedTextColor");
        }
        return _sel_unemphasizedSelectedTextColor.?;
    }

    pub fn controlColor() objc.Sel {
        if (_sel_controlColor == null) {
            _sel_controlColor = objc.Sel.registerName("controlColor");
        }
        return _sel_controlColor.?;
    }

    pub fn controlTextColor() objc.Sel {
        if (_sel_controlTextColor == null) {
            _sel_controlTextColor = objc.Sel.registerName("controlTextColor");
        }
        return _sel_controlTextColor.?;
    }

    pub fn selectedControlColor() objc.Sel {
        if (_sel_selectedControlColor == null) {
            _sel_selectedControlColor = objc.Sel.registerName("selectedControlColor");
        }
        return _sel_selectedControlColor.?;
    }

    pub fn selectedControlTextColor() objc.Sel {
        if (_sel_selectedControlTextColor == null) {
            _sel_selectedControlTextColor = objc.Sel.registerName("selectedControlTextColor");
        }
        return _sel_selectedControlTextColor.?;
    }

    pub fn disabledControlTextColor() objc.Sel {
        if (_sel_disabledControlTextColor == null) {
            _sel_disabledControlTextColor = objc.Sel.registerName("disabledControlTextColor");
        }
        return _sel_disabledControlTextColor.?;
    }

    pub fn keyboardFocusIndicatorColor() objc.Sel {
        if (_sel_keyboardFocusIndicatorColor == null) {
            _sel_keyboardFocusIndicatorColor = objc.Sel.registerName("keyboardFocusIndicatorColor");
        }
        return _sel_keyboardFocusIndicatorColor.?;
    }

    pub fn scrubberTexturedBackgroundColor() objc.Sel {
        if (_sel_scrubberTexturedBackgroundColor == null) {
            _sel_scrubberTexturedBackgroundColor = objc.Sel.registerName("scrubberTexturedBackgroundColor");
        }
        return _sel_scrubberTexturedBackgroundColor.?;
    }

    pub fn systemRedColor() objc.Sel {
        if (_sel_systemRedColor == null) {
            _sel_systemRedColor = objc.Sel.registerName("systemRedColor");
        }
        return _sel_systemRedColor.?;
    }

    pub fn systemGreenColor() objc.Sel {
        if (_sel_systemGreenColor == null) {
            _sel_systemGreenColor = objc.Sel.registerName("systemGreenColor");
        }
        return _sel_systemGreenColor.?;
    }

    pub fn systemBlueColor() objc.Sel {
        if (_sel_systemBlueColor == null) {
            _sel_systemBlueColor = objc.Sel.registerName("systemBlueColor");
        }
        return _sel_systemBlueColor.?;
    }

    pub fn systemOrangeColor() objc.Sel {
        if (_sel_systemOrangeColor == null) {
            _sel_systemOrangeColor = objc.Sel.registerName("systemOrangeColor");
        }
        return _sel_systemOrangeColor.?;
    }

    pub fn systemYellowColor() objc.Sel {
        if (_sel_systemYellowColor == null) {
            _sel_systemYellowColor = objc.Sel.registerName("systemYellowColor");
        }
        return _sel_systemYellowColor.?;
    }

    pub fn systemBrownColor() objc.Sel {
        if (_sel_systemBrownColor == null) {
            _sel_systemBrownColor = objc.Sel.registerName("systemBrownColor");
        }
        return _sel_systemBrownColor.?;
    }

    pub fn systemPinkColor() objc.Sel {
        if (_sel_systemPinkColor == null) {
            _sel_systemPinkColor = objc.Sel.registerName("systemPinkColor");
        }
        return _sel_systemPinkColor.?;
    }

    pub fn systemPurpleColor() objc.Sel {
        if (_sel_systemPurpleColor == null) {
            _sel_systemPurpleColor = objc.Sel.registerName("systemPurpleColor");
        }
        return _sel_systemPurpleColor.?;
    }

    pub fn systemGrayColor() objc.Sel {
        if (_sel_systemGrayColor == null) {
            _sel_systemGrayColor = objc.Sel.registerName("systemGrayColor");
        }
        return _sel_systemGrayColor.?;
    }

    pub fn systemTealColor() objc.Sel {
        if (_sel_systemTealColor == null) {
            _sel_systemTealColor = objc.Sel.registerName("systemTealColor");
        }
        return _sel_systemTealColor.?;
    }

    pub fn systemIndigoColor() objc.Sel {
        if (_sel_systemIndigoColor == null) {
            _sel_systemIndigoColor = objc.Sel.registerName("systemIndigoColor");
        }
        return _sel_systemIndigoColor.?;
    }

    pub fn controlAccentColor() objc.Sel {
        if (_sel_controlAccentColor == null) {
            _sel_controlAccentColor = objc.Sel.registerName("controlAccentColor");
        }
        return _sel_controlAccentColor.?;
    }

    pub fn highlightColor() objc.Sel {
        if (_sel_highlightColor == null) {
            _sel_highlightColor = objc.Sel.registerName("highlightColor");
        }
        return _sel_highlightColor.?;
    }

    pub fn shadowColor() objc.Sel {
        if (_sel_shadowColor == null) {
            _sel_shadowColor = objc.Sel.registerName("shadowColor");
        }
        return _sel_shadowColor.?;
    }

    pub fn colorWithCGColor() objc.Sel {
        if (_sel_colorWithCGColor == null) {
            _sel_colorWithCGColor = objc.Sel.registerName("colorWithCGColor:");
        }
        return _sel_colorWithCGColor.?;
    }

    pub fn cgColor() objc.Sel {
        if (_sel_cgColor == null) {
            _sel_cgColor = objc.Sel.registerName("CGColor");
        }
        return _sel_cgColor.?;
    }

    var _sel_type: ?objc.Sel = null;
    var _sel_blackColor: ?objc.Sel = null;
    var _sel_darkGrayColor: ?objc.Sel = null;
    var _sel_lightGrayColor: ?objc.Sel = null;
    var _sel_whiteColor: ?objc.Sel = null;
    var _sel_grayColor: ?objc.Sel = null;
    var _sel_redColor: ?objc.Sel = null;
    var _sel_greenColor: ?objc.Sel = null;
    var _sel_blueColor: ?objc.Sel = null;
    var _sel_cyanColor: ?objc.Sel = null;
    var _sel_yellowColor: ?objc.Sel = null;
    var _sel_magentaColor: ?objc.Sel = null;
    var _sel_orangeColor: ?objc.Sel = null;
    var _sel_purpleColor: ?objc.Sel = null;
    var _sel_brownColor: ?objc.Sel = null;
    var _sel_clearColor: ?objc.Sel = null;
    var _sel_labelColor: ?objc.Sel = null;
    var _sel_secondaryLabelColor: ?objc.Sel = null;
    var _sel_tertiaryLabelColor: ?objc.Sel = null;
    var _sel_quaternaryLabelColor: ?objc.Sel = null;
    var _sel_linkColor: ?objc.Sel = null;
    var _sel_placeholderTextColor: ?objc.Sel = null;
    var _sel_windowFrameTextColor: ?objc.Sel = null;
    var _sel_selectedMenuItemTextColor: ?objc.Sel = null;
    var _sel_alternateSelectedControlTextColor: ?objc.Sel = null;
    var _sel_headerTextColor: ?objc.Sel = null;
    var _sel_separatorColor: ?objc.Sel = null;
    var _sel_gridColor: ?objc.Sel = null;
    var _sel_windowBackgroundColor: ?objc.Sel = null;
    var _sel_underPageBackgroundColor: ?objc.Sel = null;
    var _sel_controlBackgroundColor: ?objc.Sel = null;
    var _sel_selectedContentBackgroundColor: ?objc.Sel = null;
    var _sel_unemphasizedSelectedContentBackgroundColor: ?objc.Sel = null;
    var _sel_findHighlightColor: ?objc.Sel = null;
    var _sel_textColor: ?objc.Sel = null;
    var _sel_textBackgroundColor: ?objc.Sel = null;
    var _sel_selectedTextColor: ?objc.Sel = null;
    var _sel_selectedTextBackgroundColor: ?objc.Sel = null;
    var _sel_unemphasizedSelectedTextBackgroundColor: ?objc.Sel = null;
    var _sel_unemphasizedSelectedTextColor: ?objc.Sel = null;
    var _sel_controlColor: ?objc.Sel = null;
    var _sel_controlTextColor: ?objc.Sel = null;
    var _sel_selectedControlColor: ?objc.Sel = null;
    var _sel_selectedControlTextColor: ?objc.Sel = null;
    var _sel_disabledControlTextColor: ?objc.Sel = null;
    var _sel_keyboardFocusIndicatorColor: ?objc.Sel = null;
    var _sel_scrubberTexturedBackgroundColor: ?objc.Sel = null;
    var _sel_systemRedColor: ?objc.Sel = null;
    var _sel_systemGreenColor: ?objc.Sel = null;
    var _sel_systemBlueColor: ?objc.Sel = null;
    var _sel_systemOrangeColor: ?objc.Sel = null;
    var _sel_systemYellowColor: ?objc.Sel = null;
    var _sel_systemBrownColor: ?objc.Sel = null;
    var _sel_systemPinkColor: ?objc.Sel = null;
    var _sel_systemPurpleColor: ?objc.Sel = null;
    var _sel_systemGrayColor: ?objc.Sel = null;
    var _sel_systemTealColor: ?objc.Sel = null;
    var _sel_systemIndigoColor: ?objc.Sel = null;
    var _sel_controlAccentColor: ?objc.Sel = null;
    var _sel_highlightColor: ?objc.Sel = null;
    var _sel_shadowColor: ?objc.Sel = null;
    var _sel_colorWithCGColor: ?objc.Sel = null;
    var _sel_cgColor: ?objc.Sel = null;
};
