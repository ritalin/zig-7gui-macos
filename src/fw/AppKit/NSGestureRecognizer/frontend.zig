const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSGestureRecognizer = struct {
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
        return backend.NSGestureRecognizerMessages.target(runtime_support.objectId(NSGestureRecognizer, self));
    }

    pub fn setTarget(self: Self, _target: ?objc.Object) void {
        return backend.NSGestureRecognizerMessages.setTarget(runtime_support.objectId(NSGestureRecognizer, self), runtime_support.pass(?objc.Object, _target));
    }

    pub fn action(self: Self) ?objc.Sel {
        return backend.NSGestureRecognizerMessages.action(runtime_support.objectId(NSGestureRecognizer, self));
    }

    pub fn setAction(self: Self, _action: ?objc.Sel) void {
        return backend.NSGestureRecognizerMessages.setAction(runtime_support.objectId(NSGestureRecognizer, self), runtime_support.pass(?objc.Sel, _action));
    }

    pub fn state(self: Self) NSGestureRecognizerState {
        return runtime_support.wrapEnum(NSGestureRecognizerState, NSInteger, backend.NSGestureRecognizerMessages.state(runtime_support.objectId(NSGestureRecognizer, self)));
    }

    pub fn delegate(self: Self) ?NSGestureRecognizerDelegate {
        return runtime_support.wrapObject(?NSGestureRecognizerDelegate, backend.NSGestureRecognizerMessages.delegate(runtime_support.objectId(NSGestureRecognizer, self)));
    }

    pub fn setDelegate(self: Self, _delegate: ?NSGestureRecognizerDelegate) void {
        return backend.NSGestureRecognizerMessages.setDelegate(runtime_support.objectId(NSGestureRecognizer, self), runtime_support.objectId(?NSGestureRecognizerDelegate, _delegate));
    }

    pub fn pressureConfiguration(self: Self) NSPressureConfiguration {
        return runtime_support.wrapObject(NSPressureConfiguration, backend.NSGestureRecognizerMessages.pressureConfiguration(runtime_support.objectId(NSGestureRecognizer, self)));
    }

    pub fn setPressureConfiguration(self: Self, _pressureConfiguration: NSPressureConfiguration) void {
        return backend.NSGestureRecognizerMessages.setPressureConfiguration(runtime_support.objectId(NSGestureRecognizer, self), runtime_support.objectId(NSPressureConfiguration, _pressureConfiguration));
    }

    pub fn locationInView(self: Self, _view: ?NSView) NSPoint {
        return backend.NSGestureRecognizerMessages.locationInView(runtime_support.objectId(NSGestureRecognizer, self), runtime_support.objectId(?NSView, _view));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithTargetAction(_target: ?objc.Object, _action: ?objc.Sel) DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(DesiredType, backend.NSGestureRecognizerMessages.initWithTargetAction(_class, runtime_support.pass(?objc.Object, _target), runtime_support.pass(?objc.Sel, _action)));
            }
        };
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSGestureRecognizerMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSGestureRecognizer,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSCoding,
            });
        }
    };

    pub const Self = @This();
    pub const TouchBar = NSTouchBarForNSGestureRecognizer;
    pub const SubclassUse = NSSubclassUseForNSGestureRecognizer;
};

const NSTouchBarForNSGestureRecognizer = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSGestureRecognizer;
};

const NSSubclassUseForNSGestureRecognizer = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSGestureRecognizer;
};

pub const NSGestureRecognizerState = struct {
    _value: NSInteger,

    pub const Possible: NSGestureRecognizerState = .{
        ._value = 0x0,
    };
    pub const Began: NSGestureRecognizerState = .{
        ._value = 0x1,
    };
    pub const Changed: NSGestureRecognizerState = .{
        ._value = 0x2,
    };
    pub const Ended: NSGestureRecognizerState = .{
        ._value = 0x3,
    };
    pub const Cancelled: NSGestureRecognizerState = .{
        ._value = 0x4,
    };
    pub const Failed: NSGestureRecognizerState = .{
        ._value = 0x5,
    };
    pub const Recognized: NSGestureRecognizerState = .{
        ._value = NSGestureRecognizerState.Ended._value,
    };
};

