const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");

const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;

pub const NSGlyphAttributeSoft: c_uint = 0;
pub const NSGlyphAttributeElastic: c_uint = 1;
pub const NSGlyphAttributeBidiLevel: c_uint = 2;
pub const NSGlyphAttributeInscribe: c_uint = 5;

pub const NSGlyphProperty = std.enums.EnumSet(enum(NSInteger) {
    Null = (1 << 0),
    ControlCharacter = (1 << 1),
    Elastic = (1 << 2),
    NonBaseCharacter = (1 << 3),
});

pub const NSControlCharacterAction = std.enums.EnumSet(enum(NSInteger) {
    ZeroAdvancement = (1 << 0),
    Whitespace = (1 << 1),
    HorizontalTab = (1 << 2),
    LineBreak = (1 << 3),
    ParagraphBreak = (1 << 4),
    ContainerBreak = (1 << 5),
});

pub const NSTextLayoutOrientation = struct {
    pub const Horizontal: NSTextLayoutOrientation = .{
        ._value = 0,
    };
    pub const Vertical: NSTextLayoutOrientation = .{
        ._value = 1,
    };

    _value: NSInteger,
};

pub const NSTypesetterBehavior = struct {
    pub const Latest: NSTypesetterBehavior = .{
        ._value = -1,
    };
    pub const Original: NSTypesetterBehavior = .{
        ._value = 0,
    };
    pub const Behavior_10_2_WithCompatibility: NSTypesetterBehavior = .{
        ._value = 1,
    };
    pub const Behavior_10_2: NSTypesetterBehavior = .{
        ._value = 2,
    };
    pub const Behavior_10_3: NSTypesetterBehavior = .{
        ._value = 3,
    };
    pub const Behavior_10_4: NSTypesetterBehavior = .{
        ._value = 4,
    };

    _value: NSInteger,
};

pub const NSTextLayoutOrientationProvider = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime.backend_support.concreteTypeName("NSTextLayoutOrientationProvider", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSTextLayoutOrientationProviderMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSTextLayoutOrientationProvider.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_layout_orientation_provider).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSTextLayoutOrientationProviderMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSTextLayoutOrientationProvider, _id);
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
                handler_text_layout_orientation_provider: NSTextLayoutOrientationProvider.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }
};
