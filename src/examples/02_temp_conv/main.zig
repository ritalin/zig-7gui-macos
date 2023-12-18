const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime_support = @import("Runtime-Support");
const appKit_support = @import("AppKit-Support");

const AppContext = appKit_support.ApplicationContext(TempConvContext);

const AppDelegate = appKit.NSApplicationDelegate.Protocol(AppContext).Derive(
    .{
        .handler_application_delegate = .{
            .applicationWillFinishLaunching = handleApplicationWillFinishLaunching,
            .applicationDidFinishLaunching = TempConvContext.handleDidFinishLaunching,
        },
    },
    runtime_support.identity_seed.FixValueSeed("a4e1c7ee-f5e8-46f4-9caa-733f9754f00b"),
);

// const WindowDelegate = appKit.NSWindowDelegate.Protocol(TempConvContext).Derive(
//     .{
//         .handler_window_delegate = .{
//             .windowWillClose = TempConvContext.handleWindowWillClose,
//         },
//     },
//     runtime.identity_seed.FixValueSeed("Default")
// );

const TempConvContext = struct {
    allocator: std.mem.Allocator,
    values: Values,

    pub fn init(allocator: std.mem.Allocator, values: TempConvContext.Values) !*TempConvContext {
        const self = try allocator.create(TempConvContext);
        self.* = .{
            .allocator = allocator,
            .values = values,
        };

        return self;
    }

    pub fn deinit(self: *TempConvContext) void {
        self.allocator.destroy(self);
    }

    fn handleDidFinishLaunching(context: *AppContext, _: foundation.NSNotification) !void {
        if (context.state) |state| {
            const err = state.values.window.makeFirstResponder(state.values.text_celcius.as(appKit.NSResponder));
            std.debug.print("Fiest Responder => {}\n", .{err});
        }
    }

    fn toFahrenheitTemperature(context: *TempConvContext, _: foundation.NSNotification) !void {
        std.debug.print("Debug: ->Fahrenheit\n", .{});

        var rc = objc.AutoreleasePool.init();
        defer rc.deinit();

        const temp_from = readTemperature(context.values.text_celcius) catch |err| switch (err) {
            error.InvalidValue => {
                std.debug.print("Debug: Celcius temp > need to be integer value.\n", .{});
                return;
            },
            else => {
                std.debug.print("Debug: Celcius temp > unexpected error occured ({}).\n", .{(err)});
                return;
            },
        };

        const temp_to = temp: {
            if (temp_from) |value| {
                const new_value = value * (9.0 / 5.0) + 32.0;
                break :temp try std.fmt.allocPrintZ(context.allocator, "{d:3.2}", .{new_value});
            } 
            else {
                break :temp try context.allocator.dupeZ(u8, "");
            }
        };
        defer context.allocator.free(temp_to);

        updateTemperature(context.values.text_fahrenheit, temp_to);
    }

    fn toCelciusTemperature(context: *TempConvContext, _: foundation.NSNotification) !void {
        std.debug.print("Debug: Celcius<- invoked\n", .{});

        var rc = objc.AutoreleasePool.init();
        defer rc.deinit();

        const temp_from = readTemperature(context.values.text_fahrenheit) catch |err| switch (err) {
            error.InvalidValue => {
                std.debug.print("Debug: Fahrenheit temp > need to be integer value.\n", .{});
                return;
            },
            else => {
                std.debug.print("Debug: Celcius temp > unexpected error occured ({}).\n", .{(err)});
                return;
            },
        };

        const temp_to =
            if (temp_from) |value|
        temp: {
            const new_value = (value - 32.0) * (5.0 / 9.0);
            break :temp try std.fmt.allocPrintZ(context.allocator, "{d:3.2}", .{new_value});
        } else temp: {
            break :temp try context.allocator.dupeZ(u8, "");
        };
        defer context.allocator.free(temp_to);

        updateTemperature(context.values.text_celcius, temp_to);
    }

    const TemperatureError = error{InvalidValue};

    fn readTemperature(text_view: appKit.NSTextView) (std.fmt.ParseIntError || TemperatureError)!?f32 {
        if (text_view.textStorage()) |storage| {
            const s0 = storage
                .as(foundation.NSAttributedString).string()
                .as(foundation.NSString.ExtensionMethods).utf8String();
            if (s0 == null) return null;

            if (s0) |x| {
                const input = std.mem.sliceTo(x, 0);
                if (input.len == 0) return null;

                return std.fmt.parseFloat(f32, input) catch |err| switch (err) {
                    error.InvalidCharacter => return error.InvalidValue,
                    else => return err,
                };
            }
        }

        return null;
    }

    fn updateTemperature(text_view: appKit.NSTextView, value: [:0]const u8) void {
        if (text_view.textStorage()) |storage| {
            const s1 = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(value).?;
            const s2 = foundation.NSAttributedString.ExtendedAttributedString.of(foundation.NSAttributedString).initWithString(s1);

            storage.as(foundation.NSMutableAttributedString.ExtendedMutableAttributedString).setAttributedString(s2);
        }
    }

    fn handleTabStop(context: *TempConvContext, _textView: appKit.NSTextView, _commandSelector: objc.Sel) !bool {
        _ = _textView;

        if (std.meta.eql(_commandSelector, appKit.NSStandardKeyBindingRespondingSelectors.insertTab())) {
            context.values.window.selectNextKeyView(null);
            return true;
        }

        std.debug.print("Debug: handleTabStop selector name `{s}`\n", .{_commandSelector.getName()});

        return false;
    }

    pub const Values = struct {
        window: appKit.NSWindow,
        text_celcius: appKit.NSTextView,
        text_fahrenheit: appKit.NSTextView,
    };
};

