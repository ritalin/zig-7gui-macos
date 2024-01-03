const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const coreGraphics = @import("CoreGraphics");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTableViewAnimationOptions = runtime_support.EnumOptions(enum(NSUInteger) {
    EffectFade = 0x1,
    EffectGap = 0x2,
    SlideUp = 0x10,
    SlideDown = 0x20,
    SlideRight = 0x40,
});

pub const NSTableViewGridLineStyle = runtime_support.EnumOptions(enum(NSUInteger) {
    SolidVertical = 1 << 0,
    SolidHorizontal = 1 << 1,
    DashedHorizontal = 1 << 3,
});

pub const NSTableView = struct {
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

    pub fn dataSource(self: Self) ?NSTableViewDataSource {
        return runtime_support.wrapObject(?NSTableViewDataSource, backend.NSTableViewMessages.dataSource(runtime_support.objectId(NSTableView, self)));
    }

    pub fn setDataSource(self: Self, _dataSource: ?NSTableViewDataSource) void {
        return backend.NSTableViewMessages.setDataSource(runtime_support.objectId(NSTableView, self), runtime_support.objectId(?NSTableViewDataSource, _dataSource));
    }

    pub fn delegate(self: Self) ?NSTableViewDelegate {
        return runtime_support.wrapObject(?NSTableViewDelegate, backend.NSTableViewMessages.delegate(runtime_support.objectId(NSTableView, self)));
    }

    pub fn setDelegate(self: Self, _delegate: ?NSTableViewDelegate) void {
        return backend.NSTableViewMessages.setDelegate(runtime_support.objectId(NSTableView, self), runtime_support.objectId(?NSTableViewDelegate, _delegate));
    }

    pub fn headerView(self: Self) ?NSTableHeaderView {
        return runtime_support.wrapObject(?NSTableHeaderView, backend.NSTableViewMessages.headerView(runtime_support.objectId(NSTableView, self)));
    }

    pub fn setHeaderView(self: Self, _headerView: ?NSTableHeaderView) void {
        return backend.NSTableViewMessages.setHeaderView(runtime_support.objectId(NSTableView, self), runtime_support.objectId(?NSTableHeaderView, _headerView));
    }

    pub fn rowHeight(self: Self) CGFloat {
        return backend.NSTableViewMessages.rowHeight(runtime_support.objectId(NSTableView, self));
    }

    pub fn setRowHeight(self: Self, _rowHeight: CGFloat) void {
        return backend.NSTableViewMessages.setRowHeight(runtime_support.objectId(NSTableView, self), runtime_support.pass(CGFloat, _rowHeight));
    }

    pub fn noteHeightOfRowsWithIndexesChanged(self: Self, _indexSet: NSIndexSet) void {
        return backend.NSTableViewMessages.noteHeightOfRowsWithIndexesChanged(runtime_support.objectId(NSTableView, self), runtime_support.objectId(NSIndexSet, _indexSet));
    }

    pub fn addTableColumn(self: Self, _tableColumn: NSTableColumn) void {
        return backend.NSTableViewMessages.addTableColumn(runtime_support.objectId(NSTableView, self), runtime_support.objectId(NSTableColumn, _tableColumn));
    }

    pub fn scrollRowToVisible(self: Self, _row: NSInteger) void {
        return backend.NSTableViewMessages.scrollRowToVisible(runtime_support.objectId(NSTableView, self), runtime_support.pass(NSInteger, _row));
    }

    pub fn reloadDataForRowIndexesColumnIndexes(self: Self, _rowIndexes: NSIndexSet, _columnIndexes: NSIndexSet) void {
        return backend.NSTableViewMessages.reloadDataForRowIndexesColumnIndexes(runtime_support.objectId(NSTableView, self), runtime_support.objectId(NSIndexSet, _rowIndexes), runtime_support.objectId(NSIndexSet, _columnIndexes));
    }

    pub fn selectedRow(self: Self) NSInteger {
        return backend.NSTableViewMessages.selectedRow(runtime_support.objectId(NSTableView, self));
    }

    pub fn numberOfSelectedRows(self: Self) NSInteger {
        return backend.NSTableViewMessages.numberOfSelectedRows(runtime_support.objectId(NSTableView, self));
    }

    pub fn beginUpdates(self: Self) void {
        return backend.NSTableViewMessages.beginUpdates(runtime_support.objectId(NSTableView, self));
    }

    pub fn endUpdates(self: Self) void {
        return backend.NSTableViewMessages.endUpdates(runtime_support.objectId(NSTableView, self));
    }

    pub fn insertRowsAtIndexesWithAnimation(self: Self, _indexes: NSIndexSet, _animationOptions: NSTableViewAnimationOptions) void {
        return backend.NSTableViewMessages.insertRowsAtIndexesWithAnimation(runtime_support.objectId(NSTableView, self), runtime_support.objectId(NSIndexSet, _indexes), runtime_support.packOptions(NSTableViewAnimationOptions, _animationOptions));
    }

    pub fn removeRowsAtIndexesWithAnimation(self: Self, _indexes: NSIndexSet, _animationOptions: NSTableViewAnimationOptions) void {
        return backend.NSTableViewMessages.removeRowsAtIndexesWithAnimation(runtime_support.objectId(NSTableView, self), runtime_support.objectId(NSIndexSet, _indexes), runtime_support.packOptions(NSTableViewAnimationOptions, _animationOptions));
    }

    pub fn hideRowsAtIndexesWithAnimation(self: Self, _indexes: NSIndexSet, _rowAnimation: NSTableViewAnimationOptions) void {
        return backend.NSTableViewMessages.hideRowsAtIndexesWithAnimation(runtime_support.objectId(NSTableView, self), runtime_support.objectId(NSIndexSet, _indexes), runtime_support.packOptions(NSTableViewAnimationOptions, _rowAnimation));
    }

    pub fn unhideRowsAtIndexesWithAnimation(self: Self, _indexes: NSIndexSet, _rowAnimation: NSTableViewAnimationOptions) void {
        return backend.NSTableViewMessages.unhideRowsAtIndexesWithAnimation(runtime_support.objectId(NSTableView, self), runtime_support.objectId(NSIndexSet, _indexes), runtime_support.packOptions(NSTableViewAnimationOptions, _rowAnimation));
    }

    pub fn hiddenRowIndexes(self: Self) NSIndexSet {
        return runtime_support.wrapObject(NSIndexSet, backend.NSTableViewMessages.hiddenRowIndexes(runtime_support.objectId(NSTableView, self)));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSTableViewMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSTableView,
                NSControl,
                NSView,
                NSResponder,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSAccessibilityTable,
                NSDraggingSource,
                NSTextViewDelegate,
                NSUserInterfaceValidations,
                NSAccessibilityGroup,
                NSObjectProtocol,
                NSTextDelegate,
                NSAccessibilityElement,
            });
        }
    };

    pub const Self = @This();
};

