const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

pub const NSWindowLevel = NSInteger;
pub const NSWindowFrameAutosaveName = NSString;
pub const NSWindowPersistableFrameDescriptor = NSString;
pub const NSWindowTabbingIdentifier = NSString;
const NSAppKitVersion = appKit.NSAppKitVersion;
const NSBackingStoreType = appKit.NSBackingStoreType;
const NSColor = appKit.NSColor;
const NSModalResponse = appKit.NSModalResponse;
const NSScreen = appKit.NSScreen;
const NSView = appKit.NSView;
const NSNotification = foundation.NSNotification;
const NSNotificationName = foundation.NSNotificationName;
const NSRect = foundation.NSRect;
const NSString = foundation.NSString;
const NSTimeInterval = foundation.NSTimeInterval;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
const ObjectResolver = runtime.ObjectResolver;

pub const NSAppKitVersionNumberWithCustomSheetPosition: NSAppKitVersion = 686.0;
pub const NSAppKitVersionNumberWithDeferredWindowDisplaySupport: NSAppKitVersion = 1019.0;
pub const NSModalResponseOK: NSModalResponse = 1;
pub const NSModalResponseCancel: NSModalResponse = 0;
pub const NSDisplayWindowRunLoopOrdering: u16 = 600000;
pub const NSResetCursorRectsRunLoopOrdering: u16 = 700000;
pub const NSNormalWindowLevel: NSWindowLevel = (0);
pub const NSFloatingWindowLevel: NSWindowLevel = (3);
pub const NSSubmenuWindowLevel: NSWindowLevel = (3);
pub const NSTornOffMenuWindowLevel: NSWindowLevel = (3);
pub const NSMainMenuWindowLevel: NSWindowLevel = (24);
pub const NSStatusWindowLevel: NSWindowLevel = (25);
pub const NSModalPanelWindowLevel: NSWindowLevel = (8);
pub const NSPopUpMenuWindowLevel: NSWindowLevel = (101);
pub const NSScreenSaverWindowLevel: NSWindowLevel = (1000);
pub const NSEventDurationForever: NSTimeInterval = 1.7976931348623157e+308;

pub const NSWindowCollectionBehavior = std.enums.EnumSet(enum(NSUInteger) {
    CanJoinAllSpaces = 1 << 0,
    MoveToActiveSpace = 1 << 1,
    Managed = 1 << 2,
    Transient = 1 << 3,
    Stationary = 1 << 4,
    ParticipatesInCycle = 1 << 5,
    IgnoresCycle = 1 << 6,
    FullScreenPrimary = 1 << 7,
    FullScreenAuxiliary = 1 << 8,
    FullScreenNone = 1 << 9,
    FullScreenAllowsTiling = 1 << 11,
    FullScreenDisallowsTiling = 1 << 12,
});

pub const NSWindowStyleMask = std.enums.EnumSet(enum(NSUInteger) {
    Titled = 1 << 0,
    Closable = 1 << 1,
    Miniaturizable = 1 << 2,
    Resizable = 1 << 3,
    TexturedBackground = 1 << 8,
    UnifiedTitleAndToolbar = 1 << 12,
    FullScreen = 1 << 14,
    FullSizeContentView = 1 << 15,
    UtilityWindow = 1 << 4,
    DocModalWindow = 1 << 6,
    NonactivatingPanel = 1 << 7,
    HUDWindow = 1 << 13,
});

pub const NSWindowOcclusionState = std.enums.EnumSet(enum(NSUInteger) {
    Visible = 1 << 1,
});

pub const NSWindowNumberListOptions = std.enums.EnumSet(enum(NSUInteger) {
    AllApplications = 1 << 0,
    AllSpaces = 1 << 4,
});

