const std = @import("std");
const objc = @import("objc");
const runtime = @import("Runtime");

const BOOL_YES: objc.c.BOOL = 1;
const BOOL_NO: objc.c.BOOL = 0;

pub const RuntimeTypeConverter = struct {
    pub inline fn fromBOOL(v: objc.c.BOOL) bool {
        return (v == BOOL_YES);
    }

    pub inline fn toBOOL(v: bool) objc.c.BOOL {
        return if (v) BOOL_YES else BOOL_NO;
    }

    pub inline fn pass(comptime ValueType: type, value: ValueType) ValueType {
        return value;
    }

    pub inline fn objectId(comptime ObjectType: type, value: ObjectType) objc.Object {
        return value._id;
    }

    pub inline fn objectIdOrNull(comptime ObjectType: type, value: ?ObjectType) ?objc.Object {
        return if (value) |v| v._id else null;
    }

    pub inline fn noConversion(comptime NativeType: type, value: NativeType) NativeType {
        return value;
    }

    pub inline fn wrapObject(comptime ObjectType: type, id: objc.Object) ObjectType {
        return .{
            ._id = id,
        };
    }

    pub inline fn wrapOptionalObject(comptime ObjectType: type, id: ?objc.Object) ?ObjectType {
        return if (id != null) .{ ._id = id.?, } else null;
    }

    // pub inline fn wrapDelegate(comptime DelegateType: type, allocator: std.mem.Allocator, id: objc.Object, handler: DelegateType.Handler) !*DelegateType {
    //     var obj = try allocator.create(DelegateType);
    //     obj.* = .{
    //         ._allocator = allocator,
    //         ._id = id,
    //         ._handler = handler,
    //     };
    //     return obj;
    // }

    pub inline fn releaseObject(comptime ObjectType: type, target: *ObjectType) void {
        target._allocator.destroy(target);
    }

    pub inline fn wrapEnum(comptime EnumType: type, comptime UnderlyingType: type, v: UnderlyingType) EnumType {
        return .{ ._value = v };
    }

    pub inline fn unwrapEnum(comptime EnumType: type, comptime UnderlyingType: type, v: EnumType) UnderlyingType {
        return v._value;
    }

    pub inline fn packOptions(comptime EnumOptionType: type, v: EnumOptionType) runtime.NSUInteger {
        return v.bits.mask;
    }

    pub inline fn wrapOptionalObjectId(id: ?objc.c.id) ?objc.Object {
        return if (id) |x| .{ .value = x } else null;
    }

    pub inline fn unwrapOptionalObjectId(obj: ?objc.Object) objc.c.id {
        return if (obj) |x| x.value else null;
    }

    pub inline fn unwrapOptionalSelValue(sel: ?objc.Sel) objc.c.SEL {
        return if (sel) |x| x.value else null;
    }

    pub inline fn wrapDelegateHandler(handler: anytype) objc.c.IMP {
        return @ptrCast(handler);
    }

    pub inline fn isCategory(comptime DesiredType: type) bool {
        const fields = std.meta.fields(DesiredType);

        inline for (fields) |field| {
            if (std.mem.eql(u8, field.name, "_id")) return false;
        }

        return true;
    }

    pub fn ObjectUpperCast(comptime ObjectType: type, comptime ConstructorType: fn (comptime type) type) type {
        return struct {
            pub inline fn as(self: ObjectType, comptime DesiredType: type) DesiredType {
                comptime constraint: {
                    if (ObjectType.Support.inheritFrom(DesiredType)) {
                        break :constraint;
                    }
                    if (ObjectType.Support.protocolFrom(DesiredType)) {
                        break :constraint;
                    }
                    @compileError("Unsupported associated type: " ++ @typeName(DesiredType));
                }
                return runtime.wrapObject(DesiredType, self._id);
            }

            pub inline fn with(self: ObjectType, comptime DesiredType: type) [1]DesiredType {
                return [1]DesiredType{self.as(DesiredType)};
            }

            pub inline fn of(comptime DesiredType: type) type {
                comptime constraint: {
                    if (DesiredType.Support.inheritFrom(ObjectType)) {
                        break :constraint;
                    }
                    @compileError("Unsupported associated type: " ++ @typeName(DesiredType));
                }
                return ConstructorType(DesiredType);
            }
        };
    }

    pub fn CategoryUpperCast(comptime CategoryType: type, comptime ConstructorType: fn (comptime type) type) type {
        return struct {
            pub inline fn of(comptime DesiredType: type) type {
                comptime constraint: {
                    if (DesiredType.Support.inheritFrom(CategoryType.Self)) {
                        break :constraint;
                    }
                    @compileError("Unsupported associated type: " ++ @typeName(DesiredType));
                }
                return ConstructorType(DesiredType);
            }
        };
    }
};