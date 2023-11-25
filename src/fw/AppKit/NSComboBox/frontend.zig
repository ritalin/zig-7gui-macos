const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

const NSControl = appKit.NSControl;
const NSResponder = appKit.NSResponder;
const NSTextField = appKit.NSTextField;
const NSTextFieldDelegate = appKit.NSTextFieldDelegate;
const NSView = appKit.NSView;
const NSNotification = foundation.NSNotification;
const NSNotificationName = foundation.NSNotificationName;
const NSString = foundation.NSString;
const BOOL = runtime.BOOL;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
const ObjectResolver = runtime.ObjectResolver;

pub const NSComboBox = struct {
    pub const Self = @This();

    var DelegateResolver: ?*ObjectResolver(NSComboBox) = null;

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

    pub fn usesDataSource(self: Self) bool {
        return runtime.fromBOOL(backend.NSComboBoxMessages.usesDataSource(runtime.objectId(NSComboBox, self)));
    }

    pub fn setUsesDataSource(self: Self, _usesDataSource: bool) void {
        return backend.NSComboBoxMessages.setUsesDataSource(runtime.objectId(NSComboBox, self), runtime.toBOOL(_usesDataSource));
    }

    pub fn selectItemAtIndex(self: Self, _index: NSInteger) void {
        return backend.NSComboBoxMessages.selectItemAtIndex(runtime.objectId(NSComboBox, self), runtime.pass(NSInteger, _index));
    }

    pub fn deselectItemAtIndex(self: Self, _index: NSInteger) void {
        return backend.NSComboBoxMessages.deselectItemAtIndex(runtime.objectId(NSComboBox, self), runtime.pass(NSInteger, _index));
    }

    pub fn indexOfSelectedItem(self: Self) NSInteger {
        return backend.NSComboBoxMessages.indexOfSelectedItem(runtime.objectId(NSComboBox, self));
    }

    pub fn delegate(self: Self) ?NSComboBoxDelegate {
        return runtime.wrapOptionalObject(NSComboBoxDelegate, backend.NSComboBoxMessages.delegate(runtime.objectId(NSComboBox, self)));
    }

    pub fn setDelegate(self: Self, _delegate: ?NSComboBoxDelegate) void {
        return backend.NSComboBoxMessages.setDelegate(runtime.objectId(NSComboBox, self), runtime.objectIdOrNull(NSComboBoxDelegate, _delegate));
    }

    pub fn dataSource(self: Self) ?NSComboBoxDataSource {
        return runtime.wrapOptionalObject(NSComboBoxDataSource, backend.NSComboBoxMessages.dataSource(runtime.objectId(NSComboBox, self)));
    }

    pub fn setDataSource(self: Self, _dataSource: ?NSComboBoxDataSource) void {
        return backend.NSComboBoxMessages.setDataSource(runtime.objectId(NSComboBox, self), runtime.objectIdOrNull(NSComboBoxDataSource, _dataSource));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSComboBoxMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSComboBox,
                NSControl,
                NSObject,
                NSResponder,
                NSTextField,
                NSView,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
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
                    const _class_name = runtime.backend_support.concreteTypeName("NSComboBoxDataSource", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSComboBoxDataSourceMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSComboBoxDataSource.Protocol(ContextType).Dispatch(_delegate_handlers.handler_combo_box_data_source).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSComboBoxDataSourceMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSComboBoxDataSource, _id);
                        runtime.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchNumberOfItemsInComboBox(_id: objc.c.id, _: objc.c.SEL, _comboBox: objc.c.id) NSInteger {
                        if (_delegate_handler.numberOfItemsInComboBox) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var comboBox = runtime.wrapObject(NSComboBox, objc.Object.fromId(_comboBox));
                            return handler(context, comboBox) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchComboBoxObjectValueForItemAtIndex(_id: objc.c.id, _: objc.c.SEL, _comboBox: objc.c.id, _index: NSInteger) objc.c.id {
                        if (_delegate_handler.comboBoxObjectValueForItemAtIndex) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var comboBox = runtime.wrapObject(NSComboBox, objc.Object.fromId(_comboBox));
                            return runtime.unwrapObject(handler(context, comboBox, _index) catch {
                                unreachable;
                            });
                        }
                        unreachable;
                    }

                    fn dispatchComboBoxIndexOfItemWithStringValue(_id: objc.c.id, _: objc.c.SEL, _comboBox: objc.c.id, _string: objc.c.id) NSUInteger {
                        if (_delegate_handler.comboBoxIndexOfItemWithStringValue) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var comboBox = runtime.wrapObject(NSComboBox, objc.Object.fromId(_comboBox));
                            var string = runtime.wrapObject(NSString, objc.Object.fromId(_string));
                            return handler(context, comboBox, string) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchComboBoxCompletedString(_id: objc.c.id, _: objc.c.SEL, _comboBox: objc.c.id, _string: objc.c.id) objc.c.id {
                        if (_delegate_handler.comboBoxCompletedString) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var comboBox = runtime.wrapObject(NSComboBox, objc.Object.fromId(_comboBox));
                            var string = runtime.wrapObject(NSString, objc.Object.fromId(_string));
                            return runtime.wrapObject(NSString, handler(context, comboBox, string) catch {
                                unreachable;
                            });
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.numberOfItemsInComboBox != null) {
                            backend.NSComboBoxDataSourceMessages.registerNumberOfItemsInComboBox(_class, &dispatchNumberOfItemsInComboBox);
                        }
                        if (_delegate_handler.comboBoxObjectValueForItemAtIndex != null) {
                            backend.NSComboBoxDataSourceMessages.registerComboBoxObjectValueForItemAtIndex(_class, &dispatchComboBoxObjectValueForItemAtIndex);
                        }
                        if (_delegate_handler.comboBoxIndexOfItemWithStringValue != null) {
                            backend.NSComboBoxDataSourceMessages.registerComboBoxIndexOfItemWithStringValue(_class, &dispatchComboBoxIndexOfItemWithStringValue);
                        }
                        if (_delegate_handler.comboBoxCompletedString != null) {
                            backend.NSComboBoxDataSourceMessages.registerComboBoxCompletedString(_class, &dispatchComboBoxCompletedString);
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_combo_box_data_source: NSComboBoxDataSource.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                numberOfItemsInComboBox: ?(*const fn (context: *ContextType, _comboBox: NSComboBox) anyerror!NSInteger) = null,
                comboBoxObjectValueForItemAtIndex: ?(*const fn (context: *ContextType, _comboBox: NSComboBox, _index: NSInteger) anyerror!objc.Object) = null,
                comboBoxIndexOfItemWithStringValue: ?(*const fn (context: *ContextType, _comboBox: NSComboBox, _string: NSString) anyerror!NSUInteger) = null,
                comboBoxCompletedString: ?(*const fn (context: *ContextType, _comboBox: NSComboBox, _string: NSString) anyerror!NSString) = null,
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
                    const _class_name = runtime.backend_support.concreteTypeName("NSComboBoxDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSComboBoxDelegateMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSComboBoxDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_combo_box_delegate).initClass(class);
                            NSTextFieldDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_field_delegate).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSComboBoxDelegateMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSComboBoxDelegate, _id);
                        runtime.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchComboBoxSelectionDidChange(_id: objc.c.id, _: objc.c.SEL, _notification: objc.c.id) void {
                        if (_delegate_handler.comboBoxSelectionDidChange) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var notification = runtime.wrapObject(NSNotification, objc.Object.fromId(_notification));
                            return handler(context, notification) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.comboBoxSelectionDidChange != null) {
                            backend.NSComboBoxDelegateMessages.registerComboBoxSelectionDidChange(_class, &dispatchComboBoxSelectionDidChange);
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_combo_box_delegate: NSComboBoxDelegate.Protocol(ContextType).Handler = .{},
                handler_text_field_delegate: NSTextFieldDelegate.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                comboBoxSelectionDidChange: ?(*const fn (context: *ContextType, _notification: NSNotification) anyerror!void) = null,
            };
        };
    }
};
