const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");

pub const NSPasteboardTypeFindPanelSearchOptionKey = NSString;
const NSResponder = appKit.NSResponder;
const NSStandardKeyBindingResponding = appKit.NSStandardKeyBindingResponding;
const NSText = appKit.NSText;
const NSTextDelegate = appKit.NSTextDelegate;
const NSTextStorage = appKit.NSTextStorage;
const NSView = appKit.NSView;
const NSNotificationName = foundation.NSNotificationName;
const NSString = foundation.NSString;
const BOOL = runtime.BOOL;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;

pub const NSTextView = struct {
    pub const Self = @This();
    pub const Sharing = NSSharingForNSTextView;

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

    pub fn textStorage(self: Self) ?NSTextStorage {
        return runtime.wrapOptionalObject(NSTextStorage, backend.NSTextViewMessages.textStorage(runtime.objectId(NSTextView, self)));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const Support = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSTextViewMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSObject,
                NSResponder,
                NSText,
                NSTextView,
                NSView,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime.typeConstraints(DesiredType.Self, .{
                NSStandardKeyBindingResponding,
            });
        }
    };
};

const NSSharingForNSTextView = struct {
    const Category = @This();
    pub const Self = NSTextView;

    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    pub fn delegate(self: Category) ?NSTextViewDelegate {
        return runtime.wrapOptionalObject(NSTextViewDelegate, backend.NSSharingForNSTextViewMessages.delegate(runtime.objectId(NSSharingForNSTextView, self)));
    }

    pub fn setDelegate(self: Category, _delegate: ?NSTextViewDelegate) void {
        return backend.NSSharingForNSTextViewMessages.setDelegate(runtime.objectId(NSSharingForNSTextView, self), runtime.objectIdOrNull(NSTextViewDelegate, _delegate));
    }

    pub fn isEditable(self: Category) bool {
        return runtime.fromBOOL(backend.NSSharingForNSTextViewMessages.isEditable(runtime.objectId(NSSharingForNSTextView, self)));
    }

    pub fn setEditable(self: Category, _editable: bool) void {
        return backend.NSSharingForNSTextViewMessages.setEditable(runtime.objectId(NSSharingForNSTextView, self), runtime.toBOOL(_editable));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }
};

pub const NSFindPanelAction = struct {
    pub const ShowFindPanel: NSFindPanelAction = .{
        ._value = 1,
    };
    pub const Next: NSFindPanelAction = .{
        ._value = 2,
    };
    pub const Previous: NSFindPanelAction = .{
        ._value = 3,
    };
    pub const ReplaceAll: NSFindPanelAction = .{
        ._value = 4,
    };
    pub const Replace: NSFindPanelAction = .{
        ._value = 5,
    };
    pub const ReplaceAndFind: NSFindPanelAction = .{
        ._value = 6,
    };
    pub const SetFindString: NSFindPanelAction = .{
        ._value = 7,
    };
    pub const ReplaceAllInSelection: NSFindPanelAction = .{
        ._value = 8,
    };
    pub const SelectAll: NSFindPanelAction = .{
        ._value = 9,
    };
    pub const SelectAllInSelection: NSFindPanelAction = .{
        ._value = 10,
    };

    _value: NSUInteger,
};

pub const NSSelectionAffinity = struct {
    pub const Upstream: NSSelectionAffinity = .{
        ._value = 0,
    };
    pub const Downstream: NSSelectionAffinity = .{
        ._value = 1,
    };

    _value: NSUInteger,
};

pub const NSSelectionGranularity = struct {
    pub const SelectByCharacter: NSSelectionGranularity = .{
        ._value = 0,
    };
    pub const SelectByWord: NSSelectionGranularity = .{
        ._value = 1,
    };
    pub const SelectByParagraph: NSSelectionGranularity = .{
        ._value = 2,
    };

    _value: NSUInteger,
};

pub const NSFindPanelSubstringMatchType = struct {
    pub const Contains: NSFindPanelSubstringMatchType = .{
        ._value = 0,
    };
    pub const StartsWith: NSFindPanelSubstringMatchType = .{
        ._value = 1,
    };
    pub const FullWord: NSFindPanelSubstringMatchType = .{
        ._value = 2,
    };
    pub const EndsWith: NSFindPanelSubstringMatchType = .{
        ._value = 3,
    };

    _value: NSUInteger,
};

pub const NSTextViewDelegate = struct {
    pub const Self = @This();

    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    const _class_name = runtime.backend_support.concreteTypeName("NSTextViewDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;

                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            var class = backend.NSTextViewDelegateMessages.initClass(_class_name);
                            runtime.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSTextDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_delegate).initClass(class);
                            NSTextViewDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_view_delegate).initClass(class);
                            runtime.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        var _id = backend.NSTextViewDelegateMessages.init(_class.?);
                        var _instance = runtime.wrapObject(NSTextViewDelegate, _id);
                        runtime.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchTextViewDoCommandBySelector(_id: objc.c.id, _: objc.c.SEL, _textView: objc.c.id, _commandSelector: objc.c.SEL) BOOL {
                        if (_delegate_handler.textViewDoCommandBySelector) |handler| {
                            var context = runtime.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            var textView = runtime.wrapObject(NSTextView, objc.Object.fromId(_textView));
                            var commandSelector = runtime.wrapSelector(_commandSelector);
                            return runtime.toBOOL(handler(context, textView, commandSelector) catch {
                                unreachable;
                            });
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.textViewDoCommandBySelector != null) {
                            backend.NSTextViewDelegateMessages.registerTextViewDoCommandBySelector(_class, &dispatchTextViewDoCommandBySelector);
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_text_delegate: NSTextDelegate.Protocol(ContextType).Handler = .{},
                handler_text_view_delegate: NSTextViewDelegate.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                textViewDoCommandBySelector: ?(*const fn (context: *ContextType, _textView: NSTextView, _commandSelector: objc.Sel) anyerror!bool) = null,
            };
        };
    }
};