pub const NSWindow = struct {
    pub const Self = @This();
    pub const CursorRect = NSCursorRectForNSWindow;
    pub const Deprecated = NSDeprecatedForNSWindow;
    pub const CarbonExtensions = NSCarbonExtensionsForNSWindow;
    pub const Event = NSEventForNSWindow;
    pub const Drag = NSDragForNSWindow;

    var DelegateResolver: ?*ObjectResolver(NSWindow) = null;

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub inline fn as(self: Self, comptime DesiredType: type) DesiredType {
        return runtime.ObjectUpperCast(Self, Self.Constructor).as(self, DesiredType);
    }

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.ObjectUpperCast(Self, Self.Constructor).of(DesiredType);
    }

    pub fn title(self: Self) NSString {
        return runtime.wrapObject(NSString, backend.NSWindowMessages.title(runtime.objectId(NSWindow, self)));
    }

    pub fn setTitle(self: Self, _title: NSString) void {
        return backend.NSWindowMessages.setTitle(runtime.objectId(NSWindow, self), runtime.objectId(NSString, _title));
    }

    pub fn contentView(self: Self) ?NSView {
        return runtime.wrapOptionalObject(NSView, backend.NSWindowMessages.contentView(runtime.objectId(NSWindow, self)));
    }

    pub fn setContentView(self: Self, _contentView: ?NSView) void {
        return backend.NSWindowMessages.setContentView(runtime.objectId(NSWindow, self), runtime.objectIdOrNull(NSView, _contentView));
    }

    pub fn delegate(self: Self) ?NSWindowDelegate {
        return runtime.wrapOptionalObject(NSWindowDelegate, backend.NSWindowMessages.delegate(runtime.objectId(NSWindow, self)));
    }

    pub fn setDelegate(self: Self, _delegate: ?NSWindowDelegate) void {
        return backend.NSWindowMessages.setDelegate(runtime.objectId(NSWindow, self), runtime.objectIdOrNull(NSWindowDelegate, _delegate));
    }

    pub fn backgroundColor(self: Self) NSColor {
        return runtime.wrapObject(NSColor, backend.NSWindowMessages.backgroundColor(runtime.objectId(NSWindow, self)));
    }

    pub fn setBackgroundColor(self: Self, _backgroundColor: ?NSColor) void {
        return backend.NSWindowMessages.setBackgroundColor(runtime.objectId(NSWindow, self), runtime.objectIdOrNull(NSColor, _backgroundColor));
    }

    pub fn makeKeyAndOrderFront(self: Self, _sender: ?objc.Object) void {
        return backend.NSWindowMessages.makeKeyAndOrderFront(runtime.objectId(NSWindow, self), _sender);
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithContentRectStyleMaskBacking(_contentRect: NSRect, _style: NSWindowStyleMask, _backingStoreType: NSBackingStoreType, _flag: bool, _screen: ?NSScreen) DesiredType {
                var _class = DesiredType.Support.getClass();
                return runtime.wrapObject(DesiredType, backend.NSWindowMessages.initWithContentRectStyleMaskBacking(_class, runtime.pass(NSRect, _contentRect), runtime.packOptions(NSWindowStyleMask, _style), runtime.unwrapEnum(NSBackingStoreType, NSUInteger, _backingStoreType), runtime.toBOOL(_flag), runtime.objectIdOrNull(NSScreen, _screen)));
            }
        };
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSWindowMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSWindow,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};

