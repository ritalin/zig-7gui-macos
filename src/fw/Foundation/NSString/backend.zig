const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const unichar = c_ushort;
const NSUInteger = runtime.NSUInteger;

pub const NSSimpleCStringSelectors = struct {};

pub const NSSimpleCStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSSimpleCString").?;
    }
};

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

pub const NSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }

    pub fn length(self: objc.Object) NSUInteger {
        return self.msgSend(NSUInteger, NSStringSelectors.length(), .{});
    }

    pub fn characterAtIndex(self: objc.Object, _index: NSUInteger) unichar {
        return self.msgSend(unichar, NSStringSelectors.characterAtIndex(), .{
            _index,
        });
    }
};

pub const NSConstantStringSelectors = struct {};

pub const NSConstantStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSConstantString").?;
    }
};

pub const NSMutableStringSelectors = struct {};

pub const NSMutableStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSMutableString").?;
    }
};

pub const NSExtendedStringPropertyListParsingForNSStringSelectors = struct {};

pub const NSExtendedStringPropertyListParsingForNSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }
};

pub const NSMutableStringExtensionMethodsForNSMutableStringSelectors = struct {};

pub const NSMutableStringExtensionMethodsForNSMutableStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSMutableString").?;
    }
};

pub const NSStringEncodingDetectionForNSStringSelectors = struct {};

pub const NSStringEncodingDetectionForNSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }
};

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

pub const NSStringExtensionMethodsForNSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }

    pub fn utf8String(self: objc.Object) [*c]const u8 {
        return self.msgSend([*c]const u8, NSStringExtensionMethodsForNSStringSelectors.utf8String(), .{});
    }

    pub fn initWithUTF8String(_class: objc.Class, _nullTerminatedCString: [*c]const u8) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(runtime_support.backend_support.allocInstance(_class).msgSend(objc.c.id, NSStringExtensionMethodsForNSStringSelectors.initWithUTF8String(), .{
            _nullTerminatedCString,
        }));
    }
};

pub const NSItemProviderForNSStringSelectors = struct {};

pub const NSItemProviderForNSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }
};

pub const NSStringDeprecatedForNSStringSelectors = struct {};

pub const NSStringDeprecatedForNSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }
};
