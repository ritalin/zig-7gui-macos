const std = @import("std");
const runtime = @import("Runtime");
const appKit = @import("AppKit");
const foundation = @import("Foundation");
const quartzCore = @import("QuartzCore");
const coreGraphics = @import("CoreGraphics");

const runtime_support = @import("Runtime-Support");
const appKit_support = @import("AppKit-Support");

const LayersMap = @import("./layers_map.zig");
const UndoHistories = @import("./undo_history.zig");

pub const CIRCLE_SIZE_MIN = 25.0;

pub const CircleDrawerContext = struct {
    pub const Values = struct {
        canvas_view: appKit.NSView,
        size_slider: appKit.NSSlider,
        activated_layer: ?quartzCore.CALayer,
        undo_button: appKit.NSButton,
        redo_button: appKit.NSButton,
        adjust_diameter_modal: appKit.NSPanel,
        state: StateContext,
    };

    allocator: std.mem.Allocator,
    values: Values,

    pub fn init(allocator: std.mem.Allocator, values: CircleDrawerContext.Values) !*CircleDrawerContext {
        const self = try allocator.create(CircleDrawerContext);
        self.* = .{
            .allocator = allocator,
            .values = values,
        };

        return self;
    }

    pub fn deinit(self: *CircleDrawerContext) void {
        self.values.state.deinit(self.allocator);
    }

    fn handleSlider(context: ?*CircleDrawerContext, slider: appKit.NSSlider) !void {
        if (context) |ctx| {
            if (ctx.values.activated_layer) |activated_layer| {
                const layer = activated_layer.superlayer() orelse return;
                const state = ctx.values.state.selected;

                const value: f32 = @floatFromInt(slider.as(appKit.NSControl).intValue()); // need int value !!
                const new_size = foundation.NSSize{ .width = value, .height = value };

                if (coreGraphics.CGSizeEqualToSize(state.new_bounds.size, new_size) == 0) {
                    layer.setBounds(.{ .origin = .{ .x = 0, .y = 0 }, .size = new_size });
                }
            }
        }
    }

    fn handleSliderCommit(context: *CircleDrawerContext, value: f32) !void {
        std.debug.print("Debug Record undo hist from slider value {}\n", .{value});

        if (context.values.activated_layer) |activated_layer| {
            const layer = activated_layer.superlayer() orelse return;
            const layer_frame = layer.frame();
            const selected_state = context.values.state.selected;

            if (layer.name()) |name| {
                const layer_name = name.as(foundation.NSString.ExtensionMethods).utf8String();

                try context.values.state.undo_list.changeEntry(std.mem.sliceTo(layer_name, 0), layer_frame, selected_state.new_bounds);
            }
            
            selected_state.new_bounds = layer_frame;
        }
    }

    fn handleMouseDrag(context: ?*CircleDrawerContext, gesture: appKit.NSGestureRecognizer) !void {
        if (context) |ctx| {
            if (ctx.selectedState()) |selected| {
                const loc = ctx.currentLocation(gesture);
                const layer_frame = selected.layer.frame();
                const gesture_state = gesture.state();

                if (std.meta.eql(gesture_state, appKit.NSGestureRecognizerState.Began)) {
                    std.debug.print("Debug.Dragging: frame@(x={}, y={}), new@(x={}, y={})\n", .{ layer_frame.origin.x, layer_frame.origin.y, loc.x, loc.y });
                    selected.state.resetMoveProbe(loc);
                } 
                else if (std.meta.eql(gesture_state, appKit.NSGestureRecognizerState.Changed)) {
                    const old_loc = selected.state.move_probe.probe_loc;

                    if (selected.state.updateMoveProve(loc)) {
                        const new_loc = selected.state.move_probe.probe_loc;
                        std.debug.print("Debug.Dragging: frame@(x={}, y={}), old@(x={}, y={}), new@(x={}, y={})\n", .{
                            layer_frame.origin.x, layer_frame.origin.y,
                            old_loc.x, old_loc.y, new_loc.x, new_loc.y,
                        });

                        selected.layer.setPosition(selected.state.move_probe.origin);
                    }
                }
                else if (std.meta.eql(gesture_state, appKit.NSGestureRecognizerState.Ended)) {
                    if (selected.layer.name()) |name| {
                        const layer_name = name.as(foundation.NSString.ExtensionMethods).utf8String();
                        try ctx.values.state.undo_list.changeEntry(std.mem.sliceTo(layer_name, 0), layer_frame, selected.state.new_bounds);
                    }
                    
                    selected.state.new_bounds = layer_frame;
                }
            }

            // std.debug.print("Debug.Dragging: gesture = {}, loc = {}\n", .{ gesture_state, loc });
        }
    }

    fn currentLocation(context: *CircleDrawerContext, gesture: appKit.NSGestureRecognizer) foundation.NSPoint {
        const loc = gesture.locationInView(context.values.canvas_view);

        return .{
            .x = @trunc(loc.x),
            .y = @trunc(loc.y),
        };
    }

    pub fn selectedState(context: *CircleDrawerContext) ?(struct { state: *CircleState, layer: quartzCore.CALayer }) {
        if (context.values.activated_layer) |activated_layer| {
            const layer = activated_layer.superlayer() orelse return null;

            return .{ .state = context.values.state.selected, .layer = layer };
        }

        return null;
    }

    fn handleMoveGestureEnabled(context: *CircleDrawerContext, gesture: appKit.NSGestureRecognizer) !bool {
        if (context.selectedState()) |selected| {
            const loc = context.currentLocation(gesture);
            const layer_frame = selected.layer.frame();

            if (coreGraphics.CGRectEqualToRect(layer_frame, selected.state.new_bounds) == 0) {
                return false;
            }

            const accept = coreGraphics.CGRectContainsPoint(layer_frame, loc) != 0;
            std.debug.print("Debug move gesture delegate: state = {}, accept = {}\n", .{ gesture.state(), accept });
            return accept;
        }

        return false;
    }

    fn handleContextualMenuGestureEnabled(context: *CircleDrawerContext, _: appKit.NSGestureRecognizer, ev: appKit.NSEvent) !bool {
        if (ev.modifierFlags().contains(.FlagControl)) {
            // show context menu
            const menu = runtime.NSObject.of(appKit.NSMenu).init();
            {
                const item = menu.addItemWithTitleActionKeyEquivalent(
                    foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("Adjust diameter...").?,
                    null,
                    foundation.NSString.ExtensionMethods.of(foundation.NSString).initWithUTF8String("").?
                );

                const popup_event = appKit_support.Handlers(CircleDrawerContext).Action(appKit.NSMenuItem).init(context, &CircleDrawerContext.handleShowAdjustDiameter);
                item.setAction(popup_event.action);
                item.setTarget(popup_event.target);
            }
            appKit.NSMenu.popUpContextMenuWithEventForView(menu, ev, context.values.canvas_view);

            return true;
        }

        return false;
    }

    fn handleMouseClickLeft(context: ?*CircleDrawerContext, gesture: appKit.NSGestureRecognizer) !void {
        std.debug.print("Debug left-click gesture delegate: state = {}\n", .{gesture.state()});

        if (context) |ctx| {
            const loc = ctx.currentLocation(gesture);
            const gesture_state = gesture.state();
            const canvas_layer = ctx.values.canvas_view.layer();

            var selected_state = ctx.values.state.selected;

            if (ctx.values.activated_layer) |layer| {
                layer.removeFromSuperlayer();
            }
            ctx.values.activated_layer = null;

            if (std.meta.eql(gesture_state, appKit.NSGestureRecognizerState.Ended)) {
                const hit_layer = hit_test: {
                    const result = canvas_layer.hitTest(loc);

                    break :hit_test 
                        if (std.meta.eql(result, canvas_layer)) null 
                        else if (result) |x| x.superlayer() else null
                    ;
                };

                const circle_layer = layer: {
                    if (hit_layer) |layer| {
                        selected_state.new_bounds = layer.frame();

                        // move top most
                        {
                            _ = runtime_support.objc_helper.retain(layer._id);
                            defer runtime_support.objc_helper.release(layer._id);

                            layer.removeFromSuperlayer();
                            canvas_layer.addSublayer(layer);
                        }

                        break :layer layer;
                    }
                    else {
                        selected_state.new_bounds = foundation.NSRect{ .origin=.{.x = loc.x, .y=loc.y}, .size = .{.width=CIRCLE_SIZE_MIN, .height=CIRCLE_SIZE_MIN}};
                        
                        const new_rect = selected_state.new_bounds;
                        const new_layer = createBaseLayer(new_rect);
                        {
                            const circle_layer = createCircleLayer(selected_state, new_rect.size, appKit.NSColor.clearColor());
                            new_layer.addSublayer(circle_layer.as(quartzCore.CALayer));
                        }
                        canvas_layer.addSublayer(new_layer);

                        const name = try ctx.values.state.createCircleName(ctx.allocator);
                        try ctx.values.state.layers.registerWithName(new_layer, name);
                        try ctx.values.state.undo_list.newEntry(name, new_rect);

                        std.debug.print("Circle.add: {s}\n", .{name});

                        break :layer new_layer;
                    }
                };

                ctx.selectCircle(circle_layer, selected_state.new_bounds);
                ctx.refresh();
            }
        }
    }

    fn refresh(context: *CircleDrawerContext) void {
        context.values.undo_button.as(appKit.NSControl).setEnabled(context.values.state.undo_list.hasUndoEntry());
        context.values.redo_button.as(appKit.NSControl).setEnabled(context.values.state.undo_list.hasRedoEntry());
    }

    fn handleMouseClickLRight(context: ?*CircleDrawerContext, gesture: appKit.NSGestureRecognizer) !void {
        _ = context;
        std.debug.print("Debug right-click gesture delegate: state = {}\n", .{gesture.state()});
    }

    fn handleShowAdjustDiameter(context: ?*CircleDrawerContext, _: appKit.NSMenuItem) !void {
        if (context) |ctx| {
            ctx.values.adjust_diameter_modal.as(appKit.NSWindow).makeKeyAndOrderFront(null);

            std.debug.print("Debug Asdjusting diameter started.\n", .{});
        }
    }

    fn handleUndoAction(context: ?*CircleDrawerContext, _: appKit.NSButton) !void {
        if (context) |ctx| {
            if (ctx.values.state.undo_list.undo()) |entry| {
                try ctx.replay(entry);
            }
        }
    }

    fn handleRedoAction(context: ?*CircleDrawerContext, _: appKit.NSButton) !void {
        if (context) |ctx| {
            if (ctx.values.state.undo_list.redo()) |entry| {
                try ctx.replay(entry);
            }
        }
    }

    fn replay(context: *CircleDrawerContext, entry: UndoHistories.Entry) !void {
        switch (entry.op) {
            .delete => {
                std.debug.print("Circle.del: {s}\n", .{entry.name});
                try context.removeCircle(entry);
            },
            .add => {
                std.debug.print("Circle.revive: {s}\n", .{entry.name});
                try context.reviveCircle(entry);
            },
            .change => {
                try context.changeCircle(entry);
            },
            else => {},
        }
        context.refresh();
    }

    fn isSelectionChanged(context: *CircleDrawerContext, layer: quartzCore.CALayer) bool {
        if (context.values.activated_layer) |activated_layer| {
            if (activated_layer.superlayer()) |circle_layer| {
                if (isSameLayer(layer.name(), circle_layer.name())) return false;
            }
        }

        return true;
    }

    fn selectCircle(context: *CircleDrawerContext, layer: quartzCore.CALayer, frame_rect: foundation.NSRect) void {
        const selected_state = context.values.state.selected;

        if (! context.isSelectionChanged(layer)) return;

        context.values.activated_layer = activated: {
            const activated_layer = createCircleLayer(selected_state, frame_rect.size, appKit.NSColor.lightGrayColor());
            layer.insertSublayerAtIndex(activated_layer, 0);

            break :activated activated_layer;
        }; 
        
        // Arrange slider
        {
            context.values.size_slider.as(appKit.NSControl).setFloatValue(@floatCast(frame_rect.size.width));
        }
    }

    fn changeCircle(context: *CircleDrawerContext, entry: UndoHistories.Entry) !void {
        if (context.values.state.layers.find(entry.name)) |layer| {
            layer.setFrame(entry.new_bounds);

            context.values.state.selected.new_bounds = entry.new_bounds;
            
            // Arrange slider
            {
                context.values.size_slider.as(appKit.NSControl).setFloatValue(@floatCast(entry.new_bounds.size.width));
            }
        }
    }

    fn reviveCircle(context: *CircleDrawerContext, entry: UndoHistories.Entry) !void {
        const canvas_layer = context.values.canvas_view.layer();
        const selected_state = context.values.state.selected;

        const new_layer = createBaseLayer(entry.new_bounds);
        {
            const circle_layer = createCircleLayer(selected_state, entry.new_bounds.size, appKit.NSColor.clearColor());
            new_layer.addSublayer(circle_layer.as(quartzCore.CALayer));
        }
        canvas_layer.addSublayer(new_layer);

        const name = try context.allocator.dupeZ(u8, entry.name);
        defer context.allocator.free(name);
        
        try context.values.state.layers.registerWithName(new_layer, name);
        // try context.values.state.undo_list.newEntry(entry.name, entry.new_bounds);
  
        // Arrange slider
        {
            context.values.size_slider.as(appKit.NSControl).setFloatValue(@floatCast(entry.new_bounds.size.width));
        }
    }

    fn removeCircle(context: *CircleDrawerContext, entry: UndoHistories.Entry) !void {
        if (context.values.state.layers.find(entry.name)) |layer| {
            if (context.values.activated_layer) |activated_layer| {
                if (activated_layer.superlayer()) |circle_layer| {
                    if (! isSameLayer(layer.name(), circle_layer.name())) {
                        activated_layer.removeFromSuperlayer();
                        context.values.activated_layer = null;
                    }
                }
            }

            layer.removeFromSuperlayer();
            context.values.activated_layer = null;
            context.values.state.layers.unregister(entry.name);
        }
    }

    fn isSameLayer(lhs: ?foundation.NSString, rhs: ?foundation.NSString) bool {
        if ((lhs != null) and (rhs != null)) {
            const lhs_name = lhs.?.as(foundation.NSString.ExtensionMethods).utf8String();
            const rhs_name = rhs.?.as(foundation.NSString.ExtensionMethods).utf8String();

            if (std.mem.eql(u8, std.mem.sliceTo(lhs_name, 0), std.mem.sliceTo(rhs_name, 0))) return true;
        }

        return false;
    }
};

