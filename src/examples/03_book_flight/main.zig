const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const runtime_support = @import("Runtime-Support");
const appKit_support = @import("AppKit-Support");

const time_formatter = @import("time-formatter");
const time_parser = @import("time-parser");

const NSInteger = runtime.NSInteger;
const NSUInteger = runtime.NSUInteger;

const AppContext = appKit_support.ApplicationContext(FlightBookContext);

const AppDelegate = appKit.NSApplicationDelegate.Protocol(AppContext).Derive(
    .{
        .handler_application_delegate = .{
            .applicationWillFinishLaunching = AppRootContext.handleApplicationWillFinishLaunching,
            .applicationDidFinishLaunching = AppRootContext.handleDidFinishLaunching,
        },
    },
    runtime_support.identity_seed.FixValueSeed("a4e1c7ee-f5e8-46f4-9caa-733f9754f00b"),
);

const FlightBookContext = struct {
    allocator: std.mem.Allocator,
    values: Values,
    route_context: *FlightRouteContext,

    pub fn init(allocator: std.mem.Allocator, route_context: *FlightRouteContext, values: FlightBookContext.Values) !*FlightBookContext {
        var self = try allocator.create(FlightBookContext);
        self.* = .{
            .allocator = allocator,
            .values = values,
            .route_context = route_context,
        };

        return self;
    }

    fn handleSelectionDidChange(context: *FlightBookContext, _: foundation.NSNotification) !void {
        var index = context.values.booking_route.indexOfSelectedItem();

        if (context.route_context.isReturnRoute(index)) {
            context.values.arrival_date.as(appKit.NSControl).setEnabled(true);
        } else {
            context.values.arrival_date.as(appKit.NSControl).setEnabled(false);
            context.syncBookingDate();
        }
    }

    fn selectedRouteName(context: *FlightBookContext) []const u8 {
        var index = context.values.booking_route.indexOfSelectedItem();

        return context.route_context.findKeyAtIndex(index);
    }

    fn syncBookingDate(context: *FlightBookContext) void {
        var date_str = context.values.departure_date.as(appKit.NSControl).stringValue();
        context.values.arrival_date.as(appKit.NSControl).setStringValue(date_str);
    }

    fn handleBookingDateChanged(context: *FlightBookContext, _: foundation.NSNotification) !void {
        context.refreshView();
    }

    fn parseDate(text_field: appKit.NSTextField) ?time_formatter.FormattableTime.Utc {
        var s = text_field.as(appKit.NSControl).stringValue();
        var date_str = s.as(foundation.NSString.ExtensionMethods).utf8String();

        const offset_date = time_parser.fromISO8601(std.mem.sliceTo(date_str, 0)) catch {
            return null;
        };

        return .{ .timestamp_ms = offset_date.timestamp_ms };
    }

    fn refreshView(context: *FlightBookContext) void {
        var departure_date = parseDate(context.values.departure_date);
        var arrival_date = parseDate(context.values.arrival_date);

        var status = RefreshStatus{
            .accept_dep_date = departure_date != null,
            .accept_arr_date = arrival_date != null,
        };

        context.values.departure_date.setBackgroundColor(if (status.accept_dep_date) appKit.NSColor.whiteColor() else appKit.NSColor.redColor());
        context.values.arrival_date.setBackgroundColor(if (status.accept_arr_date) appKit.NSColor.whiteColor() else appKit.NSColor.redColor());

        if (status.accept_dep_date and status.accept_arr_date) {
            status.accept_record_book = compareDate(departure_date.?, arrival_date.?).compare(.lte);
        }

        var index = context.values.booking_route.indexOfSelectedItem();

        if (context.route_context.isReturnRoute(index)) {
            context.values.book_button.as(appKit.NSControl).setEnabled(RefreshStatusSet.init(status).eql(RefreshStatusSet.initFull()));
        } else {
            context.values.book_button.as(appKit.NSControl).setEnabled(status.accept_dep_date);
        }
    }

    fn compareDate(date: time_formatter.FormattableTime.Utc, other: time_formatter.FormattableTime.Utc) std.math.Order {
        return std.math.order(date.timestamp_ms, other.timestamp_ms);
    }

    fn handleRecordBook(context: ?*FlightBookContext, _: appKit.NSButton) !void {
        if (context) |ctx| {
            var route = ctx.selectedRouteName();
            var dep_date = parseDate(ctx.values.departure_date).?;
            var arr_date = parseDate(ctx.values.arrival_date).?;

            var msg = try std.fmt.allocPrintZ(ctx.allocator, 
                "Book recorded: \n\troute: {s}\n\tdeparture: {YYYY-MM-DD}\n\tarrival: {YYYY-MM-DD}", .{ 
                    route, 
                    time_formatter.FormattableTime{ .utc = dep_date }, 
                    time_formatter.FormattableTime{ .utc = arr_date },
                }
            );
            defer ctx.allocator.free(msg);

            std.debug.print("{s}\n", .{msg});

            var alert = runtime.NSObject.of(appKit.NSAlert).init();
            alert.setMessageText(foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(msg).?);
            // _ = alert.runModal();

            var block = try appKit.NSAlert.BlockSupport(FlightBookContext).BeginSheetModalForWindowBlock(&handleRecordBookFinished).init(ctx);

            alert.beginSheetModalForWindowCompletionHandler(ctx.values.main_window, block);
        }
    }

    pub fn handleRecordBookFinished(context: *FlightBookContext, r: appKit.NSModalResponse) !void {
        _ = context;
        _ = r;
        std.debug.print("Debug: RecordBook finished !!\n", .{});
    }

    const Values = struct {
        main_window: appKit.NSWindow,
        booking_route: appKit.NSComboBox,
        departure_date: appKit.NSTextField,
        arrival_date: appKit.NSTextField,
        book_button: appKit.NSButton,
    };

    const RefreshKind = enum { accept_dep_date, accept_arr_date, accept_record_book };
    const RefreshStatus = std.enums.EnumFieldStruct(RefreshKind, bool, false);
    const RefreshStatusSet = std.enums.EnumSet(RefreshKind);
};

