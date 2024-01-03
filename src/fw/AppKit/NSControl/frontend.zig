const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSControl = struct {
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

    pub fn target(self: Self) ?objc.Object {
        return backend.NSControlMessages.target(runtime_support.objectId(NSControl, self));
    }

    pub fn setTarget(self: Self, _target: ?objc.Object) void {
        return backend.NSControlMessages.setTarget(runtime_support.objectId(NSControl, self), runtime_support.pass(?objc.Object, _target));
    }

    pub fn action(self: Self) ?objc.Sel {
        return backend.NSControlMessages.action(runtime_support.objectId(NSControl, self));
    }

    pub fn setAction(self: Self, _action: ?objc.Sel) void {
        return backend.NSControlMessages.setAction(runtime_support.objectId(NSControl, self), runtime_support.pass(?objc.Sel, _action));
    }

    pub fn isEnabled(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSControlMessages.isEnabled(runtime_support.objectId(NSControl, self)));
    }

    pub fn setEnabled(self: Self, _enabled: bool) void {
        return backend.NSControlMessages.setEnabled(runtime_support.objectId(NSControl, self), runtime_support.toBOOL(_enabled));
    }

    pub fn stringValue(self: Self) NSString {
        return runtime_support.wrapObject(NSString, backend.NSControlMessages.stringValue(runtime_support.objectId(NSControl, self)));
    }

    pub fn setStringValue(self: Self, _stringValue: NSString) void {
        return backend.NSControlMessages.setStringValue(runtime_support.objectId(NSControl, self), runtime_support.objectId(NSString, _stringValue));
    }

    pub fn intValue(self: Self) c_int {
        return backend.NSControlMessages.intValue(runtime_support.objectId(NSControl, self));
    }

    pub fn setIntValue(self: Self, _intValue: c_int) void {
        return backend.NSControlMessages.setIntValue(runtime_support.objectId(NSControl, self), _intValue);
    }

    pub fn integerValue(self: Self) NSInteger {
        return backend.NSControlMessages.integerValue(runtime_support.objectId(NSControl, self));
    }

    pub fn setIntegerValue(self: Self, _integerValue: NSInteger) void {
        return backend.NSControlMessages.setIntegerValue(runtime_support.objectId(NSControl, self), runtime_support.pass(NSInteger, _integerValue));
    }

    pub fn floatValue(self: Self) f32 {
        return backend.NSControlMessages.floatValue(runtime_support.objectId(NSControl, self));
    }

    pub fn setFloatValue(self: Self, _floatValue: f32) void {
        return backend.NSControlMessages.setFloatValue(runtime_support.objectId(NSControl, self), _floatValue);
    }

    pub fn doubleValue(self: Self) f64 {
        return backend.NSControlMessages.doubleValue(runtime_support.objectId(NSControl, self));
    }

    pub fn setDoubleValue(self: Self, _doubleValue: f64) void {
        return backend.NSControlMessages.setDoubleValue(runtime_support.objectId(NSControl, self), _doubleValue);
    }

    pub fn sendActionOn(self: Self, _mask: NSEventMask) NSInteger {
        return backend.NSControlMessages.sendActionOn(runtime_support.objectId(NSControl, self), runtime_support.packOptions(NSEventMask, _mask));
    }

    pub fn sendActionTo(self: Self, _action: ?objc.Sel, _target: ?objc.Object) bool {
        return runtime_support.fromBOOL(backend.NSControlMessages.sendActionTo(runtime_support.objectId(NSControl, self), runtime_support.pass(?objc.Sel, _action), runtime_support.pass(?objc.Object, _target)));
    }

    pub fn alignment(self: Self) NSTextAlignment {
        return runtime_support.wrapEnum(NSTextAlignment, NSInteger, backend.NSControlMessages.alignment(runtime_support.objectId(NSControl, self)));
    }

    pub fn setAlignment(self: Self, _alignment: NSTextAlignment) void {
        return backend.NSControlMessages.setAlignment(runtime_support.objectId(NSControl, self), runtime_support.unwrapEnum(NSTextAlignment, NSInteger, _alignment));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithFrame(_frameRect: NSRect) DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(DesiredType, backend.NSControlMessages.initWithFrame(_class, runtime_support.pass(NSRect, _frameRect)));
            }
        };
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSControlMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSControl,
                NSView,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const Self = @This();
};

pub const NSControlTextEditingDelegate = struct {
    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            const class = backend.NSControlTextEditingDelegateMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSControlTextEditingDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_control_text_editing_delegate).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSControlTextEditingDelegateMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSControlTextEditingDelegate, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSControlTextEditingDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchControlTextDidChange(_id: objc.c.id, _: objc.c.SEL, _obj: objc.c.id) void {
                        if (_delegate_handler.controlTextDidChange) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const obj = runtime_support.wrapObject(NSNotification, objc.Object.fromId(_obj));
                            return handler(context, obj) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.controlTextDidChange != null) {
                            backend.NSControlTextEditingDelegateMessages.registerControlTextDidChange(_class, @constCast(&dispatchControlTextDidChange));
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_control_text_editing_delegate: NSControlTextEditingDelegate.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                controlTextDidChange: ?*const fn (context: *ContextType, _: NSNotification) anyerror!void = null,
            };
        };
    }

    pub const Self = @This();
};

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSDraggingDestination = appKit.NSDraggingDestination;
const NSEventMask = appKit.NSEventMask;
const NSResponder = appKit.NSResponder;
const NSTextAlignment = appKit.NSTextAlignment;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSView = appKit.NSView;
const NSCoding = foundation.NSCoding;
const NSNotification = foundation.NSNotification;
const NSNotificationName = foundation.NSNotificationName;
const NSRect = foundation.NSRect;
const NSString = foundation.NSString;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
