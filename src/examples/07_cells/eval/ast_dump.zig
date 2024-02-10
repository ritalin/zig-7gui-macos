const std = @import("std");

pub fn dump(ast: std.zig.Ast) void {
    const datas = ast.nodes.items(.data);
    const token_tags = ast.tokens.items(.tag);
    const starts = ast.tokens.items(.start);

    std.debug.print("\nprint token info (tags, starts)\n", .{});
    for (token_tags, starts, 0..) |tag, start, i| {
        std.debug.print("    [{:>2}] tag: {}, start: {}\n", .{i, tag, start});
    }

    const node_tags = ast.nodes.items(.tag);
    const tokens = ast.nodes.items(.main_token);

    std.debug.print("\nprint node info (tokens, datas)\n", .{});
    for (node_tags, tokens, datas, 0..) |tag, tk, dd, i| {
        std.debug.print("    [{:>2}] tk: {}, d: {}, tag: {}\n", .{i, tk, dd, tag});
    }

    const extras = ast.extra_data;

    std.debug.print("\nprint extra info\n", .{});
    for (extras, 0..) |extra, i| {
        std.debug.print("    [{:>2}] {}\n", .{i, extra});
    }
}