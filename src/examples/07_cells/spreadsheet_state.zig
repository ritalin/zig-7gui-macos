const std = @import("std");

const eval_types = @import("./eval/eval_types.zig");
const EvalProgress = eval_types.EvalProgress;
const ParseResult = eval_types.ParseResult;

const ops = @import("./eval/ops.zig");
const utils = @import("./eval/eval_utils.zig");

const Evaluator = @import("./eval/eval.zig").Evaluator;

pub const MAX_ROW_COUNT = 99;
pub const MAX_COL_COUNT = 'z' - 'a' + 1;

pub const EvalResult = union(enum) {
    unimplemented: void,
    cycric: void,
    invalid: void,
    div_zero: void,
    undefined_call: void,
    success: Success,

    const Success = [:0]const u8;
};

pub const Observer = struct {
    ctx: *anyopaque,
    call: *const fn (ctx: *anyopaque, col: usize, row: usize, result: EvalResult) void,
};

const LinkReferenceRequest = struct {
    const Mode = enum {link, unlink};
    const StateContext = Self;

    context: *StateContext,
    request: *const fn (context: *StateContext, cell_name: []const u8, reference: []const u8, mode: Mode) anyerror!void,
};

const builtin_functions: BuiltinFunctions = .{};

arena: *std.heap.ArenaAllocator,
state_map: std.StringHashMap(*CellState),
observer: ?Observer = null,

const Self = @This();

pub fn init(allocator: std.mem.Allocator) !Self {
    const arena = try createArena(allocator);

    return .{
        .arena = arena,
        .state_map = std.StringHashMap(*CellState).init(arena.allocator()),
    };
}

pub fn deinit(self: Self) void {
    self.arena.deinit();
    self.arena.child_allocator.destroy(self.arena);
}

pub fn beginEvaluate(self: *Self, col: usize, row: usize, text: [:0]const u8) !void {
    if (text.len == 0) {
        try self.removeState(col, row);
    } 
    else {
        try self.evaluateExpression(col, row, text);
    }
}

fn removeState(self: *Self, col: usize, row: usize) !void {
    const arena = std.heap.ArenaAllocator.init(self.arena.allocator());
    defer arena.deinit();

    const allocator = self.arena.allocator();

    const cell_name = try utils.nameFromAddress(allocator, col, row);

    if (self.state_map.get(cell_name)) |state| {
        defer {
            if (state.sitations.count() == 0) {
                _ = self.state_map.fetchRemove(cell_name);
                state.deinit();
            }
        }

        try state.parse("");

        const result = .{.success = ""};

        var cyclics = std.BufSet.init(allocator);
        var eval_cache = std.StringHashMap(EvalProgress).init(allocator);
        try eval_cache.put(cell_name, .empty);

        self.notify(col, row, result);
        try self.notifyRefCite(state, result, &cyclics, &eval_cache);

        try state.unlinkReferences(cell_name, self.notifyLinkRequested());
    }
}

fn evaluateExpression(self: *Self, col: usize, row: usize, text: []const u8) !void {
    const root_allocator = self.arena.allocator();
    const cell_name = try utils.nameFromAddress(root_allocator, col, row);
    defer root_allocator.free(cell_name);

    if (try self.stateOf(col, row, cell_name, text)) |state| {
        try state.parse(text);

        var arena = std.heap.ArenaAllocator.init(root_allocator);
        defer arena.deinit();

        const allocator = arena.allocator();

        var cyclics = std.BufSet.init(allocator);
        try cyclics.insert(cell_name);

        var eval_cache = std.StringHashMap(EvalProgress).init(allocator);
        
        var evaluator = Evaluator(Self).init(allocator, self, &cyclics, &eval_cache);
        const eval_result: EvalResult = result: {
            if (evaluator.evaluate(state.parse_result)) |progress| {
                try evaluator.eval_cache.put(cell_name, progress);
                break :result .{.success = try progress.asString(allocator)};
            }
            else |err| {
                break :result try handleEvalError(err);
            }
        };

        try state.linkReferences(cell_name, try evaluator.references(), self.notifyLinkRequested()); 

        self.notify(col, row, eval_result);
        try self.notifyRefCite(state, eval_result, &cyclics, evaluator.eval_cache);
    }
}

