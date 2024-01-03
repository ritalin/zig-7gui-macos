const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const coreGraphics = @import("CoreGraphics");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTableViewMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSTableView").?;
    }

    pub fn dataSource(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSTableViewSelectors.dataSource(), .{}));
    }

    pub fn setDataSource(self: objc.Object, _dataSource: ?objc.Object) void {
        return self.msgSend(void, selector.NSTableViewSelectors.setDataSource(), .{
            runtime_support.unwrapOptionalObject(_dataSource),
        });
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSTableViewSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, selector.NSTableViewSelectors.setDelegate(), .{
            runtime_support.unwrapOptionalObject(_delegate),
        });
    }

    pub fn headerView(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSTableViewSelectors.headerView(), .{}));
    }

    pub fn setHeaderView(self: objc.Object, _headerView: ?objc.Object) void {
        return self.msgSend(void, selector.NSTableViewSelectors.setHeaderView(), .{
            runtime_support.unwrapOptionalObject(_headerView),
        });
    }

    pub fn rowHeight(self: objc.Object) CGFloat {
        return self.msgSend(CGFloat, selector.NSTableViewSelectors.rowHeight(), .{});
    }

    pub fn setRowHeight(self: objc.Object, _rowHeight: CGFloat) void {
        return self.msgSend(void, selector.NSTableViewSelectors.setRowHeight(), .{
            _rowHeight,
        });
    }

    pub fn noteHeightOfRowsWithIndexesChanged(self: objc.Object, _indexSet: objc.Object) void {
        return self.msgSend(void, selector.NSTableViewSelectors.noteHeightOfRowsWithIndexesChanged(), .{
            runtime_support.unwrapOptionalObject(_indexSet),
        });
    }

    pub fn addTableColumn(self: objc.Object, _tableColumn: objc.Object) void {
        return self.msgSend(void, selector.NSTableViewSelectors.addTableColumn(), .{
            runtime_support.unwrapOptionalObject(_tableColumn),
        });
    }

    pub fn scrollRowToVisible(self: objc.Object, _row: NSInteger) void {
        return self.msgSend(void, selector.NSTableViewSelectors.scrollRowToVisible(), .{
            _row,
        });
    }

    pub fn reloadDataForRowIndexesColumnIndexes(self: objc.Object, _rowIndexes: objc.Object, _columnIndexes: objc.Object) void {
        return self.msgSend(void, selector.NSTableViewSelectors.reloadDataForRowIndexesColumnIndexes(), .{
            runtime_support.unwrapOptionalObject(_rowIndexes),
            runtime_support.unwrapOptionalObject(_columnIndexes),
        });
    }

    pub fn selectedRow(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSTableViewSelectors.selectedRow(), .{});
    }

    pub fn numberOfSelectedRows(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSTableViewSelectors.numberOfSelectedRows(), .{});
    }

    pub fn beginUpdates(self: objc.Object) void {
        return self.msgSend(void, selector.NSTableViewSelectors.beginUpdates(), .{});
    }

    pub fn endUpdates(self: objc.Object) void {
        return self.msgSend(void, selector.NSTableViewSelectors.endUpdates(), .{});
    }

    pub fn insertRowsAtIndexesWithAnimation(self: objc.Object, _indexes: objc.Object, _animationOptions: NSUInteger) void {
        return self.msgSend(void, selector.NSTableViewSelectors.insertRowsAtIndexesWithAnimation(), .{
            runtime_support.unwrapOptionalObject(_indexes),
            _animationOptions,
        });
    }

    pub fn removeRowsAtIndexesWithAnimation(self: objc.Object, _indexes: objc.Object, _animationOptions: NSUInteger) void {
        return self.msgSend(void, selector.NSTableViewSelectors.removeRowsAtIndexesWithAnimation(), .{
            runtime_support.unwrapOptionalObject(_indexes),
            _animationOptions,
        });
    }

    pub fn hideRowsAtIndexesWithAnimation(self: objc.Object, _indexes: objc.Object, _rowAnimation: NSUInteger) void {
        return self.msgSend(void, selector.NSTableViewSelectors.hideRowsAtIndexesWithAnimation(), .{
            runtime_support.unwrapOptionalObject(_indexes),
            _rowAnimation,
        });
    }

    pub fn unhideRowsAtIndexesWithAnimation(self: objc.Object, _indexes: objc.Object, _rowAnimation: NSUInteger) void {
        return self.msgSend(void, selector.NSTableViewSelectors.unhideRowsAtIndexesWithAnimation(), .{
            runtime_support.unwrapOptionalObject(_indexes),
            _rowAnimation,
        });
    }

    pub fn hiddenRowIndexes(self: objc.Object) objc.Object {
        return self.msgSend(objc.Object, selector.NSTableViewSelectors.hiddenRowIndexes(), .{});
    }
};

pub const NSTableViewDataSourceMessages = struct {
    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSTableViewDataSource");
        }
        return class.?;
    }

    pub fn registerNumberOfRowsInTableView(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "numberOfRowsInTableView:", runtime_support.wrapDelegateHandler(_handler), "q24@0:8@16");
    }

    pub fn registerTableViewObjectValueForTableColumnRow(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "tableView:objectValueForTableColumn:row:", runtime_support.wrapDelegateHandler(_handler), "@40@0:8@16@24q32");
    }

    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;
};

pub const NSTableViewDelegateMessages = struct {
    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSTableViewDelegate");
        }
        return class.?;
    }

    pub fn registerTableViewDidRemoveRowViewForRow(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "tableView:didRemoveRowView:forRow:", runtime_support.wrapDelegateHandler(_handler), "v40@0:8@16@24q32");
    }

    pub fn registerTableViewHeightOfRow(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "tableView:heightOfRow:", runtime_support.wrapDelegateHandler(_handler), "d32@0:8@16q24");
    }

    pub fn registerTableViewSelectionDidChange(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "tableViewSelectionDidChange:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;
};

const CGFloat = coreGraphics.CGFloat;
const NSInteger = runtime.NSInteger;
const NSUInteger = runtime.NSUInteger;
