const std = @import("std");

pub const RandomSeed = struct {
    pub fn generateIdentifier() []const u8 {
        var rand_seed = std.rand.DefaultPrng.init(@intCast(@returnAddress()));
        // var rand = rand_seed.random();
        // var v = rand.int(u64);

        var input: [32]u8 = undefined;
        rand_seed.fill(&input);
        var output = std.fmt.bytesToHex(&input, .upper);

        return &output;
    }
};

pub fn FixValueSeed(comptime value: []const u8) type {
    return struct {
        pub fn generateIdentifier() []const u8 {
            return value;
        }
    };
}
