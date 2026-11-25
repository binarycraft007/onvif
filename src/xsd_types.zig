const std = @import("std");

pub const DateTime = struct {
    year: i32 = 1970,
    month: u8 = 1,
    day: u8 = 1,
    hour: u8 = 0,
    minute: u8 = 0,
    second: u8 = 0,
    nanoseconds: u32 = 0,
    offset_minutes: ?i16 = null, // null or 0 for UTC / Z

    pub fn format(self: DateTime, w: *std.Io.Writer) !void {
        if (self.year < 0) {
            try w.print("-{d:0>4}", .{@abs(self.year)});
        } else {
            try w.print("{d:0>4}", .{@abs(self.year)});
        }
        if (self.nanoseconds == 0) {
            try w.print("-{d:0>2}-{d:0>2}T{d:0>2}:{d:0>2}:{d:0>2}", .{
                self.month, self.day, self.hour, self.minute, self.second,
            });
        } else {
            const clamped_ns = @min(self.nanoseconds, 999_999_999);
            const ms = @divTrunc(clamped_ns, 1_000_000);
            try w.print("-{d:0>2}-{d:0>2}T{d:0>2}:{d:0>2}:{d:0>2}.{d:0>3}", .{
                self.month, self.day, self.hour, self.minute, self.second, ms,
            });
        }

        if (self.offset_minutes) |off| {
            if (off == 0) {
                try w.writeByte('Z');
            } else {
                const sign: u8 = if (off < 0) '-' else '+';
                const abs_off: u16 = @abs(off);
                const off_h = abs_off / 60;
                const off_m = abs_off % 60;
                try w.print("{c}{d:0>2}:{d:0>2}", .{ sign, off_h, off_m });
            }
        } else {
            try w.writeByte('Z');
        }
    }

    pub fn formatAlloc(self: DateTime, gpa: std.mem.Allocator) ![]u8 {
        var out: std.Io.Writer.Allocating = .init(gpa);
        defer out.deinit();
        try self.format(&out.writer);
        return try out.toOwnedSlice();
    }

    pub fn parse(s: []const u8) !DateTime {
        const trimmed = std.mem.trim(u8, s, " \t\r\n");
        var idx: usize = 0;

        if (idx < trimmed.len and trimmed[idx] == '-') {
            idx += 1;
        }
        const year_start = idx;
        while (idx < trimmed.len and std.ascii.isDigit(trimmed[idx])) : (idx += 1) {}
        if (idx - year_start < 4) return error.InvalidDateTime;
        const year = std.fmt.parseInt(i32, trimmed[0..idx], 10) catch return error.InvalidDateTime;

        // Expect "-MM-DDTHH:MM:SS" (15 bytes remaining minimum)
        if (idx + 15 > trimmed.len) return error.InvalidDateTime;
        if (trimmed[idx] != '-' or
            trimmed[idx + 3] != '-' or
            (trimmed[idx + 6] != 'T' and trimmed[idx + 6] != 't') or
            trimmed[idx + 9] != ':' or
            trimmed[idx + 12] != ':')
        {
            return error.InvalidDateTime;
        }

        const month = try parseTwoDigits(trimmed[idx + 1 .. idx + 3]);
        const day = try parseTwoDigits(trimmed[idx + 4 .. idx + 6]);
        const hour = try parseTwoDigits(trimmed[idx + 7 .. idx + 9]);
        const minute = try parseTwoDigits(trimmed[idx + 10 .. idx + 12]);
        const second = try parseTwoDigits(trimmed[idx + 13 .. idx + 15]);
        idx += 15;

        if (month < 1 or month > 12) return error.InvalidDateTime;
        if (day < 1 or day > daysInMonth(year, month)) return error.InvalidDateTime;
        if (hour > 23 or minute > 59 or second > 59) return error.InvalidDateTime;

        var nanoseconds: u32 = 0;
        if (idx < trimmed.len and trimmed[idx] == '.') {
            idx += 1;
            const frac_start = idx;
            while (idx < trimmed.len and std.ascii.isDigit(trimmed[idx])) : (idx += 1) {}
            const frac_str = trimmed[frac_start..idx];
            if (frac_str.len == 0) return error.InvalidDateTime;

            var val: u64 = 0;
            var scale: u64 = 1_000_000_000;
            for (frac_str) |c| {
                scale /= 10;
                val += (c - '0') * scale;
                if (scale == 1) break;
            }
            nanoseconds = @intCast(val);
        }

        var offset_minutes: ?i16 = null;
        if (idx < trimmed.len) {
            if (trimmed[idx] == 'Z' or trimmed[idx] == 'z') {
                offset_minutes = 0;
                idx += 1;
            } else if (trimmed[idx] == '+' or trimmed[idx] == '-') {
                const sign: i16 = if (trimmed[idx] == '-') -1 else 1;
                idx += 1;
                if (idx + 5 > trimmed.len or trimmed[idx + 2] != ':') return error.InvalidDateTime;
                const off_h = try parseTwoDigits(trimmed[idx .. idx + 2]);
                const off_m = try parseTwoDigits(trimmed[idx + 3 .. idx + 5]);
                if (off_h > 14 or off_m > 59 or (off_h == 14 and off_m != 0)) {
                    return error.InvalidDateTime;
                }
                offset_minutes = sign * (@as(i16, off_h) * 60 + @as(i16, off_m));
                idx += 5;
            } else {
                return error.InvalidDateTime;
            }
        }

        if (idx != trimmed.len) return error.InvalidDateTime;

        return .{
            .year = year,
            .month = month,
            .day = day,
            .hour = hour,
            .minute = minute,
            .second = second,
            .nanoseconds = nanoseconds,
            .offset_minutes = offset_minutes,
        };
    }

    fn parseTwoDigits(s: []const u8) !u8 {
        if (s.len != 2 or !std.ascii.isDigit(s[0]) or !std.ascii.isDigit(s[1])) {
            return error.InvalidDateTime;
        }
        return (s[0] - '0') * 10 + (s[1] - '0');
    }

    fn isLeapYear(year: i32) bool {
        return (@mod(year, 4) == 0 and @mod(year, 100) != 0) or @mod(year, 400) == 0;
    }

    fn daysInMonth(year: i32, month: u8) u8 {
        return switch (month) {
            1, 3, 5, 7, 8, 10, 12 => 31,
            4, 6, 9, 11 => 30,
            2 => if (isLeapYear(year)) 29 else 28,
            else => 0,
        };
    }

    pub fn toTimestamp(self: DateTime) std.Io.Timestamp {
        var y = self.year;
        var m: i32 = std.math.clamp(self.month, 1, 12);
        const d: i32 = @max(self.day, 1);
        if (m <= 2) {
            y -= 1;
            m += 12;
        }
        const era: i32 = if (y >= 0) @divTrunc(y, 400) else @divTrunc(y - 399, 400);
        const yoe: u32 = @intCast(y - era * 400);
        const doy: u32 = @intCast(@divTrunc(153 * (m - 3) + 2, 5) + d - 1);
        const doe: u32 = yoe * 365 + yoe / 4 - yoe / 100 + doy;
        const days: i64 = @as(i64, era) * 146097 + @as(i64, doe) - 719468;

        var secs: i64 = days * 86400 + @as(i64, self.hour) * 3600 + @as(i64, self.minute) * 60 + @as(i64, self.second);
        if (self.offset_minutes) |off| {
            secs -= @as(i64, off) * 60;
        }

        const total_ns = @as(i96, secs) * std.time.ns_per_s + self.nanoseconds;
        return std.Io.Timestamp.fromNanoseconds(total_ns);
    }

    pub fn fromTimestamp(ts: std.Io.Timestamp) DateTime {
        const total_ns = ts.toNanoseconds();
        const secs: i64 = @intCast(@divFloor(total_ns, std.time.ns_per_s));
        const rem_ns: u32 = @intCast(@mod(total_ns, std.time.ns_per_s));

        const days: i64 = @divFloor(secs, 86400);
        const day_secs: u32 = @intCast(@mod(secs, 86400));

        const hour: u8 = @intCast(day_secs / 3600);
        const minute: u8 = @intCast((day_secs % 3600) / 60);
        const second: u8 = @intCast(day_secs % 60);

        // Civil calendar from days since 1970-01-01
        const z = days + 719468;
        const era: i32 = if (z >= 0) @intCast(@divTrunc(z, 146097)) else @intCast(@divTrunc(z - 146096, 146097));
        const doe: u32 = @intCast(z - era * 146097);
        const yoe: u32 = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;
        const y: i32 = @intCast(@as(i64, yoe) + @as(i64, era) * 400);
        const doy: u32 = doe - (365 * yoe + yoe / 4 - yoe / 100);
        const mp: u32 = (5 * doy + 2) / 153;
        const d: u8 = @intCast(doy - (153 * mp + 2) / 5 + 1);
        const m: u8 = @intCast(if (mp < 10) mp + 3 else mp - 9);
        const year: i32 = if (m <= 2) y + 1 else y;

        return .{
            .year = year,
            .month = m,
            .day = d,
            .hour = hour,
            .minute = minute,
            .second = second,
            .nanoseconds = rem_ns,
            .offset_minutes = 0,
        };
    }
};

