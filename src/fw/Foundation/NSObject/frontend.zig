const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSCopying = struct {
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
                            const class = backend.NSCopyingMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSCopying.Protocol(ContextType).Dispatch(_delegate_handlers.handler_copying).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSCopyingMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSCopying, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSCopying", SuffixIdSeed.generateIdentifier());
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
                handler_copying: NSCopying.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }

    pub const Self = @This();
};

pub const NSCoding = struct {
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
                            const class = backend.NSCodingMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSCoding.Protocol(ContextType).Dispatch(_delegate_handlers.handler_coding).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSCodingMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSCoding, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSCoding", SuffixIdSeed.generateIdentifier());
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
                handler_coding: NSCoding.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }

    pub const Self = @This();
};

pub const NSSecureCoding = struct {
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
                            const class = backend.NSSecureCodingMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSSecureCoding.Protocol(ContextType).Dispatch(_delegate_handlers.handler_secure_coding).initClass(class);
                            NSCoding.Protocol(ContextType).Dispatch(_delegate_handlers.handler_coding).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSSecureCodingMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSSecureCoding, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSSecureCoding", SuffixIdSeed.generateIdentifier());
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
                handler_secure_coding: NSSecureCoding.Protocol(ContextType).Handler = .{},
                handler_coding: NSCoding.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }

    pub const Self = @This();
};

const NSObject = runtime.NSObject;
