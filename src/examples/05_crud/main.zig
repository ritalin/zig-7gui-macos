const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const coreGraphics = @import("CoreGraphics");

const runtime_support = @import("Runtime-Support");
const appKit_support = @import("AppKit-Support");

const NSApplicationDelegate = appKit.NSApplicationDelegate;
const NSApplicationActivationPolicy = appKit.NSApplicationActivationPolicy;

const NSNotification = foundation.NSNotification;

const RowIndexSet = @import("./index_set.zig");

const AppDelegate = appKit.NSApplicationDelegate.Protocol(AppContext).Derive(.{
    .handler_application_delegate = .{
        .applicationWillFinishLaunching = AppRootContext.handleApplicationWillFinishLaunching,
    },
}, runtime_support.identity_seed.FixValueSeed("a4e1c7ee-f5e8-46f4-9caa-733f9754f00b"));

const AppContext = appKit_support.ApplicationContext(CrudContext);

const CrudContext = struct {
    allocator: std.mem.Allocator,
    values: Values,

    pub const Values = struct {
        filter_field: appKit.NSTextField,
        entries_list: appKit.NSTableView,
        name_field: appKit.NSTextField,
        surname_field: appKit.NSTextField,
        update_button: appKit.NSButton,
        delete_button: appKit.NSButton,
        debounce_timer: ?foundation.NSTimer,
        state_context: *CrudCacheContext,
    };

    pub fn init(allocator: std.mem.Allocator, values: CrudContext.Values) !*CrudContext {
        const self = try allocator.create(CrudContext);
        self.* = .{
            .allocator = allocator,
            .values = values,
        };

        return self;
    }

    pub fn deinit(self: *CrudContext) void {
        self.values.state_context.deinit();
    }

    fn handleNewEntry(context: ?*CrudContext, _: appKit.NSButton) !void {
        if (context) |ctx| {
            if (try ctx.values.state_context.validateNameEntry(ctx.values)) |entry| {
                const count = ctx.values.state_context.entries.items.len;

                try ctx.values.state_context.entries.append(entry);

                const row = foundation.NSIndexSet.of(foundation.NSIndexSet).indexSetWithIndex(count); // zero-base index

                ctx.values.entries_list.beginUpdates();
                defer ctx.values.entries_list.endUpdates();
                {
                    ctx.values.entries_list.insertRowsAtIndexesWithAnimation(row, appKit.NSTableViewAnimationOptions.init(.{ .SlideLeft = true }));
                }
            }
        }
    }

    fn handleUpdateEntry(context: ?*CrudContext, _: appKit.NSButton) !void {
        if (context) |ctx| {
            if (try ctx.values.state_context.validateNameEntry(ctx.values)) |entry| {
                var e = entry;
                defer e.deinit(ctx.values.state_context.allocator);
                const i: usize = @intCast(ctx.values.entries_list.selectedRow()); // zero-base index

                std.mem.swap(CrudCacheContext.ItemEntry, &ctx.values.state_context.entries.items[i], &e);

                ctx.values.entries_list.beginUpdates();
                defer ctx.values.entries_list.endUpdates();
                {
                    const col = foundation.NSIndexSet.of(foundation.NSIndexSet).indexSetWithIndex(0);
                    const row = foundation.NSIndexSet.of(foundation.NSIndexSet).indexSetWithIndex(i);
                    ctx.values.entries_list.reloadDataForRowIndexesColumnIndexes(row, col);
                }
            }
        }
    }
    fn handleDeleteEntry(context: ?*CrudContext, _: appKit.NSButton) !void {
        if (context) |ctx| {
            const i: usize = @intCast(ctx.values.entries_list.selectedRow()); // zero-base index

            ctx.values.entries_list.beginUpdates();
            defer ctx.values.entries_list.endUpdates();
            {
                var entry = ctx.values.state_context.entries.orderedRemove(i);
                defer entry.deinit(ctx.values.state_context.allocator);

                const row = foundation.NSIndexSet.of(foundation.NSIndexSet).indexSetWithIndex(i); // zero-base index
                ctx.values.entries_list.removeRowsAtIndexesWithAnimation(row, appKit.NSTableViewAnimationOptions.init(.{ .SlideRight = true }));

                ctx.values.state_context.hidden_rows.deinit();
                ctx.values.state_context.hidden_rows = try ctx.values.state_context.getUnmatchedIndexes(ctx.values.filter_field.as(appKit.NSControl).stringValue());
            }
        }
    }

    fn handleListSelectionDidChange(context: *CrudContext, _: NSNotification) !void {
        const selected_row_counr = context.values.entries_list.numberOfSelectedRows();

        context.values.update_button.as(appKit.NSControl).setEnabled(selected_row_counr > 0);
        context.values.delete_button.as(appKit.NSControl).setEnabled(selected_row_counr > 0);

        if (selected_row_counr > 0) {
            const row: usize = @intCast(context.values.entries_list.selectedRow()); // zero-base index

            std.debug.print("Debug.selected-row = {}\n", .{row});

            const entry = context.values.state_context.entries.items[row];

            updateEntry(context.values.name_field, entry.name);
            updateEntry(context.values.surname_field, entry.surname);
        }
    }

    fn handleDidRemoveRowView(context: *CrudContext, _: appKit.NSTableView, _: appKit.NSTableRowView, row: runtime.NSInteger) !void {
        if (row >= 0) {
            const hidden = context.values.state_context.hidden_rows.contains(@intCast(row));
            std.debug.print("Debug > handleDidRemoveRowView called {} hidden? = {}\n", .{ row, hidden });
        }
    }

    fn handleHeightOfRow(context: *CrudContext, entries_list: appKit.NSTableView, row: runtime.NSInteger) !coreGraphics.CGFloat {
        const default_row_height = entries_list.rowHeight();
        const hidden = context.values.state_context.hidden_rows.contains(@intCast(row));

        std.debug.print("Debug > handleHeightOfRow called {} height = {}, hidden? = {}\n", .{ row, default_row_height, hidden });

        return if (hidden) 0.01 else default_row_height;
    }

    fn updateEntry(field: appKit.NSTextField, value: []const u8) void {
        const s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(value.ptr).?;
        field.as(appKit.NSControl).setStringValue(s);
    }

    fn handleFilterPhraseChange(context: *CrudContext, _: NSNotification) !void {
        if (context.values.debounce_timer) |timer| {
            timer.invalidate();
        }

        const timer_block = try foundation.NSTimer.BlockSupport(CrudContext).TimerWithTimeIntervalBlock(&CrudContext.handleDebounceTimer).init(context);
        context.values.debounce_timer = foundation.NSTimer.scheduledTimerWithTimeIntervalRepeatsBlock(0.5, false, timer_block); // one shot
    }

    fn handleDebounceTimer(context: *CrudContext, _: foundation.NSTimer) !void {
        context.values.debounce_timer = null;

        var unmached_rows = try context.values.state_context.getUnmatchedIndexes(context.values.filter_field.as(appKit.NSControl).stringValue());

        context.values.entries_list.beginUpdates();
        defer context.values.entries_list.endUpdates();
        {
            // unhidden changes
            var unhidden_rows = try context.values.state_context.hidden_rows.diff(&unmached_rows);
            defer unhidden_rows.deinit();
            // hidden changes
            var hidden_rows = try unmached_rows.diff(&context.values.state_context.hidden_rows);
            defer hidden_rows.deinit();

            context.values.state_context.hidden_rows.deinit();
            context.values.state_context.hidden_rows = unmached_rows;

            // update unhidden rows
            {
                const unhidden_set = unhidden_rows.toSet();
                if (unhidden_set.count() > 0) {
                    // context.values.entries_list.unhideRowsAtIndexesWithAnimation(unhidden_set, appKit.NSTableViewAnimationOptions.init(.{ .SlideDown = true }));
                    context.values.entries_list.noteHeightOfRowsWithIndexesChanged(unhidden_set);
                }
            }

            // update hidden rows
            {
                const hidden_set = hidden_rows.toSet();
                if (hidden_set.count() > 0) {
                    // context.values.entries_list.hideRowsAtIndexesWithAnimation(hidden_set, appKit.NSTableViewAnimationOptions.init(.{ .SlideUp = true }));
                    context.values.entries_list.noteHeightOfRowsWithIndexesChanged(hidden_set);
                }
            }
        }
    }
};

