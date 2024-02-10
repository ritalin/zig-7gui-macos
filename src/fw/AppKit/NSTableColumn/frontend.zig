const std = @import("std");
const objc = @import("objc");
const backend = @import("./backend.zig");
const appKit = @import("AppKit");
const coreGraphics = @import("CoreGraphics");
const foundation = @import("Foundation");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub const NSTableColumnResizingOptions = runtime_support.EnumOptions(enum(NSUInteger) {
    AutoresizingMask = (1 << 0),
    User = (1 << 1),
});

pub const NSTableColumn = struct {
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

    pub fn width(self: Self) CGFloat {
        return backend.NSTableColumnMessages.width(runtime_support.objectId(NSTableColumn, self));
    }

    pub fn setWidth(self: Self, _width: CGFloat) void {
        return backend.NSTableColumnMessages.setWidth(runtime_support.objectId(NSTableColumn, self), runtime_support.pass(CGFloat, _width));
    }

    pub fn minWidth(self: Self) CGFloat {
        return backend.NSTableColumnMessages.minWidth(runtime_support.objectId(NSTableColumn, self));
    }

    pub fn setMinWidth(self: Self, _minWidth: CGFloat) void {
        return backend.NSTableColumnMessages.setMinWidth(runtime_support.objectId(NSTableColumn, self), runtime_support.pass(CGFloat, _minWidth));
    }

    pub fn maxWidth(self: Self) CGFloat {
        return backend.NSTableColumnMessages.maxWidth(runtime_support.objectId(NSTableColumn, self));
    }

    pub fn setMaxWidth(self: Self, _maxWidth: CGFloat) void {
        return backend.NSTableColumnMessages.setMaxWidth(runtime_support.objectId(NSTableColumn, self), runtime_support.pass(CGFloat, _maxWidth));
    }

    pub fn title(self: Self) NSString {
        return runtime_support.wrapObject(NSString, backend.NSTableColumnMessages.title(runtime_support.objectId(NSTableColumn, self)));
    }

    pub fn setTitle(self: Self, _title: NSString) void {
        return backend.NSTableColumnMessages.setTitle(runtime_support.objectId(NSTableColumn, self), runtime_support.objectId(NSString, _title));
    }

    pub fn isEditable(self: Self) bool {
        return runtime_support.fromBOOL(backend.NSTableColumnMessages.isEditable(runtime_support.objectId(NSTableColumn, self)));
    }

    pub fn setEditable(self: Self, _editable: bool) void {
        return backend.NSTableColumnMessages.setEditable(runtime_support.objectId(NSTableColumn, self), runtime_support.toBOOL(_editable));
    }

    fn Constructor(comptime DesiredType: type) type {
        return struct {
            pub fn initWithIdentifier(_identifier: NSUserInterfaceItemIdentifier) DesiredType {
                const _class = DesiredType.TypeSupport.getClass();
                return runtime_support.wrapObject(DesiredType, backend.NSTableColumnMessages.initWithIdentifier(_class, runtime_support.objectId(NSString, _identifier)));
            }
        };
    }

    pub const TypeSupport = struct {
        pub inline fn getClass() objc.Class {
            return backend.NSTableColumnMessages.getClass();
        }

        pub fn inheritFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSTableColumn,
                NSObject,
            });
        }

        pub fn protocolFrom(comptime DesiredType: type) bool {
            return runtime_support.typeConstraints(DesiredType.Self, .{
                NSCoding,
                NSUserInterfaceItemIdentification,
            });
        }
    };

    pub const Self = @This();
};

const NSUserInterfaceItemIdentification = appKit.NSUserInterfaceItemIdentification;
const NSUserInterfaceItemIdentifier = appKit.NSUserInterfaceItemIdentifier;
const CGFloat = coreGraphics.CGFloat;
const NSCoding = foundation.NSCoding;
const NSString = foundation.NSString;
const NSObject = runtime.NSObject;
const NSObjectProtocol = runtime.NSObjectProtocol;
const NSUInteger = runtime.NSUInteger;