const ToFahrenheitDelegate =
    appKit.NSTextViewDelegate.Protocol(TempConvContext).Derive(
    // appKit.NSTextDelegate.Protocol(TempConvContext).Derive(
    .{
        .handler_text_view_delegate = .{
            .textViewDoCommandBySelector = TempConvContext.handleTabStop,
        },
        .handler_text_delegate = .{
            .textDidChange = TempConvContext.toFahrenheitTemperature,
        },
    },
    runtime_support.identity_seed.FixValueSeed("0631ee4b-fdcd-4efe-999d-61f7aefd2798"),
);

const ToCelciusDelegate =
    appKit.NSTextViewDelegate.Protocol(TempConvContext).Derive(
    // appKit.NSTextDelegate.Protocol(TempConvContext).Derive(
    .{
        .handler_text_view_delegate = .{
            .textViewDoCommandBySelector = TempConvContext.handleTabStop,
        },
        .handler_text_delegate = .{
            .textDidChange = TempConvContext.toCelciusTemperature,
        },
    },
    runtime_support.identity_seed.FixValueSeed("570c2bb9-a451-43cf-93e3-800fbf883e9b"),
);

fn handleApplicationWillFinishLaunching(app_context: *AppContext, _: foundation.NSNotification) !void {
    const center: foundation.NSPoint =
        if (appKit.NSScreen.mainScreen()) |screen|
    origin: {
        const desktop_rect = screen.visibleFrame();

        break :origin .{ .x = (desktop_rect.size.width - desktop_rect.origin.x) / 2, .y = (desktop_rect.size.height - desktop_rect.origin.y) / 2 };
    } else origin: {
        break :origin .{ .x = 50, .y = 50 };
    };
    const window_size: foundation.NSSize = .{ .width = 300, .height = 48 };

    const rect = foundation.NSRect{
        .origin = .{ .x = center.x - window_size.width / 2, .y = center.y - window_size.height / 2 },
        .size = window_size,
    };
    const mask = appKit.NSWindowStyleMask.init(.{ .Titled = true, .Closable = true, .Miniaturizable = true, .Resizable = true });
    const backing = appKit.NSBackingStoreType.Buffered;

    const screen = appKit.NSScreen.mainScreen();

    var w = appKit.NSWindow.of(appKit.NSWindow).initWithContentRectStyleMaskBacking(rect, mask, backing, false, screen.?);

    const window_title: [:0]const u8 = "TempConv App - 7GUIs#2";
    const s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(window_title).?;

    w.setTitle(s);

    var context_values = TempConvContext.Values{
        .window = w,
        .text_celcius = undefined,
        .text_fahrenheit = undefined,
    };

    if (w.contentView()) |root| {
        var v = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = .{ .x = 8, .y = 8 }, .size = .{ .width = window_size.width - 16, .height = 32 } });
        {
            context_values.text_celcius = edit: {
                const text_rect = .{ .origin = .{ .x = 4, .y = 4 }, .size = .{ .width = 64, .height = 18 } };
                const edit = appKit.NSView.of(appKit.NSTextView).initWithFrame(text_rect);
                // edit.as(appKit.NSControl).setAlignment(appKit.NSTextAlignment.Right);
                break :edit edit;
            };
            v.addSubview(context_values.text_celcius.as(appKit.NSView));

            var c_caption = caption: {
                const caption_text = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Celsius = ").?;
                var caption = appKit.NSTextField.Convenience.of(appKit.NSTextField).labelWithString(caption_text);
                caption.as(appKit.NSView).setFrameOrigin(.{ .x = 74, .y = 4 });
                break :caption caption;
            };
            v.addSubview(c_caption.as(appKit.NSView));

            context_values.text_fahrenheit = edit: {
                const text_rect = .{ .origin = .{ .x = 136, .y = 4 }, .size = .{ .width = 64, .height = 18 } };
                const edit = appKit.NSView.of(appKit.NSTextView).initWithFrame(text_rect);
                // edit.as(appKit.NSControl).setAlignment(appKit.NSTextAlignment.Right);
                break :edit edit;
            };
            v.addSubview(context_values.text_fahrenheit.as(appKit.NSView));

            var f_caption = caption: {
                const caption_text = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Fahrenheit").?;
                var caption = appKit.NSTextField.Convenience.of(appKit.NSTextField).labelWithString(caption_text);
                caption.as(appKit.NSView).setFrameOrigin(.{ .x = 204, .y = 4 });
                break :caption caption;
            };
            v.addSubview(f_caption.as(appKit.NSView));
        }
        root.addSubview(v);
    }

    // init context
    const context = try TempConvContext.init(app_context.arena.allocator(), context_values);
    app_context.state = context;

    const c_edit_changed = ToFahrenheitDelegate.initWithContext(context);
    context_values.text_celcius.as(appKit.NSTextView.Sharing).setDelegate(c_edit_changed);

    const f_edit_changed = ToCelciusDelegate.initWithContext(context);
    context_values.text_fahrenheit.as(appKit.NSTextView.Sharing).setDelegate(f_edit_changed);

    w.makeKeyAndOrderFront(null);

    appKit.NSApplication.sharedApplication().activateIgnoringOtherApps(true);
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
