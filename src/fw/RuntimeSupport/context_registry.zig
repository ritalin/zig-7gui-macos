const objc = @import("objc");
const runtime = @import("Runtime");

pub fn ContextReg(comptime ContextType: type) type {
    return struct {
        pub fn context(object: objc.Object) ?*ContextType {
            var proxy = runtime.backend_support.ObjectProxy.init(object);
            return proxy.field("context").asPointer(*ContextType);
        }
        
        pub fn setContext(object: objc.Object, _context: *ContextType) void {
            var proxy = runtime.backend_support.ObjectProxy.init(object);
            proxy.field("context").setAsPointer(*ContextType, _context);
        }
    };
}