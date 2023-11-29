const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

pub const NSAppearanceName = NSString;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;

pub const NSAppearanceCustomization = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime.backend_support.concreteTypeName("NSAppearanceCustomization", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSAppearanceCustomizationMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSAppearanceCustomization.Protocol(ContextType).Dispatch(_delegate_handlers.handler_appearance_customization).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSAppearanceCustomizationMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSAppearanceCustomization, _id);
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
                handler_appearance_customization: NSAppearanceCustomization.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }
};
