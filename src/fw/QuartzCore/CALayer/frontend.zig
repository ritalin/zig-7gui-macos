const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const coreGraphics = @import("CoreGraphics");
const foundation = @import("Foundation");
const quartzCore = @import("QuartzCore");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const CAAutoresizingMask = runtime_support.EnumOptions(enum(c_uint) {
    kCALayerMinXMargin = 1 << 0,
    kCALayerWidthSizable = 1 << 1,
    kCALayerMaxXMargin = 1 << 2,
    kCALayerMinYMargin = 1 << 3,
    kCALayerHeightSizable = 1 << 4,
    kCALayerMaxYMargin = 1 << 5,
});

pub const CAEdgeAntialiasingMask = runtime_support.EnumOptions(enum(c_uint) {
    kCALayerLeftEdge = 1 << 0,
    kCALayerRightEdge = 1 << 1,
    kCALayerBottomEdge = 1 << 2,
    kCALayerTopEdge = 1 << 3,
});

pub const CACornerMask = runtime_support.EnumOptions(enum(NSUInteger) {
    kCALayerMinXMinYCorner = 1 << 0,
    kCALayerMaxXMinYCorner = 1 << 1,
    kCALayerMinXMaxYCorner = 1 << 2,
    kCALayerMaxXMaxYCorner = 1 << 3,
});

