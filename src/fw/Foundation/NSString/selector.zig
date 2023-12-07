const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSSimpleCStringSelectors = struct {};

pub const NSStringSelectors = struct {
    var _sel_length: ?objc.Sel = null;
    var _sel_characterAtIndex: ?objc.Sel = null;

    pub fn length() objc.Sel {
        if (_sel_length == null) {
            _sel_length = objc.Sel.registerName("length");
        }
        return _sel_length.?;
    }

    pub fn characterAtIndex() objc.Sel {
        if (_sel_characterAtIndex == null) {
            _sel_characterAtIndex = objc.Sel.registerName("characterAtIndex:");
        }
        return _sel_characterAtIndex.?;
    }
};

pub const NSConstantStringSelectors = struct {};

pub const NSMutableStringSelectors = struct {};

pub const NSExtendedStringPropertyListParsingForNSStringSelectors = struct {};

pub const NSMutableStringExtensionMethodsForNSMutableStringSelectors = struct {};

pub const NSStringEncodingDetectionForNSStringSelectors = struct {};

pub const NSStringExtensionMethodsForNSStringSelectors = struct {
    var _sel_utf8String: ?objc.Sel = null;
    var _sel_initWithUTF8String: ?objc.Sel = null;

    pub fn utf8String() objc.Sel {
        if (_sel_utf8String == null) {
            _sel_utf8String = objc.Sel.registerName("UTF8String");
        }
        return _sel_utf8String.?;
    }

    pub fn initWithUTF8String() objc.Sel {
        if (_sel_initWithUTF8String == null) {
            _sel_initWithUTF8String = objc.Sel.registerName("initWithUTF8String:");
        }
        return _sel_initWithUTF8String.?;
    }
};

pub const NSItemProviderForNSStringSelectors = struct {};

pub const NSStringDeprecatedForNSStringSelectors = struct {};
