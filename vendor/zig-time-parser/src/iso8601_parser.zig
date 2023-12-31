const std = @import("std");
const time_formatter = @import("time-formatter");

pub fn fromISO8601(date_string: []const u8) TimeParseError!time_formatter.FormattableTime.WithOffset {
    var split_result = splidDataString(date_string);

    var parsed_kind: DateSplitKindSet = .{};
    var yd = std.time.epoch.YearAndDay{
        .year = std.time.epoch.epoch_year,
        .day = 0,
    };

    if (split_result.get(.date_part)) |date_part| {
        const split_year_result = try splitYear(date_part);

        yd.year = split_year_result.years;
        parsed_kind.year_part = true;

        if (split_year_result.rest) |rest| {
            var split_month_result = try splitMonth(yd.year, rest);

            if (split_month_result.get(.days_in_year_aprt)) |days| {
                yd.day = @intCast(days);
                parsed_kind.days_in_year_aprt = true;
            }

            parsed_kind.month_part = split_month_result.contains(.month_part);
            parsed_kind.day_part = split_month_result.contains(.day_part);
        }
    }

    var time_ms: i64 = 0;

    if (split_result.get(.time_part)) |time_part| {
        if (!isTimeAcceptable(parsed_kind)) {
            return error.InvalidDateTime;
        }

        var split_time_result = try splitTime(time_part);

        if (split_time_result.get(.hour_part)) |hours| {
            time_ms += @as(i64, @intCast(hours)) * 60 * 60 * 1000;
        }
        if (split_time_result.get(.minute_part)) |minutes| {
            time_ms += @as(i64, @intCast(minutes)) * 60 * 1000;
        }
        if (split_time_result.get(.second_part)) |seconds| {
            time_ms += @as(i64, @intCast(seconds)) * 1000;
        }
        if (split_time_result.get(.milisec_part)) |ms| {
            time_ms += @as(i64, @intCast(ms));
        }
    }

    var offset_ms: u64 = 0;

    if (split_result.get(.tz_part)) |tz_part| {
        if (std.mem.indexOfAny(u8, tz_part, &[_]u8{ 'Z', 'z' })) |_| {
            // utc
            offset_ms = 0;
        } else {
            // Unsupported
            return error.UnsupportedTimezone;
        }
    }

    return time_formatter.FormattableTime.WithOffset{
        .timestamp_ms = (convertYearsToDays(yd.year) + yd.day) * std.time.epoch.secs_per_day * 1000 + time_ms,
        .offset = offset_ms,
    };
}

fn convertYearsToDays(year: std.time.epoch.Year) i64 {
    const year_from: std.time.epoch.Year = std.time.epoch.epoch_year;
    var result: i64 = 0;

    for (year_from .. year) |y| {
        result += @as(i64, @intCast(std.time.epoch.getDaysInYear(@intCast(y))));
    }

    return result;
}

fn convertMonthDayToDays(year: u16, month: u16, day: u16) u16 {
    var days: u16 = 0;

    for (1..month) |i| {
        days += std.time.epoch.getDaysInMonth(
            if (std.time.epoch.isLeapYear(year)) .leap else .not_leap,
            @enumFromInt(i)
        );
    }

    return days + day - 1;
}

fn isTimeAcceptable(kinds: DateSplitKindSet) bool {
    if (kinds.year_part and kinds.month_part and kinds.day_part) return true;
    if ((kinds.year_part == false) and (kinds.month_part == false) and (kinds.day_part == false)) return true;

    return false;
}

const DateSplitKind = enum {
    date_part,
    time_part,
    days_in_year_aprt,
    tz_part,
    year_part,
    month_part,
    day_part,
    hour_part,
    minute_part,
    second_part,
    milisec_part,
};
const DateSplitKindSet = std.enums.EnumFieldStruct(DateSplitKind, bool, false);
const DateSplitResult = std.enums.EnumMap(DateSplitKind, []const u8);
const DateParseResult = std.enums.EnumMap(DateSplitKind, u16);

const UnexpectedTimeError = error{
    Unexpected,
    UnsupportedTimezone,
};
const InvalidTimeError = error{
    InvalidYearPart,
    InvalidMonthPart,
    InvalidDayPart,
    InvalidHourPart,
    InvalidMinutePart,
    InvalidSecondPart,
    InvalidMiliSecondPart,
    InvalidMonthDay,
    InvalidBC,
    InvalidTime,
    InvalidDateTime,
};
const OutOfRangeTimeError = error{
    OutOfRangeYear,
    OutOfRangeMonth,
    OutOfRangeDay,
    OutOfRangeHour,
    OutOfRangeMinute,
    OutOfRangeSecond,
    OutOfRangeMiliSecond,
};

pub const TimeParseError = UnexpectedTimeError || InvalidTimeError || OutOfRangeTimeError;

