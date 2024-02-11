const std = @import("std");
const objc = @import("objc");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const appKit_support = @import("AppKit-Support");
const runtime_support = @import("Runtime-Support");

const SpreadsheetState = @import("./spreadsheet_state.zig");
const EvalResult = SpreadsheetState.EvalResult;

const ActiveCell = struct {
    cell: SpreadsheetCell,
    is_edited: bool,

    pub fn eqlAddress(self: ActiveCell, col: usize, row: usize) bool {
        return (self.cell.col == col) and (self.cell.row == row);
    }
};

pub const SpreadSheet = struct {
    allocator: std.mem.Allocator,
    root_view: appKit.NSView,
    col_header_view: appKit.NSView,
    content_view: appKit.NSScrollView,
    editor: appKit.NSTextView,
    cells: CellCollection,
    active_cell: ?ActiveCell,
    config: struct {
        fixed_cell_size: foundation.NSSize,
        cell_size: foundation.NSSize,
        border_width: f64,
        top_inset: f64,
        col_count: usize, 
        row_count: usize,
    },
    states: SpreadsheetState,

    pub fn init(allocator: std.mem.Allocator, config: struct { col_count: usize, row_count: usize, fixed_cell_size: foundation.NSSize, cell_size: foundation.NSSize, frame_size: foundation.NSSize, top_inset: f64 }) !*SpreadSheet {
        const root_view = appKit.NSView.of(appKit.NSView).initWithFrame(.{ 
            .origin = .{ .x = 0, .y = 0 }, 
            .size = .{.width = config.frame_size.width, .height = config.frame_size.height + config.fixed_cell_size.height }
        });
        root_view.setWantsLayer(true);
        
        const scroll_pane = appKit.NSView.of(appKit.NSScrollView).initWithFrame(.{ .origin = .{ .x = 0, .y = 0 }, .size = config.frame_size });
        
        scroll_pane.setHasVerticalScroller(true);
        scroll_pane.setHasHorizontalScroller(true);
        root_view.addSubview(scroll_pane.as(appKit.NSView));

        const inplace_editor = appKit.NSView.of(appKit.NSTextView).initWithFrame(.{ .origin = .{.x = 0, .y = 0}, .size = config.cell_size});
        inplace_editor.as(appKit.NSTextView.Checking).setAutomaticQuoteSubstitutionEnabled(false);
        _ = objc.Object.retain(inplace_editor._id);

        const self = try allocator.create(SpreadSheet);
        self.* = .{
            .allocator = allocator,
            .root_view = root_view,
            .col_header_view = undefined,
            .content_view = scroll_pane,
            .editor = inplace_editor,
            .cells = try CellCollection.init(allocator),
            .active_cell = null,
            .config = .{
                .fixed_cell_size = config.fixed_cell_size,
                .cell_size = config.cell_size,
                .top_inset = config.top_inset,
                .border_width = 1,
                .col_count = config.col_count,
                .row_count = config.row_count,
            },
            .states = try SpreadsheetState.init(allocator),
        };

        const width = @as(f64, @floatFromInt(config.col_count)) * config.cell_size.width + config.fixed_cell_size.width;
        const height = @as(f64, @floatFromInt(config.row_count)) * config.cell_size.height - @as(f64, @floatFromInt(config.row_count)) * self.config.border_width;

        std.debug.print("sheet size: (width: {}, height: {})\n", .{width, height});
        
        try self.buildSpreadsheetView(.{.width = width, .height = height}, config.frame_size);
        try self.buildColumnHeadersView(config.frame_size);

        self.activateAt(0, 0);
        
        return self;
    }

    fn buildSpreadsheetView(self: *SpreadSheet, sheet_size: foundation.NSSize, frame_size: foundation.NSSize) !void {
        const spreadsheet = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = .{ .x = 0, .y = 0 }, .size = .{ .width = sheet_size.width, .height = sheet_size.height + self.config.border_width } });
        {
            _ = frame_size;

            const row_headers = try buildRowHeader(
                .{
                    .cell_count = self.config.row_count,
                    .fixed_cell_size = self.config.fixed_cell_size,
                    .cell_size = self.config.cell_size,
                    .sheet_height = sheet_size.height,
                    .top_inset = self.config.top_inset,
                    .border_width = self.config.border_width,
                }
            );
            self.content_view.addFloatingSubviewForAxis(
                row_headers, appKit.NSEventGestureAxis.Horizontal
            );
            
            for (0..self.config.row_count) |r| {
                const rows = try buildRow(self.allocator, 
                    .{
                        .row = r, .col_count = self.config.col_count,
                        .fixed_cell_size = self.config.fixed_cell_size,
                        .cell_size = self.config.cell_size,
                        .sheet_height = sheet_size.height,
                        .top_inset = self.config.top_inset,
                        .border_width = self.config.border_width,
                    }
                );
                defer self.allocator.free(rows.cells);
                
                spreadsheet.addSubview(rows.view);

                try self.putCells(rows.cells);
            }
        }
        self.content_view.setDocumentView(spreadsheet.as(appKit.NSView));
        self.content_view.contentView().scrollToPoint(.{.x = 0, .y = sheet_size.height});

        spreadsheet.as(appKit.NSView).setWantsLayer(true);
        
        self.bindAction();
    }

    fn buildCell(col_offset: usize, row_offset: usize, cell_size: foundation.NSSize, border_width: f64, caption: [:0]const u8) appKit.NSTextField {
        const s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(caption).?;

        const cell = appKit.NSTextField.Convenience.of(appKit.NSTextField).labelWithString(s);

        const x = @as(f64, @floatFromInt(col_offset)) * (cell_size.width - border_width);
        const y = @as(f64, @floatFromInt(row_offset)) * cell_size.height - @as(f64, @floatFromInt(row_offset)) * border_width;

        cell.as(appKit.NSView).setFrame(.{.origin = .{ .x = x, .y = y }, .size = cell_size });
        cell.as(appKit.NSView).setWantsLayer(true);
        cell.as(appKit.NSView).layer().setBorderWidth(border_width);
        cell.as(appKit.NSView).layer().setBorderColor(appKit.NSColor.grayColor().cgColor());

        return cell;
    }

    fn buildColumnHeader(config: struct {origin: foundation.NSPoint, cell_count: usize, fixed_cell_size: foundation.NSSize, cell_size: foundation.NSSize, sheet_height: f64, top_inset: f64, border_width: f64}) !appKit.NSView {
        std.debug.print("(header) sheet_height:{}, cell_height:{}\n", .{config.sheet_height, config.cell_size.height});

        const headers_size: foundation.NSSize = .{
            .width = config.cell_size.width * @as(f64, @floatFromInt(config.cell_count)), 
            .height = config.cell_size.height,
        };
        const headers_view = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = config.origin, .size = headers_size });
        headers_view.as(appKit.NSView).setWantsLayer(true);
        headers_view.as(appKit.NSView).layer().setBackgroundColor(appKit.NSColor.whiteColor().cgColor());

        for (0..config.cell_count) |c| {
            var buf: [2]u8 = undefined;
            const s = try std.fmt.bufPrintZ(&buf, "{c}", .{@as(u8, @intCast(c + 'A'))});
            const cell = buildCell(c, 0, config.cell_size, config.border_width, s);

            headers_view.addSubview(cell.as(appKit.NSView));
        }

        return headers_view;
    }

    fn buildRowHeader(config: struct {cell_count: usize, fixed_cell_size: foundation.NSSize, cell_size: foundation.NSSize, sheet_height: f64, top_inset: f64, border_width: f64}) !appKit.NSView {
        const origin: foundation.NSPoint = .{ 
            .x = 0, 
            .y = 0, 
        };
        const size = .{ 
            .width = config.fixed_cell_size.width, 
            .height = config.sheet_height - config.top_inset + config.border_width,
        };
        
        const headers_view = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = origin, .size = size });
        headers_view.as(appKit.NSView).setWantsLayer(true);
        headers_view.as(appKit.NSView).layer().setBackgroundColor(appKit.NSColor.whiteColor().cgColor());

        for (0..config.cell_count) |r| {
            var buf: [3]u8 = undefined;
            const s = try std.fmt.bufPrintZ(&buf, "{}", .{r+1});
            const cell = buildCell(0, config.cell_count - r - 1, config.fixed_cell_size, config.border_width, s);
            headers_view.addSubview(cell.as(appKit.NSView));
        }

        return headers_view;        
    }

    fn buildRow(allocator: std.mem.Allocator, config: 
        struct{
            row: usize, col_count: usize, fixed_cell_size: foundation.NSSize, cell_size: foundation.NSSize, 
            sheet_height: f64, top_inset: f64, border_width: f64
        }) !(struct {view: appKit.NSView, cells: []const SpreadsheetCell}) 
    {
        var cells = try allocator.alloc(SpreadsheetCell, config.col_count);

        const origin: foundation.NSPoint = .{ 
            .x = config.fixed_cell_size.width - config.border_width, 
            .y = config.sheet_height - @as(f64, @floatFromInt(config.row+1)) * config.cell_size.height + @as(f64, @floatFromInt(config.row+1)) * config.border_width,
        };
        const size = .{ 
            .width = config.cell_size.width * @as(f64, @floatFromInt(config.col_count)), 
            .height = config.cell_size.height,
        };
        const rows_view = appKit.NSView.of(appKit.NSView).initWithFrame(.{ .origin = origin, .size = size });

        for (0..config.col_count) |c| {
            const s = "";
            // var buf: [3]u8 = undefined;
            // const s = try std.fmt.bufPrintZ(&buf, "{}", .{config.row+1});
            const cell_view = buildCell(c, 0, config.cell_size, config.border_width, s);

            rows_view.addSubview(cell_view.as(appKit.NSView));
            cells[c] = SpreadsheetCell.init(c, config.row, cell_view.as(appKit.NSView), cell_view);
        }

        return .{.view = rows_view, .cells = cells};
    }

    fn putCells(self: *SpreadSheet, cells: []const SpreadsheetCell) !void {
        for (cells) |cell| {
            try self.cells.put(cell);
        }
    }

    fn bindAction(self: *SpreadSheet) void {
        // inplace field editor
        self.editor.as(appKit.NSTextView.Sharing).setDelegate(CellEditorDelegate.initWithContext(self));

        // state observer
        self.states.observer = .{
            .ctx = self,
            .call = &dispatchValueUpdated,
        };

        const gesture_config = appKit.NSPressureConfiguration.of(appKit.NSPressureConfiguration).initWithPressureBehavior(appKit.NSPressureBehavior.PrimaryClick);
        self.content_view.as(appKit.NSPressureConfiguration.ForNSView.PressureConfiguration).setPressureConfiguration(gesture_config);

        // single click (left)
        const left_click_gesture = appKit.NSGestureRecognizer.of(appKit.NSClickGestureRecognizer).initWithTargetAction(null, null);
        left_click_gesture.setButtonMask(1 << 0);
        left_click_gesture.setNumberOfClicksRequired(1);
        left_click_gesture.as(appKit.NSGestureRecognizer).setDelegate(CellGestureDelegate.initWithContext(self));
        self.content_view.as(appKit.NSView.GestureRecognizer).addGestureRecognizer(left_click_gesture.as(appKit.NSGestureRecognizer)); 

        // double click (left)
        const left_dbl_click_gesture = appKit.NSGestureRecognizer.of(appKit.NSClickGestureRecognizer).initWithTargetAction(null, null);
        left_click_gesture.setButtonMask(1 << 0);
        left_dbl_click_gesture.setNumberOfClicksRequired(2);
        left_dbl_click_gesture.as(appKit.NSGestureRecognizer).setDelegate(CellDblGestureDelegate.initWithContext(self));
        self.content_view.as(appKit.NSView.GestureRecognizer).addGestureRecognizer(left_dbl_click_gesture.as(appKit.NSGestureRecognizer)); 

        // sync scroll
        const sync_scroll_action = appKit_support.Handlers(SpreadSheet).Action(foundation.NSNotification).init(self, &SpreadSheet.handleViewScrolled);
        foundation.NSNotificationCenter.defaultCenter().addObserverSelectorName(
            sync_scroll_action.target,
            sync_scroll_action.action,
            appKit.NSView.ExternVars.NSViewBoundsDidChangeNotification(),
            runtime_support.objectId(appKit.NSClipView, self.content_view.contentView())
        );
    }

    fn handleSelectCell(ctx: *SpreadSheet, gesture: appKit.NSGestureRecognizer, ev: appKit.NSEvent) !bool {
        _ = gesture;

        if (ev.clickCount() != 1) return false;

        std.debug.print("handleSelectCell ({})\n", .{ev.clickCount()});

        if (ctx.content_view.documentView()) |doc_view| {
            const loc = doc_view.as(appKit.NSView).convertPointFromView(ev.locationInWindow(), null);
            if (ctx.toAddress(loc)) |address| {
                std.debug.print("Selecting cell: {}\n", .{address});

                if (ctx.active_cell) |active_cell| {
                    if (active_cell.eqlAddress(address.col, address.row)) return false;

                    try ctx.deactivateCell(active_cell);
                }
                ctx.activateAt(address.col, address.row);

                return true;
            }
        }

        return false;
    }

    fn handleBeginEditCell(ctx: *SpreadSheet, gesture: appKit.NSGestureRecognizer, ev: appKit.NSEvent) !bool {
        _ = gesture;

        if (ev.clickCount() != 2) return false;

        std.debug.print("handleBeginEditCell ({})\n", .{ev.clickCount()});

        if (ctx.content_view.documentView()) |doc_view| {
            const loc = doc_view.as(appKit.NSView).convertPointFromView(ev.locationInWindow(), null);
            if (ctx.toAddress(loc)) |address| {
                // std.debug.print("Enter field editor: (col: {}, row: {})", .{address.col, address.row});

                if (ctx.active_cell) |*active_cell| {
                    defer active_cell.is_edited = true;
                    std.debug.print("Editing cell: {}\n", .{address});

                    if (ctx.editor.textStorage()) |storage| {
                        const text = text: {
                            const s0 = try ctx.states.cellTextFor(ctx.allocator, active_cell.cell.col, active_cell.cell.row);
                            defer ctx.allocator.free(s0);

                            break :text foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(s0).?;
                        };
                        const attr_text = foundation.NSAttributedString.ExtendedAttributedString.of(foundation.NSAttributedString).initWithString(text);

                        storage.as(foundation.NSMutableAttributedString.ExtendedMutableAttributedString).setAttributedString(attr_text);
                    }

                    active_cell.cell.value_view.as(appKit.NSView).addSubview(ctx.editor.as(appKit.NSView));

                    const r = ev.window().?.makeFirstResponder(ctx.editor.as(appKit.NSResponder));
                    std.debug.print("responder changed? {}\n", .{r});

                    return true;
                }
            }
        }

        return false;
    }

    fn handleEndEditCell(ctx: *SpreadSheet, _: appKit.NSTextView, _commandSelector: objc.Sel) !bool {
        if (std.meta.eql(_commandSelector, appKit.NSStandardKeyBindingRespondingSelectors.insertNewline())) {
            if (ctx.active_cell) |active_cell| {
                try ctx.deactivateCell(active_cell);
            }

            return true;
        }

        return false;
    }

    fn handleViewScrolled(context: ?*SpreadSheet, _: foundation.NSNotification) !void {
        if (context) |ctx| {
            const visible_origin = ctx.content_view.documentVisibleRect().origin;

            const origin = ctx.col_header_view.frame().origin;
            if (origin.x != @abs(visible_origin.x)) {
                ctx.col_header_view.setFrameOrigin(.{.x = -visible_origin.x, .y = origin.y});
            }
        }
    }

    fn buildColumnHeadersView(self: *SpreadSheet, frame_size: foundation.NSSize) !void {
        const col_headers_bounds: foundation.NSRect = .{
            .origin = .{.x = self.config.fixed_cell_size.width - self.config.border_width, .y = frame_size.height-1},
            .size = .{.width = frame_size.width, .height = self.config.fixed_cell_size.height}
        };
        const col_headers_root = appKit.NSView.of(appKit.NSView).initWithFrame(col_headers_bounds);
        col_headers_root.setWantsLayer(true);

        const col_headers = try buildColumnHeader(
            .{
                .cell_count = self.config.col_count, 
                .fixed_cell_size = self.config.fixed_cell_size,
                .cell_size = self.config.cell_size,
                .sheet_height = frame_size.height,
                .top_inset = self.config.top_inset,
                .border_width = self.config.border_width,
                .origin = .{.x = 0, .y = 0},
            }
        );
        col_headers_root.addSubview(col_headers);
        self.root_view.addSubview(col_headers_root);

        self.col_header_view = col_headers;
    }

    pub fn deinit(self: *SpreadSheet) void {
        self.cells.deinit();
        self.states.deinit();
    }

    pub fn toAddress(self: *SpreadSheet, location: foundation.NSPoint) ?(struct {col: usize, row: usize}) {
        if (location.x < self.config.fixed_cell_size.width) return null;
        if (location.y > self.config.cell_size.height * @as(f64, @floatFromInt(self.config.row_count))) return null;
        
        const row_offset: usize = @intFromFloat(location.y / (self.config.cell_size.height - self.config.border_width));
        const col_offset: usize = @intFromFloat((location.x - self.config.fixed_cell_size.width) / (self.config.cell_size.width - self.config.border_width));

        return .{
            .row = self.config.row_count - row_offset - 1,
            .col = col_offset,
        };
    }

    pub fn deactivateCell(self: *SpreadSheet, active_cell: ActiveCell) !void { 
        defer self.active_cell = null;

        if (active_cell.is_edited) {
            try self.evaluateEditor(self.editor, active_cell);
            self.editor.as(appKit.NSView).removeFromSuperview();
        }

        active_cell.cell.cell_view.as(appKit.NSView).layer().setBackgroundColor(appKit.NSColor.whiteColor().cgColor());
    }

    pub fn activateAt(self: *SpreadSheet, col: usize, row: usize) void {
        if (self.cells.get(col, row)) |cell| {
            // std.debug.print("fetch cell: (col: {}, row: {})\n", .{cell.col, cell.row});
            cell.cell_view.as(appKit.NSView).layer().setBackgroundColor(appKit.NSColor.selectedControlColor().cgColor());
            
            self.active_cell = .{ .cell = cell, .is_edited = false };
        }
    }

    fn evaluateEditor(self: *SpreadSheet, editor: appKit.NSTextView, active_cell: ActiveCell) !void {
        if (editor.textStorage()) |storage| {
            const text = storage
                .as(foundation.NSAttributedString).string()
                .as(foundation.NSString.ExtensionMethods).utf8String().?
            ;

            std.debug.print("Begin evaluate text: `{s}`\n", .{text});

            try self.states.beginEvaluate(active_cell.cell.col, active_cell.cell.row, std.mem.span(text));
        }
    }

    fn dispatchValueUpdated(ctx: *anyopaque, col: usize, row: usize, result: EvalResult) void {
        const self: *SpreadSheet = @ptrCast(@alignCast(ctx));

        self.notifyCellUpdated(col, row, result);
    }

    fn notifyCellUpdated(self: *SpreadSheet, col: usize, row: usize, result: EvalResult) void {
        if (self.cells.get(col, row)) |cell| {
            switch (result) {
                .success => |v| updateCellValue(cell, v, appKit.NSColor.controlTextColor()),
                .cycric => updateCellValue(cell, "(Cycric)", appKit.NSColor.redColor()),
                .invalid => updateCellValue(cell, "(Invalid)", appKit.NSColor.redColor()),
                .div_zero => updateCellValue(cell, "(Div/0)", appKit.NSColor.redColor()),
                .undefined_call => updateCellValue(cell, "Name?", appKit.NSColor.redColor()),
                .unimplemented => updateCellValue(cell, "(Unimplemented)", appKit.NSColor.purpleColor()),
            }
        }
    }

    fn updateCellValue(cell: SpreadsheetCell, value: [:0]const u8, color: appKit.NSColor) void {
        const s1 = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(value).?;
        cell.value_view.as(appKit.NSControl).setStringValue(s1);
        cell.value_view.setTextColor(color);
    }
};

