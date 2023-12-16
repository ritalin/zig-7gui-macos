const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSTableViewSelectors = struct {
    var _sel_dataSource: ?objc.Sel = null;
    var _sel_setDataSource: ?objc.Sel = null;
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;
    var _sel_headerView: ?objc.Sel = null;
    var _sel_setHeaderView: ?objc.Sel = null;
    var _sel_rowHeight: ?objc.Sel = null;
    var _sel_setRowHeight: ?objc.Sel = null;
    var _sel_noteHeightOfRowsWithIndexesChanged: ?objc.Sel = null;
    var _sel_addTableColumn: ?objc.Sel = null;
    var _sel_scrollRowToVisible: ?objc.Sel = null;
    var _sel_reloadDataForRowIndexesColumnIndexes: ?objc.Sel = null;
    var _sel_selectedRow: ?objc.Sel = null;
    var _sel_numberOfSelectedRows: ?objc.Sel = null;
    var _sel_beginUpdates: ?objc.Sel = null;
    var _sel_endUpdates: ?objc.Sel = null;
    var _sel_insertRowsAtIndexesWithAnimation: ?objc.Sel = null;
    var _sel_removeRowsAtIndexesWithAnimation: ?objc.Sel = null;
    var _sel_hideRowsAtIndexesWithAnimation: ?objc.Sel = null;
    var _sel_unhideRowsAtIndexesWithAnimation: ?objc.Sel = null;
    var _sel_hiddenRowIndexes: ?objc.Sel = null;

    pub fn dataSource() objc.Sel {
        if (_sel_dataSource == null) {
            _sel_dataSource = objc.Sel.registerName("dataSource");
        }
        return _sel_dataSource.?;
    }

    pub fn setDataSource() objc.Sel {
        if (_sel_setDataSource == null) {
            _sel_setDataSource = objc.Sel.registerName("setDataSource:");
        }
        return _sel_setDataSource.?;
    }

    pub fn delegate() objc.Sel {
        if (_sel_delegate == null) {
            _sel_delegate = objc.Sel.registerName("delegate");
        }
        return _sel_delegate.?;
    }

    pub fn setDelegate() objc.Sel {
        if (_sel_setDelegate == null) {
            _sel_setDelegate = objc.Sel.registerName("setDelegate:");
        }
        return _sel_setDelegate.?;
    }

    pub fn headerView() objc.Sel {
        if (_sel_headerView == null) {
            _sel_headerView = objc.Sel.registerName("headerView");
        }
        return _sel_headerView.?;
    }

    pub fn setHeaderView() objc.Sel {
        if (_sel_setHeaderView == null) {
            _sel_setHeaderView = objc.Sel.registerName("setHeaderView:");
        }
        return _sel_setHeaderView.?;
    }

    pub fn rowHeight() objc.Sel {
        if (_sel_rowHeight == null) {
            _sel_rowHeight = objc.Sel.registerName("rowHeight");
        }
        return _sel_rowHeight.?;
    }

    pub fn setRowHeight() objc.Sel {
        if (_sel_setRowHeight == null) {
            _sel_setRowHeight = objc.Sel.registerName("setRowHeight:");
        }
        return _sel_setRowHeight.?;
    }

    pub fn noteHeightOfRowsWithIndexesChanged() objc.Sel {
        if (_sel_noteHeightOfRowsWithIndexesChanged == null) {
            _sel_noteHeightOfRowsWithIndexesChanged = objc.Sel.registerName("noteHeightOfRowsWithIndexesChanged:");
        }
        return _sel_noteHeightOfRowsWithIndexesChanged.?;
    }

    pub fn addTableColumn() objc.Sel {
        if (_sel_addTableColumn == null) {
            _sel_addTableColumn = objc.Sel.registerName("addTableColumn:");
        }
        return _sel_addTableColumn.?;
    }

    pub fn scrollRowToVisible() objc.Sel {
        if (_sel_scrollRowToVisible == null) {
            _sel_scrollRowToVisible = objc.Sel.registerName("scrollRowToVisible:");
        }
        return _sel_scrollRowToVisible.?;
    }

    pub fn reloadDataForRowIndexesColumnIndexes() objc.Sel {
        if (_sel_reloadDataForRowIndexesColumnIndexes == null) {
            _sel_reloadDataForRowIndexesColumnIndexes = objc.Sel.registerName("reloadDataForRowIndexes:columnIndexes:");
        }
        return _sel_reloadDataForRowIndexesColumnIndexes.?;
    }

    pub fn selectedRow() objc.Sel {
        if (_sel_selectedRow == null) {
            _sel_selectedRow = objc.Sel.registerName("selectedRow");
        }
        return _sel_selectedRow.?;
    }

    pub fn numberOfSelectedRows() objc.Sel {
        if (_sel_numberOfSelectedRows == null) {
            _sel_numberOfSelectedRows = objc.Sel.registerName("numberOfSelectedRows");
        }
        return _sel_numberOfSelectedRows.?;
    }

    pub fn beginUpdates() objc.Sel {
        if (_sel_beginUpdates == null) {
            _sel_beginUpdates = objc.Sel.registerName("beginUpdates");
        }
        return _sel_beginUpdates.?;
    }

    pub fn endUpdates() objc.Sel {
        if (_sel_endUpdates == null) {
            _sel_endUpdates = objc.Sel.registerName("endUpdates");
        }
        return _sel_endUpdates.?;
    }

    pub fn insertRowsAtIndexesWithAnimation() objc.Sel {
        if (_sel_insertRowsAtIndexesWithAnimation == null) {
            _sel_insertRowsAtIndexesWithAnimation = objc.Sel.registerName("insertRowsAtIndexes:withAnimation:");
        }
        return _sel_insertRowsAtIndexesWithAnimation.?;
    }

    pub fn removeRowsAtIndexesWithAnimation() objc.Sel {
        if (_sel_removeRowsAtIndexesWithAnimation == null) {
            _sel_removeRowsAtIndexesWithAnimation = objc.Sel.registerName("removeRowsAtIndexes:withAnimation:");
        }
        return _sel_removeRowsAtIndexesWithAnimation.?;
    }

    pub fn hideRowsAtIndexesWithAnimation() objc.Sel {
        if (_sel_hideRowsAtIndexesWithAnimation == null) {
            _sel_hideRowsAtIndexesWithAnimation = objc.Sel.registerName("hideRowsAtIndexes:withAnimation:");
        }
        return _sel_hideRowsAtIndexesWithAnimation.?;
    }

    pub fn unhideRowsAtIndexesWithAnimation() objc.Sel {
        if (_sel_unhideRowsAtIndexesWithAnimation == null) {
            _sel_unhideRowsAtIndexesWithAnimation = objc.Sel.registerName("unhideRowsAtIndexes:withAnimation:");
        }
        return _sel_unhideRowsAtIndexesWithAnimation.?;
    }

    pub fn hiddenRowIndexes() objc.Sel {
        if (_sel_hiddenRowIndexes == null) {
            _sel_hiddenRowIndexes = objc.Sel.registerName("hiddenRowIndexes");
        }
        return _sel_hiddenRowIndexes.?;
    }
};

