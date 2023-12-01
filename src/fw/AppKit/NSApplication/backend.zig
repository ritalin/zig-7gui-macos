const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSInteger = runtime.NSInteger;

pub const NSApplicationSelectors = struct {
    var _sel_sharedApplication: ?objc.Sel = null;
    var _sel_delegate: ?objc.Sel = null;
    var _sel_setDelegate: ?objc.Sel = null;
    var _sel_activateIgnoringOtherApps: ?objc.Sel = null;
    var _sel_run: ?objc.Sel = null;
    var _sel_activationPolicy: ?objc.Sel = null;
    var _sel_setActivationPolicy: ?objc.Sel = null;

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
};

pub const NSApplicationMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSApplication").?;
    }

    pub fn sharedApplication() objc.Object {
        return getClass().msgSend(objc.Object, NSApplicationSelectors.sharedApplication(), .{});
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, NSApplicationSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, NSApplicationSelectors.setDelegate(), .{
            runtime_support.unwrapOptionalObject(_delegate),
        });
    }

    pub fn activateIgnoringOtherApps(self: objc.Object, _flag: objc.c.BOOL) void {
        return self.msgSend(void, NSApplicationSelectors.activateIgnoringOtherApps(), .{
            _flag,
        });
    }

    pub fn run(self: objc.Object) void {
        return self.msgSend(void, NSApplicationSelectors.run(), .{});
    }

    pub fn activationPolicy(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, NSApplicationSelectors.activationPolicy(), .{});
    }

    pub fn setActivationPolicy(self: objc.Object, _activationPolicy: NSInteger) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, NSApplicationSelectors.setActivationPolicy(), .{
            _activationPolicy,
        });
    }
};

pub const NSApplicationDelegateSelectors = struct {
    var _sel_applicationWillFinishLaunching: ?objc.Sel = null;
    var _sel_applicationDidFinishLaunching: ?objc.Sel = null;

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
};

pub const NSApplicationDelegateMessages = struct {
    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;

    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "");
        }
        return class.?;
    }

    pub fn registerApplicationWillFinishLaunching(_class: objc.Class, _handler: *runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "applicationWillFinishLaunching:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerApplicationDidFinishLaunching(_class: objc.Class, _handler: *runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "applicationDidFinishLaunching:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }
};
