const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

pub const NSAppKitVersion = f64;
pub const NSModalResponse = NSInteger;
pub const NSModalSession = *anyopaque;
pub const NSAboutPanelOptionKey = NSString;
pub const NSServiceProviderName = NSString;
const NSApplicationActivationPolicy = appKit.NSApplicationActivationPolicy;
const NSNotification = foundation.NSNotification;
const NSNotificationName = foundation.NSNotificationName;
const NSString = foundation.NSString;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSUInteger = runtime.NSUInteger;
const ObjectResolver = runtime.ObjectResolver;

pub const NSAppKitVersionNumber10_0: NSAppKitVersion = 577;
pub const NSAppKitVersionNumber10_1: NSAppKitVersion = 620;
pub const NSAppKitVersionNumber10_2: NSAppKitVersion = 663;
pub const NSAppKitVersionNumber10_2_3: NSAppKitVersion = 663.6;
pub const NSAppKitVersionNumber10_3: NSAppKitVersion = 743;
pub const NSAppKitVersionNumber10_3_2: NSAppKitVersion = 743.14;
pub const NSAppKitVersionNumber10_3_3: NSAppKitVersion = 743.2;
pub const NSAppKitVersionNumber10_3_5: NSAppKitVersion = 743.24;
pub const NSAppKitVersionNumber10_3_7: NSAppKitVersion = 743.33;
pub const NSAppKitVersionNumber10_3_9: NSAppKitVersion = 743.36;
pub const NSAppKitVersionNumber10_4: NSAppKitVersion = 824;
pub const NSAppKitVersionNumber10_4_1: NSAppKitVersion = 824.1;
pub const NSAppKitVersionNumber10_4_3: NSAppKitVersion = 824.23;
pub const NSAppKitVersionNumber10_4_4: NSAppKitVersion = 824.33;
pub const NSAppKitVersionNumber10_4_7: NSAppKitVersion = 824.41;
pub const NSAppKitVersionNumber10_5: NSAppKitVersion = 949;
pub const NSAppKitVersionNumber10_5_2: NSAppKitVersion = 949.27;
pub const NSAppKitVersionNumber10_5_3: NSAppKitVersion = 949.33;
pub const NSAppKitVersionNumber10_6: NSAppKitVersion = 1038;
pub const NSAppKitVersionNumber10_7: NSAppKitVersion = 1138;
pub const NSAppKitVersionNumber10_7_2: NSAppKitVersion = 1138.23;
pub const NSAppKitVersionNumber10_7_3: NSAppKitVersion = 1138.32;
pub const NSAppKitVersionNumber10_7_4: NSAppKitVersion = 1138.47;
pub const NSAppKitVersionNumber10_8: NSAppKitVersion = 1187;
pub const NSAppKitVersionNumber10_9: NSAppKitVersion = 1265;
pub const NSAppKitVersionNumber10_10: NSAppKitVersion = 1343;
pub const NSAppKitVersionNumber10_10_2: NSAppKitVersion = 1344;
pub const NSAppKitVersionNumber10_10_3: NSAppKitVersion = 1347;
pub const NSAppKitVersionNumber10_10_4: NSAppKitVersion = 1348;
pub const NSAppKitVersionNumber10_10_5: NSAppKitVersion = 1348;
pub const NSAppKitVersionNumber10_10_Max: NSAppKitVersion = 1349;
pub const NSAppKitVersionNumber10_11: NSAppKitVersion = 1404;
pub const NSAppKitVersionNumber10_11_1: NSAppKitVersion = 1404.13;
pub const NSAppKitVersionNumber10_11_2: NSAppKitVersion = 1404.34;
pub const NSAppKitVersionNumber10_11_3: NSAppKitVersion = 1404.34;
pub const NSAppKitVersionNumber10_12: NSAppKitVersion = 1504;
pub const NSAppKitVersionNumber10_12_1: NSAppKitVersion = 1504.60;
pub const NSAppKitVersionNumber10_12_2: NSAppKitVersion = 1504.76;
pub const NSAppKitVersionNumber10_13: NSAppKitVersion = 1561;
pub const NSAppKitVersionNumber10_13_1: NSAppKitVersion = 1561.1;
pub const NSAppKitVersionNumber10_13_2: NSAppKitVersion = 1561.2;
pub const NSAppKitVersionNumber10_13_4: NSAppKitVersion = 1561.4;
pub const NSAppKitVersionNumber10_14: NSAppKitVersion = 1671;
pub const NSAppKitVersionNumber10_14_1: NSAppKitVersion = 1671.1;
pub const NSAppKitVersionNumber10_14_2: NSAppKitVersion = 1671.2;
pub const NSAppKitVersionNumber10_14_3: NSAppKitVersion = 1671.3;
pub const NSAppKitVersionNumber10_14_4: NSAppKitVersion = 1671.4;
pub const NSAppKitVersionNumber10_14_5: NSAppKitVersion = 1671.5;
pub const NSAppKitVersionNumber10_15: NSAppKitVersion = 1894;
pub const NSModalResponseStop: NSModalResponse = (-1000);
pub const NSModalResponseAbort: NSModalResponse = (-1001);
pub const NSModalResponseContinue: NSModalResponse = (-1002);
pub const NSUpdateWindowsRunLoopOrdering: u16 = 500000;
pub const NSRunStoppedResponse: c_int = (-1000);
pub const NSRunAbortedResponse: c_int = (-1001);
pub const NSRunContinuesResponse: c_int = (-1002);

