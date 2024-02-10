const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSStringEncodingConversionOptions = runtime_support.EnumOptions(enum(NSUInteger) {
    AllowLossy = 1,
    ExternalRepresentation = 2,
});

pub const NSStringCompareOptions = runtime_support.EnumOptions(enum(NSUInteger) {
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

pub const NSStringEnumerationOptions = runtime_support.EnumOptions(enum(NSUInteger) {
    ByParagraphs = 1,
    ByComposedCharacterSequences = 2,
    BySentences = 4,
    Reverse = 1 << 8,
    SubstringNotRequired = 1 << 9,
    Localized = 1 << 10,
});

pub const NSSimpleCString = struct {
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

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSSimpleCStringMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSSimpleCString,
                NSString,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const Self = @This();
};

pub const NSString = struct {
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

    pub fn length(self: Self) NSUInteger {
        return backend.NSStringMessages.length(runtime_support.objectId(NSString, self));
    }

    pub fn characterAtIndex(self: Self, _index: NSUInteger) unichar {
        return backend.NSStringMessages.characterAtIndex(runtime_support.objectId(NSString, self), runtime_support.pass(NSUInteger, _index));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSStringMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSString,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSCopying,
                NSMutableCopying,
                NSSecureCoding,
                NSCoding,
            });
        }
    };

    pub const Self = @This();
    pub const ExtendedStringPropertyListParsing = NSExtendedStringPropertyListParsingForNSString;
    pub const EncodingDetection = NSStringEncodingDetectionForNSString;
    pub const ExtensionMethods = NSStringExtensionMethodsForNSString;
    pub const ItemProvider = NSItemProviderForNSString;
};

pub const NSConstantString = struct {
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

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSConstantStringMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSConstantString,
                NSSimpleCString,
                NSString,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const Self = @This();
};

pub const NSMutableString = struct {
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

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSMutableStringMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSMutableString,
                NSString,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const Self = @This();
    pub const ExtensionMethods = NSMutableStringExtensionMethodsForNSMutableString;
};

const NSExtendedStringPropertyListParsingForNSString = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSString;
};

const NSMutableStringExtensionMethodsForNSMutableString = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSMutableString;
};

const NSStringEncodingDetectionForNSString = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSString;
};

const NSStringExtensionMethodsForNSString = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    pub fn utf8String(self: Category) [*c]const u8 {
        return backend.NSStringExtensionMethodsForNSStringMessages.utf8String(runtime_support.objectId(NSStringExtensionMethodsForNSString, self));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithUTF8String(_nullTerminatedCString: [*c]const u8) ?DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(?DesiredType, backend.NSStringExtensionMethodsForNSStringMessages.initWithUTF8String(_class, _nullTerminatedCString));
            }
        };
    }

    const Category = @This();
    pub const Self = NSString;
};

const NSItemProviderForNSString = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSString;
};

pub const NSStringEncoding = struct {
    _value: NSUInteger,

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
        ._value = NSStringEncoding.Unicode._value,
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
};

pub const unichar = *const c_ushort;
const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSMutableCopying = foundation.NSMutableCopying;
const NSSecureCoding = foundation.NSSecureCoding;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
