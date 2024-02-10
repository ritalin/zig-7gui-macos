const std = @import("std");

const eval_types = @import("../eval_types.zig");
const EvalProgress = eval_types.EvalProgress;

const eval_values = @import("../eval_values.zig");

pub fn evalBinaryBoolOperator(op: std.zig.Ast.Node.Tag, lhs: EvalProgress, rhs: EvalProgress) anyerror!EvalProgress {
    const v = switch (op) {
        .bool_and => lhs.boolean and rhs.boolean,
        .bool_or => lhs.boolean or rhs.boolean,
        else => return error.invalir_expr,
    };

    return .{.boolean = v};
}

pub fn evalLogicalOperatorAsScalar(op: std.zig.Ast.Node.Tag, lhs: EvalProgress, rhs: EvalProgress) anyerror!EvalProgress {
    const tag_l = std.meta.activeTag(lhs);
    const tag_r = std.meta.activeTag(rhs);
    
    if (tag_l != tag_r) {
        if (tag_l == .float) {
            return try evalLogicalOperatorAsScalar(op, lhs, try rhs.asFloat());
        }
        else if (tag_l == .int) {
            return evalLogicalOperatorAsScalar(op, lhs, try rhs.asInt());
        }
        else if (tag_r == .int) {
            return evalLogicalOperatorAsScalar(op, try lhs.asInt(), rhs);
        }
    }
    else {
        if (tag_l == .float) {
            return evalLogicalOperatorAsScalarInternal(f64, op, lhs.float, rhs.float);
        }
        else if (tag_l == .int) {
            return evalLogicalOperatorAsScalarInternal(i64, op, lhs.int, rhs.int);
        }
        else if (tag_l == .uint) {
            return evalLogicalOperatorAsScalarInternal(u64, op, lhs.uint, rhs.uint);
        }
        else if (tag_l == .any) {
            if (eval_values.parseScalar(lhs.any)) |v| {
                return evalLogicalOperatorAsScalar(op, v, rhs);
            }
            else |_| {
                return error.unmatch_any_type;
            }
        }
    }

    return error.invalid_expr;
}

fn evalLogicalOperatorAsScalarInternal(comptime SymType: type, op: std.zig.Ast.Node.Tag, lhs: SymType, rhs: SymType) anyerror!EvalProgress {
    const v = switch (op) {
        .greater_than => lhs > rhs,
        .greater_or_equal => lhs >= rhs,
        .less_than => lhs < rhs,
        .less_or_equal => lhs <= rhs,
        .equal_equal => lhs == rhs,
        .bang_equal => lhs != rhs,
        else => return error.invalid_expr,
    };

    return .{.boolean = v};
}

pub fn evalLogicalOperatorAsBool(op: std.zig.Ast.Node.Tag, lhs: bool, rhs: bool) anyerror!EvalProgress {
    const v = switch (op) {
        .equal_equal => lhs == rhs,
        .bang_equal => lhs != rhs,
        else => return error.invalid_expr,
    };

    return .{.boolean = v};
}