pub const CALayer = struct {
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

    pub fn bounds(self: Self) CGRect {
        return backend.CALayerMessages.bounds(runtime_support.objectId(CALayer, self));
    }

    pub fn setBounds(self: Self, _bounds: CGRect) void {
        return backend.CALayerMessages.setBounds(runtime_support.objectId(CALayer, self), runtime_support.pass(CGRect, _bounds));
    }

    pub fn position(self: Self) CGPoint {
        return backend.CALayerMessages.position(runtime_support.objectId(CALayer, self));
    }

    pub fn setPosition(self: Self, _position: CGPoint) void {
        return backend.CALayerMessages.setPosition(runtime_support.objectId(CALayer, self), runtime_support.pass(CGPoint, _position));
    }

    pub fn frame(self: Self) CGRect {
        return backend.CALayerMessages.frame(runtime_support.objectId(CALayer, self));
    }

    pub fn setFrame(self: Self, _frame: CGRect) void {
        return backend.CALayerMessages.setFrame(runtime_support.objectId(CALayer, self), runtime_support.pass(CGRect, _frame));
    }

    pub fn superlayer(self: Self) ?CALayer {
        return runtime_support.wrapObject(?CALayer, backend.CALayerMessages.superlayer(runtime_support.objectId(CALayer, self)));
    }

    pub fn removeFromSuperlayer(self: Self) void {
        return backend.CALayerMessages.removeFromSuperlayer(runtime_support.objectId(CALayer, self));
    }

    pub fn addSublayer(self: Self, _layer: CALayer) void {
        return backend.CALayerMessages.addSublayer(runtime_support.objectId(CALayer, self), runtime_support.objectId(CALayer, _layer));
    }

    pub fn insertSublayerAtIndex(self: Self, _layer: CALayer, _idx: c_uint) void {
        return backend.CALayerMessages.insertSublayerAtIndex(runtime_support.objectId(CALayer, self), runtime_support.objectId(CALayer, _layer), _idx);
    }

    pub fn convertPointFromLayer(self: Self, _p: CGPoint, _l: ?CALayer) CGPoint {
        return backend.CALayerMessages.convertPointFromLayer(runtime_support.objectId(CALayer, self), runtime_support.pass(CGPoint, _p), runtime_support.objectId(?CALayer, _l));
    }

    pub fn convertPointToLayer(self: Self, _p: CGPoint, _l: ?CALayer) CGPoint {
        return backend.CALayerMessages.convertPointToLayer(runtime_support.objectId(CALayer, self), runtime_support.pass(CGPoint, _p), runtime_support.objectId(?CALayer, _l));
    }

    pub fn hitTest(self: Self, _p: CGPoint) ?CALayer {
        return runtime_support.wrapObject(?CALayer, backend.CALayerMessages.hitTest(runtime_support.objectId(CALayer, self), runtime_support.pass(CGPoint, _p)));
    }

    pub fn containsPoint(self: Self, _p: CGPoint) bool {
        return runtime_support.fromBOOL(backend.CALayerMessages.containsPoint(runtime_support.objectId(CALayer, self), runtime_support.pass(CGPoint, _p)));
    }

    pub fn needsDisplay(self: Self) bool {
        return runtime_support.fromBOOL(backend.CALayerMessages.needsDisplay(runtime_support.objectId(CALayer, self)));
    }

    pub fn displayIfNeeded(self: Self) void {
        return backend.CALayerMessages.displayIfNeeded(runtime_support.objectId(CALayer, self));
    }

    pub fn backgroundColor(self: Self) ?CGColorRef {
        return backend.CALayerMessages.backgroundColor(runtime_support.objectId(CALayer, self));
    }

    pub fn setBackgroundColor(self: Self, _backgroundColor: ?CGColorRef) void {
        return backend.CALayerMessages.setBackgroundColor(runtime_support.objectId(CALayer, self), runtime_support.pass(?CGColorRef, _backgroundColor));
    }

    pub fn cornerRadius(self: Self) CGFloat {
        return backend.CALayerMessages.cornerRadius(runtime_support.objectId(CALayer, self));
    }

    pub fn setCornerRadius(self: Self, _cornerRadius: CGFloat) void {
        return backend.CALayerMessages.setCornerRadius(runtime_support.objectId(CALayer, self), runtime_support.pass(CGFloat, _cornerRadius));
    }

    pub fn borderWidth(self: Self) CGFloat {
        return backend.CALayerMessages.borderWidth(runtime_support.objectId(CALayer, self));
    }

    pub fn setBorderWidth(self: Self, _borderWidth: CGFloat) void {
        return backend.CALayerMessages.setBorderWidth(runtime_support.objectId(CALayer, self), runtime_support.pass(CGFloat, _borderWidth));
    }

    pub fn borderColor(self: Self) ?CGColorRef {
        return backend.CALayerMessages.borderColor(runtime_support.objectId(CALayer, self));
    }

    pub fn setBorderColor(self: Self, _borderColor: ?CGColorRef) void {
        return backend.CALayerMessages.setBorderColor(runtime_support.objectId(CALayer, self), runtime_support.pass(?CGColorRef, _borderColor));
    }

    pub fn autoresizingMask(self: Self) CAAutoresizingMask {
        return runtime_support.unpackOptions(CAAutoresizingMask, c_uint, backend.CALayerMessages.autoresizingMask(runtime_support.objectId(CALayer, self)));
    }

    pub fn setAutoresizingMask(self: Self, _autoresizingMask: CAAutoresizingMask) void {
        return backend.CALayerMessages.setAutoresizingMask(runtime_support.objectId(CALayer, self), runtime_support.packOptions(CAAutoresizingMask, _autoresizingMask));
    }

    pub fn name(self: Self) ?NSString {
        return runtime_support.wrapObject(?NSString, backend.CALayerMessages.name(runtime_support.objectId(CALayer, self)));
    }

    pub fn setName(self: Self, _name: ?NSString) void {
        return backend.CALayerMessages.setName(runtime_support.objectId(CALayer, self), runtime_support.objectId(?NSString, _name));
    }

    pub fn delegate(self: Self) ?CALayerDelegate {
        return runtime_support.wrapObject(?CALayerDelegate, backend.CALayerMessages.delegate(runtime_support.objectId(CALayer, self)));
    }

    pub fn setDelegate(self: Self, _delegate: ?CALayerDelegate) void {
        return backend.CALayerMessages.setDelegate(runtime_support.objectId(CALayer, self), runtime_support.objectId(?CALayerDelegate, _delegate));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn layer() DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(DesiredType, backend.CALayerMessages.layer(_class));
            }

            pub fn init() DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(DesiredType, backend.CALayerMessages.init(_class));
            }
        };
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.CALayerMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                CALayer,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                CAMediaTiming,
                NSSecureCoding,
                NSCoding,
            });
        }
    };

    pub const Self = @This();
};

