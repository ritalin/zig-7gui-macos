const std = @import("std");
const DaySeconds = std.time.epoch.DaySeconds;

const time = @import("time"); //

const patterns = @import("./pattern.zig");

pub const FormattableTime = union(enum) {
    utc: FormattableTime.Utc,
    with_offset: FormattableTime.WithOffset,
    duration: std.time.Timer,

    pub fn format(self: FormattableTime, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        const timestamp_ms = switch (self) {
            .utc => |t| @as(u64, @intCast(t.timestamp_ms)),
            .with_offset => |t| @as(u64, @intCast(t.timestamp_ms)) + t.offset,
            .duration => |d| d.started.since(d.previous) / 1000_000,
        };

        try YearDayTime.fromMiliSecs(timestamp_ms).format(fmt, options, writer);
    }

    pub const Utc = struct { timestamp_ms: i64 };
    pub const WithOffset = struct { timestamp_ms: i64, offset: ZoneOffset };
};

const MonthNameLong = std.enums.EnumArray(std.time.epoch.Month, []const u8).init(.{
    .jan = "January",
    .feb = "February",
    .mar = "March",
    .apr = "April",
    .may = "May",
    .jun = "June",
    .jul = "July",
    .aug = "August",
    .sep = "September",
    .oct = "October",
    .nov = "November",
    .dec = "December",
});

pub const ZoneOffset = u64;

pub const helpers = struct {
    pub fn loadZoneInfo(allocator: std.mem.Allocator, zone_id: []const u8) !std.json.Parsed(std.Tz) {
        const path = try std.fs.path.join(allocator, &[_][]const u8{ "/usr/share/zoneinfo/", zone_id});
        defer allocator.free(path);

        var file = try std.fs.openFileAbsolute(path, .{});
        defer file.close();

        var arena = try allocator.create(std.heap.ArenaAllocator);
        arena.* = std.heap.ArenaAllocator.init(allocator);

        const tz = try std.Tz.parse(arena.allocator(), file.reader());

        return .{
            .arena = arena,
            .value = tz,
        };
    }

    pub fn getTransitionOffsetMili(tz: std.Tz) ZoneOffset {
        for (tz.timetypes) |timetype| {
            if (timetype.flags & 0x02 != 0) {
                return @as(u64, @intCast(timetype.offset)) * 1000;
            } 
        }

        return 0;
    }
};



