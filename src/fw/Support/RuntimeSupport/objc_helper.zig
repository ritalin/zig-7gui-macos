const objc = @import("objc");

extern "c" fn objc_retain(objc.c.id) objc.c.id;
extern "c" fn objc_release(objc.c.id) void;

pub fn retain(self: objc.Object) objc.Object {
    return objc.Object.fromId(objc_retain(self.value));
}

pub fn release(self: objc.Object) void {
    objc_release(self.value);
}
