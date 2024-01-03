const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSPasteboardWritingOptions = runtime_support.EnumOptions(enum(NSUInteger) {
    Promised = 1 << 9,
});

pub const NSPasteboardReadingOptions = runtime_support.EnumOptions(enum(NSUInteger) {
    AsString = 1 << 0,
    AsPropertyList = 1 << 1,
    AsKeyedArchive = 1 << 2,
});

pub const NSPasteboardContentsOptions = runtime_support.EnumOptions(enum(NSUInteger) {
    CurrentHostOnly = 1 << 0,
});

pub const NSPasteboardWriting = struct {
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
                            const class = backend.NSPasteboardWritingMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSPasteboardWriting.Protocol(ContextType).Dispatch(_delegate_handlers.handler_pasteboard_writing).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSPasteboardWritingMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSPasteboardWriting, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSPasteboardWriting", SuffixIdSeed.generateIdentifier());
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
                handler_pasteboard_writing: NSPasteboardWriting.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }

    pub const Self = @This();
};

const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
