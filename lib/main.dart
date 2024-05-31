import 'package:clean_arch_todos_flutter/ui/pages/splash_page.dart';
import 'package:clean_arch_todos_flutter/ui/viewmodel/login_view_model.dart';
import 'package:clean_arch_todos_flutter/ui/viewmodel/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/init.dart' as di;
import 'domain/repository/auth_repository.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/viewmodel/auth_view_model.dart';
import 'ui/viewmodel/snackbar_view_model.dart';

void main() {
  di.setup();
  runApp(const TodosApp());
}

class TodosApp extends StatefulWidget {
  const TodosApp({super.key});

  @override
  State<StatefulWidget> createState() => _TodosAppState();
}

class _TodosAppState extends State<TodosApp> {
  final SnackbarViewModel _snackBarViewModel = di.getIt();
  final LoginViewModel _loginViewModel = di.getIt();

  @override
  void dispose() {
    super.dispose();
    _snackBarViewModel.dispose();
    _loginViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SnackbarViewModel>(create: (_) => _snackBarViewModel),
        BlocProvider<LoginViewModel>(create: (_) => _loginViewModel),
        BlocProvider<AuthViewModel>(create: (_) => di.getIt()),
        BlocProvider<RegisterViewModel>(create: (_) => di.getIt()),
      ],
      child: const TodosAppView(),
    );
  }
}

final class TodosAppView extends StatefulWidget {
  const TodosAppView({super.key});

  @override
  State<StatefulWidget> createState() => _TodosAppViewState();
}

final class _TodosAppViewState extends State<TodosAppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture TODOs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthViewModel, AuthState>(
          listener: (context, state) {
            switch (state) {
              case Authenticated():
                _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false,
                );
              case Unauthenticated():
                _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => LoginPage(navigator: _navigator),
                  ),
                  (route) => false,
                );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => const SplashPage(),
      ),
    );
  }
}