pub const StateContext = struct {
    selected: *CircleState,
    diameter_context: *CircleDiameterContext,
    layers: LayersMap,
    undo_list: UndoHistories,
    key_gen: std.rand.Random,
    
    pub fn init(allocator: std.mem.Allocator) !StateContext {
        const seed = try allocator.create(std.rand.DefaultPrng);
        seed.* = std.rand.DefaultPrng.init(@intCast(std.time.milliTimestamp()));

        return .{
            .selected = try CircleState.init(allocator),
            .diameter_context = try CircleDiameterContext.init(allocator),
            .layers = try LayersMap.init(allocator),
            .undo_list = UndoHistories.init(allocator),
            .key_gen = seed.random(),
        };
    }

    pub fn deinit(self: *StateContext, allocator: std.mem.Allocator) void {
        self.layers.deinit();
        self.diameter_context.deinit(allocator);
        allocator.destroy(@as(*std.rand.DefaultPrng, @ptrCast(@alignCast(self.key_gen.ptr))));
    }

    pub fn createCircleName(self: *StateContext, allocator: std.mem.Allocator) ![:0]const u8 {
        var buf: [32]u8 = undefined;
        self.key_gen.bytes(&buf);

        return std.fmt.allocPrintZ(allocator, "{}", .{std.fmt.fmtSliceHexUpper(&buf)});
    }

    fn handleLayoutSublayer(state: *CircleState, layer: quartzCore.CALayer) !void {
        const shape_layer = runtime_support.wrapObject(quartzCore.CAShapeLayer, layer._id);
        const base_layer = layer.superlayer() orelse return;
        const new_size = base_layer.bounds().size;

        shape_layer.setPath(createCirclePath(new_size));

        if (layer.name()) |identifier| {
            const s = identifier.as(foundation.NSString.ExtensionMethods).utf8String();
            if (s != null) {
                std.debug.print("Debug.circle layout changed: {s} size={}, state={}\n",.{s, layer.bounds().size.width, state.new_bounds.size.width});
            }
        }
        // std.debug.print("Debug.circle layout changed: {}\n",.{layer.bounds().size});
    }
};

