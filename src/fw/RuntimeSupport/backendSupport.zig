const std = @import("std");
const objc = @import("objc");

const Class = objc.Class;
const Object = objc.Object;
const Protocol = objc.c.protocol;

const Selectors = struct {
    var _sel_alloc: ?objc.Sel = null;
    var _sel_init: ?objc.Sel = null;

    pub fn alloc() objc.Sel {
        if (_sel_alloc == null) {
            _sel_alloc = objc.Sel.registerName("alloc");
        }
        return _sel_alloc.?;
    }

    pub fn init() objc.Sel {
        if (_sel_init == null) {
            _sel_init = objc.Sel.registerName("init");
        }
        return _sel_init.?;
    }

    pub fn dealloc() objc.Sel {
        if (_sel_init == null) {
            _sel_init = objc.Sel.registerName("dealloc");
        }
        return _sel_init.?;
    }
};

pub const DelegateHandler = anyopaque;

pub const ObjectRegistry = struct {
    const BOOL_YES: objc.c.BOOL = 1;

    pub fn newDelegateClass(className: [:0]const u8, protocolName: [:0]const u8) Class {
        var base = objc.getClass("NSObject");
        std.debug.assert(base != null);

        var c = objc.c.objc_allocateClassPair(base.?.value, className, 0);
        std.debug.assert(c != null);

        var p = objc.c.objc_getProtocol(protocolName);
        std.debug.assert((protocolName.len == 0) or (p != null));

        var res = objc.c.class_addProtocol(c, p);
        std.debug.assert(res == BOOL_YES);

        return Class{ .value = c };
    }

    pub fn registerMessage(class: Class, name: [:0]const u8, method: objc.c.IMP, typeEncoding: [:0]const u8) void {
        var selector = objc.Sel.registerName(name);
        std.debug.assert(selector.value != null);

        var ret = objc.c.class_replaceMethod(class.value, selector.value, method, typeEncoding);
        _ = ret;
    }

    pub fn registerField(class: Class, comptime FieldType: type, field_name: [:0]const u8) void {
        const type_size = @sizeOf(FieldType);
        const alignmemnt = @alignOf(FieldType);
        const encoding = std.fmt.comptimePrint("{}", .{objc.Encoding.init(FieldType)});

        registerFieldInternal(class, field_name, type_size, alignmemnt, encoding);
        // var ret = objc.c.class_addIvar(class.value, type_name, type_size, alignmemnt, encoding);
        // std.debug.assert(ret == BOOL_YES);
    }
    pub fn registerFieldInternal(class: Class, field_name: [:0]const u8, type_size: usize, alignmemnt: u8, encoding: [:0]const u8) void {
        var ret = objc.c.class_addIvar(class.value, field_name, type_size, alignmemnt, encoding);
        std.debug.assert(ret == BOOL_YES);
    }

    pub fn registerClass(class: Class) void {
        objc.c.objc_registerClassPair(class.value);
    }
};

pub fn concreteTypeName(comptime base_type_name: []const u8, comptime suffix: []const u8) [:0]const u8 {
    return std.mem.sliceTo(base_type_name ++ suffix ++ &[_:0]u8{0}, 0);
}

pub inline fn newInstance(class: Class) Object {
    var alloc = allocInstance(class);
    std.debug.assert(alloc.value != null);

    return alloc.msgSend(Object, Selectors.init(), .{});
}

pub inline fn allocInstance(class: Class) Object {
    return class.msgSend(Object, Selectors.alloc(), .{});
}

pub inline fn destroyInstance(id: Object) void {
    id.msgSend(void, Selectors.dealloc(), .{});
}

pub fn isSameId(lhs: ?objc.Object, rhs: ?objc.Object) bool {
    if (lhs == null) return false;
    if (rhs == null) return false;

    return lhs.?.value == rhs.?.value;
}


pub const ObjectProxy = struct {
    object: objc.Object, 

    pub fn init(object: objc.Object) ObjectProxy {
        return .{ .object = object };
    }

    pub fn field(self: ObjectProxy, field_name: [:0]const u8) FieldProxy {
        return .{
            .owner = self,
            .field_name = field_name,
        };
    }

    pub const FieldProxy = struct {
        owner: ObjectProxy,
        field_name: [:0]const u8,

        pub fn asObject(self: FieldProxy) objc.Object {
            return self.owner.object.getIVar(self.field_name);
        }

        pub fn setAsObject(self: FieldProxy, value: objc.Object) objc.Object {
            return self.owner.object.setIVar(self.field_name, value);
        }

        pub fn asPointer(self: FieldProxy, comptime ReturnType: type) ?ReturnType {
            std.debug.assert(@typeInfo(ReturnType) == .Pointer);
            
            var out_value: ?*anyopaque = undefined;
            _ = objc.c.object_getInstanceVariable(self.owner.object.value, self.field_name, &out_value);
            
            if (out_value == null) return null;
            
            return @as(ReturnType, @ptrCast(@alignCast(out_value)));
        }

        pub fn setAsPointer(self: FieldProxy, comptime ReturnType: type, value: ReturnType) void {
            std.debug.assert(@typeInfo(ReturnType) == .Pointer);
            std.debug.assert(@TypeOf(value) == ReturnType);
            
            _ = objc.c.object_setInstanceVariable(self.owner.object.value, self.field_name, @constCast(value));
        }
    };
};
