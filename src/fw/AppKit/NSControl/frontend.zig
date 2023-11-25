const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSResponder = appKit.NSResponder;
const NSTextAlignment = appKit.NSTextAlignment;
const NSView = appKit.NSView;
const NSNotification = foundation.NSNotification;
const NSNotificationName = foundation.NSNotificationName;
const NSRect = foundation.NSRect;
const NSString = foundation.NSString;
const BOOL = runtime.BOOL;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;

pub const NSControl = struct {
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

    pub fn target(self: Self) ?objc.Object {
        return backend.NSControlMessages.target(runtime.objectId(NSControl, self));
    }

    pub fn setTarget(self: Self, _target: ?objc.Object) void {
        return backend.NSControlMessages.setTarget(runtime.objectId(NSControl, self), _target);
    }

    pub fn action(self: Self) ?objc.Sel {
        return backend.NSControlMessages.action(runtime.objectId(NSControl, self));
    }

    pub fn setAction(self: Self, _action: ?objc.Sel) void {
        return backend.NSControlMessages.setAction(runtime.objectId(NSControl, self), _action);
    }

    pub fn isEnabled(self: Self) bool {
        return runtime.fromBOOL(backend.NSControlMessages.isEnabled(runtime.objectId(NSControl, self)));
    }

    pub fn setEnabled(self: Self, _enabled: bool) void {
        return backend.NSControlMessages.setEnabled(runtime.objectId(NSControl, self), runtime.toBOOL(_enabled));
    }

    pub fn stringValue(self: Self) NSString {
        return runtime.wrapObject(NSString, backend.NSControlMessages.stringValue(runtime.objectId(NSControl, self)));
    }

    pub fn setStringValue(self: Self, _stringValue: NSString) void {
        return backend.NSControlMessages.setStringValue(runtime.objectId(NSControl, self), runtime.objectId(NSString, _stringValue));
    }

    pub fn intValue(self: Self) c_int {
        return backend.NSControlMessages.intValue(runtime.objectId(NSControl, self));
    }

    pub fn setIntValue(self: Self, _intValue: c_int) void {
        return backend.NSControlMessages.setIntValue(runtime.objectId(NSControl, self), _intValue);
    }

    pub fn integerValue(self: Self) NSInteger {
        return backend.NSControlMessages.integerValue(runtime.objectId(NSControl, self));
    }

    pub fn setIntegerValue(self: Self, _integerValue: NSInteger) void {
        return backend.NSControlMessages.setIntegerValue(runtime.objectId(NSControl, self), runtime.pass(NSInteger, _integerValue));
    }

    pub fn floatValue(self: Self) f32 {
        return backend.NSControlMessages.floatValue(runtime.objectId(NSControl, self));
    }

    pub fn setFloatValue(self: Self, _floatValue: f32) void {
        return backend.NSControlMessages.setFloatValue(runtime.objectId(NSControl, self), _floatValue);
    }

    pub fn doubleValue(self: Self) f64 {
        return backend.NSControlMessages.doubleValue(runtime.objectId(NSControl, self));
    }

    pub fn setDoubleValue(self: Self, _doubleValue: f64) void {
        return backend.NSControlMessages.setDoubleValue(runtime.objectId(NSControl, self), _doubleValue);
    }

    pub fn alignment(self: Self) NSTextAlignment {
        return runtime.toEnum(NSTextAlignment, backend.NSControlMessages.alignment(runtime.objectId(NSControl, self)));
    }

    pub fn setAlignment(self: Self, _alignment: NSTextAlignment) void {
        return backend.NSControlMessages.setAlignment(runtime.objectId(NSControl, self), runtime.unwrapEnum(NSTextAlignment, NSInteger, _alignment));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithFrame(_frameRect: NSRect) DesiredType {
                var _class = DesiredType.Support.getClass();
                return runtime.wrapObject(DesiredType, backend.NSControlMessages.initWithFrame(_class, runtime.pass(NSRect, _frameRect)));
            }
        };
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSControlMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSControl,
                NSObject,
                NSResponder,
                NSView,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};

pub const NSControlTextEditingDelegate = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime.backend_support.concreteTypeName("NSControlTextEditingDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSControlTextEditingDelegateMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSControlTextEditingDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_control_text_editing_delegate).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSControlTextEditingDelegateMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSControlTextEditingDelegate, _id);
                        runtime.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchControlTextDidChange(_id: objc.c.id, _: objc.c.SEL, _obj: objc.c.id) void {
                        if (_delegate_handler.controlTextDidChange) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var obj = runtime.wrapObject(NSNotification, objc.Object.fromId(_obj));
                            return handler(context, obj) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.controlTextDidChange != null) {
                            backend.NSControlTextEditingDelegateMessages.registerControlTextDidChange(_class, &dispatchControlTextDidChange);
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_control_text_editing_delegate: NSControlTextEditingDelegate.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                controlTextDidChange: ?(*const fn (context: *ContextType, _obj: NSNotification) anyerror!void) = null,
            };
        };
    }
};
