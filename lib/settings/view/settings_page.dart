import 'package:bloc_go_router/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.read<AppBloc>().add(const AppLogoutRequested());
          },
          child: const Text("LogOut"),
        ),
      ),
    );
  }
}
