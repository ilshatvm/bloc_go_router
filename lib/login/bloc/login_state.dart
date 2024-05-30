part of 'login_bloc.dart';

enum LoginStatus { initial, submitting, success, error }

final class LoginState extends Equatable {
  const LoginState({required this.status});

  final LoginStatus status;

  LoginState copyWith({LoginStatus? status}) {
    return LoginState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [];
}
