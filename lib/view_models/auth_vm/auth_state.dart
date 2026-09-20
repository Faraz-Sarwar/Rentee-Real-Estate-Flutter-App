class AuthState {
  final bool isLoading;
  final bool isGoogleSignUpLoading;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.error,
    this.isGoogleSignUpLoading = false,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? isGoogleSignUpLoading,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isGoogleSignUpLoading:
          isGoogleSignUpLoading ?? this.isGoogleSignUpLoading,
      error: error ?? this.error,
    );
  }
}
