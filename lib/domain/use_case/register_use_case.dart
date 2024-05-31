import 'package:fpdart/fpdart.dart';

import '../repository/auth_repository.dart';

enum LoginError {
  usernameIsEmpty,
  passwordIsEmpty,
  serverError,
}

final class RegisterUseCase {
  final AuthRepository _auth;

  RegisterUseCase(this._auth);

  Future<Option<LoginError>> call(
    String username,
    String password,
  ) async {
    if (username.isEmpty) {
      return const Option.of(LoginError.usernameIsEmpty);
    }

    if (password.isEmpty) {
      return const Option.of(LoginError.passwordIsEmpty);
    }

    await _auth.register(username, password);

    return const Option.none();
  }
}
