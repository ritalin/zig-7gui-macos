const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTextStorageEditActions = runtime_support.EnumOptions(enum(NSUInteger) {
    EditedAttributes = (1 << 0),
    EditedCharacters = (1 << 1),
});

pub const NSTextStorage = struct {
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
            return backend.NSTextStorageMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSTextStorage,
                NSMutableAttributedString,
                NSAttributedString,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSSecureCoding,
                NSCoding,
            });
        }
    };

    pub const Self = @This();
};

const NSAttributedString = foundation.NSAttributedString;
const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSMutableAttributedString = foundation.NSMutableAttributedString;
const NSMutableCopying = foundation.NSMutableCopying;
const NSSecureCoding = foundation.NSSecureCoding;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
