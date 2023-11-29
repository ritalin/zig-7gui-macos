const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

pub const NSPasteboardType = NSString;
pub const NSPasteboardName = NSString;
pub const NSPasteboardReadingOptionKey = NSString;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const NSPasteboardWritingOptions = std.enums.EnumSet(enum(NSUInteger) {
    Promised = 1 << 9,
});

pub const NSPasteboardReadingOptions = std.enums.EnumSet(enum(NSUInteger) {
    AsString = 1 << 0,
    AsPropertyList = 1 << 1,
    AsKeyedArchive = 1 << 2,
});

pub const NSPasteboardContentsOptions = std.enums.EnumSet(enum(NSUInteger) {
    CurrentHostOnly = 1 << 0,
});

pub const NSPasteboardReading = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime.backend_support.concreteTypeName("NSPasteboardReading", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSPasteboardReadingMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSPasteboardReading.Protocol(ContextType).Dispatch(_delegate_handlers.handler_pasteboard_reading).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSPasteboardReadingMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSPasteboardReading, _id);
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
                handler_pasteboard_reading: NSPasteboardReading.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }
};