const CircleState = struct {
    move_probe: struct {
        origin: foundation.NSPoint,
        probe_loc: foundation.NSPoint,
    } = .{ .origin = .{ .x = 0, .y = 0 }, .probe_loc = .{ .x = 0, .y = 0 } },
    new_bounds: foundation.NSRect,

    pub fn init(allocator: std.mem.Allocator) !*CircleState {
        const empty_rect = .{ .origin = .{ .x = 0, .y = 0 }, .size = .{ .width = 0, .height = 0 } };

        const self = try allocator.create(CircleState);
        self.* = .{
            .new_bounds = empty_rect,
        };

        return self;
    }

    pub fn resetMoveProbe(state: *CircleState, probe_loc: foundation.NSPoint) void {
        state.move_probe = .{
            .probe_loc = probe_loc,
            .origin = state.new_bounds.origin,
        };
    }

    pub fn updateMoveProve(state: *CircleState, new_loc: foundation.NSPoint) bool {
        const diff = .{ .x = new_loc.x - state.move_probe.probe_loc.x, .y = new_loc.y - state.move_probe.probe_loc.y };
        state.move_probe = .{ .probe_loc = new_loc, .origin = .{
            .x = state.move_probe.origin.x + diff.x,
            .y = state.move_probe.origin.y + diff.y,
        } };

        return (diff.x != 0) or (diff.y != 0);
    }
};

