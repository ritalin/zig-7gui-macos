const std = @import("std");
const eval_types = @import("./eval_types.zig");

const EvalProgress = eval_types.EvalProgress;

pub fn ofString(allocator: std.mem.Allocator, ast: std.zig.Ast, index: std.zig.Ast.TokenIndex) !EvalProgress {
    const token = ast.tokenSlice(index);

    return .{.string = try std.zig.string_literal.parseAlloc(allocator, token) };
}

pub fn parseScalar(token: []const u8) anyerror!EvalProgress {
    const text = std.mem.trim(u8, token, " \t");
    if (std.fmt.parseInt(u64, text, 0)) |v| {
        return .{.uint = v};
    }
    else |_| {}

    if (std.fmt.parseInt(i64, text, 0)) |v| {
        return .{.int = v};
    }
    else |_| {}

    return .{.float = (std.fmt.parseFloat(f64, text)) catch return error.invalid_expr };
}

pub fn ofScalar(allocator: std.mem.Allocator, ast: std.zig.Ast, index: std.zig.Ast.TokenIndex) !EvalProgress {
    _ = allocator;
    
    return parseScalar(ast.tokenSlice(index));
}

const bool_values = std.ComptimeStringMap(bool, .{
    .{"false", false},
    .{"true", true},
});

pub fn ofIdentifier(allocator: std.mem.Allocator, ast: std.zig.Ast, index: std.zig.Ast.TokenIndex) !EvalProgress {
    const token = ast.tokenSlice(index);

    if (bool_values.get(token)) |v| {
        return .{.boolean = v};
    }
    
    return .{.identifier = try allocator.dupe(u8, token)};
}