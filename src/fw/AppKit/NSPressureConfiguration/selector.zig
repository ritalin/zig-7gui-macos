const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSPressureConfigurationSelectors = struct {
    pub fn pressureBehavior() objc.Sel {
        if (_sel_pressureBehavior == null) {
            _sel_pressureBehavior = objc.Sel.registerName("pressureBehavior");
        }
        return _sel_pressureBehavior.?;
    }

    pub fn initWithPressureBehavior() objc.Sel {
        if (_sel_initWithPressureBehavior == null) {
            _sel_initWithPressureBehavior = objc.Sel.registerName("initWithPressureBehavior:");
        }
        return _sel_initWithPressureBehavior.?;
    }

    pub fn set() objc.Sel {
        if (_sel_set == null) {
            _sel_set = objc.Sel.registerName("set");
        }
        return _sel_set.?;
    }

    var _sel_pressureBehavior: ?objc.Sel = null;
    var _sel_initWithPressureBehavior: ?objc.Sel = null;
    var _sel_set: ?objc.Sel = null;
};

pub const NSPressureConfigurationForNSViewSelectors = struct {
    pub fn pressureConfiguration() objc.Sel {
        if (_sel_pressureConfiguration == null) {
            _sel_pressureConfiguration = objc.Sel.registerName("pressureConfiguration");
        }
        return _sel_pressureConfiguration.?;
    }

    pub fn setPressureConfiguration() objc.Sel {
        if (_sel_setPressureConfiguration == null) {
            _sel_setPressureConfiguration = objc.Sel.registerName("setPressureConfiguration:");
        }
        return _sel_setPressureConfiguration.?;
    }

    var _sel_pressureConfiguration: ?objc.Sel = null;
    var _sel_setPressureConfiguration: ?objc.Sel = null;
};