const CircleDiameterContext = struct {
    on_commit: ?(*const fn (context: *CircleDrawerContext, value: f32) anyerror!void),

    pub fn init(allocator: std.mem.Allocator) !*CircleDiameterContext {
        const self = try allocator.create(CircleDiameterContext);
        self.* = .{
            .on_commit = null,
        };
        return self;
    }

    pub fn deinit(self: *CircleDiameterContext, allocator: std.mem.Allocator) void {
        allocator.destroy(self);
    }

    fn handleClick(context: ?*CircleDrawerContext, gesture: appKit.NSClickGestureRecognizer) !void {
        std.debug.print("slider click\n", .{  });
        if (context) |ctx| {
            if (std.meta.eql(gesture.as(appKit.NSGestureRecognizer).state(), appKit.NSGestureRecognizerState.Ended)) {
                const slider = ctx.values.size_slider;
                const pt = gesture.as(appKit.NSGestureRecognizer).locationInView(slider.as(appKit.NSView));

                if (changeSlicerValue(slider, pt)) |new_value| {
                    if (ctx.values.state.diameter_context.on_commit) |action| {
                        try action(ctx, new_value);
                    }
                }
            }
        }
    }

    fn handleTracking(context: ?*CircleDrawerContext, gesture: appKit.NSPressGestureRecognizer) !void {
        std.debug.print("slider tracking\n", .{  });
        if (context) |ctx| {
            const gesture_state = gesture.as(appKit.NSGestureRecognizer).state();
            const slider = ctx.values.size_slider;

            if (std.meta.eql(gesture_state, appKit.NSGestureRecognizerState.Changed)) {
               const pt = gesture.as(appKit.NSGestureRecognizer).locationInView(slider.as(appKit.NSView));

                _ = changeSlicerValue(slider, pt);
            }
            else if (std.meta.eql(gesture.as(appKit.NSGestureRecognizer).state(), appKit.NSGestureRecognizerState.Ended)) {
                if (ctx.values.state.diameter_context.on_commit) |action| {
                    const new_value = slider.as(appKit.NSControl).floatValue();
                    try action(ctx, new_value);
                }
            }
        }
    }

    fn changeSlicerValue(slider: appKit.NSSlider, pt: foundation.NSPoint) ?f32 {
        std.debug.print("slider change value\n", .{  });
        const bounds = slider.as(appKit.NSView).bounds();

        const min_value = slider.minValue();
        const max_value = slider.maxValue();
        const value = slider.as(appKit.NSControl).intValue();
        const new_value: f32 = @floatCast(@trunc(min_value + (pt.x - bounds.origin.x) / bounds.size.width * (max_value - min_value)));

        if (value != @as(@TypeOf(value), @intFromFloat(new_value))) {
            // change slider value
            slider.as(appKit.NSControl).setFloatValue(new_value);
            // send to event handler
            _ = slider.as(appKit.NSControl).sendActionTo(slider.as(appKit.NSControl).action(), slider.as(appKit.NSControl).target());

            return new_value;
        }

        return null;
    }
};

