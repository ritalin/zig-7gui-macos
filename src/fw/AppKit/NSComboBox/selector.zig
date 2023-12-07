const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSComboBoxSelectors = struct {
    var _sel_usesDataSource: ?objc.Sel = null;
    var _sel_setUsesDataSource: ?objc.Sel = null;
    var _sel_selectItemAtIndex: ?objc.Sel = null;
    var _sel_deselectItemAtIndex: ?objc.Sel = null;
    var _sel_indexOfSelectedItem: ?objc.Sel = null;
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;
    var _sel_dataSource: ?objc.Sel = null;
    var _sel_setDataSource: ?objc.Sel = null;

    pub fn usesDataSource() objc.Sel {
        if (_sel_usesDataSource == null) {
            _sel_usesDataSource = objc.Sel.registerName("usesDataSource");
        }
        return _sel_usesDataSource.?;
    }

    pub fn setUsesDataSource() objc.Sel {
        if (_sel_setUsesDataSource == null) {
            _sel_setUsesDataSource = objc.Sel.registerName("setUsesDataSource:");
        }
        return _sel_setUsesDataSource.?;
    }

    pub fn selectItemAtIndex() objc.Sel {
        if (_sel_selectItemAtIndex == null) {
            _sel_selectItemAtIndex = objc.Sel.registerName("selectItemAtIndex:");
        }
        return _sel_selectItemAtIndex.?;
    }

    pub fn deselectItemAtIndex() objc.Sel {
        if (_sel_deselectItemAtIndex == null) {
            _sel_deselectItemAtIndex = objc.Sel.registerName("deselectItemAtIndex:");
        }
        return _sel_deselectItemAtIndex.?;
    }

    pub fn indexOfSelectedItem() objc.Sel {
        if (_sel_indexOfSelectedItem == null) {
            _sel_indexOfSelectedItem = objc.Sel.registerName("indexOfSelectedItem");
        }
        return _sel_indexOfSelectedItem.?;
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
};

pub const NSComboBoxDataSourceSelectors = struct {
    var _sel_numberOfItemsInComboBox: ?objc.Sel = null;
    var _sel_comboBoxObjectValueForItemAtIndex: ?objc.Sel = null;
    var _sel_comboBoxIndexOfItemWithStringValue: ?objc.Sel = null;
    var _sel_comboBoxCompletedString: ?objc.Sel = null;

    pub fn numberOfItemsInComboBox() objc.Sel {
        if (_sel_numberOfItemsInComboBox == null) {
            _sel_numberOfItemsInComboBox = objc.Sel.registerName("numberOfItemsInComboBox:");
        }
        return _sel_numberOfItemsInComboBox.?;
    }

    pub fn comboBoxObjectValueForItemAtIndex() objc.Sel {
        if (_sel_comboBoxObjectValueForItemAtIndex == null) {
            _sel_comboBoxObjectValueForItemAtIndex = objc.Sel.registerName("comboBox:objectValueForItemAtIndex:");
        }
        return _sel_comboBoxObjectValueForItemAtIndex.?;
    }

    pub fn comboBoxIndexOfItemWithStringValue() objc.Sel {
        if (_sel_comboBoxIndexOfItemWithStringValue == null) {
            _sel_comboBoxIndexOfItemWithStringValue = objc.Sel.registerName("comboBox:indexOfItemWithStringValue:");
        }
        return _sel_comboBoxIndexOfItemWithStringValue.?;
    }

    pub fn comboBoxCompletedString() objc.Sel {
        if (_sel_comboBoxCompletedString == null) {
            _sel_comboBoxCompletedString = objc.Sel.registerName("comboBox:completedString:");
        }
        return _sel_comboBoxCompletedString.?;
    }
};

pub const NSComboBoxDelegateSelectors = struct {
    var _sel_comboBoxSelectionDidChange: ?objc.Sel = null;

    pub fn comboBoxSelectionDidChange() objc.Sel {
        if (_sel_comboBoxSelectionDidChange == null) {
            _sel_comboBoxSelectionDidChange = objc.Sel.registerName("comboBoxSelectionDidChange:");
        }
        return _sel_comboBoxSelectionDidChange.?;
    }
};
