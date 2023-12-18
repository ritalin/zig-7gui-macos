
const std = @import("std");

pub const NopState = struct{
    pub fn deinit(_: *NopState) void {}
};

pub fn ApplicationContext(comptime ApplicationState: type) type {
    return struct {
        pub const State = ApplicationState;

        arena: *std.heap.ArenaAllocator,
        state: ?*State,

        const Context = @This();

        pub fn deinit(self: *Context) void {
            var allocator = self.arena.child_allocator;

            if (comptime std.meta.hasFn(Context.State, "deinit")) {
                if (self.state) |x| {
                    x.deinit();
                }
            }
            self.arena.deinit();
            allocator.destroy(self.arena);
        }
    };
}

pub const ApplicationContextWithoutState = ApplicationContext(struct{});

pub fn ApplicationContextFactory(comptime Context: type) type {
    return struct {
        pub fn create(gpa: std.mem.Allocator, config: ?(*const fn (allocator: std.mem.Allocator) anyerror!*Context.State)) !*Context {
            var arena = try gpa.create(std.heap.ArenaAllocator);
            arena.* = std.heap.ArenaAllocator.init(gpa);
            
            var allocator = arena.allocator();
            const self = try allocator.create(Context);

            self.* = Context{
                .arena = arena,
                .state = if (config) |c| try c(allocator) else null,
            };

            return self;
        }
    };
}