const CellGestureDelegate = appKit.NSGestureRecognizerDelegate.Protocol(SpreadSheet).Derive(.{
    .handler_gesture_recognizer_delegate = .{
        .gestureRecognizerShouldAttemptToRecognizeWithEvent = &SpreadSheet.handleSelectCell,
        // .gestureRecognizerShouldRequireFailureOfGestureRecognizer = &SpreadSheet.handleRequestClick,
    },
}, runtime_support.identity_seed.FixValueSeed("5074ac72-9407-4b0c-a2ef-b71a2f27a219"));

const CellDblGestureDelegate = appKit.NSGestureRecognizerDelegate.Protocol(SpreadSheet).Derive(.{
    .handler_gesture_recognizer_delegate = .{
        .gestureRecognizerShouldAttemptToRecognizeWithEvent = &SpreadSheet.handleBeginEditCell,
        // .gestureRecognizerShouldRequireFailureOfGestureRecognizer = &SpreadSheet.handleRequestDblClick,
    },
}, runtime_support.identity_seed.FixValueSeed("174eaa08-6eb5-4765-9885-0f4df6db05dd"));

const CellEditorDelegate =
    appKit.NSTextViewDelegate.Protocol(SpreadSheet).Derive(
    .{
        .handler_text_view_delegate = .{
            .textViewDoCommandBySelector = SpreadSheet.handleEndEditCell,
        },
    },
    runtime_support.identity_seed.FixValueSeed("0631ee4b-fdcd-4efe-999d-61f7aefd2798"),
);


