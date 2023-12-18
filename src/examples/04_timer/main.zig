const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime_support = @import("Runtime-Support");
const appKit_support = @import("AppKit-Support");

// const time = @import("time");
const time_parser = @import("time-parser");
const time_formatter = @import("time-formatter");

const NSInteger = runtime.NSInteger;
const NSUInteger = runtime.NSUInteger;

const AppContext = appKit_support.ApplicationContext(TimerContext);

const AppDelegate = appKit.NSApplicationDelegate.Protocol(AppContext).Derive(
    .{
        .handler_application_delegate = .{
            .applicationWillFinishLaunching = AppRootContext.handleApplicationWillFinishLaunching,
        },
    },
    runtime_support.identity_seed.FixValueSeed("a4e1c7ee-f5e8-46f4-9caa-733f9754f00b"),
);

const TimerContext = struct {
    allocator: std.mem.Allocator,
    values: Values,

    pub fn init(allocator: std.mem.Allocator, values: TimerContext.Values) !*TimerContext {
        const self = try allocator.create(TimerContext);
        self.* = .{
            .allocator = allocator,
            .values = values,
        };

        return self;
    }

    pub fn deinit(self: *TimerContext) void {
        self.allocator.destroy(self);
    }

    fn handleTimer(context: *TimerContext, _: foundation.NSTimer) !void {
        try updateElapsedTime(context);
    }

    fn handleSlider(context: ?*TimerContext, slider: appKit.NSSlider) !void {
        if (context) |ctx| {
            ctx.values.timer_state.duration_ms = @intCast(slider.as(appKit.NSControl).intValue());

            const max_time = try Helpers.formatTime(ctx.allocator, .{ .utc = .{.timestamp_ms = ctx.values.timer_state.duration_ms }});
            defer ctx.allocator.free(max_time);

            const s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(max_time.ptr).?;
            ctx.values.maxtime_label.as(appKit.NSControl).setStringValue(s);

            ctx.values.guage.setMaxValue(@floatFromInt(ctx.values.timer_state.duration_ms));

            try updateElapsedTime(ctx);
        }
    }

    fn updateElapsedTime(context: *TimerContext) !void {
        const prev_time = context.values.timer_state.last_elapsed_ms;
        const current_time = try std.time.Instant.now();
        context.values.timer_state.last_elapsed_ms = @as(i64, @intCast(current_time.since(context.values.timer_state.start_time) / 1000_000));

        if (prev_time <= @min(context.values.timer_state.last_elapsed_ms, context.values.timer_state.duration_ms)) {
            const elapsed_time = try Helpers.formatTime(context.allocator, .{ .utc = .{.timestamp_ms = context.values.timer_state.last_elapsed_ms} });
            defer context.allocator.free(elapsed_time);
            
            const s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(elapsed_time.ptr).?;
            context.values.elapsed_label.as(appKit.NSControl).setStringValue(s);

            context.values.guage.setDoubleValue(@floatFromInt(context.values.timer_state.last_elapsed_ms));
        }
    }

    fn handleTimerReset(context: ?*TimerContext, _: appKit.NSButton) !void {
        if (context) |ctx| {
            ctx.values.timer_state.last_elapsed_ms = 0;
            ctx.values.timer_state.start_time = try std.time.Instant.now();
        }
    }

    const Values = struct {
        timer: foundation.NSTimer,
        elapsed_label: appKit.NSTextField,
        maxtime_label: appKit.NSTextField,
        guage: appKit.NSProgressIndicator,
        timer_state: struct {
            start_time: std.time.Instant,
            last_elapsed_ms: i64,
            duration_ms: i64,
        },
    };
};

const Helpers = struct {
    pub fn formatTime(allocator: std.mem.Allocator, time: time_formatter.FormattableTime) ! [:0]const u8 {
        return std.fmt.allocPrintZ(allocator, "{[0]HH}:{[0]mm}:{[0]ss.SS}", .{ time });
    }
};