pub const NSGestureRecognizerDelegate = struct {
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
                            const class = backend.NSGestureRecognizerDelegateMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSGestureRecognizerDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_gesture_recognizer_delegate).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSGestureRecognizerDelegateMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSGestureRecognizerDelegate, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSGestureRecognizerDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchGestureRecognizerShouldAttemptToRecognizeWithEvent(_id: objc.c.id, _: objc.c.SEL, _gestureRecognizer: objc.c.id, _event: objc.c.id) objc.c.BOOL {
                        if (_delegate_handler.gestureRecognizerShouldAttemptToRecognizeWithEvent) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const gestureRecognizer = runtime_support.wrapObject(NSGestureRecognizer, objc.Object.fromId(_gestureRecognizer));
                            const event = runtime_support.wrapObject(NSEvent, objc.Object.fromId(_event));
                            return runtime_support.toBOOL(handler(context, gestureRecognizer, event) catch {
                                unreachable;
                            });
                        }
                        unreachable;
                    }

                    fn dispatchGestureRecognizerShouldBegin(_id: objc.c.id, _: objc.c.SEL, _gestureRecognizer: objc.c.id) objc.c.BOOL {
                        if (_delegate_handler.gestureRecognizerShouldBegin) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const gestureRecognizer = runtime_support.wrapObject(NSGestureRecognizer, objc.Object.fromId(_gestureRecognizer));
                            return runtime_support.toBOOL(handler(context, gestureRecognizer) catch {
                                unreachable;
                            });
                        }
                        unreachable;
                    }

                    fn dispatchGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer(_id: objc.c.id, _: objc.c.SEL, _gestureRecognizer: objc.c.id, _otherGestureRecognizer: objc.c.id) objc.c.BOOL {
                        if (_delegate_handler.gestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const gestureRecognizer = runtime_support.wrapObject(NSGestureRecognizer, objc.Object.fromId(_gestureRecognizer));
                            const otherGestureRecognizer = runtime_support.wrapObject(NSGestureRecognizer, objc.Object.fromId(_otherGestureRecognizer));
                            return runtime_support.toBOOL(handler(context, gestureRecognizer, otherGestureRecognizer) catch {
                                unreachable;
                            });
                        }
                        unreachable;
                    }

                    fn dispatchGestureRecognizerShouldRequireFailureOfGestureRecognizer(_id: objc.c.id, _: objc.c.SEL, _gestureRecognizer: objc.c.id, _otherGestureRecognizer: objc.c.id) objc.c.BOOL {
                        if (_delegate_handler.gestureRecognizerShouldRequireFailureOfGestureRecognizer) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const gestureRecognizer = runtime_support.wrapObject(NSGestureRecognizer, objc.Object.fromId(_gestureRecognizer));
                            const otherGestureRecognizer = runtime_support.wrapObject(NSGestureRecognizer, objc.Object.fromId(_otherGestureRecognizer));
                            return runtime_support.toBOOL(handler(context, gestureRecognizer, otherGestureRecognizer) catch {
                                unreachable;
                            });
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.gestureRecognizerShouldAttemptToRecognizeWithEvent != null) {
                            backend.NSGestureRecognizerDelegateMessages.registerGestureRecognizerShouldAttemptToRecognizeWithEvent(_class, @constCast(&dispatchGestureRecognizerShouldAttemptToRecognizeWithEvent));
                        }
                        if (_delegate_handler.gestureRecognizerShouldBegin != null) {
                            backend.NSGestureRecognizerDelegateMessages.registerGestureRecognizerShouldBegin(_class, @constCast(&dispatchGestureRecognizerShouldBegin));
                        }
                        if (_delegate_handler.gestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer != null) {
                            backend.NSGestureRecognizerDelegateMessages.registerGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer(_class, @constCast(&dispatchGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer));
                        }
                        if (_delegate_handler.gestureRecognizerShouldRequireFailureOfGestureRecognizer != null) {
                            backend.NSGestureRecognizerDelegateMessages.registerGestureRecognizerShouldRequireFailureOfGestureRecognizer(_class, @constCast(&dispatchGestureRecognizerShouldRequireFailureOfGestureRecognizer));
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_gesture_recognizer_delegate: NSGestureRecognizerDelegate.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                gestureRecognizerShouldAttemptToRecognizeWithEvent: ?*const fn (context: *ContextType, _: NSGestureRecognizer, _: NSEvent) anyerror!bool = null,
                gestureRecognizerShouldBegin: ?*const fn (context: *ContextType, _: NSGestureRecognizer) anyerror!bool = null,
                gestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer: ?*const fn (context: *ContextType, _: NSGestureRecognizer, _: NSGestureRecognizer) anyerror!bool = null,
                gestureRecognizerShouldRequireFailureOfGestureRecognizer: ?*const fn (context: *ContextType, _: NSGestureRecognizer, _: NSGestureRecognizer) anyerror!bool = null,
            };
        };
    }

    pub const Self = @This();
};

const NSEvent = appKit.NSEvent;
const NSPressureConfiguration = appKit.NSPressureConfiguration;
const NSView = appKit.NSView;
const NSCoding = foundation.NSCoding;
const NSPoint = foundation.NSPoint;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
