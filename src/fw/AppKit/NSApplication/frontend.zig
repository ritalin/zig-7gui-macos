const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSRemoteNotificationType = runtime_support.EnumOptions(enum(NSUInteger) {
    Badge = 1 << 0,
    Sound = 1 << 1,
    Alert = 1 << 2,
});

pub const NSApplicationPresentationOptions = runtime_support.EnumOptions(enum(NSUInteger) {
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

pub const NSApplicationOcclusionState = runtime_support.EnumOptions(enum(NSUInteger) {
    Visible = 1 << 1,
});

pub const NSWindowListOptions = runtime_support.EnumOptions(enum(NSInteger) {
    OrderedFrontToBack = (1 << 0),
});

pub const NSApplication = struct {
    _id: objc.Object,

    pub inline fn as(self: Self, comptime DesiredType: type) DesiredType {
        return runtime_support.ObjectUpperCast(Self, Self.Constructor).as(self, DesiredType);
    }

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.ObjectUpperCast(Self, Self.Constructor).of(DesiredType);
    }

    pub fn sharedApplication() NSApplication {
        return runtime_support.wrapObject(NSApplication, backend.NSApplicationMessages.sharedApplication());
    }

    pub fn delegate(self: Self) ?NSApplicationDelegate {
        return runtime_support.wrapObject(?NSApplicationDelegate, backend.NSApplicationMessages.delegate(runtime_support.objectId(NSApplication, self)));
    }

    pub fn setDelegate(self: Self, _delegate: ?NSApplicationDelegate) void {
        return backend.NSApplicationMessages.setDelegate(runtime_support.objectId(NSApplication, self), runtime_support.objectId(?NSApplicationDelegate, _delegate));
    }

    pub fn activateIgnoringOtherApps(self: Self, _flag: bool) void {
        return backend.NSApplicationMessages.activateIgnoringOtherApps(runtime_support.objectId(NSApplication, self), runtime_support.toBOOL(_flag));
    }

    pub fn run(self: Self) void {
        return backend.NSApplicationMessages.run(runtime_support.objectId(NSApplication, self));
    }

    pub fn activationPolicy(self: Self) NSApplicationActivationPolicy {
        return runtime_support.wrapEnum(NSApplicationActivationPolicy, NSInteger, backend.NSApplicationMessages.activationPolicy(runtime_support.objectId(NSApplication, self)));
    }

    pub fn setActivationPolicy(self: Self, _activationPolicy: NSApplicationActivationPolicy) bool {
        return runtime_support.fromBOOL(backend.NSApplicationMessages.setActivationPolicy(runtime_support.objectId(NSApplication, self), runtime_support.unwrapEnum(NSApplicationActivationPolicy, NSInteger, _activationPolicy)));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSApplicationMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSApplication,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSAccessibility,
                NSAccessibilityElement,
                NSMenuItemValidation,
                NSUserInterfaceValidations,
                NSObjectProtocol,
            });
        }
    };

    pub const Self = @This();
    pub const Event = NSEventForNSApplication;
    pub const ExternVars = ExternVarsForNSApplication;
};

const NSEventForNSApplication = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    pub fn currentEvent(self: Category) ?NSEvent {
        return runtime_support.wrapObject(?NSEvent, backend.NSEventForNSApplicationMessages.currentEvent(runtime_support.objectId(NSEventForNSApplication, self)));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSApplication;
};

pub const NSApplicationPrintReply = struct {
    _value: NSUInteger,

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
};

pub const NSRequestUserAttentionType = struct {
    _value: NSUInteger,

    pub const Critical: NSRequestUserAttentionType = .{
        ._value = 0,
    };
    pub const Informational: NSRequestUserAttentionType = .{
        ._value = 10,
    };
};

pub const NSApplicationTerminateReply = struct {
    _value: NSUInteger,

    pub const TerminateCancel: NSApplicationTerminateReply = .{
        ._value = 0,
    };
    pub const TerminateNow: NSApplicationTerminateReply = .{
        ._value = 1,
    };
    pub const TerminateLater: NSApplicationTerminateReply = .{
        ._value = 2,
    };
};

pub const NSApplicationDelegateReply = struct {
    _value: NSUInteger,

    pub const Success: NSApplicationDelegateReply = .{
        ._value = 0,
    };
    pub const Cancel: NSApplicationDelegateReply = .{
        ._value = 1,
    };
    pub const Failure: NSApplicationDelegateReply = .{
        ._value = 2,
    };
};

pub const NSApplicationDelegate = struct {
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
                            const class = backend.NSApplicationDelegateMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSApplicationDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_application_delegate).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSApplicationDelegateMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSApplicationDelegate, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSApplicationDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchApplicationWillFinishLaunching(_id: objc.c.id, _: objc.c.SEL, _notification: objc.c.id) void {
                        if (_delegate_handler.applicationWillFinishLaunching) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const notification = runtime_support.wrapObject(NSNotification, objc.Object.fromId(_notification));
                            return handler(context, notification) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchApplicationDidFinishLaunching(_id: objc.c.id, _: objc.c.SEL, _notification: objc.c.id) void {
                        if (_delegate_handler.applicationDidFinishLaunching) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const notification = runtime_support.wrapObject(NSNotification, objc.Object.fromId(_notification));
                            return handler(context, notification) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.applicationWillFinishLaunching != null) {
                            backend.NSApplicationDelegateMessages.registerApplicationWillFinishLaunching(_class, @constCast(&dispatchApplicationWillFinishLaunching));
                        }
                        if (_delegate_handler.applicationDidFinishLaunching != null) {
                            backend.NSApplicationDelegateMessages.registerApplicationDidFinishLaunching(_class, @constCast(&dispatchApplicationDidFinishLaunching));
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_application_delegate: NSApplicationDelegate.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                applicationWillFinishLaunching: ?*const fn (context: *ContextType, _: NSNotification) anyerror!void = null,
                applicationDidFinishLaunching: ?*const fn (context: *ContextType, _: NSNotification) anyerror!void = null,
            };
        };
    }

    pub const Self = @This();
};

const ExternVarsForNSApplication = struct {
    pub fn NSAppKitVersionNumber() NSAppKitVersion {
        return runtime_support.wrapObject(NSAppKitVersion, objc.Object.fromId(backend.NSAppKitVersionNumber));
    }
};

pub const NSAppKitVersion = f64;
pub const NSModalResponse = NSInteger;
pub const NSModalSession = *anyopaque;
pub const NSAboutPanelOptionKey = NSString;
pub const NSServiceProviderName = NSString;
const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSApplicationActivationPolicy = appKit.NSApplicationActivationPolicy;
const NSEvent = appKit.NSEvent;
const NSMenuItemValidation = appKit.NSMenuItemValidation;
const NSResponder = appKit.NSResponder;
const NSUserInterfaceValidations = appKit.NSUserInterfaceValidations;
const NSCoding = foundation.NSCoding;
const NSNotification = foundation.NSNotification;
const NSString = foundation.NSString;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

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
pub const NSUpdateWindowsRunLoopOrdering: c_uint = 500000;
pub const NSRunStoppedResponse: c_int = (-1000);
pub const NSRunAbortedResponse: c_int = (-1001);
pub const NSRunContinuesResponse: c_int = (-1002);
