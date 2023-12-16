const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSEnumerationOptions = foundation.NSEnumerationOptions;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const NSDragOperation = std.enums.EnumSet(enum(NSUInteger) {
    Copy = 1,
    Link = 2,
    Generic = 4,
    Private = 8,
    Move = 16,
    Delete = 32,
    Every = 0xffffffffffffffff,
});

pub const NSSpringLoadingOptions = std.enums.EnumSet(enum(NSUInteger) {
    Enabled = 1 << 0,
    ContinuousActivation = 1 << 1,
    NoHover = 1 << 3,
});

pub const NSDraggingItemEnumerationOptions = std.enums.EnumSet(enum(NSUInteger) {
    Concurrent = NSEnumerationOptions.Concurrent,
    ClearNonenumeratedImages = (1 << 16),
});

pub const NSDraggingContext = struct {
    pub const OutsideApplication: NSDraggingContext = .{
        ._value = 0,
    };
    pub const WithinApplication: NSDraggingContext = .{
        ._value = 0x1,
    };

    _value: NSInteger,
};

pub const NSSpringLoadingHighlight = struct {
    pub const None: NSSpringLoadingHighlight = .{
        ._value = 0,
    };
    pub const Standard: NSSpringLoadingHighlight = .{
        ._value = 0x1,
    };
    pub const Emphasized: NSSpringLoadingHighlight = .{
        ._value = 0x2,
    };

    _value: NSInteger,
};

pub const NSDraggingFormation = struct {
    pub const Default: NSDraggingFormation = .{
        ._value = 0,
    };
    pub const None: NSDraggingFormation = .{
        ._value = 0x1,
    };
    pub const Pile: NSDraggingFormation = .{
        ._value = 0x2,
    };
    pub const List: NSDraggingFormation = .{
        ._value = 0x3,
    };
    pub const Stack: NSDraggingFormation = .{
        ._value = 0x4,
    };

    _value: NSInteger,
};

pub const NSDraggingSource = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime_support.backend_support.concreteTypeName("NSDraggingSource", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSDraggingSourceMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSDraggingSource.Protocol(ContextType).Dispatch(_delegate_handlers.handler_dragging_source).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSDraggingSourceMessages.init(_class.?);
                        var _instance = runtime_support.wrapObject(NSDraggingSource, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
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
                handler_dragging_source: NSDraggingSource.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }
};

pub const NSDraggingInfo = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime_support.backend_support.concreteTypeName("NSDraggingInfo", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSDraggingInfoMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSDraggingInfo.Protocol(ContextType).Dispatch(_delegate_handlers.handler_dragging_info).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSDraggingInfoMessages.init(_class.?);
                        var _instance = runtime_support.wrapObject(NSDraggingInfo, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
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
                handler_dragging_info: NSDraggingInfo.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }
};