pub fn createCircleLayer(state: *CircleState, size: foundation.NSSize, fill_color: appKit.NSColor) quartzCore.CALayer {
    const circle_bounds = .{ .origin = .{ .x = 0, .y = 0 }, .size = size };

    const circle_layer = quartzCore.CALayer.of(quartzCore.CAShapeLayer).layer();
    circle_layer.as(quartzCore.CALayer).setFrame(circle_bounds);
    circle_layer.setLineWidth(1.0);
    circle_layer.setFillColor(fill_color.cgColor());
    circle_layer.setStrokeColor(appKit.NSColor.blackColor().cgColor());

    const circle_path = createCirclePath(size);
    circle_layer.setPath(circle_path);

    circle_layer.as(quartzCore.CALayer).setDelegate(ResizeCircleDelegate.initWithContext(state));

    // assign to sublayer
    circle_layer.as(quartzCore.CALayer).setAutoresizingMask(quartzCore.CAAutoresizingMask.init(.{
        .kCALayerWidthSizable = true,
        .kCALayerHeightSizable = true,
    }));

    return circle_layer.as(quartzCore.CALayer);
}

fn createCirclePath(size: foundation.NSSize) coreGraphics.CGPathRef {
    const path = appKit.NSBezierPath.bezierPath();
    path.appendBezierPathWithOvalInRect(.{ .origin = .{ .x = 0, .y = 0 }, .size = size });

    return appKit_support.NSBezierPath.toCGPath(path);
}