pub const NSTableViewDropOperation = struct {
    _value: NSUInteger,

    pub const On: NSTableViewDropOperation = .{
        ._value = 0x0,
    };
    pub const Above: NSTableViewDropOperation = .{
        ._value = 0x1,
    };
};

pub const NSTableRowActionEdge = struct {
    _value: NSInteger,

    pub const Leading: NSTableRowActionEdge = .{
        ._value = 0x0,
    };
    pub const Trailing: NSTableRowActionEdge = .{
        ._value = 0x1,
    };
};

pub const NSTableViewDraggingDestinationFeedbackStyle = struct {
    _value: NSInteger,

    pub const None: NSTableViewDraggingDestinationFeedbackStyle = .{
        ._value = -1,
    };
    pub const Regular: NSTableViewDraggingDestinationFeedbackStyle = .{
        ._value = 0,
    };
    pub const SourceList: NSTableViewDraggingDestinationFeedbackStyle = .{
        ._value = 1,
    };
    pub const Gap: NSTableViewDraggingDestinationFeedbackStyle = .{
        ._value = 2,
    };
};

pub const NSTableViewSelectionHighlightStyle = struct {
    _value: NSInteger,

    pub const None: NSTableViewSelectionHighlightStyle = .{
        ._value = -1,
    };
    pub const Regular: NSTableViewSelectionHighlightStyle = .{
        ._value = 0,
    };
    pub const SourceList: NSTableViewSelectionHighlightStyle = .{
        ._value = 1,
    };
};

