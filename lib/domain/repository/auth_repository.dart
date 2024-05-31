sealed class AuthState {}

final class Unauthenticated extends AuthState {}

final class Authenticated extends AuthState {
  final String accessToken;
  final String username;

  Authenticated({required this.accessToken, required this.username});
}

abstract class AuthRepository {
  /// Current auth state.
  Stream<AuthState> get authState;

  /// Perform login.
  /// @return The access token if successful.
  Future<String?> login(String username, String password);

  /// Perform registration
  Future<void> register(String username, String password);

  /// Dispose of this AuthRepository.
  void dispose() {}
}
