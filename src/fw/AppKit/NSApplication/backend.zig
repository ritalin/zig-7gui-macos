const std = @import("std");
const objc = @import("objc");
const selector = @import("./selector.zig");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

const NSAppKitVersion = f64;
const NSInteger = runtime.NSInteger;

pub const NSApplicationMessages = struct {
    pub fn getClass() objc.Class {
        return objc.getClass("NSApplication").?;
    }

    pub fn sharedApplication() objc.Object {
        return getClass().msgSend(objc.Object, selector.NSApplicationSelectors.sharedApplication(), .{});
    }

    pub fn delegate(self: objc.Object) ?objc.Object {
        return runtime_support.wrapOptionalObjectId(self.msgSend(objc.c.id, selector.NSApplicationSelectors.delegate(), .{}));
    }

    pub fn setDelegate(self: objc.Object, _delegate: ?objc.Object) void {
        return self.msgSend(void, selector.NSApplicationSelectors.setDelegate(), .{
            runtime_support.unwrapOptionalObject(_delegate),
        });
    }

    pub fn activateIgnoringOtherApps(self: objc.Object, _flag: objc.c.BOOL) void {
        return self.msgSend(void, selector.NSApplicationSelectors.activateIgnoringOtherApps(), .{
            _flag,
        });
    }

    pub fn run(self: objc.Object) void {
        return self.msgSend(void, selector.NSApplicationSelectors.run(), .{});
    }

    pub fn activationPolicy(self: objc.Object) NSInteger {
        return self.msgSend(NSInteger, selector.NSApplicationSelectors.activationPolicy(), .{});
    }

    pub fn setActivationPolicy(self: objc.Object, _activationPolicy: NSInteger) objc.c.BOOL {
        return self.msgSend(objc.c.BOOL, selector.NSApplicationSelectors.setActivationPolicy(), .{
            _activationPolicy,
        });
    }
};

pub const NSApplicationDelegateMessages = struct {
    pub const init = runtime_support.backend_support.newInstance;
    pub const dealloc = runtime_support.backend_support.destroyInstance;
    pub const registerMessage = runtime_support.backend_support.ObjectRegistry.registerMessage;

    pub fn initClass(_class_name: [:0]const u8) objc.Class {
        var class = objc.getClass(_class_name);
        if (class == null) {
            class = runtime_support.backend_support.ObjectRegistry.newDelegateClass(_class_name, "NSApplicationDelegate");
        }
        return class.?;
    }

    pub fn registerApplicationWillFinishLaunching(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "applicationWillFinishLaunching:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }

    pub fn registerApplicationDidFinishLaunching(_class: objc.Class, _handler: *const runtime_support.DelegateHandler) void {
        runtime_support.backend_support.ObjectRegistry.registerMessage(_class, "applicationDidFinishLaunching:", runtime_support.wrapDelegateHandler(_handler), "v24@0:8@16");
    }
};