pub const Duration = struct {
    negative: bool = false,
    years: u32 = 0,
    months: u32 = 0,
    days: u32 = 0,
    hours: u32 = 0,
    minutes: u32 = 0,
    seconds: u32 = 0,
    nanoseconds: u32 = 0,

    pub fn format(self: Duration, w: *std.Io.Writer) !void {
        if (self.negative) try w.writeByte('-');
        try w.writeByte('P');
        var wrote_any = false;
        if (self.years > 0) {
            try w.print("{d}Y", .{self.years});
            wrote_any = true;
        }
        if (self.months > 0) {
            try w.print("{d}M", .{self.months});
            wrote_any = true;
        }
        if (self.days > 0) {
            try w.print("{d}D", .{self.days});
            wrote_any = true;
        }

        const has_time = self.hours > 0 or self.minutes > 0 or self.seconds > 0 or self.nanoseconds > 0;
        if (has_time or !wrote_any) {
            try w.writeByte('T');
            if (self.hours > 0) try w.print("{d}H", .{self.hours});
            if (self.minutes > 0) try w.print("{d}M", .{self.minutes});
            if (self.seconds > 0 or self.nanoseconds > 0 or !wrote_any) {
                if (self.nanoseconds == 0) {
                    try w.print("{d}S", .{self.seconds});
                } else {
                    const clamped_ns = @min(self.nanoseconds, 999_999_999);
                    const ms = @divTrunc(clamped_ns, 1_000_000);
                    try w.print("{d}.{d:0>3}S", .{ self.seconds, ms });
                }
            }
        }
    }

    pub fn formatAlloc(self: Duration, gpa: std.mem.Allocator) ![]u8 {
        var out: std.Io.Writer.Allocating = .init(gpa);
        defer out.deinit();
        try self.format(&out.writer);
        return try out.toOwnedSlice();
    }

    pub fn parse(s: []const u8) !Duration {
        const trimmed = std.mem.trim(u8, s, " \t\r\n");
        var res: Duration = .{};
        var idx: usize = 0;
        if (idx < trimmed.len and trimmed[idx] == '-') {
            res.negative = true;
            idx += 1;
        }
        if (idx >= trimmed.len or trimmed[idx] != 'P') return error.InvalidDuration;
        idx += 1;

        var in_time = false;
        var saw_t = false;
        var saw_any_component = false;
        var saw_time_component = false;
        var stage: u8 = 0; // 0:Y, 1:M, 2:D, 3:H, 4:min, 5:S, 6:done
        var current_num: u32 = 0;
        var has_current_num = false;

        while (idx < trimmed.len) : (idx += 1) {
            const c = trimmed[idx];
            if (c == 'T') {
                if (in_time or has_current_num) return error.InvalidDuration;
                in_time = true;
                saw_t = true;
                stage = @max(stage, 3);
                continue;
            }
            if (std.ascii.isDigit(c)) {
                const mul = std.math.mul(u32, current_num, 10) catch return error.InvalidDuration;
                current_num = std.math.add(u32, mul, c - '0') catch return error.InvalidDuration;
                has_current_num = true;
            } else if (c == '.') {
                if (!in_time or !has_current_num or stage > 5) return error.InvalidDuration;
                idx += 1;
                const frac_start = idx;
                while (idx < trimmed.len and std.ascii.isDigit(trimmed[idx])) : (idx += 1) {}
                const frac_str = trimmed[frac_start..idx];
                if (frac_str.len == 0 or idx >= trimmed.len or trimmed[idx] != 'S') {
                    return error.InvalidDuration;
                }

                res.seconds = current_num;
                var val: u64 = 0;
                var scale: u64 = 1_000_000_000;
                for (frac_str) |fc| {
                    scale /= 10;
                    val += (fc - '0') * scale;
                    if (scale == 1) break;
                }
                res.nanoseconds = @intCast(val);
                current_num = 0;
                has_current_num = false;
                saw_any_component = true;
                saw_time_component = true;
                stage = 6;
            } else {
                if (!has_current_num) return error.InvalidDuration;
                if (!in_time) {
                    switch (c) {
                        'Y' => {
                            if (stage > 0) return error.InvalidDuration;
                            res.years = current_num;
                            stage = 1;
                        },
                        'M' => {
                            if (stage > 1) return error.InvalidDuration;
                            res.months = current_num;
                            stage = 2;
                        },
                        'D' => {
                            if (stage > 2) return error.InvalidDuration;
                            res.days = current_num;
                            stage = 3;
                        },
                        else => return error.InvalidDuration,
                    }
                } else {
                    switch (c) {
                        'H' => {
                            if (stage > 3) return error.InvalidDuration;
                            res.hours = current_num;
                            stage = 4;
                        },
                        'M' => {
                            if (stage > 4) return error.InvalidDuration;
                            res.minutes = current_num;
                            stage = 5;
                        },
                        'S' => {
                            if (stage > 5) return error.InvalidDuration;
                            res.seconds = current_num;
                            stage = 6;
                        },
                        else => return error.InvalidDuration,
                    }
                    saw_time_component = true;
                }
                saw_any_component = true;
                current_num = 0;
                has_current_num = false;
            }
        }

        if (has_current_num or !saw_any_component) return error.InvalidDuration;
        if (saw_t and !saw_time_component) return error.InvalidDuration;

        return res;
    }

    /// Converts day/time components to milliseconds (ignores variable-length `years` and `months`).
    pub fn toMilliseconds(self: Duration) i64 {
        const total_s: i64 = @as(i64, self.days) * 86400 +
            @as(i64, self.hours) * 3600 +
            @as(i64, self.minutes) * 60 +
            @as(i64, self.seconds);
        var ms: i64 = total_s * 1000 + @as(i64, self.nanoseconds / 1_000_000);
        if (self.negative) ms = -ms;
        return ms;
    }

    pub fn fromMilliseconds(ms: i64) Duration {
        var res: Duration = .{};
        if (ms < 0) res.negative = true;
        const abs_ms: u64 = @abs(ms);

        const total_s = abs_ms / 1000;
        res.nanoseconds = @intCast((abs_ms % 1000) * 1_000_000);

        res.days = @intCast(@min(total_s / 86400, std.math.maxInt(u32)));
        const rem_day = total_s % 86400;
        res.hours = @intCast(rem_day / 3600);
        const rem_hr = rem_day % 3600;
        res.minutes = @intCast(rem_hr / 60);
        res.seconds = @intCast(rem_hr % 60);
        return res;
    }
};

