const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSResponder = appKit.NSResponder;
const NSView = appKit.NSView;
const NSNotification = foundation.NSNotification;
const NSNotificationName = foundation.NSNotificationName;
const NSString = foundation.NSString;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const ObjectResolver = runtime.ObjectResolver;

pub const NSEnterCharacter: u8 = 0x0003;
pub const NSBackspaceCharacter: u8 = 0x0008;
pub const NSTabCharacter: u8 = 0x0009;
pub const NSNewlineCharacter: u8 = 0x000a;
pub const NSFormFeedCharacter: u8 = 0x000c;
pub const NSCarriageReturnCharacter: u8 = 0x000d;
pub const NSBackTabCharacter: u8 = 0x0019;
pub const NSDeleteCharacter: u8 = 0x007f;
pub const NSLineSeparatorCharacter: u8 = 0x2028;
pub const NSParagraphSeparatorCharacter: u8 = 0x2029;
pub const NSIllegalTextMovement: u8 = 0;
pub const NSReturnTextMovement: u8 = 0x10;
pub const NSTabTextMovement: u8 = 0x11;
pub const NSBacktabTextMovement: u8 = 0x12;
pub const NSLeftTextMovement: u8 = 0x13;
pub const NSRightTextMovement: u8 = 0x14;
pub const NSUpTextMovement: u8 = 0x15;
pub const NSDownTextMovement: u8 = 0x16;
pub const NSCancelTextMovement: u8 = 0x17;
pub const NSOtherTextMovement: u8 = 0;
pub const NSTextWritingDirectionEmbedding: u8 = (0 << 1);
pub const NSTextWritingDirectionOverride: u8 = (1 << 1);

pub const NSText = struct {
    pub const Self = @This();

    var DelegateResolver: ?*ObjectResolver(NSText) = null;

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

    pub fn string(self: Self) NSString {
        return runtime.wrapObject(NSString, backend.NSTextMessages.string(runtime.objectId(NSText, self)));
    }

    pub fn setString(self: Self, _string: NSString) void {
        return backend.NSTextMessages.setString(runtime.objectId(NSText, self), runtime.objectId(NSString, _string));
    }

    pub fn delegate(self: Self) ?NSTextDelegate {
        return runtime.wrapOptionalObject(NSTextDelegate, backend.NSTextMessages.delegate(runtime.objectId(NSText, self)));
    }

    pub fn setDelegate(self: Self, _delegate: ?NSTextDelegate) void {
        return backend.NSTextMessages.setDelegate(runtime.objectId(NSText, self), runtime.objectIdOrNull(NSTextDelegate, _delegate));
    }

    pub fn isEditable(self: Self) bool {
        return runtime.fromBOOL(backend.NSTextMessages.isEditable(runtime.objectId(NSText, self)));
    }

    pub fn setEditable(self: Self, _editable: bool) void {
        return backend.NSTextMessages.setEditable(runtime.objectId(NSText, self), runtime.toBOOL(_editable));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSTextMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSObject,
                NSResponder,
                NSText,
                NSView,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};

pub const NSTextAlignment = struct {
    pub const Left: NSTextAlignment = .{
        ._value = 0,
    };
    pub const Right: NSTextAlignment = .{
        ._value = 1,
    };
    pub const Center: NSTextAlignment = .{
        ._value = 2,
    };
    pub const Justified: NSTextAlignment = .{
        ._value = 3,
    };
    pub const Natural: NSTextAlignment = .{
        ._value = 4,
    };

    _value: NSInteger,
};

pub const NSTextMovement = struct {
    pub const Return: NSTextMovement = .{
        ._value = 0x10,
    };
    pub const Tab: NSTextMovement = .{
        ._value = 0x11,
    };
    pub const Backtab: NSTextMovement = .{
        ._value = 0x12,
    };
    pub const Left: NSTextMovement = .{
        ._value = 0x13,
    };
    pub const Right: NSTextMovement = .{
        ._value = 0x14,
    };
    pub const Up: NSTextMovement = .{
        ._value = 0x15,
    };
    pub const Down: NSTextMovement = .{
        ._value = 0x16,
    };
    pub const Cancel: NSTextMovement = .{
        ._value = 0x17,
    };
    pub const Other: NSTextMovement = .{
        ._value = 0,
    };

    _value: NSInteger,
};

pub const NSWritingDirection = struct {
    pub const Natural: NSWritingDirection = .{
        ._value = -1,
    };
    pub const LeftToRight: NSWritingDirection = .{
        ._value = 0,
    };
    pub const RightToLeft: NSWritingDirection = .{
        ._value = 1,
    };

    _value: NSInteger,
};

pub const NSTextDelegate = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime.backend_support.concreteTypeName("NSTextDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSTextDelegateMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            NSTextDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_delegate).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSTextDelegateMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSTextDelegate, _id);
                        runtime.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchTextDidChange(_id: objc.c.id, _: objc.c.SEL, _notification: objc.c.id) void {
                        if (_delegate_handler.textDidChange) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var notification = runtime.wrapObject(NSNotification, objc.Object.fromId(_notification));
                            return handler(context, notification) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.textDidChange != null) {
                            backend.NSTextDelegateMessages.registerTextDidChange(_class, &dispatchTextDidChange);
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
                handler_text_delegate: NSTextDelegate.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                textDidChange: ?(*const fn (context: *ContextType, _notification: NSNotification) anyerror!void) = null,
            };
        };
    }
};
