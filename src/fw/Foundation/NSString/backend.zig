const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const unichar = c_ushort;
const NSUInteger = runtime.NSUInteger;

pub const NSSimpleCStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSSimpleCString").?;
    }
};

pub const NSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }

    pub fn length(self: objc.Object) NSUInteger {
        return self.msgSend(NSUInteger, selector.NSStringSelectors.length(), .{});
    }

    pub fn characterAtIndex(self: objc.Object, _index: NSUInteger) unichar {
        return self.msgSend(unichar, selector.NSStringSelectors.characterAtIndex(), .{
            _index,
        });
    }
};

pub const NSConstantStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSConstantString").?;
    }
};

pub const NSMutableStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSMutableString").?;
    }
};

pub const NSExtendedStringPropertyListParsingForNSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }
};

pub const NSMutableStringExtensionMethodsForNSMutableStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSMutableString").?;
    }
};

pub const NSStringEncodingDetectionForNSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }
};

pub const NSStringExtensionMethodsForNSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }

    pub fn utf8String(self: objc.Object) [*c]const u8 {
        return self.msgSend([*c]const u8, selector.NSStringExtensionMethodsForNSStringSelectors.utf8String(), .{});
    }

    pub fn initWithUTF8String(_class: objc.Class, _nullTerminatedCString: [*c]const u8) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(runtime_support.backend_support.allocInstance(_class).msgSend(objc.c.id, selector.NSStringExtensionMethodsForNSStringSelectors.initWithUTF8String(), .{
            _nullTerminatedCString,
        }));
    }
};

pub const NSItemProviderForNSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }
};

pub const NSStringDeprecatedForNSStringMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSString").?;
    }
};
