const std = @import("std");
const runtime = @import("Runtime");
const foundation = @import("Foundation");

const Self = @This();

arena: *std.heap.ArenaAllocator,
state: State,

pub fn init(allocator: std.mem.Allocator) !Self {
    const arena = try allocator.create(std.heap.ArenaAllocator);
    arena.* = std.heap.ArenaAllocator.init(allocator);

    return .{
        .arena = arena,
        .state = State{},
    };
}

pub fn deinit(self: *Self) void {
    var allocator = self.arena.child_allocator;

    self.arena.deinit();
    allocator.destroy(self.arena);
}

pub fn contains(self: *Self, index: runtime.NSUInteger) bool {
    return self.state.getEntryFor(index).node != null;
}

pub fn includeIndex(self: *Self, index: runtime.NSUInteger) !void {
    var entry = self.state.getEntryFor(index);
    if (entry.node == null) {
        const node = try self.arena.allocator().create(State.Node);
        node.* = undefined;

        entry.set(node);
    }
}

pub fn diff(self: *Self, other: *Self) !Self {
    var result = try Self.init(self.arena.child_allocator);

    var iter = self.state.inorderIterator();

    while (iter.next()) |node| {
        if (other.state.getEntryFor(node.key).node == null) {
            try result.includeIndex(node.key);
        }
    }

    return result;
}

pub fn toSet(self: *Self) foundation.NSIndexSet {
    const result = foundation.NSIndexSet.of(foundation.NSMutableIndexSet).indexSet();

    var iter = self.state.inorderIterator();

    while (iter.next()) |node| {
        result.addIndex(node.key);
    }

    return result.as(foundation.NSIndexSet);
}

const State = std.Treap(runtime.NSUInteger, struct {
    pub fn compare(lhs: runtime.NSUInteger, rhs: runtime.NSUInteger) std.math.Order {
        return std.math.order(lhs, rhs);
    }
}.compare);