pub const NSTableViewDataSourceSelectors = struct {
    var _sel_numberOfRowsInTableView: ?objc.Sel = null;
    var _sel_tableViewObjectValueForTableColumnRow: ?objc.Sel = null;

    pub fn numberOfRowsInTableView() objc.Sel {
        if (_sel_numberOfRowsInTableView == null) {
            _sel_numberOfRowsInTableView = objc.Sel.registerName("numberOfRowsInTableView:");
        }
        return _sel_numberOfRowsInTableView.?;
    }

    pub fn tableViewObjectValueForTableColumnRow() objc.Sel {
        if (_sel_tableViewObjectValueForTableColumnRow == null) {
            _sel_tableViewObjectValueForTableColumnRow = objc.Sel.registerName("tableView:objectValueForTableColumn:row:");
        }
        return _sel_tableViewObjectValueForTableColumnRow.?;
    }
};

pub const NSTableViewDelegateSelectors = struct {
    var _sel_tableViewDidRemoveRowViewForRow: ?objc.Sel = null;
    var _sel_tableViewHeightOfRow: ?objc.Sel = null;
    var _sel_tableViewSelectionDidChange: ?objc.Sel = null;

    pub fn tableViewDidRemoveRowViewForRow() objc.Sel {
        if (_sel_tableViewDidRemoveRowViewForRow == null) {
            _sel_tableViewDidRemoveRowViewForRow = objc.Sel.registerName("tableView:didRemoveRowView:forRow:");
        }
        return _sel_tableViewDidRemoveRowViewForRow.?;
    }

    pub fn tableViewHeightOfRow() objc.Sel {
        if (_sel_tableViewHeightOfRow == null) {
            _sel_tableViewHeightOfRow = objc.Sel.registerName("tableView:heightOfRow:");
        }
        return _sel_tableViewHeightOfRow.?;
    }

    pub fn tableViewSelectionDidChange() objc.Sel {
        if (_sel_tableViewSelectionDidChange == null) {
            _sel_tableViewSelectionDidChange = objc.Sel.registerName("tableViewSelectionDidChange:");
        }
        return _sel_tableViewSelectionDidChange.?;
    }
};
