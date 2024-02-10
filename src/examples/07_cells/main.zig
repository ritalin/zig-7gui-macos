const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const appKit = @import("AppKit");
const foundation = @import("Foundation");

const runtime_support = @import("Runtime-Support");
const appKit_support = @import("AppKit-Support");

const user_context = @import("./user_context.zig");
const SpreadsheetContext = user_context.SpreadsheetContext;
const SpreadSheet = @import("./spreadsheet_view.zig").SpreadSheet;

const MAX_ROW_COUNT = @import("./spreadsheet_state.zig").MAX_ROW_COUNT;
const MAX_COL_COUNT = @import("./spreadsheet_state.zig").MAX_COL_COUNT;

const AppContext = appKit_support.ApplicationContext(SpreadsheetContext);

const AppDelegate = appKit.NSApplicationDelegate.Protocol(AppContext).Derive(.{
    .handler_application_delegate = .{
        .applicationWillFinishLaunching = &AppRootContext.handleApplicationWillFinishLaunching,
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
        const window_size: foundation.NSSize = .{ .width = 400, .height = 400 };

        const rect = foundation.NSRect{
            .origin = .{ .x = center.x - window_size.width / 2, .y = center.y - window_size.height / 2 },
            .size = window_size,
        };

        const mask = appKit.NSWindowStyleMask.init(.{ .Titled = true, .Closable = true, .Miniaturizable = true, .Resizable = true });
        const backing = appKit.NSBackingStoreType.Buffered;

        const screen = appKit.NSScreen.mainScreen();

        var w = appKit.NSWindow.of(appKit.NSWindow).initWithContentRectStyleMaskBacking(rect, mask, backing, false, screen.?);

        const window_title: [:0]const u8 = "Cells App - 7GUIs#7";
        const s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(window_title).?;

        w.setTitle(s);

        var widgets = SpreadsheetContext.WidgetRef{
            .spreadsheet = undefined,
        };

        if (w.contentView()) |root| {
            const content_bounds = .{ .origin = .{ .x = 8, .y = 4 }, .size = .{ .width = window_size.width - 16, .height = window_size.height - 8 } };
            var v = appKit.NSView.of(appKit.NSView).initWithFrame(content_bounds);
            {
                const sheet_size = .{.width = content_bounds.size.width, .height = content_bounds.size.height - 40};
                const fixed_cell_size = .{.width = 32, .height = 24};

                widgets.spreadsheet = try SpreadSheet.init(
                    allocator,
                    .{ 
                        .col_count = MAX_COL_COUNT, 
                        .row_count = MAX_ROW_COUNT, 
                        .fixed_cell_size = fixed_cell_size, 
                        .cell_size = .{.width = 80, .height = 24}, 
                        .frame_size = sheet_size, 
                        .top_inset = 0,
                    }
                );
                v.addSubview(widgets.spreadsheet.root_view.as(appKit.NSView));
            }
            root.addSubview(v);
        }

        const context = try SpreadsheetContext.init(allocator, widgets);
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