pub const NSRemoteNotificationType = std.enums.EnumSet(enum(NSUInteger) {
    Badge = 1 << 0,
    Sound = 1 << 1,
    Alert = 1 << 2,
});

pub const NSApplicationPresentationOptions = std.enums.EnumSet(enum(NSUInteger) {
    AutoHideDock = (1 << 0),
    HideDock = (1 << 1),
    AutoHideMenuBar = (1 << 2),
    HideMenuBar = (1 << 3),
    DisableAppleMenu = (1 << 4),
    DisableProcessSwitching = (1 << 5),
    DisableForceQuit = (1 << 6),
    DisableSessionTermination = (1 << 7),
    DisableHideApplication = (1 << 8),
    DisableMenuBarTransparency = (1 << 9),
    FullScreen = (1 << 10),
    AutoHideToolbar = (1 << 11),
    DisableCursorLocationAssistance = (1 << 12),
});

pub const NSApplicationOcclusionState = std.enums.EnumSet(enum(NSUInteger) {
    Visible = 1 << 1,
});

pub const NSWindowListOptions = std.enums.EnumSet(enum(NSInteger) {
    OrderedFrontToBack = (1 << 0),
});

pub const NSApplication = struct {
    pub const Self = @This();
    pub const RestorableUserInterface = NSRestorableUserInterfaceForNSApplication;
    pub const Deprecated = NSDeprecatedForNSApplication;
    pub const WindowsMenu = NSWindowsMenuForNSApplication;
    pub const ServicesHandling = NSServicesHandlingForNSApplication;
    pub const StandardAboutPanel = NSStandardAboutPanelForNSApplication;
    pub const LayoutDirection = NSApplicationLayoutDirectionForNSApplication;
    pub const ServicesMenu = NSServicesMenuForNSApplication;
    pub const Event = NSEventForNSApplication;
    pub const Responder = NSResponderForNSApplication;
    pub const AppearanceCustomization = NSAppearanceCustomizationForNSApplication;
    pub const RemoteNotifications = NSRemoteNotificationsForNSApplication;
    pub const FullKeyboardAccess = NSFullKeyboardAccessForNSApplication;

    var DelegateResolver: ?*ObjectResolver(NSApplication) = null;

    _id: objc.Object,

    pub inline fn as(self: Self, comptime DesiredType: type) DesiredType {
        return runtime.ObjectUpperCast(Self, Self.Constructor).as(self, DesiredType);
    }

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.ObjectUpperCast(Self, Self.Constructor).of(DesiredType);
    }

    pub fn sharedApplication() NSApplication {
        return runtime.wrapObject(NSApplication, backend.NSApplicationMessages.sharedApplication());
    }

    pub fn delegate(self: Self) ?NSApplicationDelegate {
        return runtime.wrapOptionalObject(NSApplicationDelegate, backend.NSApplicationMessages.delegate(runtime.objectId(NSApplication, self)));
    }

    pub fn setDelegate(self: Self, _delegate: ?NSApplicationDelegate) void {
        return backend.NSApplicationMessages.setDelegate(runtime.objectId(NSApplication, self), runtime.objectIdOrNull(NSApplicationDelegate, _delegate));
    }

    pub fn activateIgnoringOtherApps(self: Self, _flag: bool) void {
        return backend.NSApplicationMessages.activateIgnoringOtherApps(runtime.objectId(NSApplication, self), runtime.toBOOL(_flag));
    }

    pub fn run(self: Self) void {
        return backend.NSApplicationMessages.run(runtime.objectId(NSApplication, self));
    }

    pub fn activationPolicy(self: Self) NSApplicationActivationPolicy {
        return runtime.toEnum(NSApplicationActivationPolicy, backend.NSApplicationMessages.activationPolicy(runtime.objectId(NSApplication, self)));
    }

    pub fn setActivationPolicy(self: Self, _activationPolicy: NSApplicationActivationPolicy) bool {
        return runtime.fromBOOL(backend.NSApplicationMessages.setActivationPolicy(runtime.objectId(NSApplication, self), runtime.unwrapEnum(NSApplicationActivationPolicy, NSInteger, _activationPolicy)));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSApplicationMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSApplication,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};

const NSRestorableUserInterfaceForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSDeprecatedForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSWindowsMenuForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSServicesHandlingForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSStandardAboutPanelForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSApplicationLayoutDirectionForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSServicesMenuForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSEventForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSResponderForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSAppearanceCustomizationForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSRemoteNotificationsForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

