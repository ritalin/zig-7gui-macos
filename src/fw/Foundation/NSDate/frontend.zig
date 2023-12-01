const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTimeInterval = f64;
const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSNotificationName = foundation.NSNotificationName;
const NSSecureCoding = foundation.NSSecureCoding;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;

pub const NSDate = struct {
    pub const Self = @This();
    pub const Creation = NSDateCreationForNSDate;
    pub const ExtendedDate = NSExtendedDateForNSDate;

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
            return backend.NSDateMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSDate,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSCopying,
                NSSecureCoding,
                NSCoding,
            });
        }
    };
};

const NSDateCreationForNSDate = struct {
    const Category = @This();
    pub const Self = NSDate;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSExtendedDateForNSDate = struct {
    const Category = @This();
    pub const Self = NSDate;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};