pub const Base64Binary = struct {
    pub fn encodeAlloc(data: []const u8, gpa: std.mem.Allocator) ![]u8 {
        const encoder = std.base64.standard.Encoder;
        const out_len = encoder.calcSize(data.len);
        const out = try gpa.alloc(u8, out_len);
        _ = encoder.encode(out, data);
        return out;
    }

    pub fn decodeAlloc(s: []const u8, gpa: std.mem.Allocator) ![]u8 {
        const decoder = std.base64.standard.Decoder;

        var has_ws = false;
        for (s) |ch| {
            if (ch == ' ' or ch == '\t' or ch == '\r' or ch == '\n') {
                has_ws = true;
                break;
            }
        }

        if (!has_ws) {
            const max_len = try decoder.calcSizeForSlice(s);
            const out = try gpa.alloc(u8, max_len);
            errdefer gpa.free(out);
            try decoder.decode(out, s);
            return out;
        }

        var clean: std.ArrayList(u8) = .empty;
        defer clean.deinit(gpa);
        try clean.ensureTotalCapacity(gpa, s.len);
        for (s) |ch| {
            if (ch != ' ' and ch != '\t' and ch != '\r' and ch != '\n') {
                clean.appendAssumeCapacity(ch);
            }
        }

        const max_len = try decoder.calcSizeForSlice(clean.items);
        const out = try gpa.alloc(u8, max_len);
        errdefer gpa.free(out);
        try decoder.decode(out, clean.items);
        return out;
    }
};

