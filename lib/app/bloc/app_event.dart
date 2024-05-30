part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

final class _AppStatusChanged extends AppEvent {
  const _AppStatusChanged(this.status);
  final AuthStatus status;
}
