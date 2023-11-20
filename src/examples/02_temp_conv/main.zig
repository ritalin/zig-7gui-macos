const std = @import("std");
const runtime = @import("Runtime");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const appKit_support = @import("AppKit-Support");

const uuid = @import("uuid");

const AppContext = appKit_support.ApplicationContext(appKit_support.NopState);

const AppDelegate = appKit.NSApplicationDelegate.Protocol(AppContext).Derive(
    .{
        .applicationWillFinishLaunching = handleApplicationWillFinishLaunching,
    },
    runtime.identity_seed.RandomSeed
);

fn handleApplicationWillFinishLaunching(app_context: *AppContext, _: appKit.NSApplicationDelegate, _: foundation.NSNotification) !void {
    _ = app_context;

    std.debug.print("Debug: handleApplicationWillFinishLaunching invoked.\n", .{});
}

pub fn main() !void {
    var app_context = try appKit_support.ApplicationContextFactory(AppContext).create(std.heap.page_allocator, null);
    defer app_context.deinit();

    var app = appKit.NSApplication.sharedApplication();
    _ = app.setActivationPolicy(appKit.NSApplicationActivationPolicy.Regular);

    var d = AppDelegate.initWithContext(app_context);

    app.setDelegate(d);
    app.run();
}

