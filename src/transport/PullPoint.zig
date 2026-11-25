const std = @import("std");
const xsd = @import("../xsd_types.zig");

pub const PropertyOperation = enum {
    Initialized,
    Changed,
    Deleted,
};

pub const NotificationMessage = struct {
    topic: []const u8,
    utc_time: xsd.DateTime,
    property_operation: PropertyOperation = .Changed,
    data: []const u8,
};

pub const SubscriptionManager = struct {
    const QUEUE_CAPACITY = 64;

    io: std.Io,
    mutex: std.Io.Mutex = .init,
    cond: std.Io.Condition = .init,
    buf: [QUEUE_CAPACITY]NotificationMessage = undefined,
    head: usize = 0,
    len: usize = 0,
    closed: bool = false,

    pub fn init(io: std.Io) SubscriptionManager {
        return .{ .io = io };
    }

    pub fn deinit(self: *SubscriptionManager) void {
        self.mutex.lockUncancelable(self.io);
        defer self.mutex.unlock(self.io);
        self.closed = true;
        self.cond.broadcast(self.io);
    }

    pub fn publish(self: *SubscriptionManager, msg: NotificationMessage) !void {
        try self.mutex.lock(self.io);
        defer self.mutex.unlock(self.io);

        if (self.closed) return error.Closed;

        if (self.len == QUEUE_CAPACITY) {
            // Evict oldest event so slow consumers never stall event producers
            self.head = (self.head + 1) % QUEUE_CAPACITY;
            self.len -= 1;
        }

        const tail = (self.head + self.len) % QUEUE_CAPACITY;
        self.buf[tail] = msg;
        self.len += 1;
        self.cond.broadcast(self.io);
    }

    pub fn pullMessages(
        self: *SubscriptionManager,
        timeout_ms: u32,
        max_messages: usize,
        out: []NotificationMessage,
    ) !usize {
        const limit = @min(max_messages, out.len);
        if (limit == 0) return 0;

        try self.mutex.lock(self.io);
        defer self.mutex.unlock(self.io);

        while (self.len == 0 and !self.closed) {
            if (timeout_ms == 0) return 0;
            self.cond.waitTimeout(self.io, &self.mutex, .{
                .duration = .{ .clock = .awake, .raw = .fromMilliseconds(timeout_ms) },
            }) catch |err| switch (err) {
                error.Timeout => return 0,
                error.Canceled => return error.Canceled,
            };
        }

        if (self.len == 0) return 0; // closed

        var count: usize = 0;
        while (count < limit and self.len > 0) {
            out[count] = self.buf[self.head];
            self.head = (self.head + 1) % QUEUE_CAPACITY;
            self.len -= 1;
            count += 1;
        }

        return count;
    }
};

test "PullPoint subscription manager publish and pull" {
    const io = std.testing.io;

    var sm = SubscriptionManager.init(io);
    defer sm.deinit();

    const msg = NotificationMessage{
        .topic = "tns1:RuleEngine/CellMotionDetector/Motion",
        .utc_time = .{ .year = 2026, .month = 11, .day = 25, .hour = 12, .minute = 0, .second = 0 },
        .property_operation = .Changed,
        .data = "IsMotion=true",
    };

    try sm.publish(msg);

    var out_buf: [4]NotificationMessage = undefined;
    const pulled = try sm.pullMessages(100, 4, &out_buf);

    try std.testing.expectEqual(@as(usize, 1), pulled);
    try std.testing.expectEqualStrings("tns1:RuleEngine/CellMotionDetector/Motion", out_buf[0].topic);
    try std.testing.expectEqualStrings("IsMotion=true", out_buf[0].data);

    // Pull with timeout when empty
    const pulled_empty = try sm.pullMessages(10, 4, &out_buf);
    try std.testing.expectEqual(@as(usize, 0), pulled_empty);
}

test "PullPoint delayed publish wakes pullMessages without blocking for max_messages" {
    const io = std.testing.io;

    var sm = SubscriptionManager.init(io);
    defer sm.deinit();

    const Producer = struct {
        fn run(m: *SubscriptionManager, p_io: std.Io) void {
            p_io.sleep(std.Io.Duration.fromMilliseconds(15), .awake) catch return;
            m.publish(.{
                .topic = "tns1:VideoSource/SignalLoss",
                .utc_time = .{ .year = 2026, .month = 11, .day = 25, .hour = 12, .minute = 0, .second = 0 },
                .data = "State=true",
            }) catch {};
        }
    };

    var fut = try io.concurrent(Producer.run, .{ &sm, io });
    defer fut.cancel(io);

    var out_buf: [4]NotificationMessage = undefined;
    const pulled = try sm.pullMessages(500, 4, &out_buf);
    try std.testing.expectEqual(@as(usize, 1), pulled);
    try std.testing.expectEqualStrings("State=true", out_buf[0].data);
}
