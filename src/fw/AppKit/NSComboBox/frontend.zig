const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAccessibilityNavigableStaticText = appKit.NSAccessibilityNavigableStaticText;
const NSAccessibilityStaticText = appKit.NSAccessibilityStaticText;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSControl = appKit.NSControl;
const NSControlTextEditingDelegate = appKit.NSControlTextEditingDelegate;
const NSDraggingDestination = appKit.NSDraggingDestination;
const NSResponder = appKit.NSResponder;
const NSTextContent = appKit.NSTextContent;
const NSTextField = appKit.NSTextField;
const NSTextFieldDelegate = appKit.NSTextFieldDelegate;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSUserInterfaceValidations = appKit.NSUserInterfaceValidations;
const NSView = appKit.NSView;
const NSCoding = foundation.NSCoding;
const NSNotification = foundation.NSNotification;
const NSNotificationName = foundation.NSNotificationName;
const NSString = foundation.NSString;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const NSComboBox = struct {
    pub const Self = @This();

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

    pub fn usesDataSource(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSComboBoxMessages.usesDataSource(runtime_support.objectId(NSComboBox, self)));
    }

    pub fn setUsesDataSource(self: Self, _usesDataSource: bool) void {
        return backend.NSComboBoxMessages.setUsesDataSource(runtime_support.objectId(NSComboBox, self), runtime_support.toBOOL(_usesDataSource));
    }

    pub fn selectItemAtIndex(self: Self, _index: NSInteger) void {
        return backend.NSComboBoxMessages.selectItemAtIndex(runtime_support.objectId(NSComboBox, self), runtime_support.pass(NSInteger, _index));
    }

    pub fn deselectItemAtIndex(self: Self, _index: NSInteger) void {
        return backend.NSComboBoxMessages.deselectItemAtIndex(runtime_support.objectId(NSComboBox, self), runtime_support.pass(NSInteger, _index));
    }

    pub fn indexOfSelectedItem(self: Self) NSInteger {
        return backend.NSComboBoxMessages.indexOfSelectedItem(runtime_support.objectId(NSComboBox, self));
    }

    pub fn delegate(self: Self) ?NSComboBoxDelegate {
        return runtime_support.wrapObject(?NSComboBoxDelegate, backend.NSComboBoxMessages.delegate(runtime_support.objectId(NSComboBox, self)));
    }

    pub fn setDelegate(self: Self, _delegate: ?NSComboBoxDelegate) void {
        return backend.NSComboBoxMessages.setDelegate(runtime_support.objectId(NSComboBox, self), runtime_support.objectId(?NSComboBoxDelegate, _delegate));
    }

    pub fn dataSource(self: Self) ?NSComboBoxDataSource {
        return runtime_support.wrapObject(?NSComboBoxDataSource, backend.NSComboBoxMessages.dataSource(runtime_support.objectId(NSComboBox, self)));
    }

    pub fn setDataSource(self: Self, _dataSource: ?NSComboBoxDataSource) void {
        return backend.NSComboBoxMessages.setDataSource(runtime_support.objectId(NSComboBox, self), runtime_support.objectId(?NSComboBoxDataSource, _dataSource));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSComboBoxMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSComboBox,
                NSTextField,
                NSControl,
                NSView,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };
};

