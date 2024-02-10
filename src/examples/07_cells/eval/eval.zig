const std = @import("std");

const eval_types = @import("./eval_types.zig");
const EvalResult = eval_types.EvalResult;
const ParseResult = eval_types.ParseResult;
const EvalProgress = eval_types.EvalProgress;

const eval_values = @import("./eval_values.zig");
const ops = @import("./ops.zig");

pub fn Evaluator(comptime StateContext: type) type {
    return struct {
        allocator: std.mem.Allocator, 
        context: *StateContext,
        cyclics: *std.BufSet,
        eval_cache: *std.StringHashMap(EvalProgress),

        const Self = @This();

        pub fn init(allocator: std.mem.Allocator, context: *StateContext, cyclics: *std.BufSet, cache: *std.StringHashMap(EvalProgress)) Self {
            return .{
                .allocator = allocator,
                .context = context,
                .cyclics = cyclics,
                .eval_cache = cache,
            };
        }

        const dumpAst = @import("./ast_dump.zig").dump;

        pub fn evaluate(self: *Self, source: ParseResult) !EvalProgress {
            return switch (source) {
                .empty => .empty,
                .text => |p| .{ .any = p.value },
                .ast => |p| try self.evaluateInternal(p.tree),
            };
        }

        fn evaluateInternal(self: *Self, ast: std.zig.Ast) anyerror!EvalProgress {
            if (ast.errors.len > 0) {
                return error.invalid_expr;
            }

            dumpAst(ast);

            const datas = ast.nodes.items(.data);
            
            return self.evalExpression(ast, datas[0].lhs, .{});
        }

        const EvalOptions = std.enums.EnumFieldStruct(enum {skip_resolve_ref}, bool, false);

        fn evalExpression(self: *Self, ast: std.zig.Ast, index: std.zig.Ast.TokenIndex, eval_opt: EvalOptions) anyerror!EvalProgress {
            const tags = ast.nodes.items(.tag);
            const tokens = ast.nodes.items(.main_token);
            const datas = ast.nodes.items(.data);

            const tag = tags[index];
            switch (tag) {
                .add, .sub, .mul, .div, .mod, .bool_and, .bool_or => {
                    return self.evalBinaryOperator(ast, tag, index);
                },
                .negation => {
                    return self.evalUnaryOperator(ast, tag, index);
                },
                .less_than, .greater_than, 
                .less_or_equal, .greater_or_equal, 
                .equal_equal, .bang_equal => {
                    return self.evalLogicalOperator(ast, tag, index);
                },
                .grouped_expression => {
                    return self.evalExpression(ast, datas[index].lhs, .{});
                },
                .call, .call_one => {
                    return self.evalCall(ast, index);
                },
                .number_literal => return eval_values.ofScalar(self.allocator, ast, tokens[index]),
                .string_literal => return eval_values.ofString(self.allocator, ast, tokens[index]),
                .identifier => {
                    const identifier = try eval_values.ofIdentifier(self.allocator, ast, tokens[index]);
                    if (eval_opt.skip_resolve_ref) {
                        return identifier;
                    }
                    else {
                        return self.resolveReference(identifier);
                    }
                },
                else => return error.invalid_expr,
            }
        }

        fn resolveReference(self: *Self, progress: EvalProgress) anyerror!EvalProgress {
            if (std.meta.activeTag(progress) != .identifier) {
                return progress;
            }

            const cell_name = try std.ascii.allocUpperString(self.allocator, progress.identifier);
            defer self.allocator.free(cell_name);
            
            if (self.eval_cache.get(cell_name)) |cache| {
                return cache;
            }
            if (self.cyclics.contains(cell_name)) {
                return error.cycric_identifier;
            }

            var cyclics = try self.cyclics.cloneWithAllocator(self.allocator);
            defer cyclics.deinit();

            const eval_result = try self.context.resolveReference(cell_name, &cyclics, self.eval_cache);
            try self.eval_cache.put(try self.eval_cache.allocator.dupe(u8, cell_name), eval_result);

            return eval_result;
        }

        fn evalBinaryOperator(self: *Self, ast: std.zig.Ast, op: std.zig.Ast.Node.Tag, index: std.zig.Ast.TokenIndex) anyerror!EvalProgress {
            const datas = ast.nodes.items(.data);

            const d = datas[index];
            const lhs = try self.evalExpression(ast, d.lhs, .{});
            const rhs = try self.evalExpression(ast, d.rhs, .{});

            fall_through: {
                if (lhs.isNumber() and rhs.isNumber()) {
                    return ops.evalBinaryMathOperator(op, lhs, rhs) catch |err| switch (err) {
                        error.unmatch_any_type => break :fall_through,
                        else => return err,
                    };
                }
            }

            fall_through: {
                if (lhs.isBoolean() and rhs.isBoolean()) {
                    return ops.evalBinaryBoolOperator(op, lhs, rhs) catch |err| switch (err) {
                        error.unmatch_any_type => break :fall_through,
                        else => return err,
                    };
                }
            }

            if (lhs.isString()) {
                return ops.evalBinaryStringOperator(self.allocator, op, lhs, rhs);
            }
            
            return error.invalid_expr;
        }

        fn evalUnaryOperator(self: *Self, ast: std.zig.Ast, op: std.zig.Ast.Node.Tag, index: std.zig.Ast.TokenIndex) !EvalProgress {
            const datas = ast.nodes.items(.data);

            const d = datas[index];
            const lhs = try self.evalExpression( ast, d.lhs, .{});

            switch (op) {
                .negation => return ops.evalNegation(lhs),
                else => return error.invalid_expr,
            }
        }

        fn evalLogicalOperator(self: *Self, ast: std.zig.Ast, op: std.zig.Ast.Node.Tag, index: std.zig.Ast.TokenIndex) anyerror!EvalProgress {
            const datas = ast.nodes.items(.data);

            const d = datas[index];
            const lhs = try self.evalExpression( ast, d.lhs, .{});
            const rhs = try self.evalExpression( ast, d.rhs, .{});

            fall_through: {
                if (lhs.isNumber() and rhs.isNumber()) {
                    return ops.evalLogicalOperatorAsScalar(op, lhs, rhs) catch |err| switch (err) {
                        error.unmatch_any_type => break :fall_through,
                        else => return err,
                    };
                }
            }

            if (lhs.isBoolean() and rhs.isBoolean()) {
                return ops.evalLogicalOperatorAsBool(op, lhs.boolean, rhs.boolean);
            }

            return error.invalid_expr;
        }

        fn evalCall(self: *Self, ast: std.zig.Ast, index: std.zig.Ast.TokenIndex) anyerror!EvalProgress {
            var buf: [1]std.zig.Ast.Node.Index = undefined;
            const call_ast = ast.fullCall(&buf, index).?;

            const tokens = ast.nodes.items(.main_token);

            const call_name = try std.ascii.allocLowerString(self.allocator, ast.tokenSlice(tokens[call_ast.ast.fn_expr]));
            defer self.allocator.free(call_name);
            const req = try self.context.resolveCall(call_name);

            var args = std.ArrayList(EvalProgress).init(self.allocator);
            defer args.deinit();

            for (call_ast.ast.params) |i| {
                try args.append(try self.evalExpression(ast, i, .{.skip_resolve_ref = true}));
            }

            return try req.invoke(self.allocator, try args.toOwnedSlice(), self.cyclics, self.eval_cache);
        }

        pub fn references(self: *Self) !std.BufSet {
            var result = std.BufSet.init(self.allocator);

            var key_iter = self.eval_cache.keyIterator();

            while (key_iter.next()) |id| {
                try result.insert(id.*);
            }

            return result;
         }
    };
}