const CrudCacheContext = struct {
    arena: *std.heap.ArenaAllocator,
    allocator: std.mem.Allocator,
    entries: std.ArrayList(ItemEntry),
    hidden_rows: RowIndexSet,

    fn init(allocator: std.mem.Allocator) !*CrudCacheContext {
        var arena = try allocator.create(std.heap.ArenaAllocator);
        arena.* = std.heap.ArenaAllocator.init(allocator);

        var managed_allocator = arena.allocator();
        const self = try managed_allocator.create(CrudCacheContext);
        self.* = .{
            .arena = arena,
            .allocator = managed_allocator,
            .entries = std.ArrayList(ItemEntry).init(managed_allocator),
            .hidden_rows = try RowIndexSet.init(managed_allocator),
        };
        return self;
    }

    fn deinit(self: *CrudCacheContext) void {
        var arena = self.arena;
        arena.deinit();
        arena.child_allocator.destroy(arena);
    }

    fn handleNumberOfRowsInTableView(context: *CrudCacheContext, _: appKit.NSTableView) !runtime.NSInteger {
        return @as(runtime.NSInteger, @intCast(context.entries.items.len));
    }

    fn handleObjectValueForTableColumnRow(context: *CrudCacheContext, _: appKit.NSTableView, _: ?appKit.NSTableColumn, row: runtime.NSInteger) !?objc.Object {
        const item_index: usize = @intCast(row);
        const entry = context.entries.items[item_index];
        return if (foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(entry.full_name)) |x| x._id else null;
    }

    pub fn validateNameEntry(context: CrudCacheContext, values: CrudContext.Values) !?CrudCacheContext.ItemEntry {
        const name_entry = name: {
            const s = values.name_field.as(appKit.NSControl).stringValue();
            break :name s.as(foundation.NSString.ExtensionMethods).utf8String();
        };
        const surname_entry = name: {
            const s = values.surname_field.as(appKit.NSControl).stringValue();
            break :name s.as(foundation.NSString.ExtensionMethods).utf8String();
        };
        if ((std.mem.sliceTo(name_entry, 0).len == 0) or (std.mem.sliceTo(surname_entry, 0).len == 0)) return null;

        return try CrudCacheContext.ItemEntry.init(
            context.allocator, 
            std.mem.sliceTo(name_entry, 0), 
            std.mem.sliceTo(surname_entry, 0)
        );
    }

    pub fn getUnmatchedIndexes(self: *CrudCacheContext, filter_text: foundation.NSString) !RowIndexSet {
        var result = try RowIndexSet.init(self.allocator);

        const needle = std.mem.sliceTo(filter_text.as(foundation.NSString.ExtensionMethods).utf8String(), 0);

        for (self.entries.items, 0..) |entry, i| {
            if (! std.mem.startsWith(u8, entry.full_name, needle)) {
                try result.includeIndex(@intCast(i));
            }
        }

        return result;
    }

    pub const ItemEntry = struct {
        name: [:0]const u8,
        surname: [:0]const u8,
        full_name: [:0]const u8,

        pub fn init(allocator: std.mem.Allocator, name: [:0]const u8, surname: [:0]const u8) !ItemEntry {
            return .{ 
                .name = try allocator.dupeZ(u8, name), 
                .surname = try allocator.dupeZ(u8, surname),
                .full_name = try std.fmt.allocPrintZ(allocator, "{s},{s}", .{ name, surname }),
            };
        }

        pub fn deinit(self: *ItemEntry, allocator: std.mem.Allocator) void {
            allocator.free(self.name);
            allocator.free(self.surname);
            allocator.free(self.full_name);
        }
    };
};

