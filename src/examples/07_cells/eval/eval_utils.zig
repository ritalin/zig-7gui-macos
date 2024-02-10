const std = @import("std");

pub fn nameFromAddress(allocator: std.mem.Allocator, col: usize, row: usize) ![]const u8 {
    return std.fmt.allocPrint(allocator, "{c}{}", .{ 'A' + @as(u8, @intCast(col)), row+1 });
}

pub fn nameToAddress(cell_name: []const u8, max_row_count: usize) !(struct {col: usize, row: usize}) {
    std.debug.assert(cell_name.len >= 1);

    const col = std.ascii.toUpper(cell_name[0]) - 'A';

    const row = r: {
        if (cell_name.len > 1) {
            break :r try std.fmt.parseInt(usize, cell_name[1..], 10);
        }
        else {
            break :r max_row_count;
        }
    };
    
    return .{.col = col, .row = row-1};
}
