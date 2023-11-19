const std = @import("std");
const runtime = @import("Runtime");
const appKit = @import("AppKit");
const foundation = @import("Foundation");

const appKit_support = @import("AppKit-Support");

const NSApplicationDelegate = appKit.NSApplicationDelegate;
const NSApplicationActivationPolicy = appKit.NSApplicationActivationPolicy;

const NSNotification = foundation.NSNotification;

const AppDelegate = NSApplicationDelegate.Protocol(ApplicationContext).Derive(.{
    .applicationWillFinishLaunching = handleApplicationWillFinishLaunching,
},
// runtime.identity_seed.RandomSeed
runtime.identity_seed.FixValueSeed("Default"));

const WindowDelegate = appKit.NSWindowDelegate.Protocol.Derive(.{
    .windowWillClose = handleWindowWillClose,
}, runtime.identity_seed.FixValueSeed("Default"));

const ApplicationContext = struct {
    const Self = @This();

    arena: *std.heap.ArenaAllocator,

    pub fn init(gpa: std.mem.Allocator) !*Self {
        var arena = try gpa.create(std.heap.ArenaAllocator);
        arena.* = std.heap.ArenaAllocator.init(gpa);

        var self = try arena.allocator().create(Self);
        self.* = .{
            .arena = arena,
        };

        return self;
    }

    pub fn deinit(self: *Self) void {
        var child_allocator = self.arena.child_allocator;
        self.arena.deinit();
        child_allocator.destroy(self.arena);
    }
};

const CounterContext = struct {
    allocator: std.mem.Allocator,
    values: Values,

    pub const Values = struct {
        text_field: appKit.NSTextField,
    };

    pub fn init(allocator: std.mem.Allocator, values: CounterContext.Values) !*CounterContext {
        var self = try allocator.create(CounterContext);
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
            var val = c.values.text_field.as(appKit.NSControl).integerValue();
            c.values.text_field.as(appKit.NSControl).setIntegerValue(val + 1);
        }
    }
};

fn handleApplicationWillFinishLaunching(app_context: *ApplicationContext, _d: NSApplicationDelegate, _: NSNotification) !void {
    std.debug.print("[DEBUG] application delegate: (id: {*})\n", .{_d._id.value});

    var center: foundation.NSPoint =
        if (appKit.NSScreen.mainScreen()) |screen| center: {
            var desktop_rect = screen.visibleFrame();
            std.debug.print("desktop-area: ( rect: {} )\n", .{desktop_rect});

            break :center .{ .x = (desktop_rect.size.width - desktop_rect.origin.x) / 2, .y = (desktop_rect.size.height - desktop_rect.origin.y) / 2 };
        } 
        else .{ .x = 50, .y = 50 }
    ;
    const window_size: foundation.NSSize = .{ .width = 300, .height = 48 };

    var rect = foundation.NSRect{
        .origin = .{ .x = center.x - window_size.width / 2, .y = center.y - window_size.height / 2 },
        .size = window_size,
    };
    var mask = appKit.NSWindowStyleMask.init(.{ .Titled = true, .Closable = true, .Miniaturizable = true, .Resizable = true });
    var backing = appKit.NSBackingStoreType.Buffered;

    std.debug.print("window_args: ( rect: {}, mask: {}, backing: {} )\n", .{ rect, mask, backing });

    var screen = appKit.NSScreen.mainScreen();

    std.debug.print("Main Screen: {any}\n", .{screen});
    std.debug.print("\n\n", .{});

    var w = appKit.NSWindow.of(appKit.NSWindow).initWithContentRectStyleMaskBacking(rect, mask, backing, false, screen.?);
    std.debug.print("[window#1] {any}\n", .{w});

    w.setBackgroundColor(appKit.NSColor.grayColor());

    var window_title: [:0]const u8 = "Counter App - 7GUIs#1";
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
            var text_field_value = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("0").?;

            var text_field_rect = foundation.NSRect{ .origin = .{ .x = 4, .y = 4 }, .size = .{ .width = 100, .height = 24 } };
            var text_field = appKit.NSControl.of(appKit.NSTextField).initWithFrame(text_field_rect);
            text_field.as(appKit.NSControl).setStringValue(text_field_value);
            text_field.as(appKit.NSControl).setAlignment(appKit.NSTextAlignment.Right);
            text_field.setEditable(false);

            v.addSubview(text_field.as(appKit.NSView));

            var ctx = try CounterContext.init(app_context.arena.allocator(), .{ .text_field = text_field });
            var handler = appKit_support.Handlers(CounterContext).Action(appKit.NSButton).init(ctx, CounterContext.handleIncrement);
            var button_text = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Count").?;
            std.debug.print("[button-caption] {s}\n", .{button_text.as(foundation.NSString.ExtensionMethods).utf8String()});

            var button = appKit.NSButton.of(appKit.NSButton).buttonWithTitleTargetAction(button_text, handler.target, handler.action);

            button.as(appKit.NSView).setFrame(foundation.NSRect{ .origin = .{ .x = 110, .y = 4 }, .size = .{ .width = 100, .height = 24 } });

            v.addSubview(button.as(appKit.NSView));
        }
        root.addSubview(v);
    }

    var d = WindowDelegate.init();

    _ = w.setDelegate(d);

    w.makeKeyAndOrderFront(null);

    appKit.NSApplication.sharedApplication().activateIgnoringOtherApps(true);
}

fn handleWindowWillClose(instance: appKit.NSWindowDelegate, notification: foundation.NSNotification) !void {
    std.debug.print("In handleWindowWillClose ...\n", .{});
    std.debug.print("window instance: {any}\n", .{instance});
    std.debug.print("nootification: {any}\n", .{notification});
}

const uuid = @import("uuid");

pub fn main() !void {
    var app_context = try ApplicationContext.init(std.heap.page_allocator);
    defer app_context.deinit();

    std.debug.print("[DEBUG] UUID: {s}\n\n", .{uuid.newV4()});

    var app = appKit.NSApplication.sharedApplication();

    std.debug.print("[DEBUG] application id: {*}\n", .{app._id.value});

    _ = app.setActivationPolicy(NSApplicationActivationPolicy.Regular);

    var d = AppDelegate.initWithContext(app_context);

    app.setDelegate(d);
    app.run();
}

test "root" {
    comptime {
        std.testing.refAllDecls(@This());
    }
}
