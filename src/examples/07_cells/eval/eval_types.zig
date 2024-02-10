const std = @import("std");

const utils = @import("./eval_utils.zig");

pub const EvalError = error {
    invalid_expr, unimplemented_feature, div_zero_expr, cycric_identifier,unmatch_any_type, undefined_call,
};

pub const EvalProgress = union(enum) {
    empty: void,
    any: []const u8,
    int: i64,
    uint: u64,
    float: f64,
    string: []const u8,
    boolean: bool,
    identifier: []const u8,
    range: Range,

    pub fn asFloat(self: EvalProgress) !EvalProgress {
        const v: f64 = switch (self) {
            .empty => 0,
            .float => |v| v,
            .int => |v| @floatFromInt(v),
            .uint => |v| @floatFromInt(v),
            .any => |v| std.fmt.parseFloat(f64, v) catch return error.unmatch_any_type,
            else => unreachable,
        };

        return .{.float = v};
    }

    pub fn asInt(self: EvalProgress) !EvalProgress {
        const v: i64 = switch (self) {
            .empty => 0,
            .int => |v| v,
            .uint => |v| @intCast(v),
            .float => |v| @intFromFloat(v),
            .any => |v| std.fmt.parseInt(i64, v, 0) catch return error.unmatch_any_type,
            else => unreachable,
        };

        return .{.int = v};
    }

    pub fn isNumber(self: EvalProgress) bool {
        const candidates = std.enums.EnumSet(std.meta.FieldEnum(EvalProgress)).init(.{.int = true, .uint = true, .float = true, .any = true, .empty = true});
        return candidates.contains(std.meta.activeTag(self));
    }

    pub fn isString(self: EvalProgress) bool {
        const candidates = std.enums.EnumSet(std.meta.FieldEnum(EvalProgress)).init(.{.string = true, .any = true});
        return candidates.contains(std.meta.activeTag(self));
    }

    pub fn isBoolean(self: EvalProgress) bool {
        const candidates = std.enums.EnumSet(std.meta.FieldEnum(EvalProgress)).init(.{.boolean = true, .any = true});
        return candidates.contains(std.meta.activeTag(self));
    }

    pub fn isEmpty(self: EvalProgress) bool {
        return std.meta.activeTag(self) == .empty;
    }

    pub fn clone(self: EvalProgress, allocator: std.mem.Allocator) !EvalProgress {
        return switch (self) {
            .any => |v| .{.any = try allocator.dupe(u8, v)},
            .string => |v| .{.string = try allocator.dupe(u8, v)},
            .identifier => |v| .{.identifier = try allocator.dupe(u8, v)},
            else => self,
        };
    }

    pub fn asString(self: EvalProgress, allocator: std.mem.Allocator) ![:0]const u8 {
        return switch (self) {
            .empty => "",
            .int => |v| try std.fmt.allocPrintZ(allocator, "{}", .{v}),
            .uint => |v| try std.fmt.allocPrintZ(allocator, "{}", .{v}),
            .float => |v| try std.fmt.allocPrintZ(allocator, "{}", .{v}),
            .boolean => |v| try std.fmt.allocPrintZ(allocator, "{}", .{v}),
            .string, .identifier, .any => |v| try allocator.dupeZ(u8, v),
            .range => |cells| s: {
                const from_cell = try utils.nameFromAddress(allocator, cells.from.col, cells.from.row);
                defer allocator.free(from_cell);
                const to_cell = try utils.nameFromAddress(allocator, cells.to.col, cells.to.row);
                defer allocator.free(to_cell);

                break :s try std.fmt.allocPrintZ(allocator, "{s}:{s}", .{from_cell, to_cell});
            },
        };
    }

    pub const Range = struct {
        pub const Cell = struct {col: usize, row: usize};
        
        from: Cell,
        to: Cell,

        pub fn iterate(self: Range) Iterator {
            return .{
                .col = self.from.col,
                .row = self.from.row,
                .max_col = self.to.col,
                .min_row = self.from.row,
                .max_row = self.to.row,              
            };
        }

        pub const Iterator = struct {
            col: usize,
            row: usize,
            max_col: usize,
            min_row: usize,
            max_row: usize,

            pub fn next(self: *Iterator) ?Cell {
                if (self.row > self.max_row) {
                    self.row = self.min_row;
                    self.col += 1;
                }
                if (self.col > self.max_col) return null;
                
                defer self.row += 1;

                return .{.col = self.col, .row = self.row};
            }
        };
    };
};

pub const ParseResult = union(enum) {
    empty: void,
    text: struct { allocator: std.mem.Allocator, value: [:0]const u8 },
    ast: struct { allocator: std.mem.Allocator, tree: std.zig.Ast },

    pub fn deinit(self: *ParseResult) void {
        switch (self.*) {
            .empty => {},
            .text => |obj| obj.allocator.free(obj.value),
            .ast => |*obj| {
                obj.allocator.free(obj.tree.source);
                obj.tree.deinit(obj.allocator);
            },
        }
    }
};


pub fn CallRequest(comptime Context: type) type {
    return struct {
        pub const Callable = *const fn (context: *Context, allocator: std.mem.Allocator, args: []const EvalProgress, cyclics: *std.BufSet, cache: *std.StringHashMap(EvalProgress)) anyerror!EvalProgress;

        context: *Context,
        callable: Callable,

        pub fn invoke(self: @This(), allocator: std.mem.Allocator, args: []const EvalProgress, cyclics: *std.BufSet, cache: *std.StringHashMap(EvalProgress)) anyerror!EvalProgress {
            return self.callable(self.context, allocator, args, cyclics, cache);
        }
    };
}