pub const CALayerDelegate = struct {
    _id: objc.Object,

    fn deinit(self: *Self) void {
        self.as(NSObject).dealloc(self);
    }

    pub fn Protocol(comptime ContextType: type) type {
        return struct {
            pub fn Derive(comptime _delegate_handlers: HandlerSet, comptime SuffixIdSeed: type) type {
                return struct {
                    pub fn initWithContext(context: *ContextType) Self {
                        if (_class == null) {
                            const class = backend.CALayerDelegateMessages.initClass(_class_name);
                            runtime_support.backend_support.ObjectRegistry.registerField(class, *anyopaque, "context");
                            CALayerDelegate.Protocol(ContextType).Dispatch(_delegate_handlers.handler_calayer_delegate).initClass(class);
                            NSObjectProtocol.Protocol(ContextType).Dispatch(_delegate_handlers.handler_object_protocol).initClass(class);
                            runtime_support.backend_support.ObjectRegistry.registerClass(class);
                            _class = class;
                        }
                        const _id = backend.CALayerDelegateMessages.init(_class.?);
                        const _instance = runtime_support.wrapObject(CALayerDelegate, _id);
                        runtime_support.ContextReg(ContextType).setContext(_id, context);
                        return _instance;
                    }

                    const _class_name = runtime_support.backend_support.concreteTypeName("CALayerDelegate", SuffixIdSeed.generateIdentifier());
                    var _class: ?objc.Class = null;
                };
            }

            pub fn Dispatch(comptime _delegate_handler: Handler) type {
                return struct {
                    fn dispatchDisplayLayer(_id: objc.c.id, _: objc.c.SEL, _layer: objc.c.id) void {
                        if (_delegate_handler.displayLayer) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const layer = runtime_support.wrapObject(CALayer, objc.Object.fromId(_layer));
                            return handler(context, layer) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    fn dispatchLayoutSublayersOfLayer(_id: objc.c.id, _: objc.c.SEL, _layer: objc.c.id) void {
                        if (_delegate_handler.layoutSublayersOfLayer) |handler| {
                            const context = runtime_support.ContextReg(ContextType).context(objc.Object.fromId(_id)).?;
                            const layer = runtime_support.wrapObject(CALayer, objc.Object.fromId(_layer));
                            return handler(context, layer) catch {
                                unreachable;
                            };
                        }
                        unreachable;
                    }

                    pub fn initClass(_class: objc.Class) void {
                        if (_delegate_handler.displayLayer != null) {
                            backend.CALayerDelegateMessages.registerDisplayLayer(_class, @constCast(&dispatchDisplayLayer));
                        }
                        if (_delegate_handler.layoutSublayersOfLayer != null) {
                            backend.CALayerDelegateMessages.registerLayoutSublayersOfLayer(_class, @constCast(&dispatchLayoutSublayersOfLayer));
                        }
                    }
                };
            }

            pub const HandlerSet = struct {
                handler_calayer_delegate: CALayerDelegate.Protocol(ContextType).Handler = .{},
                handler_object_protocol: NSObjectProtocol.Protocol(ContextType).Handler = .{},
            };

            pub const Handler = struct {
                displayLayer: ?*const fn (context: *ContextType, _: CALayer) anyerror!void = null,
                layoutSublayersOfLayer: ?*const fn (context: *ContextType, _: CALayer) anyerror!void = null,
            };
        };
    }

    pub const Self = @This();
};

const CGColorRef = coreGraphics.CGColorRef;
const CGFloat = coreGraphics.CGFloat;
const CGPoint = coreGraphics.CGPoint;
const CGRect = coreGraphics.CGRect;
const NSCoding = foundation.NSCoding;
const NSSecureCoding = foundation.NSSecureCoding;
const NSString = foundation.NSString;
const CAMediaTiming = quartzCore.CAMediaTiming;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
