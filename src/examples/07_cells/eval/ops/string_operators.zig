const std = @import("std");

const eval_types = @import("../eval_types.zig");
const EvalProgress = eval_types.EvalProgress;

const eval_values = @import("../eval_values.zig");

pub fn evalBinaryStringOperator(allocator: std.mem.Allocator, op: std.zig.Ast.Node.Tag, lhs: EvalProgress, rhs: EvalProgress) anyerror!EvalProgress {
    if (std.meta.activeTag(lhs) == .any) {
        return evalBinaryStringOperator(allocator, op, .{.string = lhs.any}, rhs);
    }

    const v = s: {
        switch (rhs) {
            .empty => {
                switch (op) {
                    .add => return lhs,
                    .mul => return .empty,
                    else => return error.invalid_expr,
                }
            },
            .any => |s| {
                switch (op) {
                    .add => break :s try evalConcatString(allocator, lhs.string, s),
                    .mul => {
                        const rvalue = try eval_values.parseScalar(s);
                        return evalBinaryStringOperator(allocator, op, lhs, rvalue);
                    },
                    else => return error.invalid_expr,
                }
            },
            .string => |s| {
                switch (op) {
                    .add => break :s try evalConcatString(allocator, lhs.string, s),
                    else => return error.invalid_expr,
                }
            },
            .uint => |n| {
                switch (op) {
                    .mul => break :s try evalRepeatString(allocator, lhs.string, n),
                    else => return error.invalid_expr,
                }
            },
            .int => |n| {
                switch (op) {
                    .mul => {
                        if (n < 0) {
                            return error.invalid_expr;
                        }
                        else {
                            break :s try evalRepeatString(allocator, lhs.string, @as(u64, @intCast(n)));
                        }
                    },
                    else => return error.invalid_expr,
                }
            },
            else => return error.invalid_expr,
        }
    };

    return .{.string = v};
}

fn evalConcatString(allocator: std.mem.Allocator, lhs: []const u8, rhs: []const u8) ![]const u8 {
    return std.mem.concat(allocator, u8, &[_][]const u8{lhs, rhs});
}

fn evalRepeatString(allocator: std.mem.Allocator, lhs: []const u8, n: u64) ![]const u8 {
    var buf = std.ArrayList(u8).init(allocator);
    defer buf.deinit();

    try buf.writer().writeBytesNTimes(lhs, n); 
    return buf.toOwnedSlice();
}