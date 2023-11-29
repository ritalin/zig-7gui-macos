const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

pub const unichar = c_ushort;
pub const NSStringTransform = NSString;
pub const NSStringEncodingDetectionOptionsKey = NSString;
const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSExceptionName = foundation.NSExceptionName;
const NSMutableCopying = foundation.NSMutableCopying;
const NSSecureCoding = foundation.NSSecureCoding;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const NSStringEncodingConversionOptions = std.enums.EnumSet(enum(NSUInteger) {
    AllowLossy = 1,
    ExternalRepresentation = 2,
});

pub const NSStringCompareOptions = std.enums.EnumSet(enum(NSUInteger) {
    CaseInsensitiveSearch = 1,
    LiteralSearch = 2,
    BackwardsSearch = 4,
    AnchoredSearch = 8,
    NumericSearch = 64,
    DiacriticInsensitiveSearch = 128,
    WidthInsensitiveSearch = 256,
    ForcedOrderingSearch = 512,
    RegularExpressionSearch = 1024,
});

pub const NSStringEnumerationOptions = std.enums.EnumSet(enum(NSUInteger) {
    ByParagraphs = 1,
    ByComposedCharacterSequences = 2,
    ByWords = 3,
    BySentences = 4,
    ByCaretPositions = 5,
    ByDeletionClusters = 6,
    Reverse = 1 << 8,
    SubstringNotRequired = 1 << 9,
    Localized = 1 << 10,
});

pub const NSSimpleCString = struct {
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

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSSimpleCStringMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSSimpleCString,
                NSString,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};

pub const NSString = struct {
    pub const Self = @This();
    pub const ExtendedStringPropertyListParsing = NSExtendedStringPropertyListParsingForNSString;
    pub const EncodingDetection = NSStringEncodingDetectionForNSString;
    pub const ExtensionMethods = NSStringExtensionMethodsForNSString;
    pub const ItemProvider = NSItemProviderForNSString;
    pub const Deprecated = NSStringDeprecatedForNSString;

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

    pub fn length(self: Self) NSUInteger {
        return backend.NSStringMessages.length(runtime.objectId(NSString, self));
    }

    pub fn characterAtIndex(self: Self, _index: NSUInteger) unichar {
        return backend.NSStringMessages.characterAtIndex(runtime.objectId(NSString, self), runtime.pass(NSUInteger, _index));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSStringMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSString,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSCopying,
                NSMutableCopying,
                NSSecureCoding,
                NSCoding,
            });
        }
    };
};

pub const NSConstantString = struct {
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

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSConstantStringMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSConstantString,
                NSSimpleCString,
                NSString,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};

pub const NSMutableString = struct {
    pub const Self = @This();
    pub const ExtensionMethods = NSMutableStringExtensionMethodsForNSMutableString;

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

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSMutableStringMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSMutableString,
                NSString,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};

const NSExtendedStringPropertyListParsingForNSString = struct {
    const Category = @This();
    pub const Self = NSString;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSMutableStringExtensionMethodsForNSMutableString = struct {
    const Category = @This();
    pub const Self = NSMutableString;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSStringEncodingDetectionForNSString = struct {
    const Category = @This();
    pub const Self = NSString;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSStringExtensionMethodsForNSString = struct {
    const Category = @This();
    pub const Self = NSString;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    pub fn utf8String(self: Category) [*c]const u8 {
        return backend.NSStringExtensionMethodsForNSStringMessages.utf8String(runtime.objectId(NSStringExtensionMethodsForNSString, self));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithUTF8String(_nullTerminatedCString: [*c]const u8) ?DesiredType {
                var _class = DesiredType.Support.getClass();
                return runtime.wrapObject(?DesiredType, backend.NSStringExtensionMethodsForNSStringMessages.initWithUTF8String(_class, _nullTerminatedCString));
            }
        };
    }
};

const NSItemProviderForNSString = struct {
    const Category = @This();
    pub const Self = NSString;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSStringDeprecatedForNSString = struct {
    const Category = @This();
    pub const Self = NSString;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

pub const NSStringEncoding = struct {
    pub const ASCII: NSStringEncoding = .{
        ._value = 1,
    };
    pub const NEXTSTEP: NSStringEncoding = .{
        ._value = 2,
    };
    pub const JapaneseEUC: NSStringEncoding = .{
        ._value = 3,
    };
    pub const UTF8: NSStringEncoding = .{
        ._value = 4,
    };
    pub const ISOLatin1: NSStringEncoding = .{
        ._value = 5,
    };
    pub const Symbol: NSStringEncoding = .{
        ._value = 6,
    };
    pub const NonLossyASCII: NSStringEncoding = .{
        ._value = 7,
    };
    pub const ShiftJIS: NSStringEncoding = .{
        ._value = 8,
    };
    pub const ISOLatin2: NSStringEncoding = .{
        ._value = 9,
    };
    pub const Unicode: NSStringEncoding = .{
        ._value = 10,
    };
    pub const WindowsCP1251: NSStringEncoding = .{
        ._value = 11,
    };
    pub const WindowsCP1252: NSStringEncoding = .{
        ._value = 12,
    };
    pub const WindowsCP1253: NSStringEncoding = .{
        ._value = 13,
    };
    pub const WindowsCP1254: NSStringEncoding = .{
        ._value = 14,
    };
    pub const WindowsCP1250: NSStringEncoding = .{
        ._value = 15,
    };
    pub const ISO2022JP: NSStringEncoding = .{
        ._value = 21,
    };
    pub const MacOSRoman: NSStringEncoding = .{
        ._value = 30,
    };
    pub const UTF16: NSStringEncoding = .{
        ._value = NSStringEncoding.Unicode,
    };
    pub const UTF16BigEndian: NSStringEncoding = .{
        ._value = 0x90000100,
    };
    pub const UTF16LittleEndian: NSStringEncoding = .{
        ._value = 0x94000100,
    };
    pub const UTF32: NSStringEncoding = .{
        ._value = 0x8c000100,
    };
    pub const UTF32BigEndian: NSStringEncoding = .{
        ._value = 0x98000100,
    };
    pub const UTF32LittleEndian: NSStringEncoding = .{
        ._value = 0x9c000100,
    };
    pub const Proprietary: NSStringEncoding = .{
        ._value = 65536,
    };

    _value: NSUInteger,
};
