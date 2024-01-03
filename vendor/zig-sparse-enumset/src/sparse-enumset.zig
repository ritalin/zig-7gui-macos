const std = @import("std");

/// Indexer
pub fn SparseEnumIndexer(comptime E: type) type {
    const S = struct {
        fn maxLength() comptime_int {
            var result: i32 = -1;

            inline for(std.meta.fields(E), 0..) |f, i| {
                const v: std.meta.Tag(E) = f.value;
                const c: comptime_int = @popCount(v);
                if (c != 1) {
                    @compileError(std.fmt.comptimePrint("enum value @({}: {s}) is not bit flag", .{i, f.name}));
                }

                result = @max(result, @ctz(v));
            }

            return result + 1;
        }

        fn toArray(comptime len: comptime_int) [len]E {
            var result: [len]E = undefined;

            inline for (std.meta.fields(E)) |f| {
                const v: std.meta.Tag(E) = f.value;
                const i = @ctz(v);

                result[i] = @field(E, f.name);
            }

            return result;
        }
    };  

    const len = S.maxLength();
    const keys = S.toArray(len);
  
    return struct {
        pub const Key = E; 
        pub const count: comptime_int = len;

        pub fn indexOf(e: E) usize {
            return @ctz(@intFromEnum(e));
        }

        pub fn keyForIndex(i: usize) E {
            return keys[i];
        }
    };
}

/// Extension methods
pub fn SparseEnumFlagSet(comptime Self: type) type {
    return struct {
        pub fn init(args: std.enums.EnumFieldStruct(Self.Key, bool, false)) Self {
            var self = Self {};

            const fields = std.meta.fields(Self.Key);

            inline for (fields) |field| {
                if (@field(args, field.name)) {
                    const i = @ctz(@as(usize, @intCast(field.value)));
                    self.insert(Self.Indexer.keyForIndex(i));
                }
            }

            return self;
        }

        pub fn includes(self: *Self, args: anytype) void {
            const typ = @typeInfo(@TypeOf(args)).Struct;
            if (! typ.is_tuple) {
                @compileError("need pass by tuple\n");
            }

            const len = typ.fields.len;
            comptime var i = 0;

            inline while (i < len) : (i += 1) {
                self.insert(args[i]);
            }
        }

        pub fn excludes(self: *Self, args: anytype) void {
            const typ = @typeInfo(@TypeOf(args)).Struct;
            if (! typ.is_tuple) {
                @compileError("need pass by tuple\n");
            }

            const len = typ.fields.len;
            comptime var i = 0;

            inline while (i < len) : (i += 1) {
                self.remove(args[i]);
            }
        }
    };
}

const TestOptions = enum(u32) {
   Opt1 = 1 << 0,
   Opt2 = 1 << 1,
   Opt3 = 1 << 2,
   Opt55 = 1 << 10,
   Opt99 = 1 << 15,
};

const SparseOptions = std.enums.IndexedSet(SparseEnumIndexer(TestOptions), SparseEnumFlagSet);

test "testing for sparse enum set" {
    var opts = SparseOptions.init(.{ .Opt1 = true });

    try std.testing.expectEqual(true, opts.contains(.Opt1));
    try std.testing.expectEqual(false, opts.contains(.Opt2));
    try std.testing.expectEqual(false, opts.contains(.Opt3));
    try std.testing.expectEqual(false, opts.contains(.Opt55));

    try std.testing.expect(opts.bits.mask == 1);

    opts.includes(.{ .Opt3, .Opt55 });

    try std.testing.expectEqual(true, opts.contains(.Opt1));
    try std.testing.expectEqual(false, opts.contains(.Opt2));
    try std.testing.expectEqual(true, opts.contains(.Opt3));
    try std.testing.expectEqual(true, opts.contains(.Opt55));
    try std.testing.expect(opts.bits.mask == 1029);

    opts.excludes(.{ .Opt1, .Opt2, .Opt3 });

    try std.testing.expectEqual(false, opts.contains(.Opt1));
    try std.testing.expectEqual(false, opts.contains(.Opt2));
    try std.testing.expectEqual(false, opts.contains(.Opt3));
    try std.testing.expectEqual(true, opts.contains(.Opt55));
    try std.testing.expect(opts.bits.mask == 1024);
}
