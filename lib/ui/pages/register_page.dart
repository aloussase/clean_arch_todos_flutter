import 'dart:async';

import 'package:clean_arch_todos_flutter/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../viewmodel/register_view_model.dart';
import '../viewmodel/snackbar_view_model.dart';

class RegisterPage extends StatefulWidget {
  final NavigatorState navigator;

  const RegisterPage({required this.navigator, super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final StreamSubscription _snackbarSubscription;
  late final StreamSubscription _errorsSubscription;

  @override
  void initState() {
    super.initState();

    _snackbarSubscription = context.read<SnackbarViewModel>().messages.listen(
      (message) {
        final snackbar = SnackBar(content: Text(message));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
    );

    _errorsSubscription = context.read<RegisterViewModel>().errors.listen(
      (error) {
        context
            .read<SnackbarViewModel>()
            .add(OnSnackbarMessage(message: error));
      },
    );
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
        title: const Text("Register"),
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
                  "Register",
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
                  context
                      .read<RegisterViewModel>()
                      .add(OnUsernameChanged(value));
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
                  context
                      .read<RegisterViewModel>()
                      .add(OnPasswordChanged(value));
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
                  context.read<RegisterViewModel>().add(OnRegister());
                },
                child: const Text("Register"),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      widget.navigator.push(
                        MaterialPageRoute(
                          builder: (_) =>
                              LoginPage(navigator: widget.navigator),
                        ),
                      );
                    },
                    child: const Text("Login"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
