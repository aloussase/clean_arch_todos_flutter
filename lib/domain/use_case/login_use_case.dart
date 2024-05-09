import 'package:fpdart/fpdart.dart';

import '../repository/auth_repository.dart';

enum LoginError {
  usernameIsEmpty,
  passwordIsEmpty,
  serverError,
}

final class LoginUseCase {
  final AuthRepository _auth;

  LoginUseCase(this._auth);

  Future<Either<LoginError, String>> call(
    String username,
    String password,
  ) async {
    if (username.isEmpty) {
      return Either.left(LoginError.usernameIsEmpty);
    }

    if (password.isEmpty) {
      return Either.left(LoginError.passwordIsEmpty);
    }

    final accessToken = await _auth.login(username, password);

    if (accessToken == null) {
      return Either.left(LoginError.serverError);
    }

    return Either.right(accessToken);
  }
}
