import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(const LoginState(status: LoginStatus.initial)) {
    on<LoginWithCredentialsPressed>(_loginWithCredentials);
  }

  Future<void> _loginWithCredentials(
    LoginWithCredentialsPressed event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.logIn(
        username: 'username',
        password: 'password',
      );
      emit(state.copyWith(status: LoginStatus.success));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
