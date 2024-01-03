const std = @import("std");
const objc = @import("objc");
const runtime_support = @import("Runtime-Support");

pub const NSApplicationSelectors = struct {
    pub fn sharedApplication() objc.Sel {
        if (_sel_sharedApplication == null) {
            _sel_sharedApplication = objc.Sel.registerName("sharedApplication");
        }
        return _sel_sharedApplication.?;
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

    pub fn activateIgnoringOtherApps() objc.Sel {
        if (_sel_activateIgnoringOtherApps == null) {
            _sel_activateIgnoringOtherApps = objc.Sel.registerName("activateIgnoringOtherApps:");
        }
        return _sel_activateIgnoringOtherApps.?;
    }

    pub fn run() objc.Sel {
        if (_sel_run == null) {
            _sel_run = objc.Sel.registerName("run");
        }
        return _sel_run.?;
    }

    pub fn activationPolicy() objc.Sel {
        if (_sel_activationPolicy == null) {
            _sel_activationPolicy = objc.Sel.registerName("activationPolicy");
        }
        return _sel_activationPolicy.?;
    }

    pub fn setActivationPolicy() objc.Sel {
        if (_sel_setActivationPolicy == null) {
            _sel_setActivationPolicy = objc.Sel.registerName("setActivationPolicy:");
        }
        return _sel_setActivationPolicy.?;
    }

    var _sel_sharedApplication: ?objc.Sel = null;
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;
    var _sel_activateIgnoringOtherApps: ?objc.Sel = null;
    var _sel_run: ?objc.Sel = null;
    var _sel_activationPolicy: ?objc.Sel = null;
    var _sel_setActivationPolicy: ?objc.Sel = null;
};

pub const NSEventForNSApplicationSelectors = struct {
    pub fn currentEvent() objc.Sel {
        if (_sel_currentEvent == null) {
            _sel_currentEvent = objc.Sel.registerName("currentEvent");
        }
        return _sel_currentEvent.?;
    }

    var _sel_currentEvent: ?objc.Sel = null;
};

pub const NSApplicationDelegateSelectors = struct {
    pub fn applicationWillFinishLaunching() objc.Sel {
        if (_sel_applicationWillFinishLaunching == null) {
            _sel_applicationWillFinishLaunching = objc.Sel.registerName("applicationWillFinishLaunching:");
        }
        return _sel_applicationWillFinishLaunching.?;
    }

    pub fn applicationDidFinishLaunching() objc.Sel {
        if (_sel_applicationDidFinishLaunching == null) {
            _sel_applicationDidFinishLaunching = objc.Sel.registerName("applicationDidFinishLaunching:");
        }
        return _sel_applicationDidFinishLaunching.?;
    }

    var _sel_applicationWillFinishLaunching: ?objc.Sel = null;
    var _sel_applicationDidFinishLaunching: ?objc.Sel = null;
};
