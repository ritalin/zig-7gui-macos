const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSNotificationSelectors = struct {};

pub const NSNotificationCenterSelectors = struct {
    pub fn defaultCenter() objc.Sel {
        if (_sel_defaultCenter == null) {
            _sel_defaultCenter = objc.Sel.registerName("defaultCenter");
        }
        return _sel_defaultCenter.?;
    }

    pub fn addObserverSelectorName() objc.Sel {
        if (_sel_addObserverSelectorName == null) {
            _sel_addObserverSelectorName = objc.Sel.registerName("addObserver:selector:name:object:");
        }
        return _sel_addObserverSelectorName.?;
    }

    var _sel_defaultCenter: ?objc.Sel = null;
    var _sel_addObserverSelectorName: ?objc.Sel = null;
};

pub const NSNotificationCreationForNSNotificationSelectors = struct {};
