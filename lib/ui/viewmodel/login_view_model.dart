import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

sealed class LoginEvent {}

final class UsernameChanged extends LoginEvent {
  final String value;
  UsernameChanged(this.value);
}

final class PasswordChanged extends LoginEvent {
  final String value;
  PasswordChanged(this.value);
}

final class LoginState {
  String username;
  String password;

  LoginState({required this.username, required this.password});

  factory LoginState.empty() => LoginState(
        username: "",
        password: "",
      );
}

final class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  LoginViewModel() : super(LoginState.empty()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  FutureOr<void> _onUsernameChanged(
    UsernameChanged evt,
    Emitter<LoginState> emit,
  ) {
    print("Username changed: " + evt.value);
  }

  FutureOr<void> _onPasswordChanged(
    PasswordChanged evt,
    Emitter<LoginState> emit,
  ) {
    print("Password changed: " + evt.value);
  }
}
