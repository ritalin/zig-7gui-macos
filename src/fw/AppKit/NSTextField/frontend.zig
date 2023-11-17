const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSControl = appKit.NSControl;
const NSView = appKit.NSView;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const ObjectResolver = runtime.ObjectResolver;

pub const NSTextField = struct {
    pub const Self = @This();
    pub const Convenience = NSTextFieldConvenienceForNSTextField;

    var DelegateResolver: ?*ObjectResolver(NSTextField) = null;

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

    pub fn isEditable(self: Self) bool {
        return runtime.fromBOOL(backend.NSTextFieldMessages.isEditable(runtime.objectId(NSTextField, self)));
    }

    pub fn setEditable(self: Self, _editable: bool) void {
        return backend.NSTextFieldMessages.setEditable(runtime.objectId(NSTextField, self), runtime.toBOOL(_editable));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSTextFieldMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSControl,
                NSTextField,
                NSView,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};

const NSTextFieldConvenienceForNSTextField = struct {
    const Category = @This();
    pub const Self = NSTextField;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn labelWithString(_stringValue: NSString) DesiredType {
                var _class = DesiredType.Support.getClass();
                return runtime.wrapObject(DesiredType, backend.NSTextFieldConvenienceForNSTextFieldMessages.labelWithString(_class, runtime.objectId(NSString, _stringValue)));
            }

            pub fn wrappingLabelWithString(_stringValue: NSString) DesiredType {
                var _class = DesiredType.Support.getClass();
                return runtime.wrapObject(DesiredType, backend.NSTextFieldConvenienceForNSTextFieldMessages.wrappingLabelWithString(_class, runtime.objectId(NSString, _stringValue)));
            }

            pub fn textFieldWithString(_stringValue: NSString) DesiredType {
                var _class = DesiredType.Support.getClass();
                return runtime.wrapObject(DesiredType, backend.NSTextFieldConvenienceForNSTextFieldMessages.textFieldWithString(_class, runtime.objectId(NSString, _stringValue)));
            }
        };
    }
};

pub const NSTextFieldDelegate = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub const Protocol = struct {
        pub fn Derive(comptime _delegate_handler: Handler, comptime SuffixIdSeed: type) type {
            return struct {
                const _class_name = runtime.backend_support.concreteTypeName("NSTextFieldDelegate", SuffixIdSeed.generateIdentifier());
                const _handler = _delegate_handler;
                var _class: ?objc.Class = null;

                pub fn init() Self {
                    if (_class == null) {
                        _class = backend.NSTextFieldDelegateMessages.initClass(_class_name);
                    }
                    var _id = backend.NSTextFieldDelegateMessages.init(_class.?);
                    var _instance = runtime.wrapObject(NSTextFieldDelegate, _id);
                    return _instance;
                }
            };
        }

        pub const Handler = struct {};
    };
};