fn splidDataString(date_string: []const u8) DateSplitResult {
    var result = DateSplitResult{};

    if (std.mem.indexOfScalar(u8, date_string, 'T')) |i| {
        // date & time
        result.put(.date_part, date_string[0..i]);

        var rest = date_string[i + 1 ..];

        if (std.mem.indexOfAny(u8, rest, &[_]u8{ 'Z', 'z', '+', '-' })) |z| {
            // with tz
            result.put(.time_part, rest[0..z]);
            result.put(.tz_part, rest[z..]);
        } 
        else {
            // without tz
            result.put(.time_part, rest);
        }
    } 
    else {
        if (std.mem.indexOfScalar(u8, date_string, ':')) |_| {
            // time only

            if (std.mem.indexOfAny(u8, date_string, &[_]u8{ 'Z', 'z', '+', '-' })) |z| {
                // with tz
                result.put(.time_part, date_string[0..z]);
                result.put(.tz_part, date_string[z..]);
            } 
            else {
                // without tz
                result.put(.time_part, date_string);
            }
        } 
        else {
            // date only
            if (std.mem.indexOfAny(u8, date_string, &[_]u8{ 'Z', 'z' })) |z| {
                // with tz
                result.put(.date_part, date_string[0..z]);
                result.put(.tz_part, date_string[z..]);
            } 
            else {
                // without tz
                result.put(.date_part, date_string);
            }
        }
    }

    return result;
}

fn splitYear(date_string: []const u8) !(struct { years: u16, rest: ?[]const u8 }) {
    var s = date_string;

    if (s[0] == '-') {
        // Unsupported BC century
        return error.InvalidBC;
    }
    if (s[0] == '+') {
        s = s[1..];
    }

    if (std.mem.indexOfScalar(u8, s, '-')) |y| {
        const years = std.fmt.parseInt(u16, s[0..y], 10) catch |err| switch (err) {
            error.InvalidCharacter => return error.InvalidYearPart,
            else => return error.Unexpected,
        };
        return .{ .years = years, .rest = s[y + 1 ..] };
    } 
    else {
        // year only
        const years = std.fmt.parseInt(u16, s, 10) catch |err| switch (err) {
            error.InvalidCharacter => return error.InvalidYearPart,
            else => return error.Unexpected,
        };
        return .{ .years = years, .rest = null };
    }
}

fn splitMonth(years: u16, date_string: []const u8) TimeParseError!DateParseResult {
    var result = DateParseResult{};

    if (std.mem.indexOfScalar(u8, date_string, '-')) |i| {
        // month and day
        const months = std.fmt.parseInt(u16, date_string[0..i], 10) catch |err| switch (err) {
            error.InvalidCharacter => return error.InvalidMonthPart,
            else => return error.Unexpected,
        };
        try validateDateTimeRange(.month_part, months);

        const days = std.fmt.parseInt(u16, date_string[i+1..], 10) catch |err| switch (err) {
            error.InvalidCharacter => return error.InvalidDayPart,
            else => return error.Unexpected,
        };
        try validateDateTimeRange(.day_part, days);

        const days_in_month = std.time.epoch.getDaysInMonth(
            if (std.time.epoch.isLeapYear(years)) .leap else .not_leap, 
            @enumFromInt(months)
        );
        if (days > days_in_month) {
            return error.OutOfRangeDay;
        }

        result.put(.month_part, months);
        result.put(.day_part, days);
        result.put(.days_in_year_aprt, convertMonthDayToDays(years, months, days));
    } 
    else {
        // month or day
        const part = std.fmt.parseInt(u16, date_string, 10) catch |err| switch (err) {
            error.InvalidCharacter => return error.InvalidMonthDay,
            else => return error.Unexpected,
        };
        
        if (date_string.len == 2) {
            try validateDateTimeRange(.month_part, part);
            result.put(.month_part, part);
            result.put(.days_in_year_aprt, convertMonthDayToDays(years, part, 1));
        }
        else if (date_string.len == 3) {
            result.put(.days_in_year_aprt, part-1);
        }
        else {
            return error.InvalidMonthDay;
        }
    }

    return result;
}

