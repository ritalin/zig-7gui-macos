pub const Errors = struct {
    pub const RuntimeError = error{
        InstanciationFailed,
        ObjectRegistrationFailed,
        DelegateInvocationFailed,
    };
};
