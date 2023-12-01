const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSObject = runtime.NSObject;

pub const NSUserInterfaceValidations = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime_support.backend_support.concreteTypeName("NSUserInterfaceValidations", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSUserInterfaceValidationsMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSUserInterfaceValidations.Protocol(ContextType).Dispatch(_delegate_handlers.handler_user_interface_validations).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSUserInterfaceValidationsMessages.init(_class.?);
                        var _instance = runtime_support.wrapObject(NSUserInterfaceValidations, _id);
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
                handler_user_interface_validations: NSUserInterfaceValidations.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }
};

pub const NSValidatedUserInterfaceItem = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime_support.backend_support.concreteTypeName("NSValidatedUserInterfaceItem", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSValidatedUserInterfaceItemMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSValidatedUserInterfaceItem.Protocol(ContextType).Dispatch(_delegate_handlers.handler_validated_user_interface_item).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSValidatedUserInterfaceItemMessages.init(_class.?);
                        var _instance = runtime_support.wrapObject(NSValidatedUserInterfaceItem, _id);
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
                handler_validated_user_interface_item: NSValidatedUserInterfaceItem.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }
};
