const std = @import("std");

const foundation = @import("Foundation");
const quartzCore = @import("QuartzCore");

const Self = @This();

arena: *std.heap.ArenaAllocator,
map: std.StringHashMap(quartzCore.CALayer),
key_allocator: std.mem.Allocator,

pub fn init(allocator: std.mem.Allocator) !Self {
    var arena = try allocator.create(std.heap.ArenaAllocator);
    arena.* = std.heap.ArenaAllocator.init(allocator);

    return .{
        .arena = arena,
        .map = std.StringHashMap(quartzCore.CALayer).init(arena.allocator()),
        .key_allocator = arena.allocator(),
    };
}

pub fn deinit(self: *Self) void {
    self.map.deinit();

    var allocator = self.arena.child_allocator;
    self.arena.deinit();
    allocator.destroy(self.arena);
}

pub fn registerWithName(self: *Self, layer: quartzCore.CALayer, name: [:0]const u8) !void {
    const s = foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String(name.ptr).?;
    layer.setName(s);

    const key = try self.key_allocator.dupe(u8, std.mem.sliceTo(name, 0));
    const gop = try self.map.getOrPut(key);
    if (!gop.found_existing) {
        gop.value_ptr.* = layer;
    }
}

pub fn unregister(self: *Self, key: []const u8) void {
    if (self.map.getKey(key)) |name| {
        if (self.map.remove(name)) {
            self.key_allocator.free(name);
        }
    }
}

pub fn find(self: *Self, key: []const u8) ?quartzCore.CALayer {
    return self.map.get(key);
}