fn stateOf(self: *Self, col: usize, row: usize, cell_name: []const u8, text: ?[]const u8) !?*CellState {
    const allocator = self.arena.allocator();
    const entry = try self.state_map.getOrPut(cell_name);

    if (entry.found_existing) {
        if (text) |s| {
            if (! entry.value_ptr.*.cellTextChanged(s)) return null;
        }
    }
    else {
        const arena = try createArena(allocator);
        entry.key_ptr.* = try allocator.dupe(u8, cell_name);
        entry.value_ptr.* = try CellState.init(arena, col, row);
    }
    
    return entry.value_ptr.*;
}

pub fn resolveReference(self: *Self, cell_name: []const u8, cyclics: *std.BufSet, cache: *std.StringHashMap(EvalProgress)) !EvalProgress {
    var arena = try createArena(self.arena.allocator());
    defer arena.deinit();

    const eval_result = result: {
        if (self.state_map.get(cell_name)) |state| {
            try cyclics.insert(cell_name);

            var evaluator = Evaluator(Self).init(arena.allocator(), self, cyclics, cache);
            break :result try evaluator.evaluate(state.parse_result);
        }
        else {
            break :result .empty;
        }
    };

    return eval_result.clone(cache.allocator);
}

fn handleEvalError(err: anyerror) !EvalResult {
    return switch (err) {
        error.div_zero_expr => .div_zero, 
        error.invalid_expr, error.unmatch_any_type => .invalid,
        error.cycric_identifier => .cycric, 
        error.unimplemented_feature => .unimplemented, 
        error.undefined_call => .undefined_call,
        else => return err,
    };
}

pub fn resolveCall(self: *Self, call_name: []const u8) anyerror!eval_types.CallRequest(Self) {
    const functions = std.meta.fields(BuiltinFunctions);

    inline for (functions) |f| {
        if (std.mem.eql(u8, f.name, call_name)) {
            return .{
                .context = self,
                .callable = @ptrCast(@alignCast(@field(Self.builtin_functions, f.name))),
            };
        }
    }

    return error.undefined_call;
}

fn notify(self: Self, col: usize, row: usize, result: EvalResult) void {
    if (self.observer) |observer| {
        observer.call(observer.ctx, col, row, result);
    }
}

fn notifyRefCite(self: *Self, state: *CellState, result: EvalResult, cyclics: *std.BufSet, cache: *std.StringHashMap(EvalProgress)) !void {
    const allocator = self.arena.allocator();

    var iter = state.sitations.iterator();
    while (iter.next()) |site| {
        if (self.state_map.get(site.*)) |ref_state| {
            const eval_result: EvalResult = result: {
                switch (result) {
                    .success => {
                        var cite_cyclics = try cyclics.cloneWithAllocator(allocator);
                        defer cite_cyclics.deinit();

                        if (self.resolveReference(site.*, &cite_cyclics, cache)) |progress| {
                            try cache.put(try cache.allocator.dupe(u8, site.*), progress);
                            break :result .{.success = try progress.asString(allocator)};
                        }
                        else |err| {
                            break :result try handleEvalError(err);
                        }
                    },
                    else => break :result result,
                }
            };

            self.notify(ref_state.col, ref_state.row, eval_result);
            try self.notifyRefCite(ref_state, eval_result, cyclics, cache);
        }
    }
}

fn notifyLinkRequested(self: *Self) LinkReferenceRequest {
    return .{
        .context = self,
        .request = &Self.dispatchLinkRequest,
    };
}

fn dispatchLinkRequest(self: *Self, cell_name: []const u8, reference: []const u8, mode: LinkReferenceRequest.Mode) !void {
    const address = try utils.nameToAddress(cell_name, MAX_ROW_COUNT);

    if (try self.stateOf(address.col, address.row, reference, null)) |state| {
        switch (mode) {
            .link => try state.sitations.insert(cell_name),
            .unlink => state.sitations.remove(cell_name)
        }
    }
}

pub fn cellTextFor(self: *Self, allocator: std.mem.Allocator, col: usize, row: usize) ![:0]const u8 {
    const name = try utils.nameFromAddress(allocator, col, row);
    defer allocator.free(name);

    return if (self.state_map.get(name)) |state| state.cellText(allocator) else allocator.dupeZ(u8, "");
}