const AppRootContext = struct {
    fn handleApplicationWillFinishLaunching(app_context: *AppContext, _: foundation.NSNotification) !void {
        var allocator = app_context.arena.allocator();

        const center: foundation.NSPoint = origin: {
            if (appKit.NSScreen.mainScreen()) |screen| {
                const desktop_rect = screen.visibleFrame();

                break :origin .{ .x = (desktop_rect.size.width - desktop_rect.origin.x) / 2, .y = (desktop_rect.size.height - desktop_rect.origin.y) / 2 };
            } 
            else {
                break :origin .{ .x = 50, .y = 50 };
            }
        };
        const window_size: foundation.NSSize = .{ .width = 300, .height = 120 };

        const rect = foundation.NSRect{
            .origin = .{ .x = center.x - window_size.width / 2, .y = center.y - window_size.height / 2 },
            .size = window_size,
        };
        const mask = appKit.NSWindowStyleMask.init(.{ .Titled = true, .Closable = true, .Miniaturizable = true, .Resizable = true });
        const backing = appKit.NSBackingStoreType.Buffered;

        const screen = appKit.NSScreen.mainScreen();

        var w = appKit.NSWindow.of(appKit.NSWindow).initWithContentRectStyleMaskBacking(rect, mask, backing, false, screen.?);

        const window_title: [:0]const u8 = "Timer App - 7GUIs#4";
        const s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(window_title).?;

        w.setTitle(s);

        var context_values = TimerContext.Values{   
            .timer = undefined,
            .elapsed_label = undefined,
            .maxtime_label = undefined,
            .guage = undefined,
            .timer_state = .{
                .start_time = try std.time.Instant.now(),
                .last_elapsed_ms = 0,
                .duration_ms = 10_000,
            },
        };

        var slider: appKit.NSSlider = undefined;
        var button: appKit.NSButton = undefined;
        
        if (w.contentView()) |root| {
            var v = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = .{ .x = 8, .y = 4 }, .size = .{ .width = window_size.width - 16, .height = window_size.height - 8 } });
            {
                // elapsed time guage
                {
                    var guage = appKit.NSView.of(appKit.NSProgressIndicator).initWithFrame(
                        .{ .origin = .{ .x = 8, .y = 96 }, .size = .{ .width = window_size.width - 24, .height = 16 } }
                    );
                    guage.setMaxValue(@floatFromInt(context_values.timer_state.duration_ms));
                    guage.setIndeterminate(false);
                    context_values.guage = guage;
                    v.addSubview(guage.as(appKit.NSView));
                }
                // elapsed time label
                {
                    const elapsed_label_str = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("00:00:00.00").?;
                    var elapsed_label = appKit.NSTextField.Convenience.of(appKit.NSTextField).labelWithString(elapsed_label_str);
                    elapsed_label.as(appKit.NSView).setFrame(.{ .origin = .{ .x = 4, .y = 68 }, .size = .{ .width = 80, .height = 24 } });
                    context_values.elapsed_label = elapsed_label;
                    v.addSubview(elapsed_label.as(appKit.NSView));
                }
                {
                    const label_str = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(" / ").?;
                    var label = appKit.NSTextField.Convenience.of(appKit.NSTextField).labelWithString(label_str);
                    label.as(appKit.NSView).setFrame(.{ .origin = .{ .x = 80, .y = 68 }, .size = .{ .width = 10, .height = 24 } });
                    v.addSubview(label.as(appKit.NSView));
                }
                // max time label
                {
                    const max_time = try Helpers.formatTime(allocator, .{ .utc = .{.timestamp_ms = @intCast(context_values.timer_state.duration_ms) }});
                    defer allocator.free(max_time);

                    const label_str = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(max_time).?;
                    var label = appKit.NSTextField.Convenience.of(appKit.NSTextField).labelWithString(label_str);
                    label.as(appKit.NSView).setFrame(.{ .origin = .{ .x = 92, .y = 68 }, .size = .{ .width = 80, .height = 24 } });
                    context_values.maxtime_label = label;
                    v.addSubview(label.as(appKit.NSView));
                }
                // slider
                {
                    slider = appKit.NSControl.of(appKit.NSSlider).initWithFrame(
                        .{ .origin = .{ .x = 8, .y = 44 }, .size = .{ .width = window_size.width - 24, .height = 24 } }
                    );
                    slider.setMinValue(30 * 1000);
                    slider.setMaxValue(300 * 1000);
                    slider.as(appKit.NSControl).setIntValue(@intCast(context_values.timer_state.duration_ms));

                    v.addSubview(slider.as(appKit.NSView));
                }
                // timeer reset button
                {
                    button = appKit.NSControl.of(appKit.NSButton).initWithFrame(
                        .{ .origin = .{ .x = 8, .y = 8 }, .size = .{ .width = window_size.width - 16, .height = 24 } }
                    );
                    button.setBezelStyle(appKit.NSBezelStyle.Rounded);

                    const label = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Reset").?;
                    button.setTitle(label);

                    v.addSubview(button.as(appKit.NSView));
                }
            }
            root.addSubview(v);
        }

        var context = try TimerContext.init(allocator, context_values);

        const timer_block = try foundation.NSTimer.BlockSupport(TimerContext).TimerWithTimeIntervalBlock(&TimerContext.handleTimer).init(context);
        context.values.timer = foundation.NSTimer.scheduledTimerWithTimeIntervalRepeatsBlock(0.05, true, timer_block);
        context.values.timer.setTolerance(0.005);
        
        const slider_event = appKit_support.Handlers(TimerContext).Action(appKit.NSSlider).init(context, &TimerContext.handleSlider);
        slider.as(appKit.NSControl).setAction(slider_event.action);
        slider.as(appKit.NSControl).setTarget(slider_event.target);

        const button_event = appKit_support.Handlers(TimerContext).Action(appKit.NSButton).init(context, &TimerContext.handleTimerReset);
        button.as(appKit.NSControl).setAction(button_event.action);
        button.as(appKit.NSControl).setTarget(button_event.target);

        app_context.state = context;

        w.makeKeyAndOrderFront(null);

        appKit.NSApplication.sharedApplication().activateIgnoringOtherApps(true);
    }
};

pub fn main() !void {
    var app_context = try appKit_support.ApplicationContextFactory(AppContext).create(std.heap.page_allocator, null);
    defer app_context.deinit();

    var app = appKit.NSApplication.sharedApplication();
    _ = app.setActivationPolicy(appKit.NSApplicationActivationPolicy.Regular);

    const d = AppDelegate.initWithContext(app_context);

    app.setDelegate(d);
    app.run();
}
