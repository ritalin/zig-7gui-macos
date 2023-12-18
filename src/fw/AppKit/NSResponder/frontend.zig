const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSCoding = foundation.NSCoding;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;

pub const NSResponder = struct {
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

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSResponderMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSCoding,
            });
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
                    const _class_name = runtime_support.backend_support.concreteTypeName("NSStandardKeyBindingResponding", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            const class = backend.NSStandardKeyBindingRespondingMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSStandardKeyBindingResponding.Protocol(ContextType).Dispatch(_delegate_handlers.handler_standard_key_binding_responding).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSStandardKeyBindingRespondingMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSStandardKeyBindingResponding, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchInsertTab(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertTab) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertBacktab(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertBacktab) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertNewline(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertNewline) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertParagraphSeparator(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertParagraphSeparator) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertNewlineIgnoringFieldEditor(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertNewlineIgnoringFieldEditor) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertTabIgnoringFieldEditor(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertTabIgnoringFieldEditor) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertLineBreak(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertLineBreak) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertContainerBreak(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertContainerBreak) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertSingleQuoteIgnoringSubstitution(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertSingleQuoteIgnoringSubstitution) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchInsertDoubleQuoteIgnoringSubstitution(_id: objc.c.id, _: objc.c.SEL, _sender: objc.c.id) void {
                        if (_delegate_handler.insertDoubleQuoteIgnoringSubstitution) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const sender = objc.Object.fromId(_sender);
                            return handler(context, sender) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.insertTab != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertTab(_class, @constCast(&dispatchInsertTab));
                        }
                        if (_delegate_handler.insertBacktab != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertBacktab(_class, @constCast(&dispatchInsertBacktab));
                        }
                        if (_delegate_handler.insertNewline != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertNewline(_class, @constCast(&dispatchInsertNewline));
                        }
                        if (_delegate_handler.insertParagraphSeparator != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertParagraphSeparator(_class, @constCast(&dispatchInsertParagraphSeparator));
                        }
                        if (_delegate_handler.insertNewlineIgnoringFieldEditor != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertNewlineIgnoringFieldEditor(_class, @constCast(&dispatchInsertNewlineIgnoringFieldEditor));
                        }
                        if (_delegate_handler.insertTabIgnoringFieldEditor != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertTabIgnoringFieldEditor(_class, @constCast(&dispatchInsertTabIgnoringFieldEditor));
                        }
                        if (_delegate_handler.insertLineBreak != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertLineBreak(_class, @constCast(&dispatchInsertLineBreak));
                        }
                        if (_delegate_handler.insertContainerBreak != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertContainerBreak(_class, @constCast(&dispatchInsertContainerBreak));
                        }
                        if (_delegate_handler.insertSingleQuoteIgnoringSubstitution != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertSingleQuoteIgnoringSubstitution(_class, @constCast(&dispatchInsertSingleQuoteIgnoringSubstitution));
                        }
                        if (_delegate_handler.insertDoubleQuoteIgnoringSubstitution != null) {
                            backend.NSStandardKeyBindingRespondingMessages.registerInsertDoubleQuoteIgnoringSubstitution(_class, @constCast(&dispatchInsertDoubleQuoteIgnoringSubstitution));
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_standard_key_binding_responding: NSStandardKeyBindingResponding.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                insertTab: ?*const fn (context: *ContextType, _: ?objc.Object) anyerror!void = null,
                insertBacktab: ?*const fn (context: *ContextType, _: ?objc.Object) anyerror!void = null,
                insertNewline: ?*const fn (context: *ContextType, _: ?objc.Object) anyerror!void = null,
                insertParagraphSeparator: ?*const fn (context: *ContextType, _: ?objc.Object) anyerror!void = null,
                insertNewlineIgnoringFieldEditor: ?*const fn (context: *ContextType, _: ?objc.Object) anyerror!void = null,
                insertTabIgnoringFieldEditor: ?*const fn (context: *ContextType, _: ?objc.Object) anyerror!void = null,
                insertLineBreak: ?*const fn (context: *ContextType, _: ?objc.Object) anyerror!void = null,
                insertContainerBreak: ?*const fn (context: *ContextType, _: ?objc.Object) anyerror!void = null,
                insertSingleQuoteIgnoringSubstitution: ?*const fn (context: *ContextType, _: ?objc.Object) anyerror!void = null,
                insertDoubleQuoteIgnoringSubstitution: ?*const fn (context: *ContextType, _: ?objc.Object) anyerror!void = null,
            };
        };
    }
};