fn createArena(allocator: std.mem.Allocator) !*std.heap.ArenaAllocator {
    const arena = try allocator.create(std.heap.ArenaAllocator);
    arena.* = std.heap.ArenaAllocator.init(allocator);

    return arena;
}

const CellState = struct {
    arena: *std.heap.ArenaAllocator,
    col: usize,
    row: usize,
    parse_result: ParseResult,
    references: std.BufSet,
    sitations: std.BufSet,

    pub fn init(arena: *std.heap.ArenaAllocator, col: usize, row: usize) !*CellState {
        const managed_allocator = arena.allocator();
        
        const self = try managed_allocator.create(CellState);
        self.* = .{
            .arena = arena,
            .col = col,
            .row = row,
            .parse_result = .empty,
            .references = std.BufSet.init(managed_allocator),
            .sitations = std.BufSet.init(managed_allocator),
        };

        return self;
    }
    
    pub fn deinit(self: CellState) void {
        self.arena.deinit();
        self.arena.child_allocator.destroy(self.arena);
    }

    pub fn parse(self: *CellState, text: []const u8) !void {
        self.parse_result.deinit();

        const allocator = self.arena.allocator();

        self.parse_result = result: {
            if (text.len == 0) {
                break :result .empty;
            }
            else if (text[0] != '=') {
                break :result .{ 
                    .text = .{ 
                        .allocator = allocator, 
                        .value = try allocator.dupeZ(u8, text) 
                    }, 
                };
            }
            else {
                break :result .{ 
                    .ast = .{ 
                        .allocator = allocator, 
                        .tree = try std.zig.Ast.parse(allocator, try allocator.dupeZ(u8, text[1..]), .zon) 
                    },
                };
            }
        };
    }

    pub fn cellText(self: *CellState, allocator: std.mem.Allocator) ![:0]const u8 {
        return switch (self.parse_result) {
            .empty => allocator.dupeZ(u8, ""),
            .text => |obj| allocator.dupeZ(u8, obj.value),
            .ast => |obj| std.fmt.allocPrintZ(allocator, "={s}", .{obj.tree.source}),
        };
    }

    pub fn cellTextChanged(self: *CellState, text: []const u8) bool {
        const new_text = if (text[0] == '=') text[1..] else text; 
        const old_text = text: {
            switch (self.parse_result) {
                .empty => return new_text.len > 0,
                .text => |obj| break :text obj.value,
                .ast => |obj| break :text obj.tree.source,
            }
        };

        return ! std.mem.eql(u8, std.mem.sliceTo(old_text, 0), new_text);
    }

    pub fn linkReferences(self: *CellState, cell_name: []const u8, new_references: std.BufSet, callback: LinkReferenceRequest) !void {
        var iter_new = new_references.iterator();

        while (iter_new.next()) |site| {
            if (std.mem.eql(u8, site.*, cell_name)) continue;

            if (! self.references.contains(site.*)) {
                try self.references.insert(site.*);
                try callback.request(callback.context, cell_name, site.*, .link);
            }
        }

        var old_references = try self.references.clone();
        defer old_references.deinit();

        var iter_old = old_references.iterator();

        while (iter_old.next()) |site| {
            if (! new_references.contains(site.*)) {
                self.references.remove(site.*);
                try callback.request(callback.context, cell_name, site.*, .unlink);
            }
        }
    }

    pub fn unlinkReferences(self: *CellState, cell_name: []const u8, callback: LinkReferenceRequest) !void {
        defer {
            self.references.deinit();
            self.references = std.BufSet.init(self.arena.allocator());
        }

        var iter = self.references.iterator();

        while (iter.next()) |site| {
            try callback.request(callback.context, cell_name, site.*, .unlink);
        }
    }
};

