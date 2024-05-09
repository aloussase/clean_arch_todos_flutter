import 'dart:async';

import 'package:clean_arch_todos_flutter/ui/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../viewmodel/snackbar_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final StreamSubscription _snackbarSubscription;
  late final StreamSubscription _errorsSubscription;

  @override
  void initState() {
    super.initState();

    final loginViewModel = context.read<LoginViewModel>();
    final snackbarViewModel = context.read<SnackbarViewModel>();

    _snackbarSubscription = snackbarViewModel.messages.listen((message) {
      final snackbar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    });

    _errorsSubscription = loginViewModel.errors.listen((error) {
      snackbarViewModel.add(OnSnackbarMessage(message: error));
    });
  }

  @override
  void dispose() {
    super.dispose();

    _snackbarSubscription.cancel();
    _errorsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your username",
                  labelText: "Username",
                ),
                onChanged: (value) {
                  context.read<LoginViewModel>().add(OnUsernameChanged(value));
                },
              ),
              const SizedBox(height: 6),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your password",
                  labelText: "Password",
                ),
                onChanged: (value) {
                  context.read<LoginViewModel>().add(OnPasswordChanged(value));
                },
              ),
              const SizedBox(height: 6),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {
                  context.read<LoginViewModel>().add(OnLogin());
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
