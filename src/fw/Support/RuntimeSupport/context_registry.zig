const objc = @import("objc");
const runtime = @import("Runtime");
const runtime_support = @import("Runtime-Support");

pub fn ContextReg(comptime ContextType: type) type {
    return struct {
        pub fn context(object: objc.Object) ?*ContextType {
            var proxy = runtime_support.backend_support.ObjectProxy.init(object);
            return proxy.field("context").asPointer(*ContextType);
        }

        pub fn setContext(object: objc.Object, _context: *ContextType) void {
            var proxy = runtime_support.backend_support.ObjectProxy.init(object);
            proxy.field("context").setAsPointer(*ContextType, _context);
        }
    };
}
