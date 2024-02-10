const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTextView = struct {
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

    pub fn textStorage(self: Self) ?NSTextStorage {
        return runtime_support.wrapObject(?NSTextStorage, backend.NSTextViewMessages.textStorage(runtime_support.objectId(NSTextView, self)));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSTextViewMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSTextView,
                NSText,
                NSView,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSAccessibilityNavigableStaticText,
                NSColorChanging,
                NSDraggingSource,
                NSMenuItemValidation,
                NSStandardKeyBindingResponding,
                NSTextContent,
                NSTextInput,
                NSTextInputClient,
                NSTextLayoutOrientationProvider,
                NSUserInterfaceValidations,
                NSAccessibilityStaticText,
                NSObjectProtocol,
                NSAccessibilityElement,
            });
        }
    };

    pub const Self = @This();
    pub const Checking = NSTextCheckingForNSTextView;
    pub const Sharing = NSSharingForNSTextView;
};

const NSTextCheckingForNSTextView = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    pub fn setAutomaticQuoteSubstitutionEnabled(self: Category, _automaticQuoteSubstitutionEnabled: bool) void {
        return backend.NSTextCheckingForNSTextViewMessages.setAutomaticQuoteSubstitutionEnabled(runtime_support.objectId(NSTextCheckingForNSTextView, self), runtime_support.toBOOL(_automaticQuoteSubstitutionEnabled));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSTextView;
};

const NSSharingForNSTextView = struct {
    _id: objc.Object,

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.CategoryUpperCast(Category, Category.Constructor).of(DesiredType);
    }

    pub fn delegate(self: Category) ?NSTextViewDelegate {
        return runtime_support.wrapObject(?NSTextViewDelegate, backend.NSSharingForNSTextViewMessages.delegate(runtime_support.objectId(NSSharingForNSTextView, self)));
    }

    pub fn setDelegate(self: Category, _delegate: ?NSTextViewDelegate) void {
        return backend.NSSharingForNSTextViewMessages.setDelegate(runtime_support.objectId(NSSharingForNSTextView, self), runtime_support.objectId(?NSTextViewDelegate, _delegate));
    }

    pub fn isEditable(self: Category) bool {
        return runtime_support.fromBOOL(backend.NSSharingForNSTextViewMessages.isEditable(runtime_support.objectId(NSSharingForNSTextView, self)));
    }

    pub fn setEditable(self: Category, _editable: bool) void {
        return backend.NSSharingForNSTextViewMessages.setEditable(runtime_support.objectId(NSSharingForNSTextView, self), runtime_support.toBOOL(_editable));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    const Category = @This();
    pub const Self = NSTextView;
};

pub const NSFindPanelAction = struct {
    _value: NSUInteger,

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
};

pub const NSSelectionAffinity = struct {
    _value: NSUInteger,

    pub const Upstream: NSSelectionAffinity = .{
        ._value = 0,
    };
    pub const Downstream: NSSelectionAffinity = .{
        ._value = 1,
    };
};

pub const NSSelectionGranularity = struct {
    _value: NSUInteger,

    pub const SelectByCharacter: NSSelectionGranularity = .{
        ._value = 0,
    };
    pub const SelectByWord: NSSelectionGranularity = .{
        ._value = 1,
    };
    pub const SelectByParagraph: NSSelectionGranularity = .{
        ._value = 2,
    };
};

pub const NSFindPanelSubstringMatchType = struct {
    _value: NSUInteger,

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
};

pub const NSTextViewDelegate = struct {
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
                            const class = backend.NSTextViewDelegateMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSTextViewDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_view_delegate).initClass(class);
                            NSTextDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_text_delegate).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSTextViewDelegateMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSTextViewDelegate, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSTextViewDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchTextViewDoCommandBySelector(_id: objc.c.id, _: objc.c.SEL, _textView: objc.c.id, _commandSelector: objc.c.SEL) objc.c.BOOL {
                        if (_delegate_handler.textViewDoCommandBySelector) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const textView = runtime_support.wrapObject(NSTextView, objc.Object.fromId(_textView));
                            const commandSelector = runtime_support.wrapSelector(_commandSelector);
                            return runtime_support.toBOOL(handler(context, textView, commandSelector) catch {
                                unreachable;
                            });
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.textViewDoCommandBySelector != null) {
                            backend.NSTextViewDelegateMessages.registerTextViewDoCommandBySelector(_class, @constCast(&dispatchTextViewDoCommandBySelector));
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_text_view_delegate: NSTextViewDelegate.Protocol(ContextType).Handler = .{},
                handler_text_delegate: NSTextDelegate.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                textViewDoCommandBySelector: ?*const fn (context: *ContextType, _: NSTextView, _: objc.Sel) anyerror!bool = null,
            };
        };
    }

    pub const Self = @This();
};

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAccessibilityNavigableStaticText = appKit.NSAccessibilityNavigableStaticText;
const NSAccessibilityStaticText = appKit.NSAccessibilityStaticText;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSChangeSpelling = appKit.NSChangeSpelling;
const NSColorChanging = appKit.NSColorChanging;
const NSDraggingDestination = appKit.NSDraggingDestination;
const NSDraggingSource = appKit.NSDraggingSource;
const NSIgnoreMisspelledWords = appKit.NSIgnoreMisspelledWords;
const NSMenuItemValidation = appKit.NSMenuItemValidation;
const NSResponder = appKit.NSResponder;
const NSStandardKeyBindingResponding = appKit.NSStandardKeyBindingResponding;
const NSText = appKit.NSText;
const NSTextContent = appKit.NSTextContent;
const NSTextDelegate = appKit.NSTextDelegate;
const NSTextInput = appKit.NSTextInput;
const NSTextInputClient = appKit.NSTextInputClient;
const NSTextLayoutOrientationProvider = appKit.NSTextLayoutOrientationProvider;
const NSTextStorage = appKit.NSTextStorage;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSUserInterfaceValidations = appKit.NSUserInterfaceValidations;
const NSView = appKit.NSView;
const NSCoding = foundation.NSCoding;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
