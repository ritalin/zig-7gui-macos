const std = @import("std");

pub fn typeConstraints(comptime TargetType: type, comptime candidates: anytype) bool {
    const CandidateType = @TypeOf(candidates);
    const type_info = @typeInfo(CandidateType);
        
    if (type_info != .Struct) {
        @compileError("candidates is expected tuple. but " ++ @typeName(CandidateType));
    }
    if (! type_info.Struct.is_tuple) {
        @compileError("candidates is expected tuple. but " ++ @typeName(CandidateType));
    }

    const fields = type_info.Struct.fields;

    inline for (fields) |field| {
        if (std.mem.eql(u8, @typeName(TargetType), @typeName(@field(candidates, field.name)))) return true;
    }

    return false;
}