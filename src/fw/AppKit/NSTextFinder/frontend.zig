const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTextFinderAction = struct {
    _value: NSInteger,

    pub const ShowFindInterface: NSTextFinderAction = .{
        ._value = 1,
    };
    pub const NextMatch: NSTextFinderAction = .{
        ._value = 2,
    };
    pub const PreviousMatch: NSTextFinderAction = .{
        ._value = 3,
    };
    pub const ReplaceAll: NSTextFinderAction = .{
        ._value = 4,
    };
    pub const Replace: NSTextFinderAction = .{
        ._value = 5,
    };
    pub const ReplaceAndFind: NSTextFinderAction = .{
        ._value = 6,
    };
    pub const SetSearchString: NSTextFinderAction = .{
        ._value = 7,
    };
    pub const ReplaceAllInSelection: NSTextFinderAction = .{
        ._value = 8,
    };
    pub const SelectAll: NSTextFinderAction = .{
        ._value = 9,
    };
    pub const SelectAllInSelection: NSTextFinderAction = .{
        ._value = 10,
    };
    pub const HideFindInterface: NSTextFinderAction = .{
        ._value = 11,
    };
    pub const ShowReplaceInterface: NSTextFinderAction = .{
        ._value = 12,
    };
    pub const HideReplaceInterface: NSTextFinderAction = .{
        ._value = 13,
    };
};

pub const NSTextFinderMatchingType = struct {
    _value: NSInteger,

    pub const Contains: NSTextFinderMatchingType = .{
        ._value = 0,
    };
    pub const StartsWith: NSTextFinderMatchingType = .{
        ._value = 1,
    };
    pub const FullWord: NSTextFinderMatchingType = .{
        ._value = 2,
    };
    pub const EndsWith: NSTextFinderMatchingType = .{
        ._value = 3,
    };
};

pub const NSTextFinderBarContainer = struct {
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
                            const class = backend.NSTextFinderBarContainerMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSTextFinderBarContainer.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_finder_bar_container).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSTextFinderBarContainerMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSTextFinderBarContainer, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSTextFinderBarContainer", SuffixIdSeed.generateIdentifier());
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
                handler_text_finder_bar_container: NSTextFinderBarContainer.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }

    pub const Self = @This();
};

pub const NSPasteboardTypeTextFinderOptionKey = *const NSString;
const NSString = foundation.NSString;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
