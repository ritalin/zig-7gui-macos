const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const coreGraphics = @import("CoreGraphics");
const quartzCore = @import("QuartzCore");

const runtime_support = @import("Runtime-Support");
const appKit_support = @import("AppKit-Support");

const user_context = @import("./user_context.zig");

const CircleDrawerContext = user_context.CircleDrawerContext;

const AppContext = appKit_support.ApplicationContext(user_context.CircleDrawerContext);

const AppDelegate = appKit.NSApplicationDelegate.Protocol(AppContext).Derive(.{
    .handler_application_delegate = .{
        .applicationWillFinishLaunching = AppRootContext.handleApplicationWillFinishLaunching,
    },
}, runtime_support.identity_seed.FixValueSeed("a4e1c7ee-f5e8-46f4-9caa-733f9754f00b"));

const AppRootContext = struct {
    fn handleApplicationWillFinishLaunching(app_context: *AppContext, _: foundation.NSNotification) !void {
        const allocator = app_context.arena.allocator();

        const center: foundation.NSPoint = origin: {
            if (appKit.NSScreen.mainScreen()) |screen| {
                const desktop_rect = screen.visibleFrame();
                break :origin .{ .x = (desktop_rect.size.width - desktop_rect.origin.x) / 2, .y = (desktop_rect.size.height - desktop_rect.origin.y) / 2 };
            } else {
                break :origin .{ .x = 50, .y = 50 };
            }
        };
        const window_size: foundation.NSSize = .{ .width = 360, .height = 300 };

        const rect = foundation.NSRect{
            .origin = .{ .x = center.x - window_size.width / 2, .y = center.y - window_size.height / 2 },
            .size = window_size,
        };

        const mask = appKit.NSWindowStyleMask.init(.{ .Titled = true, .Closable = true, .Miniaturizable = true, .Resizable = true });
        const backing = appKit.NSBackingStoreType.Buffered;

        const screen = appKit.NSScreen.mainScreen();

        var w = appKit.NSWindow.of(appKit.NSWindow).initWithContentRectStyleMaskBacking(rect, mask, backing, false, screen.?);

        const window_title: [:0]const u8 = "Circle Drawer App - 7GUIs#6";
        const s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(window_title).?;

        w.setTitle(s);

        var context_values = CircleDrawerContext.Values{
            .size_slider = undefined,
            .canvas_view = undefined,
            .activated_layer = undefined,
            .undo_button = undefined,
            .redo_button = undefined,
            .adjust_diameter_modal = undefined,
            .state = try user_context.StateContext.init(allocator),
        };

        if (w.contentView()) |root| {
            var v = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = .{ .x = 8, .y = 4 }, .size = .{ .width = window_size.width - 16, .height = window_size.height - 8 } });
            {
                context_values.canvas_view = canvas: {
                    const view = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = .{ .x = 4, .y = 4 }, .size = .{ .width = window_size.width - 24, .height = window_size.height - 44 } });
                    view.setWantsLayer(true);
                    view.layer().setBorderWidth(1.5);
                    view.layer().setBorderColor(appKit.NSColor.blackColor().cgColor());

                    break :canvas view;
                };
                v.addSubview(context_values.canvas_view);

                context_values.undo_button = button: {
                    const frame_rect = foundation.NSRect{
                        .origin = .{ .x = 8, .y = window_size.height - 34 },
                        .size = .{ .width = 100, .height = 24 },
                    };
                    const button = appKit.NSControl.of(appKit.NSButton).initWithFrame(frame_rect);
                    button.setBezelStyle(appKit.NSBezelStyle.Rounded);
                    button.as(appKit.NSControl).setEnabled(false);

                    const label = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Undo").?;
                    button.setTitle(label);

                    break :button button;
                };
                v.addSubview(context_values.undo_button.as(appKit.NSView));

                context_values.redo_button = button: {
                    const frame_rect = foundation.NSRect{
                        .origin = .{ .x = 108, .y = window_size.height - 34 },
                        .size = .{ .width = 100, .height = 24 },
                    };
                    const button = appKit.NSControl.of(appKit.NSButton).initWithFrame(frame_rect);
                    button.setBezelStyle(appKit.NSBezelStyle.Rounded);
                    button.as(appKit.NSControl).setEnabled(false);

                    const label = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Redo").?;
                    button.setTitle(label);

                    break :button button;
                };
                v.addSubview(context_values.redo_button.as(appKit.NSView));

            }
            root.addSubview(v);
        }

        // create diameter sdjustration dialog
        createAdjustDiameterModal(rect, &context_values);

        const context = try CircleDrawerContext.init(allocator, context_values);
        app_context.state = context;

        user_context.bindSliderEvent(context, context.values.size_slider);
        user_context.bindCanvasEvent(context, context.values.canvas_view);
        user_context.bindUndoEvent(context, context.values.undo_button);
        user_context.bindRedoEvent(context, context.values.redo_button);

        //
        // sampling
        //

        const selected_state = context_values.state.selected;

        // circle sample#1
        {
            const selected_frame = foundation.NSRect{
                .origin = .{ .x = 40, .y = 40 },
                .size = .{ .width = user_context.CIRCLE_SIZE_MIN, .height = user_context.CIRCLE_SIZE_MIN },
            };
            selected_state.new_bounds = selected_frame;
            const layer = user_context.createBaseLayer(selected_frame);

            const circle_layer = user_context.createCircleLayer(selected_state, selected_state.new_bounds.size, appKit.NSColor.clearColor());
            layer.addSublayer(circle_layer.as(quartzCore.CALayer));

            context.values.canvas_view.layer().addSublayer(layer);
            try context.values.state.layers.registerWithName(layer, try context.values.state.createCircleName(allocator));
        }

        // circle sample#2
        {
            const layer_frame = foundation.NSRect{
                .origin = .{ .x = 240, .y = 200 },
                .size = .{ .width = user_context.CIRCLE_SIZE_MIN, .height = user_context.CIRCLE_SIZE_MIN },
            };
            const layer = user_context.createBaseLayer(layer_frame);

            const circle_layer = user_context.createCircleLayer(selected_state, layer_frame.size, appKit.NSColor.clearColor());
            layer.addSublayer(circle_layer.as(quartzCore.CALayer));

            context.values.canvas_view.layer().addSublayer(layer);
            try context.values.state.layers.registerWithName(layer, try context.values.state.createCircleName(allocator));
        }        

        w.makeKeyAndOrderFront(null);

        appKit.NSApplication.sharedApplication().activateIgnoringOtherApps(true);
    }
};

