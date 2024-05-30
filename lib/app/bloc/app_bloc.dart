import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<AuthStatus> _authSubscription;
  AppBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(const AppState.unauthenticated()) {
    on<AppLogoutRequested>(_onLogout);
    on<_AppStatusChanged>(_onAppStatusChanged);
    _authSubscription = _authRepository.status.listen(
      (status) => add(_AppStatusChanged(status)),
    );
  }

  void _onLogout(AppLogoutRequested event, Emitter<AppState> emit) {
    _authRepository.logOut();
    emit(const AppState.unauthenticated());
  }

  void _onAppStatusChanged(_AppStatusChanged event, Emitter<AppState> emit) {
    return switch (event.status) {
      AuthStatus.unknown => emit(const AppState.unauthenticated()),
      AuthStatus.authenticated => emit(const AppState.authenticated()),
      AuthStatus.unauthenticated => emit(const AppState.unauthenticated()),
    };
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