pub fn XsList(comptime T: type) type {
    return struct {
        pub fn parse(s: []const u8, gpa: std.mem.Allocator) ![]T {
            var list: std.ArrayList(T) = .empty;
            errdefer {
                if (T == []const u8 or T == []u8) {
                    for (list.items) |item| gpa.free(item);
                }
                list.deinit(gpa);
            }

            var it = std.mem.tokenizeAny(u8, s, " \t\r\n");
            while (it.next()) |token| {
                if (T == []const u8 or T == []u8) {
                    try list.append(gpa, try gpa.dupe(u8, token));
                } else if (@typeInfo(T) == .int) {
                    const val = try std.fmt.parseInt(T, token, 10);
                    try list.append(gpa, val);
                } else if (@typeInfo(T) == .float) {
                    const val = try std.fmt.parseFloat(T, token);
                    try list.append(gpa, val);
                } else {
                    @compileError("Unsupported XsList item type: " ++ @typeName(T));
                }
            }
            return try list.toOwnedSlice(gpa);
        }

        pub fn format(items: []const T, w: *std.Io.Writer) !void {
            for (items, 0..) |item, i| {
                if (i > 0) try w.writeByte(' ');
                if (T == []const u8 or T == []u8) {
                    try w.writeAll(item);
                } else if (@typeInfo(T) == .int) {
                    try w.print("{d}", .{item});
                } else if (@typeInfo(T) == .float) {
                    try w.print("{d}", .{item});
                }
            }
        }
    };
}

