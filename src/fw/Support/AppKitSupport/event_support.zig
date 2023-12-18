const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const HandlerSelectors = struct {
    var _sel_perform: ?objc.Sel = null;

    pub fn perform() objc.Sel {
        if (_sel_perform == null) {
            _sel_perform = objc.Sel.registerName("perform_handler:");
        }

        return _sel_perform.?;
    }
};

pub fn Handlers(comptime ContextType: type) type {
    return struct {
        pub fn Action(comptime SenderObject: type) type {
            return struct {
                const Self = @This();
                const HandlerType = *const fn (ctx: ?*ContextType, sender: SenderObject) anyerror!void;
                var _class: ?objc.Class = null;

                target: objc.Object,
                action: objc.Sel,

                pub fn init(ctx: *ContextType, handler: HandlerType) Self {
                    if (_class == null) {
                        const base = objc.getClass("NSObject").?;
                        const type_name = @typeName(@This());
                        const class = objc.allocateClassPair(base, type_name).?;

                        // register raw handler
                        {
                            runtime_support.backend_support.ObjectRegistry.registerMessage(class, "perform_handler:", runtime_support.wrapDelegateHandler(&perform_action), "v@:@");
                        }
                        // register context field
                        {
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                        }
                        // register user-side action handler
                        {
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "action");
                        }
                        objc.c.objc_registerClassPair(class.value);

                        _class = class;
                    }

                    const target = runtime_support.backend_support.allocInstance(_class.?);

                    var proxy = runtime_support.backend_support.ObjectProxy.init(target);
                    proxy.field("context").setAsPointer(*ContextType, ctx);
                    proxy.field("action").setAsPointer(HandlerType, handler);

                    return .{
                        .target = target,
                        .action = HandlerSelectors.perform(),
                    };
                }

                fn perform_action(self: objc.c.id, _: objc.c.SEL, sender: objc.c.id) callconv(.C) void {
                    var proxy = runtime_support.backend_support.ObjectProxy.init(objc.Object.fromId(self));
                    const ctx = proxy.field("context").asPointer(*ContextType);
                    const handler = proxy.field("action").asPointer(HandlerType);

                    if (handler) |h| {
                        h(ctx, runtime_support.wrapObject(SenderObject, objc.Object.fromId(sender))) catch @panic("Unhandled error.");
                    }
                }
            };
        }
    };
}
