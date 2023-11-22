const std = @import("std");

pub usingnamespace @import("./RuntimeSupport/typeConversion.zig").RuntimeTypeConverter;
pub usingnamespace @import("./RuntimeSupport/errors.zig").Errors;

pub const identity_seed = @import("./RuntimeSupport/identitySeed.zig");
pub const backend_support = @import("./RuntimeSupport/backendSupport.zig");

const RuntimeSupport_typeSupport = @import("RuntimeSupport/typeSupport.zig");
pub const typeConstraints = RuntimeSupport_typeSupport.typeConstraints;

pub const ContextReg = @import("./RuntimeSupport/context_registry.zig").ContextReg;

pub const DelegateHandler = anyopaque;

const Runtime_objc = @import("./Runtime/objc/frontend.zig");
pub const BOOL = Runtime_objc.BOOL;

const Runtime_NSObjCRuntime = @import("./Runtime/NSObjCRuntime/frontend.zig");
pub const NSInteger = Runtime_NSObjCRuntime.NSInteger;
pub const NSUInteger = Runtime_NSObjCRuntime.NSUInteger;

const Runtime_NSObject = @import("./Runtime/NSObject/frontend.zig");
pub const NSObject = Runtime_NSObject.NSObject;
pub const NSObjectProtocol = Runtime_NSObject.NSObjectProtocol;
