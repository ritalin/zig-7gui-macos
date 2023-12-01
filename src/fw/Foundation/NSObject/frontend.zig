const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSObject = runtime.NSObject;

pub const NSCopying = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime_support.backend_support.concreteTypeName("NSCopying", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSCopyingMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSCopying.Protocol(ContextType).Dispatch(_delegate_handlers.handler_copying).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSCopyingMessages.init(_class.?);
                        var _instance = runtime_support.wrapObject(NSCopying, _id);
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
                handler_copying: NSCopying.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }
};