pub const NSComboBoxDataSource = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime_support.backend_support.concreteTypeName("NSComboBoxDataSource", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            const class = backend.NSComboBoxDataSourceMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSComboBoxDataSource.Protocol(ContextType).Dispatch(_delegate_handlers.handler_combo_box_data_source).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSComboBoxDataSourceMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSComboBoxDataSource, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchNumberOfItemsInComboBox(_id: objc.c.id, _: objc.c.SEL, _comboBox: objc.c.id) NSInteger {
                        if (_delegate_handler.numberOfItemsInComboBox) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const comboBox = runtime_support.wrapObject(NSComboBox, objc.Object.fromId(_comboBox));
                            return handler(context, comboBox) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchComboBoxObjectValueForItemAtIndex(_id: objc.c.id, _: objc.c.SEL, _comboBox: objc.c.id, _index: NSInteger) objc.c.id {
                        if (_delegate_handler.comboBoxObjectValueForItemAtIndex) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const comboBox = runtime_support.wrapObject(NSComboBox, objc.Object.fromId(_comboBox));
                            return runtime_support.unwrapOptionalObject(handler(context, comboBox, _index) catch {
                                unreachable;
                            });
                        }
                        unreachable;
                    }

                    fn dispatchComboBoxIndexOfItemWithStringValue(_id: objc.c.id, _: objc.c.SEL, _comboBox: objc.c.id, _string: objc.c.id) NSUInteger {
                        if (_delegate_handler.comboBoxIndexOfItemWithStringValue) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const comboBox = runtime_support.wrapObject(NSComboBox, objc.Object.fromId(_comboBox));
                            const string = runtime_support.wrapObject(NSString, objc.Object.fromId(_string));
                            return handler(context, comboBox, string) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchComboBoxCompletedString(_id: objc.c.id, _: objc.c.SEL, _comboBox: objc.c.id, _string: objc.c.id) objc.c.id {
                        if (_delegate_handler.comboBoxCompletedString) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const comboBox = runtime_support.wrapObject(NSComboBox, objc.Object.fromId(_comboBox));
                            const string = runtime_support.wrapObject(NSString, objc.Object.fromId(_string));
                            return runtime_support.unwrapOptionalObject(?NSString, handler(context, comboBox, string) catch {
                                unreachable;
                            });
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.numberOfItemsInComboBox != null) {
                            backend.NSComboBoxDataSourceMessages.registerNumberOfItemsInComboBox(_class, @constCast(&dispatchNumberOfItemsInComboBox));
                        }
                        if (_delegate_handler.comboBoxObjectValueForItemAtIndex != null) {
                            backend.NSComboBoxDataSourceMessages.registerComboBoxObjectValueForItemAtIndex(_class, @constCast(&dispatchComboBoxObjectValueForItemAtIndex));
                        }
                        if (_delegate_handler.comboBoxIndexOfItemWithStringValue != null) {
                            backend.NSComboBoxDataSourceMessages.registerComboBoxIndexOfItemWithStringValue(_class, @constCast(&dispatchComboBoxIndexOfItemWithStringValue));
                        }
                        if (_delegate_handler.comboBoxCompletedString != null) {
                            backend.NSComboBoxDataSourceMessages.registerComboBoxCompletedString(_class, @constCast(&dispatchComboBoxCompletedString));
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_combo_box_data_source: NSComboBoxDataSource.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                numberOfItemsInComboBox: ?*const fn (context: *ContextType, _: NSComboBox) anyerror!NSInteger = null,
                comboBoxObjectValueForItemAtIndex: ?*const fn (context: *ContextType, _: NSComboBox, _: NSInteger) anyerror!?objc.Object = null,
                comboBoxIndexOfItemWithStringValue: ?*const fn (context: *ContextType, _: NSComboBox, _: NSString) anyerror!NSUInteger = null,
                comboBoxCompletedString: ?*const fn (context: *ContextType, _: NSComboBox, _: NSString) anyerror!?NSString = null,
            };
        };
    }
};

pub const NSComboBoxDelegate = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime_support.backend_support.concreteTypeName("NSComboBoxDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            const class = backend.NSComboBoxDelegateMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSComboBoxDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_combo_box_delegate).initClass(class);
                            NSTextFieldDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_field_delegate).initClass(class);
                            NSControlTextEditingDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_control_text_editing_delegate).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSComboBoxDelegateMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSComboBoxDelegate, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchComboBoxSelectionDidChange(_id: objc.c.id, _: objc.c.SEL, _notification: objc.c.id) void {
                        if (_delegate_handler.comboBoxSelectionDidChange) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const notification = runtime_support.wrapObject(NSNotification, objc.Object.fromId(_notification));
                            return handler(context, notification) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.comboBoxSelectionDidChange != null) {
                            backend.NSComboBoxDelegateMessages.registerComboBoxSelectionDidChange(_class, @constCast(&dispatchComboBoxSelectionDidChange));
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_combo_box_delegate: NSComboBoxDelegate.Protocol(ContextType).Handler = .{},
                handler_text_field_delegate: NSTextFieldDelegate.Protocol(ContextType).Handler = .{},
                handler_control_text_editing_delegate: NSControlTextEditingDelegate.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                comboBoxSelectionDidChange: ?*const fn (context: *ContextType, _: NSNotification) anyerror!void = null,
            };
        };
    }
};
