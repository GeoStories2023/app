part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthLoginInitial extends AuthState {}

class AuthLoginInProgress extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLoginFailure extends AuthState {}

class AuthLogoutInProgress extends AuthState {}

class AuthLogoutSuccess extends AuthState {}

class AuthLogoutFailure extends AuthState {}

class AuthAutoLoginInProgress extends AuthState {}

class AuthAutoLoginSuccess extends AuthState {}

enum RegisterError {
  passwordMatch,
  emailExists,
}

class AuthEmailRegisterFailure extends AuthState {
  RegisterError error;

  AuthEmailRegisterFailure(this.error);
}
