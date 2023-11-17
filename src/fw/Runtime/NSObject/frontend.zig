const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");

pub const NSObject = struct {
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
            return backend.NSObjectMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSObjectProtocol,
            });
        }
    };
};

pub const NSObjectProtocol = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub const Protocol = struct {
        pub fn Derive(comptime _delegate_handler: Handler, comptime SuffixIdSeed: type) type {
            return struct {
                const _class_name = runtime.backend_support.concreteTypeName("NSObjectProtocol", SuffixIdSeed.generateIdentifier());
                const _handler = _delegate_handler;
                var _class: ?objc.Class = null;

                pub fn init() Self {
                    if (_class == null) {
                        _class = backend.NSObjectProtocolMessages.initClass(_class_name);
                    }
                    var _id = backend.NSObjectProtocolMessages.init(_class.?);
                    var _instance = runtime.wrapObject(NSObjectProtocol, _id);
                    return _instance;
                }
            };
        }

        pub const Handler = struct {};
    };
};
