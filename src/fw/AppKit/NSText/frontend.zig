const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSChangeSpelling = appKit.NSChangeSpelling;
const NSDraggingDestination = appKit.NSDraggingDestination;
const NSIgnoreMisspelledWords = appKit.NSIgnoreMisspelledWords;
const NSResponder = appKit.NSResponder;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSView = appKit.NSView;
const NSCoding = foundation.NSCoding;
const NSNotification = foundation.NSNotification;
const NSNotificationName = foundation.NSNotificationName;
const NSString = foundation.NSString;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;

pub const NSEnterCharacter: c_uint = 0x0003;
pub const NSBackspaceCharacter: c_uint = 0x0008;
pub const NSTabCharacter: c_uint = 0x0009;
pub const NSNewlineCharacter: c_uint = 0x000a;
pub const NSFormFeedCharacter: c_uint = 0x000c;
pub const NSCarriageReturnCharacter: c_uint = 0x000d;
pub const NSBackTabCharacter: c_uint = 0x0019;
pub const NSDeleteCharacter: c_uint = 0x007f;
pub const NSLineSeparatorCharacter: c_uint = 0x2028;
pub const NSParagraphSeparatorCharacter: c_uint = 0x2029;
pub const NSIllegalTextMovement: c_uint = 0;
pub const NSReturnTextMovement: c_uint = 0x10;
pub const NSTabTextMovement: c_uint = 0x11;
pub const NSBacktabTextMovement: c_uint = 0x12;
pub const NSLeftTextMovement: c_uint = 0x13;
pub const NSRightTextMovement: c_uint = 0x14;
pub const NSUpTextMovement: c_uint = 0x15;
pub const NSDownTextMovement: c_uint = 0x16;
pub const NSCancelTextMovement: c_uint = 0x17;
pub const NSOtherTextMovement: c_uint = 0;
pub const NSTextWritingDirectionEmbedding: c_uint = (0 << 1);
pub const NSTextWritingDirectionOverride: c_uint = (1 << 1);

pub const NSText = struct {
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

    pub fn string(self: Self) NSString {
        return runtime_support.wrapObject(NSString, backend.NSTextMessages.string(runtime_support.objectId(NSText, self)));
    }

    pub fn setString(self: Self, _string: NSString) void {
        return backend.NSTextMessages.setString(runtime_support.objectId(NSText, self), runtime_support.objectId(NSString, _string));
    }

    pub fn delegate(self: Self) ?NSTextDelegate {
        return runtime_support.wrapObject(?NSTextDelegate, backend.NSTextMessages.delegate(runtime_support.objectId(NSText, self)));
    }

    pub fn setDelegate(self: Self, _delegate: ?NSTextDelegate) void {
        return backend.NSTextMessages.setDelegate(runtime_support.objectId(NSText, self), runtime_support.objectId(?NSTextDelegate, _delegate));
    }

    pub fn isEditable(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSTextMessages.isEditable(runtime_support.objectId(NSText, self)));
    }

    pub fn setEditable(self: Self, _editable: bool) void {
        return backend.NSTextMessages.setEditable(runtime_support.objectId(NSText, self), runtime_support.toBOOL(_editable));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSTextMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSText,
                NSView,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSChangeSpelling,
                NSIgnoreMisspelledWords,
            });
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
                    const _class_name = runtime_support.backend_support.concreteTypeName("NSTextDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSTextDelegateMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSTextDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_delegate).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSTextDelegateMessages.init(_class.?);
                        var _instance = runtime_support.wrapObject(NSTextDelegate, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchTextDidChange(_id: objc.c.id, _: objc.c.SEL, _notification: objc.c.id) void {
                        if (_delegate_handler.textDidChange) |handler| {
                            var context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var notification = runtime_support.wrapObject(NSNotification, objc.Object.fromId(_notification));
                            return handler(context, notification) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.textDidChange != null) {
                            backend.NSTextDelegateMessages.registerTextDidChange(_class, @constCast(&dispatchTextDidChange));
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_text_delegate: NSTextDelegate.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                textDidChange: ?*const fn (context: *ContextType, _: NSNotification) anyerror!void = null,
            };
        };
    }
};