const FlightRouteContext = struct {
    const routes = std.ComptimeStringMap(NSUInteger, .{ .{ "one-way flight", 0 }, .{ "return flight", 1 } });

    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) !*FlightRouteContext {
        var self = try allocator.create(FlightRouteContext);
        self.* = .{
            .allocator = allocator,
        };

        return self;
    }

    pub fn isReturnRoute(_: FlightRouteContext, index: NSInteger) bool {
        return index == 1;
    }

    fn handleNumberOfItemsInComboBox(_: *FlightRouteContext, _: appKit.NSComboBox) !NSInteger {
        return @as(NSInteger, routes.kvs.len);
    }

    fn handleObjectValueForItemAtIndex(context: *FlightRouteContext, _: appKit.NSComboBox, _index: NSInteger) !?objc.Object {
        var value = try context.allocator.dupeZ(u8, context.findKeyAtIndex(_index));
        defer context.allocator.free(value);

        var item_text = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(value).?;
        return item_text._id;
    }

    fn findKeyAtIndex(_: *FlightRouteContext, index: NSInteger) []const u8 {
        for (routes.kvs) |kv| {
            if (kv.value == index) return kv.key;
        }

        unreachable;
    }

    fn handleIndexOfItemWithStringValue(_: *FlightRouteContext, _: appKit.NSComboBox, _string: foundation.NSString) !NSUInteger {
        var raw_value = _string.as(foundation.NSString.ExtensionMethods).utf8String();
        return routes.get(std.mem.sliceTo(raw_value, 0)) orelse foundation.NSNotFound;
    }
};

const BookingRouteDataSource = appKit.NSComboBoxDataSource.Protocol(FlightRouteContext).Derive(
    .{
        .handler_combo_box_data_source = .{
            .numberOfItemsInComboBox = FlightRouteContext.handleNumberOfItemsInComboBox,
            .comboBoxObjectValueForItemAtIndex = FlightRouteContext.handleObjectValueForItemAtIndex,
            .comboBoxIndexOfItemWithStringValue = FlightRouteContext.handleIndexOfItemWithStringValue,
        },
    },
    runtime_support.identity_seed.FixValueSeed("15251a69-e3a6-459b-bb0c-217f9f3dc3a4"),
);

const BookingRouteDelegate = appKit.NSComboBoxDelegate.Protocol(FlightBookContext).Derive(
    .{
        .handler_combo_box_delegate = .{
            .comboBoxSelectionDidChange = FlightBookContext.handleSelectionDidChange,
        },
    },
    runtime_support.identity_seed.FixValueSeed("3ac8f383-a4a6-4c91-9f16-798a2d437854"),
);

const BookingDateDelegate = appKit.NSTextFieldDelegate.Protocol(FlightBookContext).Derive(.{
    .handler_control_text_editing_delegate = .{
        .controlTextDidChange = FlightBookContext.handleBookingDateChanged,
    },
}, runtime_support.identity_seed.FixValueSeed("a28800a4-1be9-4c3b-9f58-bec30166f480"));

