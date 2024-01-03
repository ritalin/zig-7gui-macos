const std =  @import("std");
const enumset = @import("sparse-enumset");

pub fn EnumOptions(comptime E: type) type {
    return std.enums.IndexedSet(enumset.SparseEnumIndexer(E), enumset.SparseEnumFlagSet);
}
