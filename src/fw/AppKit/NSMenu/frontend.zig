const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSMenuProperties = runtime_support.EnumOptions(enum(NSUInteger) {
    PropertyItemTitle = 1 << 0,
    PropertyItemAttributedTitle = 1 << 1,
    PropertyItemKeyEquivalent = 1 << 2,
    PropertyItemImage = 1 << 3,
    PropertyItemEnabled = 1 << 4,
    PropertyItemAccessibilityDescription = 1 << 5,
});

pub const NSMenu = struct {
    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub inline fn as(self: Self, comptime DesiredType: type) DesiredType {
        return runtime_support.ObjectUpperCast(Self, Self.Constructor).as(self, DesiredType);
    }

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.ObjectUpperCast(Self, Self.Constructor).of(DesiredType);
    }

    pub fn popUpContextMenuWithEventForView(_menu: NSMenu, _event: NSEvent, _view: NSView) void {
        return backend.NSMenuMessages.popUpContextMenuWithEventForView(runtime_support.objectId(NSMenu, _menu), runtime_support.objectId(NSEvent, _event), runtime_support.objectId(NSView, _view));
    }

    pub fn addItemWithTitleActionKeyEquivalent(self: Self, _string: NSString, _selector: ?objc.Sel, _charCode: NSString) NSMenuItem {
        return runtime_support.wrapObject(NSMenuItem, backend.NSMenuMessages.addItemWithTitleActionKeyEquivalent(runtime_support.objectId(NSMenu, self), runtime_support.objectId(NSString, _string), runtime_support.pass(?objc.Sel, _selector), runtime_support.objectId(NSString, _charCode)));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSMenuMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSMenu,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSAccessibility,
                NSAccessibilityElement,
                NSAppearanceCustomization,
                NSCoding,
                NSCopying,
                NSUserInterfaceItemIdentification,
                NSObjectProtocol,
            });
        }
    };

    pub const Self = @This();
};

pub const NSMenuItemValidation = struct {
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
                            const class = backend.NSMenuItemValidationMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSMenuItemValidation.Protocol(ContextType).Dispatch(_delegate_handlers.handler_menu_item_validation).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSMenuItemValidationMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSMenuItemValidation, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSMenuItemValidation", SuffixIdSeed.generateIdentifier());
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
                handler_menu_item_validation: NSMenuItemValidation.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {};
        };
    }

    pub const Self = @This();
};

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSEvent = appKit.NSEvent;
const NSMenuItem = appKit.NSMenuItem;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSView = appKit.NSView;
const NSCoding = foundation.NSCoding;
const NSCopying = foundation.NSCopying;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