const NSFullKeyboardAccessForNSApplication = struct {
    const Category = @This();
    pub const Self = NSApplication;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

pub const NSApplicationPrintReply = struct {
    pub const PrintingCancelled: NSApplicationPrintReply = .{
        ._value = 0,
    };
    pub const PrintingSuccess: NSApplicationPrintReply = .{
        ._value = 1,
    };
    pub const PrintingFailure: NSApplicationPrintReply = .{
        ._value = 3,
    };
    pub const PrintingReplyLater: NSApplicationPrintReply = .{
        ._value = 2,
    };

    _value: NSUInteger,
};

pub const NSRequestUserAttentionType = struct {
    pub const Critical: NSRequestUserAttentionType = .{
        ._value = 0,
    };
    pub const Informational: NSRequestUserAttentionType = .{
        ._value = 10,
    };

    _value: NSUInteger,
};

pub const NSApplicationTerminateReply = struct {
    pub const TerminateCancel: NSApplicationTerminateReply = .{
        ._value = 0,
    };
    pub const TerminateNow: NSApplicationTerminateReply = .{
        ._value = 1,
    };
    pub const TerminateLater: NSApplicationTerminateReply = .{
        ._value = 2,
    };

    _value: NSUInteger,
};

pub const NSApplicationDelegateReply = struct {
    pub const Success: NSApplicationDelegateReply = .{
        ._value = 0,
    };
    pub const Cancel: NSApplicationDelegateReply = .{
        ._value = 1,
    };
    pub const Failure: NSApplicationDelegateReply = .{
        ._value = 2,
    };

    _value: NSUInteger,
};

pub const NSServicesMenuRequestor = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub const Protocol = struct {
        pub fn Derive(comptime _delegate_handler: Handler, comptime SuffixIdSeed: type) type {
            return struct {
                const _class_name = runtime.backend_support.concreteTypeName("NSServicesMenuRequestor", SuffixIdSeed.generateIdentifier());
                const _handler = _delegate_handler;
                var _class: ?objc.Class = null;

                pub fn init() Self {
                    if (_class == null) {
                        _class = backend.NSServicesMenuRequestorMessages.initClass(_class_name);
                    }
                    var _id = backend.NSServicesMenuRequestorMessages.init(_class.?);
                    var _instance = runtime.wrapObject(NSServicesMenuRequestor, _id);
                    return _instance;
                }
            };
        }

        pub const Handler = struct {};
    };
};

pub const NSApplicationDelegate = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub const Protocol = struct {
        pub fn Derive(comptime _delegate_handler: Handler, comptime SuffixIdSeed: type) type {
            return struct {
                const _class_name = runtime.backend_support.concreteTypeName("NSApplicationDelegate", SuffixIdSeed.generateIdentifier());
                const _handler = _delegate_handler;
                var _class: ?objc.Class = null;

                pub fn init() Self {
                    if (_class == null) {
                        _class = backend.NSApplicationDelegateMessages.initClass(_class_name);
                        if (_handler.applicationWillFinishLaunching != null) {
                            backend.NSApplicationDelegateMessages.registerApplicationWillFinishLaunching(_class.?, &dispatchApplicationWillFinishLaunching);
                        }
                        if (_handler.applicationDidFinishLaunching != null) {
                            backend.NSApplicationDelegateMessages.registerApplicationDidFinishLaunching(_class.?, &dispatchApplicationDidFinishLaunching);
                        }
                    }
                    var _id = backend.NSApplicationDelegateMessages.init(_class.?);
                    var _instance = runtime.wrapObject(NSApplicationDelegate, _id);
                    return _instance;
                }

                fn dispatchApplicationWillFinishLaunching(_id: objc.c.id, _: objc.c.SEL, _notification: objc.c.id) void {
                    if (_delegate_handler.applicationWillFinishLaunching) |handler| {
                        var self = runtime.wrapObject(NSApplicationDelegate, objc.Object.fromId(_id));
                        var notification = runtime.wrapObject(NSNotification, objc.Object.fromId(_notification));
                        return handler(self, notification) catch {
                            unreachable;
                        };
                    }
                    unreachable;
                }

                fn dispatchApplicationDidFinishLaunching(_id: objc.c.id, _: objc.c.SEL, _notification: objc.c.id) void {
                    if (_delegate_handler.applicationDidFinishLaunching) |handler| {
                        var self = runtime.wrapObject(NSApplicationDelegate, objc.Object.fromId(_id));
                        var notification = runtime.wrapObject(NSNotification, objc.Object.fromId(_notification));
                        return handler(self, notification) catch {
                            unreachable;
                        };
                    }
                    unreachable;
                }
            };
        }

        pub const Handler = struct {
            applicationWillFinishLaunching: ?(*const fn (self: NSApplicationDelegate, _notification: NSNotification) anyerror!void) = null,
            applicationDidFinishLaunching: ?(*const fn (self: NSApplicationDelegate, _notification: NSNotification) anyerror!void) = null,
        };
    };
};