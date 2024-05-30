import 'package:bloc_go_router/theme/app_theme.dart';
import 'package:bloc_go_router/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () => context.read<ThemeCubit>().switchTheme(),
          icon: state.theme == AppTheme.light
              ? const Icon(Icons.dark_mode)
              : const Icon(Icons.light_mode),
        );
      },
    );
  }
}