pub fn createBaseLayer(bounds: foundation.NSRect) quartzCore.CALayer {
    const layer = quartzCore.CALayer.of(quartzCore.CALayer).layer();
    layer.as(quartzCore.CALayer).setFrame(bounds);
    // layer.as(quartzCore.CALayer).setBackgroundColor(appKit.NSColor.redColor().cgColor());

    return layer;
}

pub fn bindSliderEvent(context: *CircleDrawerContext, slider: appKit.NSSlider) void {
    // slider changed
    const slider_event = appKit_support.Handlers(CircleDrawerContext).Action(appKit.NSSlider).init(context, &CircleDrawerContext.handleSlider);
    slider.as(appKit.NSControl).setAction(slider_event.action);
    slider.as(appKit.NSControl).setTarget(slider_event.target);

    context.values.state.diameter_context.on_commit = &CircleDrawerContext.handleSliderCommit;
    
    // drag tracking
    const tracking_event = appKit_support.Handlers(CircleDrawerContext).Action(appKit.NSPressGestureRecognizer).init(context, &CircleDiameterContext.handleTracking);
    const tracking_gesture = appKit.NSGestureRecognizer.of(appKit.NSPressGestureRecognizer).initWithTargetAction(tracking_event.target, tracking_event.action);
    tracking_gesture.setMinimumPressDuration(0.15);
    tracking_gesture.setButtonMask(1 << 0);
    slider.as(appKit.NSView.GestureRecognizer).addGestureRecognizer(tracking_gesture.as(appKit.NSGestureRecognizer));

    // click
    const click_event = appKit_support.Handlers(CircleDrawerContext).Action(appKit.NSClickGestureRecognizer).init(context, &CircleDiameterContext.handleClick);
    const click_gesture = appKit.NSGestureRecognizer.of(appKit.NSClickGestureRecognizer).initWithTargetAction(click_event.target, click_event.action);
    click_gesture.setButtonMask(1 << 0);
    click_gesture.setNumberOfClicksRequired(1);
    slider.as(appKit.NSView.GestureRecognizer).addGestureRecognizer(click_gesture.as(appKit.NSGestureRecognizer));

    // gesture configuration
    const gesture_config = appKit.NSPressureConfiguration.of(appKit.NSPressureConfiguration).initWithPressureBehavior(appKit.NSPressureBehavior.PrimaryClick);
    slider.as(appKit.NSPressureConfiguration.ForNSView.PressureConfiguration).setPressureConfiguration(gesture_config);
}

pub const ResizeCircleDelegate = quartzCore.CALayerDelegate.Protocol(CircleState).Derive(.{
    .handler_calayer_delegate = .{
        .layoutSublayersOfLayer = &StateContext.handleLayoutSublayer,
    },
}, runtime_support.identity_seed.FixValueSeed("09b124f9-3ad0-4941-ac9f-dbe519a961da"));

