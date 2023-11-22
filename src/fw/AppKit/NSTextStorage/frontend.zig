const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

pub const NSTextStorageEditedOptions = NSUInteger;
const NSAttributedString = foundation.NSAttributedString;
const NSMutableAttributedString = foundation.NSMutableAttributedString;
const NSNotificationName = foundation.NSNotificationName;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
const ObjectResolver = runtime.ObjectResolver;

pub const NSTextStorageEditActions = std.enums.EnumSet(enum(NSUInteger) {
    EditedAttributes = (1 << 0),
    EditedCharacters = (1 << 1),
});

pub const NSTextStorage = struct {
    pub const Self = @This();

    var DelegateResolver: ?*ObjectResolver(NSTextStorage) = null;

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
            return backend.NSTextStorageMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSAttributedString,
                NSMutableAttributedString,
                NSObject,
                NSTextStorage,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};
