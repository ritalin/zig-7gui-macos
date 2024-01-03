const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTimer = struct {
    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub inline fn as(self: Self, comptime DesiredType: type) DesiredType {
        return runtime_support.ObjectUpperCast(Self, Self.Constructor).as(self, DesiredType);
    }

    pub inline fn of(comptime DesiredType: type) type {
        return runtime_support.ObjectUpperCast(Self, Self.Constructor).of(DesiredType);
    }

    pub fn timerWithTimeIntervalRepeatsBlock(_interval: NSTimeInterval, _repeats: bool, _block: runtime_support.ApiBlock(fn (_: NSTimer) void)) NSTimer {
        return runtime_support.wrapObject(NSTimer, backend.NSTimerMessages.timerWithTimeIntervalRepeatsBlock(runtime_support.pass(NSTimeInterval, _interval), runtime_support.toBOOL(_repeats), runtime_support.unwrapApiBlock(runtime_support.ApiBlock(fn (_: NSTimer) void), _block)));
    }

    pub fn scheduledTimerWithTimeIntervalRepeatsBlock(_interval: NSTimeInterval, _repeats: bool, _block: runtime_support.ApiBlock(fn (_: NSTimer) void)) NSTimer {
        return runtime_support.wrapObject(NSTimer, backend.NSTimerMessages.scheduledTimerWithTimeIntervalRepeatsBlock(runtime_support.pass(NSTimeInterval, _interval), runtime_support.toBOOL(_repeats), runtime_support.unwrapApiBlock(runtime_support.ApiBlock(fn (_: NSTimer) void), _block)));
    }

    pub fn tolerance(self: Self) NSTimeInterval {
        return backend.NSTimerMessages.tolerance(runtime_support.objectId(NSTimer, self));
    }

    pub fn setTolerance(self: Self, _tolerance: NSTimeInterval) void {
        return backend.NSTimerMessages.setTolerance(runtime_support.objectId(NSTimer, self), runtime_support.pass(NSTimeInterval, _tolerance));
    }

    pub fn invalidate(self: Self) void {
        return backend.NSTimerMessages.invalidate(runtime_support.objectId(NSTimer, self));
    }

    fn Constructor(comptime DesiredType: type) type {
        _ = DesiredType;
        return struct {};
    }

    pub fn BlockSupport(comptime UserContextType: type) type {
        return struct {
            pub fn TimerWithTimeIntervalBlock(comptime _handler: Handlers.TimerWithTimeIntervalHandler) type {
                return struct {
                    pub fn init(user_context: *UserContextType) !runtime_support.ApiBlock(fn (_: NSTimer) void) {
                        const block = try Block.init(.{
                            .context = user_context,
                        }, &dispatchTimerWithTimeInterval);
                        return .{
                            .context = block.context,
                        };
                    }

                    fn dispatchTimerWithTimeInterval(block_context: *const Block.Context, _timer: objc.c.id) callconv(.C) void {
                        const timer = runtime_support.wrapObject(NSTimer, runtime_support.wrapObjectId(_timer));
                        return _handler(block_context.context, timer) catch {
                            unreachable;
                        };
                    }

                    const Block = objc.Block(runtime_support.BlockCaptures(UserContextType), .{
                        objc.c.id,
                    }, void);
                };
            }

            pub fn ScheduledTimerWithTimeIntervalBlock(comptime _handler: Handlers.ScheduledTimerWithTimeIntervalHandler) type {
                return struct {
                    pub fn init(user_context: *UserContextType) !runtime_support.ApiBlock(fn (_: NSTimer) void) {
                        const block = try Block.init(.{
                            .context = user_context,
                        }, &dispatchScheduledTimerWithTimeInterval);
                        return .{
                            .context = block.context,
                        };
                    }

                    fn dispatchScheduledTimerWithTimeInterval(block_context: *const Block.Context, _timer: objc.c.id) callconv(.C) void {
                        const timer = runtime_support.wrapObject(NSTimer, runtime_support.wrapObjectId(_timer));
                        return _handler(block_context.context, timer) catch {
                            unreachable;
                        };
                    }

                    const Block = objc.Block(runtime_support.BlockCaptures(UserContextType), .{
                        objc.c.id,
                    }, void);
                };
            }

            pub const Handlers = struct {
                pub const TimerWithTimeIntervalHandler = *const fn (_context: *UserContextType, _: NSTimer) anyerror!void;
                pub const ScheduledTimerWithTimeIntervalHandler = *const fn (_context: *UserContextType, _: NSTimer) anyerror!void;
            };
        };
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSTimerMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSTimer,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{});
        }
    };

    pub const Self = @This();
};

const NSTimeInterval = foundation.NSTimeInterval;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
