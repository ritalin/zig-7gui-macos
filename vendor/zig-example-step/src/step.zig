const std = @import("std");

pub const RunExample = struct {
    step: std.build.Step,
    artifacts: std.StringArrayHashMap(*std.build.RunStep),
    
    pub fn create(b: *std.Build) !*RunExample {
        const toplevel_step = b.step("example", "run example");

        const self = b.allocator.create(RunExample) catch @panic("OOM");
        self.* = .{
            .step = std.build.Step.init(.{
                .id = .custom,
                .name = b.fmt("select example", .{}),
                .owner = b,
                .makeFn = make,
            }),
            .artifacts = std.StringArrayHashMap(*std.build.RunStep).init(b.allocator),
        };

        toplevel_step.dependOn(&self.step);

        return self;
    }

    pub fn addExample(self: *RunExample, step: *std.build.CompileStep, args: anytype) void {
        const owner = self.step.owner;

        const run_cmd = owner.addRunArtifact(step);
        const artifact = owner.addInstallArtifact(step, .{});
        run_cmd.step.dependOn(&artifact.step);

        const ArgType = @TypeOf(args);
        switch (@typeInfo(ArgType)) {
            .Struct => |type_info| {
                std.debug.assert (type_info.is_tuple);

                const fields = type_info.fields;
                inline for (fields) |field| {
                    if (field.type == []const u8) {
                        const arg = @as([]const u8, @field(fields, field.name));
                        run_cmd.addArg(arg);
                    }
                }
            },
            else => unreachable,
        } 

        const out_filename = outputName(run_cmd) orelse {
            std.debug.print("output file is not specified.\n", .{});
            return;
        };

        const gop = self.artifacts.getOrPut(out_filename) catch @panic("OOM");
        if (!gop.found_existing) {         
            gop.value_ptr.* = run_cmd;
        }
    }

    fn outputName(artifact: *std.build.RunStep) ?[]const u8 {
        for (artifact.argv.items) |arg| {
            switch (arg) {
                .artifact => |x| {
                    return x.out_filename;
                },
                else => {}
            }
        }

        return null;
    }

    fn targetExample(self: RunExample) ?[]const u8 {
        if (self.step.owner.args) |args| {
            if (args.len > 0) return args[0];
        }

        return null;
    }

    fn usageExample(self: *RunExample) void {
        std.log.scoped(.build_example).err("usage: zig build example -- <NAME/INDEX>", .{});
        for (self.artifacts.keys(), 0..) |name, i| {
            std.log.scoped(.build_example).err("[{}] {?s}", .{i, name});
        }
    }

    pub fn make(step: *std.build.Step, prog_node: *std.Progress.Node) !void {
        const self = @fieldParentPtr(RunExample, "step", step);
        
        const target = self.targetExample() orelse {
            self.usageExample();
            @atomicStore(std.build.Step.State, &step.state, .skipped, .SeqCst);
            return;
        };

        const artifact = (self.artifacts.get(target)) orelse artifact: {
            const index =  std.fmt.parseInt(u32, target, 10) catch {
                self.usageExample();
                @atomicStore(std.build.Step.State, &step.state, .failure, .SeqCst);
                return;
            };

            const keys = self.artifacts.keys();
            if (index >= keys.len) {
                self.usageExample();
                @atomicStore(std.build.Step.State, &step.state, .failure, .SeqCst);
                return;
            }

            break :artifact self.artifacts.get(keys[index]).?;
        };

        try makeInternal(&artifact.step, prog_node);
    }

    fn makeInternal(step: *std.build.Step, prog_node: *std.Progress.Node) !void {
        for (step.dependencies.items) |dep| {
            try makeInternal(dep, prog_node);
        }
        const result = step.make(prog_node);
        
        if (step.result_error_msgs.items.len > 0) err_log: {
            dumpMakeError(step, prog_node) catch break :err_log;
        }

        if (result) |_| {
            @atomicStore(std.build.Step.State, &step.state, .success, .SeqCst);
        }
        else |err| switch (err) {
            error.MakeFailed => {
                @atomicStore(std.build.Step.State, &step.state, .failure, .SeqCst);
                return err;
            },
            error.MakeSkipped => @atomicStore(std.build.Step.State, &step.state, .skipped, .SeqCst),
        }
    }

    fn dumpMakeError(step: *std.build.Step, prog_node: *std.Progress.Node) !void {
        prog_node.context.lock_stderr();
        defer prog_node.context.unlock_stderr();
        
        const stderr = std.io.getStdErr();
        const tty_config = std.io.tty.detectConfig(stderr);


        err_log: {
            for (step.result_error_msgs.items) |msg| {
                tty_config.setColor(stderr, .bold) catch break :err_log;
                stderr.writeAll(step.owner.dep_prefix) catch break :err_log;
                stderr.writeAll(step.name) catch break :err_log;
                stderr.writeAll(": ") catch break :err_log;

                tty_config.setColor(stderr, .red) catch break;
                stderr.writeAll("error: ") catch break;

                tty_config.setColor(stderr, .reset) catch break;
                stderr.writeAll(msg) catch break;
                stderr.writeAll("\n") catch break;                
            }

            stderr.writeAll("\n") catch break :err_log;

            if (step.result_error_bundle.extra.len > 0) {
                step.result_error_bundle.renderToWriter(.{.ttyconf = tty_config}, stderr.writer()) catch break :err_log;
            }
        }     
    }
};