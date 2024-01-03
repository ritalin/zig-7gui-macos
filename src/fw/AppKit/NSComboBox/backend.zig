const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSComboBoxMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSComboBox").?;
    }

    pub fn usesDataSource(self: objc.Object) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSComboBoxSelectors.usesDataSource(), .{});
    }

    pub fn setUsesDataSource(self: objc.Object, _usesDataSource: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSComboBoxSelectors.setUsesDataSource(), .{
            _usesDataSource,
        });
    }

    pub fn selectItemAtIndex(self: objc.Object, _index: NSInteger) void {
        return self.msgSend(void, selector.NSComboBoxSelectors.selectItemAtIndex(), .{
            _index,
        });
    }

    pub fn deselectItemAtIndex(self: objc.Object, _index: NSInteger) void {
        return self.msgSend(void, selector.NSComboBoxSelectors.deselectItemAtIndex(), .{
            _index,
        });
    }

    pub fn indexOfSelectedItem(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSComboBoxSelectors.indexOfSelectedItem(), .{});
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSComboBoxSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, selector.NSComboBoxSelectors.setDelegate(), .{
            runtime_support.unwrapOptionalObject(_delegate),
        });
    }

    pub fn dataSource(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSComboBoxSelectors.dataSource(), .{}));
    }

    pub fn setDataSource(self: objc.Object, _dataSource: ?objc.Object) void {
        return self.msgSend(void, selector.NSComboBoxSelectors.setDataSource(), .{
            runtime_support.unwrapOptionalObject(_dataSource),
        });
    }
};

pub const NSComboBoxDataSourceMessages = struct {
    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSComboBoxDataSource");
        }
        return class.?;
    }

    pub fn registerNumberOfItemsInComboBox(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "numberOfItemsInComboBox:", runtime_support.wrapDelegateHandler(_handler), "q24@0:8@16");
    }

    pub fn registerComboBoxObjectValueForItemAtIndex(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "comboBox:objectValueForItemAtIndex:", runtime_support.wrapDelegateHandler(_handler), "@32@0:8@16q24");
    }

    pub fn registerComboBoxIndexOfItemWithStringValue(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "comboBox:indexOfItemWithStringValue:", runtime_support.wrapDelegateHandler(_handler), "Q32@0:8@16@24");
    }

    pub fn registerComboBoxCompletedString(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "comboBox:completedString:", runtime_support.wrapDelegateHandler(_handler), "@32@0:8@16@24");
    }

    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;
};

pub const NSComboBoxDelegateMessages = struct {
    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSComboBoxDelegate");
        }
        return class.?;
    }

    pub fn registerComboBoxSelectionDidChange(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "comboBoxSelectionDidChange:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;
};

const NSInteger = runtime.NSInteger;
