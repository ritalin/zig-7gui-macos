const std = @import("std");
const foundation = @import("Foundation");

pub const Entry = struct {
    op: enum{ add, delete, change, nop },
    name: []const u8,
    old_bounds: foundation.NSRect,
    new_bounds: foundation.NSRect,

    pub fn reverse(entry: Entry) Entry {
        return .{
            .op = if (entry.op == .add) .delete else entry.op,
            .name = entry.name,
            .old_bounds = entry.new_bounds,
            .new_bounds = entry.old_bounds,
        };
    }

    pub fn deinit(self: Entry, allocator: std.mem.Allocator) void {
        allocator.free(self.name);
    }
};

const Self = @This();

const BUFFER_SIZE = 8;
const EMPTY_BOUNDS = foundation.NSRect{.origin = .{.x = 0, .y = 0}, .size = .{.width = 0, .height = 0}};
const DUMMY_ENTRY = Entry{
    .op = .nop,
    .name = "",
    .old_bounds = EMPTY_BOUNDS,
    .new_bounds = EMPTY_BOUNDS,
};

allocator: std.mem.Allocator,
undo_buffer: [BUFFER_SIZE]Entry,
head_index: usize = 0,
tail_index: usize = 0,
current_index: usize = 0,

pub fn init(allocator: std.mem.Allocator) Self {
    var buf: [BUFFER_SIZE]Entry = undefined;
    @memset(&buf, DUMMY_ENTRY);

    return .{
        .allocator = allocator,
        .undo_buffer = buf,
    };
}

pub fn peek(self: *Self) ?Self.Entry {
    return if (self.hasUndoEntry()) self.undo_buffer[self.current_index] else null;
}

pub fn undo(self: *Self) ?Self.Entry {
    if (! self.hasUndoEntry()) return null;

    const index = @mod(self.current_index + BUFFER_SIZE - 1, BUFFER_SIZE);
    defer self.current_index = index;

    return self.undo_buffer[self.current_index].reverse();
}

pub fn redo(self: *Self) ?Self.Entry {
    if (! self.hasRedoEntry()) return null;

    const index = @mod(self.current_index + BUFFER_SIZE + 1, BUFFER_SIZE);
    defer self.current_index = index;

    return self.undo_buffer[index];
}

pub inline fn hasUndoEntry(self: Self) bool {
    return self.current_index != self.head_index;
}

pub inline fn hasRedoEntry(self: Self) bool {
    return self.current_index != self.tail_index;
}

pub fn newEntry(self: *Self, name: []const u8, bounds: foundation.NSRect) !void {
    const entry = Entry{
        .op = .add,
        .name = try self.allocator.dupe(u8, name),
        .old_bounds = EMPTY_BOUNDS,
        .new_bounds = bounds,
    };
    return self.add(entry);
}

pub fn changeEntry(self: *Self, name: []const u8, new_bounds: foundation.NSRect, old_bounds: foundation.NSRect) !void {
    const entry = Entry{
        .op = .change,
        .name = try self.allocator.dupe(u8, name),
        .old_bounds = old_bounds,
        .new_bounds = new_bounds,
    };
    return self.add(entry);
}

fn add(self: *Self, entry: Entry) !void {
    const next_index = @mod(self.current_index + BUFFER_SIZE + 1, BUFFER_SIZE);
    defer {
        self.current_index = next_index;
        self.tail_index = next_index;

        if (self.head_index == self.tail_index) {
            self.head_index = next_index + 1;
        }
    }

    if (self.undo_buffer[next_index].op != .nop) {
        self.undo_buffer[next_index].deinit(self.allocator);
    }

    self.undo_buffer[next_index] = entry;
}
