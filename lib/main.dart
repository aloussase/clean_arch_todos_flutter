import 'package:clean_arch_todos_flutter/ui/pages/login_page.dart';
import 'package:clean_arch_todos_flutter/ui/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/init.dart' as di;
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
    return MaterialApp(
      title: 'Clean Architecture TODOs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SnackbarViewModel>(create: (_) => _snackBarViewModel),
          BlocProvider<LoginViewModel>(
            create: (_) => _loginViewModel,
          ),
        ],
        child: const LoginPage(),
      ),
    );
  }
}