test "xsd_types.DateTime roundtrip, validation, and timestamp conversion" {
    const dt_str = "2026-11-25T11:03:12Z";
    const dt = try DateTime.parse(dt_str);
    try std.testing.expectEqual(@as(i32, 2026), dt.year);
    try std.testing.expectEqual(@as(u8, 11), dt.month);
    try std.testing.expectEqual(@as(u8, 25), dt.day);
    try std.testing.expectEqual(@as(u8, 11), dt.hour);
    try std.testing.expectEqual(@as(u8, 3), dt.minute);
    try std.testing.expectEqual(@as(u8, 12), dt.second);

    const formatted = try dt.formatAlloc(std.testing.allocator);
    defer std.testing.allocator.free(formatted);
    try std.testing.expectEqualStrings(dt_str, formatted);

    const ts = dt.toTimestamp();
    const dt2 = DateTime.fromTimestamp(ts);
    try std.testing.expectEqual(dt.year, dt2.year);
    try std.testing.expectEqual(dt.month, dt2.month);
    try std.testing.expectEqual(dt.day, dt2.day);
    try std.testing.expectEqual(dt.hour, dt2.hour);
    try std.testing.expectEqual(dt.minute, dt2.minute);
    try std.testing.expectEqual(dt.second, dt2.second);

    // Negative year & whitespace roundtrip
    const neg_dt = try DateTime.parse("  -0001-02-28T23:59:59+05:30  ");
    try std.testing.expectEqual(@as(i32, -1), neg_dt.year);
    try std.testing.expectEqual(@as(?i16, 330), neg_dt.offset_minutes);

    // Reject invalid dates, signs in fields, and trailing garbage
    try std.testing.expectError(error.InvalidDateTime, DateTime.parse("2026-02-29T00:00:00Z"));
    try std.testing.expectError(error.InvalidDateTime, DateTime.parse("2026-03-00T00:00:00Z"));
    try std.testing.expectError(error.InvalidDateTime, DateTime.parse("2026-11-25T11:03:12Zgarbage"));
    try std.testing.expectError(error.InvalidDateTime, DateTime.parse("2026-+5-+1T+0:+0:+0Z"));
    try std.testing.expectError(error.InvalidDateTime, DateTime.parse("2026-11-25T11:03:12+14:30"));
}

