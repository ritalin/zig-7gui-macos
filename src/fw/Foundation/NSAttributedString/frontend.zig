const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSAttributedStringEnumerationOptions = runtime_support.EnumOptions(enum(NSUInteger) {
    Reverse = (1 << 1),
    LongestEffectiveRangeNotRequired = (1 << 20),
});

pub const NSAttributedString = struct {
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

    pub fn string(self: Self) NSString {
        return runtime_support.wrapObject(NSString, backend.NSAttributedStringMessages.string(runtime_support.objectId(NSAttributedString, self)));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSAttributedStringMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSAttributedString,
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
    pub const ExtendedAttributedString = NSExtendedAttributedStringForNSAttributedString;
};

pub const NSMutableAttributedString = struct {
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
            return backend.NSMutableAttributedStringMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSMutableAttributedString,
                NSAttributedString,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const Self = @This();
    pub const ExtendedMutableAttributedString = NSExtendedMutableAttributedStringForNSMutableAttributedString;
};

const NSExtendedAttributedStringForNSAttributedString = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithString(_str: NSString) DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(DesiredType, backend.NSExtendedAttributedStringForNSAttributedStringMessages.initWithString(_class, runtime_support.objectId(NSString, _str)));
            }
        };
    }

    const Category = @This();
    pub const Self = NSAttributedString;
};

const NSExtendedMutableAttributedStringForNSMutableAttributedString = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    pub fn setAttributedString(self: Category, _attrString: NSAttributedString) void {
        return backend.NSExtendedMutableAttributedStringForNSMutableAttributedStringMessages.setAttributedString(runtime_support.objectId(NSExtendedMutableAttributedStringForNSMutableAttributedString, self), runtime_support.objectId(NSAttributedString, _attrString));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSMutableAttributedString;
};

const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSMutableCopying = foundation.NSMutableCopying;
const NSSecureCoding = foundation.NSSecureCoding;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
