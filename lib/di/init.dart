import 'package:clean_arch_todos_flutter/data/repository/auth_repository_impl.dart';
import 'package:clean_arch_todos_flutter/domain/repository/auth_repository.dart';
import 'package:clean_arch_todos_flutter/domain/use_case/login_use_case.dart';
import 'package:clean_arch_todos_flutter/ui/viewmodel/auth_view_model.dart';
import 'package:clean_arch_todos_flutter/ui/viewmodel/login_view_model.dart';
import 'package:get_it/get_it.dart';
import "package:http/http.dart" as http;
import 'package:http/http.dart';

import '../ui/viewmodel/snackbar_view_model.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Client>(http.Client());

  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(httpClient: getIt()),
  );

  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt()));
  getIt.registerSingleton<LoginViewModel>(LoginViewModel(getIt()));

  getIt.registerSingleton<SnackbarViewModel>(SnackbarViewModel());

  getIt.registerLazySingleton<AuthViewModel>(
    () => AuthViewModel(authRepository: getIt()),
  );
}
