const std = @import("std");
const runtime = @import("Runtime");
const appKit = @import("AppKit");
const foundation = @import("Foundation");

const SpreadSheet = @import("./spreadsheet_view.zig").SpreadSheet;

const NSInteger = runtime.NSInteger;



pub const SpreadsheetContext = struct {
    pub const WidgetRef = struct {
        spreadsheet: *SpreadSheet,
    };

    allocator: std.mem.Allocator,
    widgets: WidgetRef,

    pub fn init(allocator: std.mem.Allocator, widgets: WidgetRef) !*SpreadsheetContext {
        const self = try allocator.create(SpreadsheetContext);
        self.* = .{
            .allocator = allocator,
            .widgets = widgets,
        };

        return self;
    }

    pub fn deinit(self: *SpreadsheetContext) void {
        self.widgets.spreadsheet.deinit();
    }
};

pub const SpreadsheetHandlers = struct {
    pub fn handleShouldSelectRow(_: *SpreadsheetContext, _: appKit.NSTableView, _: NSInteger) !bool {
        return true;
    }

    pub fn handleShouldEditTableColumnRow(_: *SpreadsheetContext, _: appKit.NSTableView, _: ?appKit.NSTableColumn, _: NSInteger) !bool {
        return true;
    }

    pub fn handleSelectionDidChange(_: *SpreadsheetContext, _: foundation.NSNotification) !void {
        //
        std.debug.print("handleSelectionDidChange\n", .{});
    }

    pub fn handleShouldChangeInTableView(_: *SpreadsheetContext, _: appKit.NSTableView) !bool {
        return true;
    }
};