test "xsd_types.Duration parse, validation, and format" {
    const dur_str = "P1Y2M3DT4H5M6S";
    const dur = try Duration.parse(dur_str);
    try std.testing.expectEqual(@as(u32, 1), dur.years);
    try std.testing.expectEqual(@as(u32, 2), dur.months);
    try std.testing.expectEqual(@as(u32, 3), dur.days);
    try std.testing.expectEqual(@as(u32, 4), dur.hours);
    try std.testing.expectEqual(@as(u32, 5), dur.minutes);
    try std.testing.expectEqual(@as(u32, 6), dur.seconds);

    const formatted = try dur.formatAlloc(std.testing.allocator);
    defer std.testing.allocator.free(formatted);
    try std.testing.expectEqualStrings(dur_str, formatted);

    const pt5s = try Duration.parse(" PT5.25S ");
    try std.testing.expectEqual(@as(i64, 5250), pt5s.toMilliseconds());
    const dur5s = Duration.fromMilliseconds(5000);
    try std.testing.expectEqual(@as(u32, 5), dur5s.seconds);

    // Reject malformed and overflowing durations
    try std.testing.expectError(error.InvalidDuration, Duration.parse("P"));
    try std.testing.expectError(error.InvalidDuration, Duration.parse("PT"));
    try std.testing.expectError(error.InvalidDuration, Duration.parse("P1DT"));
    try std.testing.expectError(error.InvalidDuration, Duration.parse("PT5"));
    try std.testing.expectError(error.InvalidDuration, Duration.parse("P1D2Y"));
    try std.testing.expectError(error.InvalidDuration, Duration.parse("PT99999999999S"));
}

test "xsd_types.Base64Binary with XML whitespace" {
    const data = "Hello, ONVIF World!";
    const encoded = try Base64Binary.encodeAlloc(data, std.testing.allocator);
    defer std.testing.allocator.free(encoded);

    const decoded = try Base64Binary.decodeAlloc(encoded, std.testing.allocator);
    defer std.testing.allocator.free(decoded);
    try std.testing.expectEqualStrings(data, decoded);

    const wrapped = "SGVs\r\nbG8s\n IE9O\tVklG IFdvcmxkIQ==";
    const decoded_ws = try Base64Binary.decodeAlloc(wrapped, std.testing.allocator);
    defer std.testing.allocator.free(decoded_ws);
    try std.testing.expectEqualStrings(data, decoded_ws);
}

test "xsd_types.XsList with mixed XML whitespace" {
    const list_str = "10\t20\n30\r\n40 50";
    const items = try XsList(i32).parse(list_str, std.testing.allocator);
    defer std.testing.allocator.free(items);

    try std.testing.expectEqual(@as(usize, 5), items.len);
    try std.testing.expectEqual(@as(i32, 10), items[0]);
    try std.testing.expectEqual(@as(i32, 50), items[4]);
}
