const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSAttributedStringKey = NSString;
const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSMutableCopying = foundation.NSMutableCopying;
const NSSecureCoding = foundation.NSSecureCoding;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const NSAttributedStringEnumerationOptions = std.enums.EnumSet(enum(NSUInteger) {
    Reverse = (1 << 1),
    LongestEffectiveRangeNotRequired = (1 << 20),
});

pub const NSAttributedString = struct {
    pub const Self = @This();
    pub const ExtendedAttributedString = NSExtendedAttributedStringForNSAttributedString;

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

    pub const Support = struct {
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
};

pub const NSMutableAttributedString = struct {
    pub const Self = @This();
    pub const ExtendedMutableAttributedString = NSExtendedMutableAttributedStringForNSMutableAttributedString;

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

    pub const Support = struct {
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
};

const NSExtendedAttributedStringForNSAttributedString = struct {
    const Category = @This();
    pub const Self = NSAttributedString;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithString(_str: NSString) DesiredType {
                var _class = DesiredType.Support.getClass();
                return runtime_support.wrapObject(DesiredType, backend.NSExtendedAttributedStringForNSAttributedStringMessages.initWithString(_class, runtime_support.objectId(NSString, _str)));
            }
        };
    }
};

const NSExtendedMutableAttributedStringForNSMutableAttributedString = struct {
    const Category = @This();
    pub const Self = NSMutableAttributedString;

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
};
