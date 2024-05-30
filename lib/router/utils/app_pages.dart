import 'package:bloc_go_router/home/home.dart';
import 'package:bloc_go_router/login/login.dart';
import 'package:bloc_go_router/settings/settings.dart';
import 'package:flutter/material.dart';

enum AppPAGES { home, login, settings }

extension AppPagesExtension on AppPAGES {
  String get path => switch (this) {
        AppPAGES.home => '/',
        AppPAGES.login => '/login',
        AppPAGES.settings => '/settings',
      };

  String get name => switch (this) {
        AppPAGES.home => 'home',
        AppPAGES.login => 'login',
        AppPAGES.settings => 'settings',
      };

  Widget get page => switch (this) {
        AppPAGES.home => const HomePage(),
        AppPAGES.login => const LoginPage(),
        AppPAGES.settings => const SettingsPage(),
      };
}