pub const YearDayTime = struct {
    year_days: std.time.epoch.YearAndDay,
    mili_seconds: u64,

    fn fromMiliSecs(mili_seconds: u64) YearDayTime {
        const ms_in_day = @as(u32, @intCast(std.time.epoch.secs_per_day)) * 1000;
        const ms = @mod(mili_seconds, ms_in_day);
        var days = mili_seconds / ms_in_day;

        var year: std.time.epoch.Year = @intCast(std.time.epoch.epoch_year);

        while (true) {
            const days_in_year = std.time.epoch.getDaysInYear(year);
            if (days < days_in_year) break;

            days -= days_in_year;
            year += 1;
        }

        return .{
            .year_days = .{
                .year = year,
                .day = @intCast(days),
            },
            .mili_seconds = ms,
        };
    }

    pub inline fn msToDaySeconds(self: YearDayTime) DaySeconds {
        return .{ .secs = @as(u17, @intCast(self.mili_seconds / 1000)) };
    }

    pub fn format(self: YearDayTime, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        if (fmt.len == 0) {
            // treat as any
            try writer.print("yd = {any}, ms = {}", .{self.year_days, self.mili_seconds});
            return;
        }
        _ = options;

        const ydt = self;

        comptime var index_from = 0;
        comptime var index_to = 0;
        comptime var current_pat: ?patterns.FormatPattern = null;
        @setEvalBranchQuota(100000);

        inline for (0..fmt.len) |i| {
            index_to = i + 1;

                if (comptime patterns.findPattern(fmt[index_from..index_to])) |pat| {
                    current_pat = pat;
                    if (i < fmt.len - 1) continue; // fall-through if it's last char
                }

            defer index_from = index_to;

            if (current_pat) |pat| {
                defer current_pat = null;

                switch (pat) {
                    // year
                    .y, .Y, .u => try writer.print("{}", .{ ydt.year_days.year % 10 }),
                    .yy, .YY, .uu => try writer.print("{:0>2}", .{ @mod(ydt.year_days.year, 100) }),
                    .yyy, .YYY, .uuu => try writer.print("{:0>3}", .{ @mod(ydt.year_days.year, 1000) }),
                    .yyyy, .YYYY, .uuuu => try writer.print("{:0>4}", .{ ydt.year_days.year }),
                    // month
                    .M, .L => try writer.print("{}", .{ @intFromEnum(ydt.year_days.calculateMonthDay().month) }),
                    .MM, .LL => try writer.print("{:0>2}", .{ @intFromEnum(ydt.year_days.calculateMonthDay().month) }),
                    .MMM, .LLL => {
                        var m = @tagName(ydt.year_days.calculateMonthDay().month);
                        try writer.writeByte(std.ascii.toUpper(m[0]));
                        try writer.writeAll(m[1..]);
                    },
                    .MMMM, .LLLL => try writer.writeAll(MonthNameLong.get(ydt.year_days.calculateMonthDay().month)),
                    // day
                    .d => try writer.print("{}", .{ ydt.year_days.calculateMonthDay().day_index+1 }),
                    .dd => try writer.print("{:0>2}", .{ ydt.year_days.calculateMonthDay().day_index+1 }),
                    .D => try writer.print("{}", .{ ydt.year_days }),
                    .DD => try writer.print("{:0>2}", .{ ydt.year_days.day }),
                    .DDD => try writer.print("{:0>3}", .{ ydt.year_days .day}),
                    // hour
                    .h => try writer.print("{}",        .{ @mod(ydt.msToDaySeconds().getHoursIntoDay(), 12)+1 }),
                    .hh => try writer.print("{:0>2}",    .{ @mod(ydt.msToDaySeconds().getHoursIntoDay(), 12)+1 }),
                    .H => try writer.print("{}",        .{ ydt.msToDaySeconds().getHoursIntoDay() }),
                    .HH => try writer.print("{:0>2}",    .{ ydt.msToDaySeconds().getHoursIntoDay() }),
                    .K => try writer.print("{}",        .{ @mod(ydt.msToDaySeconds().getHoursIntoDay(), 12) }),
                    .KK => try writer.print("{:0>2}",    .{ @mod(ydt.msToDaySeconds().getHoursIntoDay(), 12) }),
                    .k => try writer.print("{}",        .{ ydt.msToDaySeconds().getHoursIntoDay()+1 }),
                    .kk => try writer.print("{:0>2}",    .{ ydt.msToDaySeconds().getHoursIntoDay()+1 }),
                    // minute
                    .m => try writer.print("{}",        .{ ydt.msToDaySeconds().getMinutesIntoHour() }),
                    .mm => try writer.print("{:0>2}",    .{ ydt.msToDaySeconds().getMinutesIntoHour() }),
                    // second
                    .s => try writer.print("{}",        .{ ydt.msToDaySeconds().getSecondsIntoMinute() }),
                    .ss => try writer.print("{:0>2}",    .{ ydt.msToDaySeconds().getSecondsIntoMinute() }),
                    // ms
                    .S => try writer.print("{}",        .{ @mod(ydt.mili_seconds, 1000) }),
                    .SS => try writer.print("{:0>2}",    .{ @mod(ydt.mili_seconds, 1000) / 10 }),
                    .SSS => try writer.print("{:0>3}",   .{ @mod(ydt.mili_seconds, 1000) }),
                    // other
                    else => return error.Unsupported,
                }

                index_from = @tagName(pat).len;
                // index_to = index_from + 1;
            }

            if (comptime patterns.findPattern(fmt[i..i+1]) == null) {
                try writer.writeByte(fmt[i]);

                index_from += 1;
                // index_to = index_from + 1;
            }
        }
    }
};