pub const NSTableViewStyle = struct {
    _value: NSInteger,

    pub const Automatic: NSTableViewStyle = .{
        ._value = 0x0,
    };
    pub const FullWidth: NSTableViewStyle = .{
        ._value = 0x1,
    };
    pub const Inset: NSTableViewStyle = .{
        ._value = 0x2,
    };
    pub const SourceList: NSTableViewStyle = .{
        ._value = 0x3,
    };
    pub const Plain: NSTableViewStyle = .{
        ._value = 0x4,
    };
};

pub const NSTableViewRowSizeStyle = struct {
    _value: NSInteger,

    pub const Default: NSTableViewRowSizeStyle = .{
        ._value = -1,
    };
    pub const Custom: NSTableViewRowSizeStyle = .{
        ._value = 0,
    };
    pub const Small: NSTableViewRowSizeStyle = .{
        ._value = 1,
    };
    pub const Medium: NSTableViewRowSizeStyle = .{
        ._value = 2,
    };
    pub const Large: NSTableViewRowSizeStyle = .{
        ._value = 3,
    };
};

pub const NSTableViewColumnAutoresizingStyle = struct {
    _value: NSUInteger,

    pub const No: NSTableViewColumnAutoresizingStyle = .{
        ._value = 0,
    };
    pub const Uniform: NSTableViewColumnAutoresizingStyle = .{
        ._value = 0x1,
    };
    pub const Sequential: NSTableViewColumnAutoresizingStyle = .{
        ._value = 0x2,
    };
    pub const ReverseSequential: NSTableViewColumnAutoresizingStyle = .{
        ._value = 0x3,
    };
    pub const Last: NSTableViewColumnAutoresizingStyle = .{
        ._value = 0x4,
    };
    pub const First: NSTableViewColumnAutoresizingStyle = .{
        ._value = 0x5,
    };
};

pub const NSTableViewDataSource = struct {
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
                            const class = backend.NSTableViewDataSourceMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSTableViewDataSource.Protocol(ContextType).Dispatch(_delegate_handlers.handler_table_view_data_source).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSTableViewDataSourceMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSTableViewDataSource, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSTableViewDataSource", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchNumberOfRowsInTableView(_id: objc.c.id, _: objc.c.SEL, _tableView: objc.c.id) NSInteger {
                        if (_delegate_handler.numberOfRowsInTableView) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const tableView = runtime_support.wrapObject(NSTableView, objc.Object.fromId(_tableView));
                            return handler(context, tableView) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchTableViewObjectValueForTableColumnRow(_id: objc.c.id, _: objc.c.SEL, _tableView: objc.c.id, _tableColumn: objc.c.id, _row: NSInteger) objc.c.id {
                        if (_delegate_handler.tableViewObjectValueForTableColumnRow) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const tableView = runtime_support.wrapObject(NSTableView, objc.Object.fromId(_tableView));
                            const tableColumn = runtime_support.wrapObject(?NSTableColumn, objc.Object.fromId(_tableColumn));
                            return runtime_support.unwrapOptionalObject(handler(context, tableView, tableColumn, _row) catch {
                                unreachable;
                            });
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.numberOfRowsInTableView != null) {
                            backend.NSTableViewDataSourceMessages.registerNumberOfRowsInTableView(_class, @constCast(&dispatchNumberOfRowsInTableView));
                        }
                        if (_delegate_handler.tableViewObjectValueForTableColumnRow != null) {
                            backend.NSTableViewDataSourceMessages.registerTableViewObjectValueForTableColumnRow(_class, @constCast(&dispatchTableViewObjectValueForTableColumnRow));
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_table_view_data_source: NSTableViewDataSource.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                numberOfRowsInTableView: ?*const fn (context: *ContextType, _: NSTableView) anyerror!NSInteger = null,
                tableViewObjectValueForTableColumnRow: ?*const fn (context: *ContextType, _: NSTableView, _: ?NSTableColumn, _: NSInteger) anyerror!?objc.Object = null,
            };
        };
    }

    pub const Self = @This();
};