pub const SpreadsheetCell = struct {
    col: usize, 
    row: usize,
    cell_view: appKit.NSView,
    value_view: appKit.NSTextField,

    pub fn init(col: usize, row: usize, cell_view: appKit.NSView, value_view: appKit.NSTextField) SpreadsheetCell {
        return .{
            .col = col,
            .row = row,
            .cell_view = cell_view,
            .value_view = value_view,
        };
    }

    pub fn withAddress(col: usize, row: usize) SpreadsheetCell {
        return .{
            .col = col,
            .row = row,
            .cell_view = undefined,
            .value_view = undefined,
        };
    }
};

pub const CellCollection = struct {
    const Tree = std.Treap(SpreadsheetCell, struct {
        pub fn compare(lhs: SpreadsheetCell, rhs: SpreadsheetCell) std.math.Order {
            if (lhs.col != rhs.col) return std.math.order(lhs.col, rhs.col);
            if (lhs.row != rhs.row) return std.math.order(lhs.row, rhs.row);
            return .eq;
        }
    }.compare);

    arena: *std.heap.ArenaAllocator,
    allocator: std.mem.Allocator,
    tree: Tree,

    pub fn init(allocator: std.mem.Allocator) !CellCollection {
        const arena = try allocator.create(std.heap.ArenaAllocator);
        arena.* = std.heap.ArenaAllocator.init(allocator);

        return .{
            .arena = arena,
            .allocator = arena.allocator(),
            .tree = Tree{},
        };
    }

    pub fn deinit(self: CellCollection) void {
        self.arena.deinit();
        self.arena.child_allocator.destroy(self.arena);
    }

    pub fn put(self: *CellCollection, cell: SpreadsheetCell) !void {
        var entry = self.tree.getEntryFor(SpreadsheetCell.withAddress(cell.col, cell.row));

        if (entry.node == null) {
            entry.key = cell;

            entry.set(try self.allocator.create(Tree.Node));
        }
    }

    pub fn get(self: *CellCollection, col: usize, row: usize) ?SpreadsheetCell {
        const entry = self.tree.getEntryFor(SpreadsheetCell.withAddress(col, row));

        if (entry.node) |node| {
            return node.key;
        }

        return null;
    }
};