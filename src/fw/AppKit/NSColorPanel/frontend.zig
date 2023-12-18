const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSNotificationName = foundation.NSNotificationName;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const NSColorPanelOptions = std.enums.EnumSet(enum(NSUInteger) {
    GrayModeMask = 0x00000001,
    RGBModeMask = 0x00000002,
    CMYKModeMask = 0x00000004,
    HSBModeMask = 0x00000008,
    CustomPaletteModeMask = 0x00000010,
    ColorListModeMask = 0x00000020,
    WheelModeMask = 0x00000040,
    CrayonModeMask = 0x00000080,
    AllModesMask = 0x0000ffff,
});

pub const NSColorPanelMode = struct {
    pub const None: NSColorPanelMode = .{
        ._value = -1,
    };
    pub const Gray: NSColorPanelMode = .{
        ._value = 0,
    };
    pub const RGB: NSColorPanelMode = .{
        ._value = 1,
    };
    pub const CMYK: NSColorPanelMode = .{
        ._value = 2,
    };
    pub const HSB: NSColorPanelMode = .{
        ._value = 3,
    };
    pub const CustomPalette: NSColorPanelMode = .{
        ._value = 4,
    };
    pub const ColorList: NSColorPanelMode = .{
        ._value = 5,
    };
    pub const Wheel: NSColorPanelMode = .{
        ._value = 6,
    };
    pub const Crayon: NSColorPanelMode = .{
        ._value = 7,
    };

    _value: NSInteger,
};

pub const NSColorChanging = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime_support.backend_support.concreteTypeName("NSColorChanging", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            const class = backend.NSColorChangingMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSColorChanging.Protocol(ContextType).Dispatch(_delegate_handlers.handler_color_changing).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSColorChangingMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSColorChanging, _id);
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
                handler_color_changing: NSColorChanging.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }
};