pub const MoveGestureDelegate = appKit.NSGestureRecognizerDelegate.Protocol(CircleDrawerContext).Derive(.{
    .handler_gesture_recognizer_delegate = .{
        .gestureRecognizerShouldBegin = &CircleDrawerContext.handleMoveGestureEnabled,
    },
}, runtime_support.identity_seed.FixValueSeed("cf6203e7-b9ed-4b4d-8c81-475a6fbe2474"));

const ContextualMenuGestureDelegate = appKit.NSGestureRecognizerDelegate.Protocol(CircleDrawerContext).Derive(.{
    .handler_gesture_recognizer_delegate = .{
        .gestureRecognizerShouldAttemptToRecognizeWithEvent = &CircleDrawerContext.handleContextualMenuGestureEnabled,
    },
}, runtime_support.identity_seed.FixValueSeed("5074ac72-9407-4b0c-a2ef-b71a2f27a219"));

pub fn bindCanvasEvent(context: *CircleDrawerContext, canvas_view: appKit.NSView) void {
    const press_event = appKit_support.Handlers(CircleDrawerContext).Action(appKit.NSGestureRecognizer).init(context, &CircleDrawerContext.handleMouseDrag);
    const press_gesture = appKit.NSGestureRecognizer.of(appKit.NSPressGestureRecognizer).initWithTargetAction(press_event.target, press_event.action);

    const gesture_config = appKit.NSPressureConfiguration.of(appKit.NSPressureConfiguration).initWithPressureBehavior(appKit.NSPressureBehavior.PrimaryClick);
    canvas_view.as(appKit.NSPressureConfiguration.ForNSView.PressureConfiguration).setPressureConfiguration(gesture_config);
    press_gesture.setMinimumPressDuration(0.1);
    press_gesture.as(appKit.NSGestureRecognizer).setDelegate(MoveGestureDelegate.initWithContext(context));

    canvas_view.as(appKit.NSView.GestureRecognizer).addGestureRecognizer(press_gesture.as(appKit.NSGestureRecognizer));

    const left_click_event = appKit_support.Handlers(CircleDrawerContext).Action(appKit.NSGestureRecognizer).init(context, &CircleDrawerContext.handleMouseClickLeft);
    const left_click_gesture = appKit.NSGestureRecognizer.of(appKit.NSClickGestureRecognizer).initWithTargetAction(left_click_event.target, left_click_event.action);
    left_click_gesture.setButtonMask(1 << 0);
    canvas_view.as(appKit.NSView.GestureRecognizer).addGestureRecognizer(left_click_gesture.as(appKit.NSGestureRecognizer));

    const right_click_event = appKit_support.Handlers(CircleDrawerContext).Action(appKit.NSGestureRecognizer).init(context, &CircleDrawerContext.handleMouseClickLRight);
    // ctrl + left_click
    const right_click_gesture_alt = appKit.NSGestureRecognizer.of(appKit.NSClickGestureRecognizer).initWithTargetAction(right_click_event.target, right_click_event.action);
    right_click_gesture_alt.setButtonMask(1 << 0);
    right_click_gesture_alt.as(appKit.NSGestureRecognizer).setDelegate(ContextualMenuGestureDelegate.initWithContext(context));
    canvas_view.as(appKit.NSView.GestureRecognizer).addGestureRecognizer(right_click_gesture_alt.as(appKit.NSGestureRecognizer));
}

pub fn bindUndoEvent(context: *CircleDrawerContext, undo_button: appKit.NSButton) void {
    const replay_event = appKit_support.Handlers(CircleDrawerContext).Action(appKit.NSButton).init(context, &CircleDrawerContext.handleUndoAction);
    undo_button.as(appKit.NSControl).setAction(replay_event.action);
    undo_button.as(appKit.NSControl).setTarget(replay_event.target);
}

pub fn bindRedoEvent(context: *CircleDrawerContext, redo_button: appKit.NSButton) void {
    const replay_event = appKit_support.Handlers(CircleDrawerContext).Action(appKit.NSButton).init(context, &CircleDrawerContext.handleRedoAction);
    redo_button.as(appKit.NSControl).setAction(replay_event.action);
    redo_button.as(appKit.NSControl).setTarget(replay_event.target);
}