abstract class AuthRepository {
  /// Perform login.
  /// @return The access token if successful.
  Future<String?> login(String username, String password);
}
