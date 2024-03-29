const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSAnimationCurve = struct {
    _value: NSUInteger,

    pub const EaseInOut: NSAnimationCurve = .{
        ._value = 0x0,
    };
    pub const EaseIn: NSAnimationCurve = .{
        ._value = 0x1,
    };
    pub const EaseOut: NSAnimationCurve = .{
        ._value = 0x2,
    };
    pub const Linear: NSAnimationCurve = .{
        ._value = 0x3,
    };
};

pub const NSAnimationBlockingMode = struct {
    _value: NSUInteger,

    pub const NSAnimationBlocking: NSAnimationBlockingMode = .{
        ._value = 0x0,
    };
    pub const Nonblocking: NSAnimationBlockingMode = .{
        ._value = 0x1,
    };
    pub const NonblockingThreaded: NSAnimationBlockingMode = .{
        ._value = 0x2,
    };
};

pub const NSAnimatablePropertyContainer = struct {
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
                            const class = backend.NSAnimatablePropertyContainerMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSAnimatablePropertyContainer.Protocol(ContextType).Dispatch(_delegate_handlers.handler_animatable_property_container).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSAnimatablePropertyContainerMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSAnimatablePropertyContainer, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSAnimatablePropertyContainer", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;
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
                handler_animatable_property_container: NSAnimatablePropertyContainer.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }

    pub const Self = @This();
};

pub const NSViewAnimationKey = NSString;
pub const NSViewAnimationEffectName = NSString;
pub const NSAnimatablePropertyKey = NSString;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSUInteger = runtime.NSUInteger;
