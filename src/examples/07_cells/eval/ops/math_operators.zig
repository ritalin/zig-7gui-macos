const std = @import("std");

const eval_types = @import("../eval_types.zig");
const EvalProgress = eval_types.EvalProgress;

const eval_values = @import("../eval_values.zig");

pub fn evalBinaryMathOperator(op: std.zig.Ast.Node.Tag, lhs: EvalProgress, rhs: EvalProgress) anyerror!EvalProgress {
    const type_tag_l = std.meta.activeTag(lhs);
    const type_tag_r = std.meta.activeTag(rhs);
    
    if (type_tag_l != type_tag_r) {
        if (type_tag_l == .float) {
            return evalBinaryMathOperator(op, lhs, try rhs.asFloat());
        }
        else if (type_tag_r == .float) {
            return evalBinaryMathOperator(op, try rhs.asFloat(), rhs);
        }
        else if (type_tag_l == .int) {
            return evalBinaryMathOperator(op, lhs, try rhs.asInt());
        }
        else if (type_tag_r == .int) {
            return evalBinaryMathOperator(op, try lhs.asInt(), rhs);
        }
        else if (type_tag_l == .any) {
            const lvalue = try eval_values.parseScalar(lhs.any);
            return evalBinaryMathOperator(op, lvalue, rhs);
        }
        else if (type_tag_r == .any) {
            const rvalue = try eval_values.parseScalar(rhs.any);
            return evalBinaryMathOperator(op, lhs, rvalue);
        }
        if (type_tag_l == .empty) {
            return evalBinaryMathOperator(op, .{.uint = 0}, rhs);
        }
        if (type_tag_r == .empty) {
            return evalBinaryMathOperator(op, lhs, .{.uint = 0});
        }
    }
    else {
        if (type_tag_l == .float) {
            return evalBinaryMathOperatorAsFloat(op, lhs.float, rhs.float);
        }
        else if (type_tag_l == .int) {
            return evalBinaryMathOperatorAsInt(op, lhs.int, rhs.int);
        }
        else if (type_tag_l == .uint) {
            return evalBinaryMathOperatorAsUInt(op, lhs.uint, rhs.uint);
        }
        else if (type_tag_l == .any) {
            const lvalue = try eval_values.parseScalar(lhs.any);
            return evalBinaryMathOperator(op, lvalue, rhs);
        }
        else if (type_tag_l == .empty) {
            return .empty;
        }
    }

    return error.invalid_expr;
}

fn evalBinaryMathOperatorAsFloat(op: std.zig.Ast.Node.Tag, lhs: f64, rhs: f64) !EvalProgress {
    const v = switch (op) {
        .add => lhs + rhs,
        .sub => lhs - rhs,
        .mul => lhs * rhs,
        .div => if (rhs == 0) return error.div_zero_expr else lhs / rhs,
        else => return error.invalid_expr,
    };

    return .{.float = v};
}

fn evalBinaryMathOperatorAsInt(op: std.zig.Ast.Node.Tag, lhs: i64, rhs: i64) !EvalProgress {
    const v = switch (op) {
        .add => @as(i64, lhs) + @as(i64, @intCast(rhs)),
        .sub => lhs - rhs,
        .mul => lhs * rhs,
        .div => std.math.divExact(i64, lhs, rhs) catch {
            return error.div_zero_expr;
        },
        .mod => std.math.mod(i64, lhs, rhs) catch {
            return error.div_zero_expr;
        },
        else => return error.invalid_expr,
    };

    return .{.int = v};
}

fn evalBinaryMathOperatorAsUInt(op: std.zig.Ast.Node.Tag, lhs: u64, rhs: u64) !EvalProgress {
    const v = switch (op) {
        .add => lhs + rhs,
        .sub => sub: {
            if (lhs < rhs) {
                return evalBinaryMathOperator(.add, .{.int = @intCast(lhs)}, .{.int = -@as(i64, @intCast(rhs))},);
            }
            else {
                break :sub lhs - rhs;
            }
        },  
        .mul => lhs * rhs,
        .div => std.math.divExact(u64, lhs, rhs) catch |err| switch (err) {
            error.DivisionByZero => return error.div_zero_expr,
            error.UnexpectedRemainder => return evalBinaryMathOperator(op, .{.float = @floatFromInt(lhs)}, .{.float = @floatFromInt(rhs)}),
        },
        .mod => std.math.mod(u64, lhs, rhs) catch {
            return error.div_zero_expr;
        },
        else => return error.invalid_expr,
    };

    return .{.uint = v};
}

pub fn evalNegation(value: EvalProgress) !EvalProgress {
    switch (value) {
        .float => |v| return .{ .float = -v },
        .int => |v| return .{ .int = -v },
        .uint => |v| return .{ .int = -@as(i64, @intCast(v)) },
        .any => |v| return evalNegation(try eval_values.parseScalar(v)),
        else => return error.invalid_expt,
    }
}