const NSCursorRectForNSWindow = struct {
    const Category = @This();
    pub const Self = NSWindow;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSDeprecatedForNSWindow = struct {
    const Category = @This();
    pub const Self = NSWindow;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSCarbonExtensionsForNSWindow = struct {
    const Category = @This();
    pub const Self = NSWindow;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSEventForNSWindow = struct {
    const Category = @This();
    pub const Self = NSWindow;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSDragForNSWindow = struct {
    const Category = @This();
    pub const Self = NSWindow;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

pub const NSWindowToolbarStyle = struct {
    pub const Automatic: NSWindowToolbarStyle = .{
        ._value = 0x0,
    };
    pub const Expanded: NSWindowToolbarStyle = .{
        ._value = 0x1,
    };
    pub const Preference: NSWindowToolbarStyle = .{
        ._value = 0x2,
    };
    pub const Unified: NSWindowToolbarStyle = .{
        ._value = 0x3,
    };
    pub const UnifiedCompact: NSWindowToolbarStyle = .{
        ._value = 0x4,
    };

    _value: NSInteger,
};

pub const NSTitlebarSeparatorStyle = struct {
    pub const Automatic: NSTitlebarSeparatorStyle = .{
        ._value = 0x0,
    };
    pub const None: NSTitlebarSeparatorStyle = .{
        ._value = 0x1,
    };
    pub const Line: NSTitlebarSeparatorStyle = .{
        ._value = 0x2,
    };
    pub const Shadow: NSTitlebarSeparatorStyle = .{
        ._value = 0x3,
    };

    _value: NSInteger,
};

pub const NSWindowButton = struct {
    pub const Close: NSWindowButton = .{
        ._value = 0x0,
    };
    pub const Miniaturize: NSWindowButton = .{
        ._value = 0x1,
    };
    pub const Zoom: NSWindowButton = .{
        ._value = 0x2,
    };
    pub const Toolbar: NSWindowButton = .{
        ._value = 0x3,
    };
    pub const DocumentIcon: NSWindowButton = .{
        ._value = 0x4,
    };
    pub const DocumentVersions: NSWindowButton = .{
        ._value = 6,
    };

    _value: NSUInteger,
};

pub const NSWindowTabbingMode = struct {
    pub const Automatic: NSWindowTabbingMode = .{
        ._value = 0x0,
    };
    pub const Preferred: NSWindowTabbingMode = .{
        ._value = 0x1,
    };
    pub const Disallowed: NSWindowTabbingMode = .{
        ._value = 0x2,
    };

    _value: NSInteger,
};

pub const NSWindowUserTabbingPreference = struct {
    pub const Manual: NSWindowUserTabbingPreference = .{
        ._value = 0x0,
    };
    pub const Always: NSWindowUserTabbingPreference = .{
        ._value = 0x1,
    };
    pub const InFullScreen: NSWindowUserTabbingPreference = .{
        ._value = 0x2,
    };

    _value: NSInteger,
};

pub const NSWindowTitleVisibility = struct {
    pub const Visible: NSWindowTitleVisibility = .{
        ._value = 0,
    };
    pub const Hidden: NSWindowTitleVisibility = .{
        ._value = 1,
    };

    _value: NSInteger,
};

pub const NSSelectionDirection = struct {
    pub const Direct: NSSelectionDirection = .{
        ._value = 0,
    };
    pub const SelectingNext: NSSelectionDirection = .{
        ._value = 0x1,
    };
    pub const SelectingPrevious: NSSelectionDirection = .{
        ._value = 0x2,
    };

    _value: NSUInteger,
};

pub const NSWindowAnimationBehavior = struct {
    pub const Default: NSWindowAnimationBehavior = .{
        ._value = 0,
    };
    pub const None: NSWindowAnimationBehavior = .{
        ._value = 2,
    };
    pub const DocumentWindow: NSWindowAnimationBehavior = .{
        ._value = 3,
    };
    pub const UtilityWindow: NSWindowAnimationBehavior = .{
        ._value = 4,
    };
    pub const AlertPanel: NSWindowAnimationBehavior = .{
        ._value = 5,
    };

    _value: NSInteger,
};

pub const NSWindowSharingType = struct {
    pub const None: NSWindowSharingType = .{
        ._value = 0,
    };
    pub const ReadOnly: NSWindowSharingType = .{
        ._value = 1,
    };
    pub const ReadWrite: NSWindowSharingType = .{
        ._value = 2,
    };

    _value: NSUInteger,
};

pub const NSWindowDelegate = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime.backend_support.concreteTypeName("NSWindowDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSWindowDelegateMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            NSWindowDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_window_delegate).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSWindowDelegateMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSWindowDelegate, _id);
                        runtime.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchWindowWillClose(_id: objc.c.id, _: objc.c.SEL, _notification: objc.c.id) void {
                        if (_delegate_handler.windowWillClose) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var notification = runtime.wrapObject(NSNotification, objc.Object.fromId(_notification));
                            return handler(context, notification) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.windowWillClose != null) {
                            backend.NSWindowDelegateMessages.registerWindowWillClose(_class, &dispatchWindowWillClose);
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
                handler_window_delegate: NSWindowDelegate.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                windowWillClose: ?(*const fn (context: *ContextType, _notification: NSNotification) anyerror!void) = null,
            };
        };
    }
};