const AppRootContext = struct {
    fn handleApplicationWillFinishLaunching(app_context: *AppContext, _: foundation.NSNotification) !void {
        var allocator = app_context.arena.allocator();

        var center: foundation.NSPoint =
            if (appKit.NSScreen.mainScreen()) |screen|
        origin: {
            var desktop_rect = screen.visibleFrame();

            break :origin .{ .x = (desktop_rect.size.width - desktop_rect.origin.x) / 2, .y = (desktop_rect.size.height - desktop_rect.origin.y) / 2 };
        } else origin: {
            break :origin .{ .x = 50, .y = 50 };
        };
        const window_size: foundation.NSSize = .{ .width = 300, .height = 120 };

        var rect = foundation.NSRect{
            .origin = .{ .x = center.x - window_size.width / 2, .y = center.y - window_size.height / 2 },
            .size = window_size,
        };
        var mask = appKit.NSWindowStyleMask.init(.{ .Titled = true, .Closable = true, .Miniaturizable = true, .Resizable = true });
        var backing = appKit.NSBackingStoreType.Buffered;

        var screen = appKit.NSScreen.mainScreen();

        var w = appKit.NSWindow.of(appKit.NSWindow).initWithContentRectStyleMaskBacking(rect, mask, backing, false, screen.?);

        var window_title: [:0]const u8 = "Book Flight App - 7GUIs#3";
        var s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(window_title).?;

        w.setTitle(s);

        var context_values = FlightBookContext.Values{
            .main_window = w,
            .booking_route = undefined,
            .book_button = undefined,
            .departure_date = undefined,
            .arrival_date = undefined,
        };

        if (w.contentView()) |root| {
            var v = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = .{ .x = 8, .y = 4 }, .size = .{ .width = window_size.width - 16, .height = window_size.height - 8 } });
            {
                var dropdown = appKit.NSControl.of(appKit.NSComboBox).initWithFrame(.{ .origin = .{ .x = 4, .y = 88 }, .size = .{ .width = 120, .height = 24 } });
                {
                    dropdown.as(appKit.NSTextField).setEditable(false);
                    context_values.booking_route = dropdown;
                }
                v.addSubview(dropdown.as(appKit.NSView));

                var ini_date = try std.fmt.allocPrintZ(allocator, "{YYYY-MM-DD}", .{
                    time_formatter.FormattableTime{ .utc = .{.timestamp_ms = std.time.milliTimestamp()} }
                });
                var ini_date_str = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(ini_date).?;

                var departure_date = appKit.NSControl.of(appKit.NSTextField).initWithFrame(.{ .origin = .{ .x = 4, .y = 60 }, .size = .{ .width = 120, .height = 24 } });

                {
                    departure_date.as(appKit.NSControl).setStringValue(ini_date_str);
                    context_values.departure_date = departure_date;
                }
                v.addSubview(departure_date.as(appKit.NSView));

                var arrival_date = appKit.NSControl.of(appKit.NSTextField).initWithFrame(.{ .origin = .{ .x = 4, .y = 32 }, .size = .{ .width = 120, .height = 24 } });

                {
                    arrival_date.as(appKit.NSControl).setStringValue(ini_date_str);
                    context_values.arrival_date = arrival_date;
                }
                v.addSubview(arrival_date.as(appKit.NSView));

                var button_title = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Book").?;
                var button = appKit.NSButton.of(appKit.NSButton).buttonWithTitleTargetAction(button_title, null, null);
                {
                    button.as(appKit.NSView).setFrame(.{ .origin = .{ .x = 4, .y = 4 }, .size = .{ .width = 120, .height = 24 } });
                    context_values.book_button = button;
                }
                v.addSubview(button.as(appKit.NSView));
            }
            root.addSubview(v);
        }

        var route_context = try FlightRouteContext.init(allocator);
        var context = try FlightBookContext.init(allocator, route_context, context_values);
        app_context.state = context;

        context.values.booking_route.setUsesDataSource(true);
        context.values.booking_route.setDataSource(BookingRouteDataSource.initWithContext(route_context));

        context.values.booking_route.setDelegate(BookingRouteDelegate.initWithContext(context));
        context.values.departure_date.setDelegate(BookingDateDelegate.initWithContext(context));
        context.values.arrival_date.setDelegate(BookingDateDelegate.initWithContext(context));

        var book_click = appKit_support.Handlers(FlightBookContext).Action(appKit.NSButton).init(context, FlightBookContext.handleRecordBook);
        context.values.book_button.as(appKit.NSControl).setTarget(book_click.target);
        context.values.book_button.as(appKit.NSControl).setAction(book_click.action);

        w.makeKeyAndOrderFront(null);

        appKit.NSApplication.sharedApplication().activateIgnoringOtherApps(true);
    }

    fn handleDidFinishLaunching(app_context: *AppContext, _: foundation.NSNotification) !void {
        if (app_context.state) |context| {
            context.values.booking_route.selectItemAtIndex(0);
        }
    }
};

pub fn main() !void {
    var app_context = try appKit_support.ApplicationContextFactory(AppContext).create(std.heap.page_allocator, null);
    defer app_context.deinit();

    var app = appKit.NSApplication.sharedApplication();
    _ = app.setActivationPolicy(appKit.NSApplicationActivationPolicy.Regular);

    var d = AppDelegate.initWithContext(app_context);

    app.setDelegate(d);
    app.run();
}
