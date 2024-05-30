import 'package:auth_repository/auth_repository.dart';
import 'package:bloc_go_router/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(context.read<AuthRepository>()),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.read<LoginBloc>().add(LoginWithCredentialsPressed());
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
