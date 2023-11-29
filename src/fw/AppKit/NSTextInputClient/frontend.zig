const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");

const NSObject = runtime.NSObject;

pub const NSTextInputClient = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime.backend_support.concreteTypeName("NSTextInputClient", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSTextInputClientMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSTextInputClient.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_input_client).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSTextInputClientMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSTextInputClient, _id);
                        runtime.ContextReg(ContextType).setContext(_id, context);
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
                handler_text_input_client: NSTextInputClient.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }
};
