const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSMutableCopying = foundation.NSMutableCopying;
const NSSecureCoding = foundation.NSSecureCoding;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const NSMutableIndexSet = struct {
    pub const Self = @This();

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

    pub fn addIndex(self: Self, _value: NSUInteger) void {
        return backend.NSMutableIndexSetMessages.addIndex(runtime_support.objectId(NSMutableIndexSet, self), runtime_support.pass(NSUInteger, _value));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSMutableIndexSetMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSMutableIndexSet,
                NSIndexSet,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };
};

pub const NSIndexSet = struct {
    pub const Self = @This();

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

    pub fn count(self: Self) NSUInteger {
        return backend.NSIndexSetMessages.count(runtime_support.objectId(NSIndexSet, self));
    }

    pub fn containsIndex(self: Self, _value: NSUInteger) bool {
        return runtime_support.fromBOOL(backend.NSIndexSetMessages.containsIndex(runtime_support.objectId(NSIndexSet, self), runtime_support.pass(NSUInteger, _value)));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn indexSet() DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(DesiredType, backend.NSIndexSetMessages.indexSet(_class));
            }

            pub fn indexSetWithIndex(_value: NSUInteger) DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(DesiredType, backend.NSIndexSetMessages.indexSetWithIndex(_class, runtime_support.pass(NSUInteger, _value)));
            }
        };
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSIndexSetMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSIndexSet,
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
