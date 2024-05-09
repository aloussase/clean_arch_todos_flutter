import 'package:clean_arch_todos_flutter/data/repository/auth_repository_impl.dart';
import 'package:clean_arch_todos_flutter/domain/repository/auth_repository.dart';
import 'package:clean_arch_todos_flutter/domain/use_case/login_use_case.dart';
import 'package:clean_arch_todos_flutter/ui/viewmodel/login_view_model.dart';
import 'package:get_it/get_it.dart';

import '../ui/viewmodel/snackbar_view_model.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt()));
  getIt.registerSingleton<LoginViewModel>(LoginViewModel(getIt()));

  getIt.registerSingleton<SnackbarViewModel>(SnackbarViewModel());
}
