const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSColor = appKit.NSColor;
const NSControl = appKit.NSControl;
const NSControlTextEditingDelegate = appKit.NSControlTextEditingDelegate;
const NSResponder = appKit.NSResponder;
const NSView = appKit.NSView;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
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

    pub fn backgroundColor(self: Self) ?NSColor {
        return runtime.wrapOptionalObject(NSColor, backend.NSTextFieldMessages.backgroundColor(runtime.objectId(NSTextField, self)));
    }

    pub fn setBackgroundColor(self: Self, _backgroundColor: ?NSColor) void {
        return backend.NSTextFieldMessages.setBackgroundColor(runtime.objectId(NSTextField, self), runtime.objectIdOrNull(NSColor, _backgroundColor));
    }

    pub fn isEditable(self: Self) bool {
        return runtime.fromBOOL(backend.NSTextFieldMessages.isEditable(runtime.objectId(NSTextField, self)));
    }

    pub fn setEditable(self: Self, _editable: bool) void {
        return backend.NSTextFieldMessages.setEditable(runtime.objectId(NSTextField, self), runtime.toBOOL(_editable));
    }

    pub fn delegate(self: Self) ?NSTextFieldDelegate {
        return runtime.wrapOptionalObject(NSTextFieldDelegate, backend.NSTextFieldMessages.delegate(runtime.objectId(NSTextField, self)));
    }

    pub fn setDelegate(self: Self, _delegate: ?NSTextFieldDelegate) void {
        return backend.NSTextFieldMessages.setDelegate(runtime.objectId(NSTextField, self), runtime.objectIdOrNull(NSTextFieldDelegate, _delegate));
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
                NSObject,
                NSResponder,
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

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime.backend_support.concreteTypeName("NSTextFieldDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSTextFieldDelegateMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSControlTextEditingDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_control_text_editing_delegate).initClass(class);
                            NSTextFieldDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_field_delegate).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSTextFieldDelegateMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSTextFieldDelegate, _id);
                        runtime.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    pub fn initClass(_class: objc.Class) void {
                        _ = _delegate_handler;
                        _ = _class;
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_control_text_editing_delegate: NSControlTextEditingDelegate.Protocol(ContextType).Handler = .{},
                handler_text_field_delegate: NSTextFieldDelegate.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }
};
