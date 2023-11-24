const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const runtime = @import("Runtime");

const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;

pub const NSResponder = struct {
    pub const Self = @This();

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

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSResponderMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSObject,
                NSResponder,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{});
        }
    };
};

pub const NSStandardKeyBindingResponding = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime.backend_support.concreteTypeName("NSStandardKeyBindingResponding", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSStandardKeyBindingRespondingMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            NSStandardKeyBindingResponding.Protocol(ContextType).Dispatch(_delegate_handlers.handler_standard_key_binding_responding).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSStandardKeyBindingRespondingMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSStandardKeyBindingResponding, _id);
                        runtime.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchInsertTab(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertTab) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertBacktab(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertBacktab) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertNewline(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertNewline) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertParagraphSeparator(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertParagraphSeparator) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertNewlineIgnoringFieldEditor(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertNewlineIgnoringFieldEditor) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertTabIgnoringFieldEditor(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertTabIgnoringFieldEditor) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertLineBreak(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertLineBreak) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertContainerBreak(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertContainerBreak) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertSingleQuoteIgnoringSubstitution(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertSingleQuoteIgnoringSubstitution) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertDoubleQuoteIgnoringSubstitution(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertDoubleQuoteIgnoringSubstitution) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.insertTab != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertTab(_class, &dispatchInsertTab);
                        }
                        if (_delegate_handler.insertBacktab != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertBacktab(_class, &dispatchInsertBacktab);
                        }
                        if (_delegate_handler.insertNewline != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertNewline(_class, &dispatchInsertNewline);
                        }
                        if (_delegate_handler.insertParagraphSeparator != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertParagraphSeparator(_class, &dispatchInsertParagraphSeparator);
                        }
                        if (_delegate_handler.insertNewlineIgnoringFieldEditor != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertNewlineIgnoringFieldEditor(_class, &dispatchInsertNewlineIgnoringFieldEditor);
                        }
                        if (_delegate_handler.insertTabIgnoringFieldEditor != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertTabIgnoringFieldEditor(_class, &dispatchInsertTabIgnoringFieldEditor);
                        }
                        if (_delegate_handler.insertLineBreak != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertLineBreak(_class, &dispatchInsertLineBreak);
                        }
                        if (_delegate_handler.insertContainerBreak != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertContainerBreak(_class, &dispatchInsertContainerBreak);
                        }
                        if (_delegate_handler.insertSingleQuoteIgnoringSubstitution != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertSingleQuoteIgnoringSubstitution(_class, &dispatchInsertSingleQuoteIgnoringSubstitution);
                        }
                        if (_delegate_handler.insertDoubleQuoteIgnoringSubstitution != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertDoubleQuoteIgnoringSubstitution(_class, &dispatchInsertDoubleQuoteIgnoringSubstitution);
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
                handler_standard_key_binding_responding: NSStandardKeyBindingResponding.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                insertTab: ?(*const fn (context: *ContextType, _sender: objc.Object) anyerror!void) = null,
                insertBacktab: ?(*const fn (context: *ContextType, _sender: objc.Object) anyerror!void) = null,
                insertNewline: ?(*const fn (context: *ContextType, _sender: objc.Object) anyerror!void) = null,
                insertParagraphSeparator: ?(*const fn (context: *ContextType, _sender: objc.Object) anyerror!void) = null,
                insertNewlineIgnoringFieldEditor: ?(*const fn (context: *ContextType, _sender: objc.Object) anyerror!void) = null,
                insertTabIgnoringFieldEditor: ?(*const fn (context: *ContextType, _sender: objc.Object) anyerror!void) = null,
                insertLineBreak: ?(*const fn (context: *ContextType, _sender: objc.Object) anyerror!void) = null,
                insertContainerBreak: ?(*const fn (context: *ContextType, _sender: objc.Object) anyerror!void) = null,
                insertSingleQuoteIgnoringSubstitution: ?(*const fn (context: *ContextType, _sender: objc.Object) anyerror!void) = null,
                insertDoubleQuoteIgnoringSubstitution: ?(*const fn (context: *ContextType, _sender: objc.Object) anyerror!void) = null,
            };
        };
    }
};
