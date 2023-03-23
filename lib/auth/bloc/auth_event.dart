part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthLogoutPressed extends AuthEvent {}

class AuthLoginGooglePressed extends AuthEvent {
  const AuthLoginGooglePressed();
}

class AuthLoginEmailPressed extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEmailPressed(this.email, this.password);
}

class _WaitForLogin extends AuthEvent {}

class _WaitForLogout extends AuthEvent {}

class AuthAutoLogin extends AuthEvent {}