const CrudListDataSource = appKit.NSTableViewDataSource.Protocol(CrudCacheContext).Derive(.{
    .handler_table_view_data_source = .{ .numberOfRowsInTableView = &CrudCacheContext.handleNumberOfRowsInTableView, .tableViewObjectValueForTableColumnRow = &CrudCacheContext.handleObjectValueForTableColumnRow },
}, runtime_support.identity_seed.FixValueSeed("d83d55c2-3e15-4484-8029-37d036b4810d"));

const CrudListDelegate = appKit.NSTableViewDelegate.Protocol(CrudContext).Derive(.{
    .handler_table_view_delegate = .{
        .tableViewSelectionDidChange = &CrudContext.handleListSelectionDidChange,
        .tableViewDidRemoveRowViewForRow = &CrudContext.handleDidRemoveRowView,
        .tableViewHeightOfRow = &CrudContext.handleHeightOfRow,
    },
}, runtime_support.identity_seed.FixValueSeed("ec04442c-a91e-426b-8b91-389c44fd1874"));

const FilterListDelegate = appKit.NSTextFieldDelegate.Protocol(CrudContext).Derive(.{
    .handler_control_text_editing_delegate = .{
        .controlTextDidChange = &CrudContext.handleFilterPhraseChange,
    },
}, runtime_support.identity_seed.FixValueSeed("0e6e8dc7-ed7d-42a7-8099-ac6e3644d6fc"));

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
        const window_size: foundation.NSSize = .{ .width = 360, .height = 200 };

        const rect = foundation.NSRect{
            .origin = .{ .x = center.x - window_size.width / 2, .y = center.y - window_size.height / 2 },
            .size = window_size,
        };
        const mask = appKit.NSWindowStyleMask.init(.{ .Titled = true, .Closable = true, .Miniaturizable = true, .Resizable = true });
        const backing = appKit.NSBackingStoreType.Buffered;

        const screen = appKit.NSScreen.mainScreen();

        var w = appKit.NSWindow.of(appKit.NSWindow).initWithContentRectStyleMaskBacking(rect, mask, backing, false, screen.?);

        const window_title: [:0]const u8 = "CRUD App - 7GUIs#5";
        const s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(window_title).?;

        w.setTitle(s);

        var context_values = CrudContext.Values{
            .filter_field = undefined,
            .entries_list = undefined,
            .name_field = undefined,
            .surname_field = undefined,
            .update_button = undefined,
            .delete_button = undefined,
            .debounce_timer = undefined,
            .state_context = try CrudCacheContext.init(allocator),
        };

        const entry_allocator = context_values.state_context.arena.allocator();

        const inital_entries = &[_]CrudCacheContext.ItemEntry{
            try CrudCacheContext.ItemEntry.init(entry_allocator, "Emil", "Hans"),
            try CrudCacheContext.ItemEntry.init(entry_allocator, "Mustermann",  "Max"),
            try CrudCacheContext.ItemEntry.init(entry_allocator, "Tisch", "Roman"),
        };
        try context_values.state_context.entries.appendSlice(inital_entries);

        var create_button: appKit.NSButton = undefined;

        if (w.contentView()) |root| {
            var v = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = .{ .x = 8, .y = 4 }, .size = .{ .width = window_size.width - 16, .height = window_size.height - 8 } });
            {
                const top_margin = 24;
                const button_height = 24;
                const filter_height = 24;
                const listbox_width = 144;
                const vmargin = 8;

                const list_bottom = button_height + vmargin * 2;
                const filter_bottom = window_size.height - filter_height + vmargin * 2 - top_margin;

                const listbox_height = filter_bottom - list_bottom - vmargin;

                const scrollbox_frame = .{ .origin = .{ .x = 8, .y = list_bottom }, .size = .{ .width = listbox_width, .height = listbox_height } };
                const listbox_frame = .{ .origin = .{ .x = 0, .y = 0 }, .size = .{ .width = listbox_width, .height = 0 } };

                // filter (label)
                const filter_label = label: {
                    const label_str = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Filter Prefix:").?;
                    var label = appKit.NSTextField.Convenience.of(appKit.NSTextField).labelWithString(label_str);
                    label.as(appKit.NSView).setFrame(.{ .origin = .{ .x = 8, .y = filter_bottom - 4 }, .size = .{ .width = 80, .height = 24 } });
                    break :label label;
                };
                v.addSubview(filter_label.as(appKit.NSView));
                // filter
                context_values.filter_field = edit: {
                    const text_rect = .{ .origin = .{ .x = 90, .y = filter_bottom }, .size = .{ .width = 60, .height = filter_height } };
                    const edit = appKit.NSView.of(appKit.NSTextField).initWithFrame(text_rect);
                    break :edit edit;
                };
                v.addSubview(context_values.filter_field.as(appKit.NSView));

                // listbox (content)
                context_values.entries_list = list: {
                    var list = appKit.NSControl.of(appKit.NSTableView).initWithFrame(listbox_frame);

                    list.as(appKit.NSView).setFrameOrigin(.{ .x = 0, .y = 0 }); // top-left origin

                    list.setHeaderView(null);

                    const col_title = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("FullName").?;
                    var col = appKit.NSTableColumn.of(appKit.NSTableColumn).initWithIdentifier(col_title);
                    col.setMinWidth(listbox_width);

                    list.addTableColumn(col);

                    // list.as(appKit.NSView).setWantsLayer(true);
                    // list.as(appKit.NSView).layer().setBackgroundColor(appKit.NSColor.orangeColor().cgColor());
                    break :list list;
                };
                // listbox (scroll)
                const list_scroll = scrollbox: {
                    var scrollbox = appKit.NSView.of(appKit.NSScrollView).initWithFrame(scrollbox_frame);
                    // scrollbox.setDrawsBackground(false); // erase background color
                    scrollbox.setBorderType(appKit.NSBorderType.Line); // need to draw border !!
                    scrollbox.as(appKit.NSView).setWantsLayer(true);
                    scrollbox.as(appKit.NSView).layer().setCornerRadius(3); // applied
                    // scrollbox.as(appKit.NSView).layer().setMasksToBounds(true); // ????

                    scrollbox.setDocumentView(context_values.entries_list.as(appKit.NSView));
                    // scrollbox.contentView().scrollToPoint(.{ .x = 0, .y = listbox_frame.size.height });

                    scrollbox.setHasVerticalScroller(true);
                    std.debug.print("Debug.scrollbox hasVerticalScroller = {}\n", .{scrollbox.hasVerticalScroller()});
                    break :scrollbox scrollbox;
                };
                v.addSubview(list_scroll.as(appKit.NSView));

                // name entry (label)
                const name_label = label: {
                    const label_str = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Name:").?;
                    var label = appKit.NSTextField.Convenience.of(appKit.NSTextField).labelWithString(label_str);
                    label.as(appKit.NSView).setFrame(.{ .origin = .{ .x = 160, .y = 124 }, .size = .{ .width = 70, .height = 24 } });
                    break :label label;
                };
                v.addSubview(name_label.as(appKit.NSView));
                // name entry
                context_values.name_field = edit: {
                    const text_rect = .{ .origin = .{ .x = 228, .y = 128 }, .size = .{ .width = 100, .height = 24 } };
                    const edit = appKit.NSView.of(appKit.NSTextField).initWithFrame(text_rect);
                    break :edit edit;
                };
                v.addSubview(context_values.name_field.as(appKit.NSView));

                // surname entry (label)
                const surname_label = label: {
                    const label_str = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Surname:").?;
                    var label = appKit.NSTextField.Convenience.of(appKit.NSTextField).labelWithString(label_str);
                    label.as(appKit.NSView).setFrame(.{ .origin = .{ .x = 160, .y = 94 }, .size = .{ .width = 70, .height = 24 } });
                    break :label label;
                };
                v.addSubview(surname_label.as(appKit.NSView));
                // sirname entry
                context_values.surname_field = edit: {
                    const text_rect = .{ .origin = .{ .x = 228, .y = 98 }, .size = .{ .width = 100, .height = 24 } };
                    const edit = appKit.NSView.of(appKit.NSTextField).initWithFrame(text_rect);
                    break :edit edit;
                };
                v.addSubview(context_values.surname_field.as(appKit.NSView));

                // create button
                create_button = button: {
                    const button = appKit.NSControl.of(appKit.NSButton).initWithFrame(.{ .origin = .{ .x = 8, .y = vmargin }, .size = .{ .width = 80, .height = button_height } });
                    button.setBezelStyle(appKit.NSBezelStyle.Rounded);

                    const label = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Create").?;
                    button.setTitle(label);
                    break :button button;
                };
                v.addSubview(create_button.as(appKit.NSView));

                // update button
                context_values.update_button = button: {
                    const button = appKit.NSControl.of(appKit.NSButton).initWithFrame(.{ .origin = .{ .x = 90, .y = vmargin }, .size = .{ .width = 80, .height = button_height } });
                    button.setBezelStyle(appKit.NSBezelStyle.Rounded);

                    const label = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Update").?;
                    button.setTitle(label);
                    button.as(appKit.NSControl).setEnabled(false);
                    break :button button;
                };
                v.addSubview(context_values.update_button.as(appKit.NSView));

                // delete button
                context_values.delete_button = button: {
                    const button = appKit.NSControl.of(appKit.NSButton).initWithFrame(.{ .origin = .{ .x = 172, .y = vmargin }, .size = .{ .width = 80, .height = button_height } });
                    button.setBezelStyle(appKit.NSBezelStyle.Rounded);

                    const label = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Delete").?;
                    button.setTitle(label);
                    button.as(appKit.NSControl).setEnabled(false);
                    break :button button;
                };
                v.addSubview(context_values.delete_button.as(appKit.NSView));
            }
            root.addSubview(v);
        }

        var context = try CrudContext.init(allocator, context_values);
        app_context.state = context;

        context.values.entries_list.setDataSource(CrudListDataSource.initWithContext(context_values.state_context));
        context.values.entries_list.setDelegate(CrudListDelegate.initWithContext(context));

        const create_button_event = appKit_support.Handlers(CrudContext).Action(appKit.NSButton).init(context, &CrudContext.handleNewEntry);
        create_button.as(appKit.NSControl).setAction(create_button_event.action);
        create_button.as(appKit.NSControl).setTarget(create_button_event.target);

        const update_button_event = appKit_support.Handlers(CrudContext).Action(appKit.NSButton).init(context, &CrudContext.handleUpdateEntry);
        context.values.update_button.as(appKit.NSControl).setAction(update_button_event.action);
        context.values.update_button.as(appKit.NSControl).setTarget(update_button_event.target);

        const delete_button_event = appKit_support.Handlers(CrudContext).Action(appKit.NSButton).init(context, &CrudContext.handleDeleteEntry);
        context.values.delete_button.as(appKit.NSControl).setAction(delete_button_event.action);
        context.values.delete_button.as(appKit.NSControl).setTarget(delete_button_event.target);

        context.values.filter_field.setDelegate(FilterListDelegate.initWithContext(context));

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