fn splitTime(time_string: []const u8) !DateParseResult {
    var result = DateParseResult{};

    var iter = std.mem.splitScalar(u8, time_string, ':');
    const hour_part = iter.next();
    const minute_part = iter.next();
    const second_part = iter.next();

    if ((hour_part == null) or (minute_part == null) or (second_part == null)) {
        return error.InvalidTime;
    }

    if (hour_part) |part| {
        const hours = std.fmt.parseInt(u16, part, 10) catch |err| switch (err) {
            error.InvalidCharacter => return error.InvalidHourPart,
            else => return error.Unexpected,
        };
        try validateDateTimeRange(.hour_part, hours);
        result.put(.hour_part, hours);
    }

    if (minute_part) |part| {
        const minutes = std.fmt.parseInt(u16, part, 10) catch |err| switch (err) {
            error.InvalidCharacter => return error.InvalidMinutePart,
            else => return error.Unexpected,
        };
        try validateDateTimeRange(.minute_part, minutes);
        result.put(.minute_part, minutes);
    }

    if (second_part) |part| {
        if (std.mem.indexOfScalar(u8, part, '.')) |i| {
            // sec + ms
            const seconds = std.fmt.parseInt(u16, part[0..i], 10) catch |err| switch (err) {
                error.InvalidCharacter => return error.InvalidSecondPart,
                else => return error.Unexpected,
            };
            try validateDateTimeRange(.second_part, seconds);
            result.put(.second_part, seconds);

            const ms = std.fmt.parseInt(u16, part[i+1..], 10) catch |err| switch (err) {
                error.InvalidCharacter => return error.InvalidMiliSecondPart,
                else => return error.Unexpected,
            };
            try validateDateTimeRange(.milisec_part, ms);
            result.put(.milisec_part, ms);
        }
        else {
            // sec only
            const seconds = std.fmt.parseInt(u16, part, 10) catch |err| switch (err) {
                error.InvalidCharacter => return error.InvalidSecondPart,
                else => return error.Unexpected,
            };
            try validateDateTimeRange(.second_part, seconds);
            result.put(.second_part, seconds);
        }
    }

    return result;
}

fn validateDateTimeRange(kind: DateSplitKind, value: u16) !void {
    return switch (kind) {
        .year_part => if ((value >= 0) and (value <= ~(@as(u16, 0)))) return else error.OutOfRangeYear,
        .month_part => if ((value >= 1) and (value <= 12)) return else error.OutOfRangeMonth,
        .day_part => if ((value >= 1) and (value <= 31)) return else error.OutOfRangeDay,
        .hour_part => if ((value >= 0) and (value <= 23)) return else error.OutOfRangeHour,
        .minute_part => if ((value >= 0) and (value <= 59)) return else error.OutOfRangeMinute,
        .second_part => if ((value >= 0) and (value <= 60)) return else error.OutOfRangeSecond,
        .milisec_part => if ((value >= 0) and (value <= 999)) return else error.OutOfRangeMiliSecond,
        else => error.Unexpected,
    };
}

pub fn testingTimestampMili(date_patt: struct {
        years: u16 = 1970, months: u16 = 0, days: u16 = 0,
        hours: u16 = 0, minutes: u16 = 0, seconds: u16 = 0, ms: u16 = 0,
    }) time_formatter.FormattableTime.WithOffset 
{
    const days_1 = convertYearsToDays(date_patt.years);
    const days_2 = convertMonthDayToDays(date_patt.years, date_patt.months+1, date_patt.days+1);

    return .{
        .timestamp_ms = (
            (days_1 + days_2) * std.time.epoch.secs_per_day * 1000
            + @as(i64, @intCast(date_patt.hours)) * 60 * 60 * 1000
            + @as(i64, @intCast(date_patt.minutes)) * 60 * 1000
            + @as(i64, @intCast(date_patt.seconds)) * 1000
            + @as(i64, @intCast(date_patt.ms))
        ),
        .offset = 0,
    };
}

test "date only" {
    const x = try fromISO8601("2023-11-23");
    try std.testing.expectEqual(x, testingTimestampMili(.{
        .years = 2023, .months = 10, .days = 22,
        .hours = 0, .minutes = 0, .seconds = 0, .ms = 0,
    }));
}

test "out of range month" {
    if (fromISO8601("2023-13-01")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeMonth == err);
}

test "out of range day in month" {
    if (fromISO8601("2023-01-32")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);

    if (fromISO8601("2023-02-29")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);
    if (fromISO8601("2024-02-30")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);

    if (fromISO8601("2023-03-32")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);

    if (fromISO8601("2023-04-31")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);

    if (fromISO8601("2023-05-32")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);

    if (fromISO8601("2023-06-31")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);

    if (fromISO8601("2023-07-32")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);

    if (fromISO8601("2023-08-32")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);

    if (fromISO8601("2023-09-31")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);

    if (fromISO8601("2023-10-32")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);

    if (fromISO8601("2023-11-31")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);

    if (fromISO8601("2023-12-32")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeDay == err);
}

test "date only with UTC timezone" {
    const x = try fromISO8601("2023-09-01Z");
    try std.testing.expectEqual(x, testingTimestampMili(.{
        .years = 2023, .months = 8, .days = 0,
        .hours = 0, .minutes = 0, .seconds = 0, .ms = 0,
    }));
}