pub const NSTableViewDelegate = struct {
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
                            const class = backend.NSTableViewDelegateMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            NSTableViewDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_table_view_delegate).initClass(class);
                            NSControlTextEditingDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_control_text_editing_delegate).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.NSTableViewDelegateMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(NSTableViewDelegate, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("NSTableViewDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchTableViewDidRemoveRowViewForRow(_id: objc.c.id, _: objc.c.SEL, _tableView: objc.c.id, _rowView: objc.c.id, _row: NSInteger) void {
                        if (_delegate_handler.tableViewDidRemoveRowViewForRow) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const tableView = runtime_support.wrapObject(NSTableView, objc.Object.fromId(_tableView));
                            const rowView = runtime_support.wrapObject(NSTableRowView, objc.Object.fromId(_rowView));
                            return handler(context, tableView, rowView, _row) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchTableViewHeightOfRow(_id: objc.c.id, _: objc.c.SEL, _tableView: objc.c.id, _row: NSInteger) CGFloat {
                        if (_delegate_handler.tableViewHeightOfRow) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const tableView = runtime_support.wrapObject(NSTableView, objc.Object.fromId(_tableView));
                            return handler(context, tableView, _row) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchTableViewSelectionDidChange(_id: objc.c.id, _: objc.c.SEL, _notification: objc.c.id) void {
                        if (_delegate_handler.tableViewSelectionDidChange) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const notification = runtime_support.wrapObject(NSNotification, objc.Object.fromId(_notification));
                            return handler(context, notification) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.tableViewDidRemoveRowViewForRow != null) {
                            backend.NSTableViewDelegateMessages.registerTableViewDidRemoveRowViewForRow(_class, @constCast(&dispatchTableViewDidRemoveRowViewForRow));
                        }
                        if (_delegate_handler.tableViewHeightOfRow != null) {
                            backend.NSTableViewDelegateMessages.registerTableViewHeightOfRow(_class, @constCast(&dispatchTableViewHeightOfRow));
                        }
                        if (_delegate_handler.tableViewSelectionDidChange != null) {
                            backend.NSTableViewDelegateMessages.registerTableViewSelectionDidChange(_class, @constCast(&dispatchTableViewSelectionDidChange));
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_table_view_delegate: NSTableViewDelegate.Protocol(ContextType).Handler = .{},
                handler_control_text_editing_delegate: NSControlTextEditingDelegate.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                tableViewDidRemoveRowViewForRow: ?*const fn (context: *ContextType, _: NSTableView, _: NSTableRowView, _: NSInteger) anyerror!void = null,
                tableViewHeightOfRow: ?*const fn (context: *ContextType, _: NSTableView, _: NSInteger) anyerror!CGFloat = null,
                tableViewSelectionDidChange: ?*const fn (context: *ContextType, _: NSNotification) anyerror!void = null,
            };
        };
    }

    pub const Self = @This();
};

const NSAccessibility = appKit.NSAccessibility;
const NSAccessibilityElement = appKit.NSAccessibilityElement;
const NSAccessibilityGroup = appKit.NSAccessibilityGroup;
const NSAccessibilityTable = appKit.NSAccessibilityTable;
const NSAnimatablePropertyContainer = appKit.NSAnimatablePropertyContainer;
const NSAppearanceCustomization = appKit.NSAppearanceCustomization;
const NSControl = appKit.NSControl;
const NSControlTextEditingDelegate = appKit.NSControlTextEditingDelegate;
const NSDraggingDestination = appKit.NSDraggingDestination;
const NSDraggingSource = appKit.NSDraggingSource;
const NSResponder = appKit.NSResponder;
const NSTableColumn = appKit.NSTableColumn;
const NSTableHeaderView = appKit.NSTableHeaderView;
const NSTableRowView = appKit.NSTableRowView;
const NSTextDelegate = appKit.NSTextDelegate;
const NSTextViewDelegate = appKit.NSTextViewDelegate;
const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSUserInterfaceItemIdentifier = appKit.NSUserInterfaceItemIdentifier;
const NSUserInterfaceValidations = appKit.NSUserInterfaceValidations;
const NSView = appKit.NSView;
const CGFloat = coreGraphics.CGFloat;
const NSCoding = foundation.NSCoding;
const NSIndexSet = foundation.NSIndexSet;
const NSNotification = foundation.NSNotification;
const NSNotificationName = foundation.NSNotificationName;
const NSInteger = runtime.NSInteger;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
