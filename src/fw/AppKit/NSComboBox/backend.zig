const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

const NSInteger = runtime.NSInteger;

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

pub const NSComboBoxMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSComboBox").?;
    }

    pub fn usesDataSource(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, NSComboBoxSelectors.usesDataSource(), .{});
    }

    pub fn setUsesDataSource(self: objc.Object, _usesDataSource: objc.c.BOOL) void {
        return self.msgSend(void, NSComboBoxSelectors.setUsesDataSource(), .{
            _usesDataSource,
        });
    }

    pub fn selectItemAtIndex(self: objc.Object, _index: NSInteger) void {
        return self.msgSend(void, NSComboBoxSelectors.selectItemAtIndex(), .{
            _index,
        });
    }

    pub fn deselectItemAtIndex(self: objc.Object, _index: NSInteger) void {
        return self.msgSend(void, NSComboBoxSelectors.deselectItemAtIndex(), .{
            _index,
        });
    }

    pub fn indexOfSelectedItem(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, NSComboBoxSelectors.indexOfSelectedItem(), .{});
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime.wrapOptionalObjectId(self.msgSend(objc.c.id, NSComboBoxSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, NSComboBoxSelectors.setDelegate(), .{
            runtime.unwrapOptionalObject(_delegate),
        });
    }

    pub fn dataSource(self: objc.Object) ?objc.Object {
        return runtime.wrapOptionalObjectId(self.msgSend(objc.c.id, NSComboBoxSelectors.dataSource(), .{}));
    }

    pub fn setDataSource(self: objc.Object, _dataSource: ?objc.Object) void {
        return self.msgSend(void, NSComboBoxSelectors.setDataSource(), .{
            runtime.unwrapOptionalObject(_dataSource),
        });
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

pub const NSComboBoxDataSourceMessages = struct {
    pub const init = runtime.backend_support.newInstance;
    pub const dealloc = runtime.backend_support.destroyInstance;
    pub const registerMessage = runtime.backend_support.ObjectRegistry.registerMessage;

    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime.backend_support.ObjectRegistry.newDelegateClass(_class_name, "");
        }
        return class.?;
    }

    pub fn registerNumberOfItemsInComboBox(_class: objc.Class, _handler: *const runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "numberOfItemsInComboBox:", runtime.wrapDelegateHandler(_handler), "q24@0:8@16");
    }

    pub fn registerComboBoxObjectValueForItemAtIndex(_class: objc.Class, _handler: *const runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "comboBox:objectValueForItemAtIndex:", runtime.wrapDelegateHandler(_handler), "@32@0:8@16q24");
    }

    pub fn registerComboBoxIndexOfItemWithStringValue(_class: objc.Class, _handler: *const runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "comboBox:indexOfItemWithStringValue:", runtime.wrapDelegateHandler(_handler), "Q32@0:8@16@24");
    }

    pub fn registerComboBoxCompletedString(_class: objc.Class, _handler: *const runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "comboBox:completedString:", runtime.wrapDelegateHandler(_handler), "@32@0:8@16@24");
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

pub const NSComboBoxDelegateMessages = struct {
    pub const init = runtime.backend_support.newInstance;
    pub const dealloc = runtime.backend_support.destroyInstance;
    pub const registerMessage = runtime.backend_support.ObjectRegistry.registerMessage;

    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime.backend_support.ObjectRegistry.newDelegateClass(_class_name, "");
        }
        return class.?;
    }

    pub fn registerComboBoxSelectionDidChange(_class: objc.Class, _handler: *const runtime.DelegateHandler) void {
        runtime.backend_support.ObjectRegistry.registerMessage(_class, "comboBoxSelectionDidChange:", runtime.wrapDelegateHandler(_handler), "v24@0:8@16");
    }
};
