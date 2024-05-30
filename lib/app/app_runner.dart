import 'package:bloc_go_router/app/app.dart';
import 'package:bloc_go_router/app/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRunner {
  Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = const AppBlocObserver();
    runApp(const App());
  }
}