fn createAdjustDiameterModal(rect: foundation.NSRect, context_values: *user_context.CircleDrawerContext.Values) void {
    const mask = appKit.NSWindowStyleMask.init(.{ .Titled = true, .Closable = true });
    const backing = appKit.NSBackingStoreType.Buffered;
    const screen = appKit.NSScreen.mainScreen();

    const window_rect = foundation.NSRect{
        .origin = rect.origin,
        .size = .{ .width = rect.size.width, .height = 100 }
    };

    const w = appKit.NSWindow.of(appKit.NSPanel).initWithContentRectStyleMaskBacking(window_rect, mask, backing, false, screen.?);
    w.setFloatingPanel(true);

    if (w.as(appKit.NSWindow).contentView()) |root| {
        var v = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = .{ .x = 8, .y = 4 }, .size = .{ .width = rect.size.width - 16, .height = rect.size.height - 8 } });
        {
            const caption = label: {
                const s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Adjust Diameter...").?;
                const label = appKit.NSTextField.Convenience.of(appKit.NSTextField).labelWithString(s);
                label.as(appKit.NSView).setFrameOrigin(.{ .x = 4, .y = 40 });
                break :label label;
            };
            v.addSubview(caption.as(appKit.NSView));

            context_values.size_slider = slider: {
                const slider_frame = foundation.NSRect{
                    .origin = .{ .x = 8, .y = 4 },
                    .size = .{ .width = rect.size.width - 32, .height = 24 },
                };
                const slider = appKit.NSControl.of(appKit.NSSlider).initWithFrame(slider_frame);
                slider.setMinValue(user_context.CIRCLE_SIZE_MIN);
                slider.setMaxValue(user_context.CIRCLE_SIZE_MIN * 2);

                const ev_mask = appKit.NSEventMask.init(.{.LeftMouseDown = false, .LeftMouseUp = false, .LeftMouseDragged = false});
                _ = slider.as(appKit.NSControl).sendActionOn(ev_mask);
                break :slider slider;
            };
            v.addSubview(context_values.size_slider.as(appKit.NSView));
        }
        root.addSubview(v);
    }

    context_values.adjust_diameter_modal = w;
}

pub fn main() !void {
    var app_context = try appKit_support.ApplicationContextFactory(AppContext).create(std.heap.page_allocator, null);
    defer app_context.deinit();

    var app = appKit.NSApplication.sharedApplication();
    _ = app.setActivationPolicy(appKit.NSApplicationActivationPolicy.Regular);

    const d = AppDelegate.initWithContext(app_context);

    app.setDelegate(d);
    app.run();
}