test "year months" {
    const x = try fromISO8601("2023-11");
    try std.testing.expectEqual(x, testingTimestampMili(.{
        .years = 2023, .months = 10, .days = 0,
        .hours = 0, .minutes = 0, .seconds = 0, .ms = 0,
    }));
}

test "year days" {
    const x = try fromISO8601("2023-100");
    try std.testing.expectEqual(x, testingTimestampMili(.{
        .years = 2023, .months = 3, .days = 9,
        .hours = 0, .minutes = 0, .seconds = 0, .ms = 0,
    }));
}

test "invalid year months/days" {
    if (fromISO8601("2023-abc")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidMonthDay == err);
}

test "year days (leap year)" {
    const x = try fromISO8601("2024-100");
    try std.testing.expectEqual(x, testingTimestampMili(.{
        .years = 2024, .months = 3, .days = 8,
        .hours = 0, .minutes = 0, .seconds = 0, .ms = 0,
    }));
}

test "year only" {
    const x = try fromISO8601("2020");
    try std.testing.expectEqual(x, testingTimestampMili(.{
        .years = 2020, .months = 0, .days = 0,
        .hours = 0, .minutes = 0, .seconds = 0, .ms = 0,
    }));
}

test "invalid year" {
    if (fromISO8601("qwerty")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidYearPart == err);
}

test "time only" {
    const x = try fromISO8601("12:34:56");
    try std.testing.expectEqual(x, testingTimestampMili(.{
        .years = 1970, .months = 0, .days = 0,
        .hours = 12, .minutes = 34, .seconds = 56, .ms = 0,
    }));
}

test "time with milisec" {
    const x = try fromISO8601("12:34:56.999");
    try std.testing.expectEqual(x, testingTimestampMili(.{
        .years = 1970, .months = 0, .days = 0,
        .hours = 12, .minutes = 34, .seconds = 56, .ms = 999,
    }));
}

test "time with UTC timezone" {
    const x = try fromISO8601("12:34:56Z");
    try std.testing.expectEqual(x, testingTimestampMili(.{
        .years = 1970, .months = 0, .days = 0,
        .hours = 12, .minutes = 34, .seconds = 56, .ms = 0,
    }));
}

test "time with Asia/Tokyo timezone" {
    if (fromISO8601("12:34:56+0900")) |_| unreachable
    else |err| try std.testing.expect(error.UnsupportedTimezone == err);
}

test "hout + minute only" {
    if (fromISO8601("11:22")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidTime == err);

    if (fromISO8601("11:22Z")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidTime == err);
}

test "invalid hours" {
    if (fromISO8601("aa:34:56")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidHourPart == err);
}

test "out of range hours" {
    if (fromISO8601("25:34:56")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeHour == err);
}

test "invalid minutes" {
    if (fromISO8601("12:bb:56")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidMinutePart == err);
}

test "out of range minutes" {
    if (fromISO8601("12:61:56")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeMinute == err);
}

test "invalid seconds" {
    if (fromISO8601("12:34:cc")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidSecondPart == err);
}

test "out of range seconds" {
    if (fromISO8601("12:59:61")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeSecond == err);
}

test "invalid miliseconds" {
    if (fromISO8601("12:34:56.xyz")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidMiliSecondPart == err);
}

test "out of range miliseconds" {
    if (fromISO8601("12:59:59.1000")) |_| unreachable
    else |err| try std.testing.expect(error.OutOfRangeMiliSecond == err);
}

test "timestamp" {
    const x = try fromISO8601("2023-11-23T01:23:45");
    try std.testing.expectEqual(x, testingTimestampMili(.{
        .years = 2023, .months = 10, .days = 22,
        .hours = 1, .minutes = 23, .seconds = 45, .ms = 0,
    }));
}

test "timestamp with UTC timezone" {
    const x = try fromISO8601("2023-11-30T00:11:22Z");
    try std.testing.expectEqual(x, testingTimestampMili(.{
        .years = 2023, .months = 10, .days = 29,
        .hours = 0, .minutes = 11, .seconds = 22, .ms = 0,
    }));
}

test "timestamp with Asia/Tokyo timezone" {
    if (fromISO8601("2023-11-30T00:11:22+0900")) |_| unreachable
    else |err| try std.testing.expect(error.UnsupportedTimezone == err);
}

test "year + time" {
    if (fromISO8601("2021T00:11:22")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidDateTime == err);
    
    if (fromISO8601("2021T00:11:22Z")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidDateTime == err);
}
test "year + month + time" {
    if (fromISO8601("2021-08T00:11:22")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidDateTime == err);

    if (fromISO8601("2021-08T00:11:22Z")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidDateTime == err);
}

test "invalid timestamp" {
    if (fromISO8601("2021-08T")) |_| unreachable
    else |err| try std.testing.expect(error.InvalidDateTime == err);
}