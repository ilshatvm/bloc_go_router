import 'package:auth_repository/auth_repository.dart';
import 'package:bloc_go_router/app/app.dart';
import 'package:bloc_go_router/router/router.dart';
import 'package:bloc_go_router/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc(context.read<AuthRepository>()),
          ),
          BlocProvider(create: (context) => ThemeCubit()),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: state.theme,
          routerConfig: AppRouter(bloc: context.read<AppBloc>()).router,
        );
      },
    );
  }
}