const BuiltinFunctions = struct {
    const StateContext = Self;
    const Callable = eval_types.CallRequest(StateContext).Callable;
    
    range: Callable = struct {
        fn invoke(context: *StateContext, allocator: std.mem.Allocator, args: []const EvalProgress, cyclics: *std.BufSet, cache: *std.StringHashMap(EvalProgress)) anyerror!EvalProgress {
            _ = context;
            _ = allocator;
            _ = cyclics;
            _ = cache;

            if (args.len < 2) return error.invalid_expr;
            for (args[0..2]) |arg| {
                if (std.meta.activeTag(arg) != .identifier) return error.invalid_expr;
            }

            var from: EvalProgress.Range.Cell = cell: {
                const cell_name = args[0].identifier;
                const a = try utils.nameToAddress(cell_name, MAX_ROW_COUNT);
                break :cell .{.col = a.col, .row = a.row};
            };

            var to: EvalProgress.Range.Cell = cell: {
                const cell_name = args[1].identifier;
                const a = try utils.nameToAddress(cell_name, MAX_ROW_COUNT);
                break :cell .{.col = a.col, .row = a.row};
            };

            if ((from.col > to.col)) {
                std.mem.swap(usize, &from.col, &to.col);
            }
            if ((from.row > to.row)) {
                std.mem.swap(usize, &from.row, &to.row);
            }

            return .{.range = .{.from = from, .to = to}};
        }
    }.invoke,
    
    sum: Callable = struct {
        fn invoke(context: *StateContext, allocator: std.mem.Allocator, args: []const EvalProgress, cyclics: *std.BufSet, cache: *std.StringHashMap(EvalProgress)) anyerror!EvalProgress {
            var acc: EvalProgress = .empty;
            
            for (args) |arg| {
                switch (arg) {
                    .identifier => |cell_name| {
                        if (cache.get(cell_name)) |v| {
                            acc = try ops.evalBinaryMathOperator(.add, acc, v);
                        }
                        else {
                            const v = try context.resolveReference(cell_name, cyclics, cache);
                            try cache.put(cell_name, v);
                            acc = try ops.evalBinaryMathOperator(.add, acc, v);
                        }
                    },
                    .range => |range| {
                        var iter = range.iterate();

                        while (iter.next()) |c| {
                            const cell_name = try utils.nameFromAddress(allocator, c.col, c.row);

                            const value = v: {
                                if (cache.get(cell_name)) |v| {
                                    break :v v;
                                }
                                else {
                                    const v = try context.resolveReference(cell_name, cyclics, cache);
                                    try cache.put(cell_name, v);
                                    break :v v;
                                }
                            };

                            acc = try ops.evalBinaryMathOperator(.add, acc, value);
                        }
                    },
                    else => acc = try ops.evalBinaryMathOperator(.add, acc, arg),
                }
            }
            
            return acc;
        }
    }.invoke,
    
    count: Callable = struct {
        fn invoke(context: *StateContext, allocator: std.mem.Allocator, args: []const EvalProgress, cyclics: *std.BufSet, cache: *std.StringHashMap(EvalProgress)) anyerror!EvalProgress {
            _ = context;
            _ = allocator;
            _ = cyclics;
            _ = cache;

            var acc: u64 = 0;
            
            for (args) |arg| {
                switch (arg) {
                    .range => |range| {
                        acc += (range.to.row - range.from.row + 1) * (range.to.col - range.from.col + 1);
                    },
                    else => acc += 1,
                }
            }

            return .{.uint = acc};
        }
    }.invoke,
    
    counta: Callable = struct {
        fn invoke(context: *StateContext, allocator: std.mem.Allocator, args: []const EvalProgress, cyclics: *std.BufSet, cache: *std.StringHashMap(EvalProgress)) anyerror!EvalProgress {
            var acc: u64 = 0;

            for (args) |arg| {
                switch (arg) {
                    .identifier => |cell_name| {
                        const value = v: {
                            if (cache.get(cell_name)) |v| {
                                break :v v;
                            }
                            else {
                                const v = try context.resolveReference(cell_name, cyclics, cache);
                                try cache.put(cell_name, v);
                                break :v v;
                            }
                        };
                        if (!value.isEmpty()) { acc += 1; }
                    },
                    .range => |range| {
                        var iter = range.iterate();

                        while (iter.next()) |c| {
                            const cell_name = try utils.nameFromAddress(allocator, c.col, c.row);

                            const value = v: {
                                if (cache.get(cell_name)) |v| {
                                    break :v v;
                                }
                                else {
                                    const v = try context.resolveReference(cell_name, cyclics, cache);
                                    try cache.put(cell_name, v);
                                    break :v v;
                                }
                            };
                            if (!value.isEmpty()) { acc += 1; }
                        }
                    },
                    else => if (!arg.isEmpty()) { acc += 1; },
                }
            }

            return .{.uint = acc};
        }
    }.invoke,
};