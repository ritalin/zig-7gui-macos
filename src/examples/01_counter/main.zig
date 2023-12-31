const std = @import("std");
const runtime = @import("Runtime");
const appKit = @import("AppKit");
const foundation = @import("Foundation");

const runtime_support = @import("Runtime-Support");
const appKit_support = @import("AppKit-Support");

const NSApplicationDelegate = appKit.NSApplicationDelegate;
const NSApplicationActivationPolicy = appKit.NSApplicationActivationPolicy;

const NSNotification = foundation.NSNotification;

const AppDelegate = appKit.NSApplicationDelegate.Protocol(AppContext).Derive(.{
    .handler_application_delegate = .{
        .applicationWillFinishLaunching = handleApplicationWillFinishLaunching,
    },
}, runtime_support.identity_seed.FixValueSeed("Default"));

const WindowDelegate = appKit.NSWindowDelegate.Protocol(AppContext).Derive(.{
    .handler_window_delegate = .{
        .windowWillClose = handleWindowWillClose,
    },
}, runtime_support.identity_seed.FixValueSeed("Default"));

const AppContext = appKit_support.ApplicationContextWithoutState;

const CounterContext = struct {
    allocator: std.mem.Allocator,
    values: Values,

    pub const Values = struct {
        text_field: appKit.NSTextField,
    };

    pub fn init(allocator: std.mem.Allocator, values: CounterContext.Values) !*CounterContext {
        const self = try allocator.create(CounterContext);
        self.* = .{
            .allocator = allocator,
            .values = values,
        };

        return self;
    }

    pub fn handleIncrement(ctx: ?*CounterContext, sender: appKit.NSButton) !void {
        _ = sender;

        std.debug.print("[Action] handleIncrement invoked. {?any}\n", .{ctx});

        if (ctx) |c| {
            const val = c.values.text_field.as(appKit.NSControl).integerValue();
            c.values.text_field.as(appKit.NSControl).setIntegerValue(val + 1);
        }
    }
};

fn handleApplicationWillFinishLaunching(app_context: *AppContext, _: NSNotification) !void {
    std.debug.print("[DEBUG] handleApplicationWillFinishLaunching invoked\n", .{});

    const center: foundation.NSPoint = center: {
        if (appKit.NSScreen.mainScreen()) |screen| {
            const desktop_rect = screen.visibleFrame();
            std.debug.print("desktop-area: ( rect: {} )\n", .{desktop_rect});
            break :center .{ .x = (desktop_rect.size.width - desktop_rect.origin.x) / 2, .y = (desktop_rect.size.height - desktop_rect.origin.y) / 2 };
        } 
        else {
            break :center .{ .x = 50, .y = 50 };
        }
    };
    const window_size: foundation.NSSize = .{ .width = 300, .height = 48 };

    const rect = foundation.NSRect{
        .origin = .{ .x = center.x - window_size.width / 2, .y = center.y - window_size.height / 2 },
        .size = window_size,
    };
    const mask = appKit.NSWindowStyleMask.init(.{ .Titled = true, .Closable = true, .Miniaturizable = true, .Resizable = true });
    const backing = appKit.NSBackingStoreType.Buffered;

    std.debug.print("window_args: ( rect: {}, mask: {}, backing: {} )\n", .{ rect, mask, backing });

    const screen = appKit.NSScreen.mainScreen();

    std.debug.print("Main Screen: {any}\n", .{screen});
    std.debug.print("\n\n", .{});

    var w = appKit.NSWindow.of(appKit.NSWindow).initWithContentRectStyleMaskBacking(rect, mask, backing, false, screen.?);
    std.debug.print("[window#1] {any}\n", .{w});

    w.setBackgroundColor(appKit.NSColor.grayColor());

    const window_title: [:0]const u8 = "Counter App - 7GUIs#1";
    var s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(window_title).?;
    std.debug.print("[window-title] {s}\n", .{s.as(foundation.NSString.ExtensionMethods).utf8String()});

    w.setTitle(s);

    std.debug.print("{}\n", .{appKit.NSColorSystemEffect.Pressed});
    std.debug.print("[window]#root_content {any}\n", .{w.contentView()});

    if (w.contentView()) |root| {
        var v = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = .{ .x = 8, .y = 8 }, .size = .{ .width = window_size.width - 16, .height = 32 } });
        v.setWantsLayer(true);
        std.debug.print("[main-view]#wants-layer {}\n", .{v.wantsLayer()});

        v.layer().setBackgroundColor(appKit.NSColor.whiteColor().cgColor());
        {
            const text_field_value = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("0").?;

            const text_field_rect = foundation.NSRect{ .origin = .{ .x = 4, .y = 4 }, .size = .{ .width = 100, .height = 24 } };
            const text_field = appKit.NSControl.of(appKit.NSTextField).initWithFrame(text_field_rect);
            text_field.as(appKit.NSControl).setStringValue(text_field_value);
            text_field.as(appKit.NSControl).setAlignment(appKit.NSTextAlignment.Right);
            text_field.setEditable(false);

            v.addSubview(text_field.as(appKit.NSView));

            const ctx = try CounterContext.init(app_context.arena.allocator(), .{ .text_field = text_field });
            const handler = appKit_support.Handlers(CounterContext).Action(appKit.NSButton).init(ctx, CounterContext.handleIncrement);
            var button_text = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Count").?;
            std.debug.print("[button-caption] {s}\n", .{button_text.as(foundation.NSString.ExtensionMethods).utf8String()});

            var button = appKit.NSButton.of(appKit.NSButton).buttonWithTitleTargetAction(button_text, handler.target, handler.action);

            button.as(appKit.NSView).setFrame(foundation.NSRect{ .origin = .{ .x = 110, .y = 4 }, .size = .{ .width = 100, .height = 24 } });

            v.addSubview(button.as(appKit.NSView));
        }
        root.addSubview(v);
    }

    const d = WindowDelegate.initWithContext(app_context);

    _ = w.setDelegate(d);

    w.makeKeyAndOrderFront(null);

    appKit.NSApplication.sharedApplication().activateIgnoringOtherApps(true);
}

fn handleWindowWillClose(context: *AppContext, notification: foundation.NSNotification) !void {
    _ = context;
    std.debug.print("In handleWindowWillClose ...\n", .{});
    std.debug.print("nootification: {any}\n", .{notification});
}

pub fn main() !void {
    var app_context = try appKit_support.ApplicationContextFactory(AppContext).create(std.heap.page_allocator, null);
    defer app_context.deinit();

    var app = appKit.NSApplication.sharedApplication();

    std.debug.print("[DEBUG] application id: {*}\n", .{app._id.value});

    _ = app.setActivationPolicy(NSApplicationActivationPolicy.Regular);

    const d = AppDelegate.initWithContext(app_context);

    app.setDelegate(d);
    app.run();
}

test "root" {
    comptime {
        std.testing.refAllDecls(@This());
    }
}
