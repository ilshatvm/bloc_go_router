import 'package:bloc_go_router/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(theme: AppTheme.light));

  void switchTheme() {
    if (state.theme == AppTheme.light) {
      emit(ThemeState(theme: AppTheme.dark));
    } else {
      emit(ThemeState(theme: AppTheme.light));
    }
  }
}
