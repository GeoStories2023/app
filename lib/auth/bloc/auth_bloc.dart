import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../prefs/prefs.dart';
import '../auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late Stream<User?> loginStream;

  AuthBloc() : super(AuthLoginInitial()) {
    on<AuthLoginGooglePressed>(_onLoginGooglePressed);
    on<AuthLoginEmailPressed>(_onLoginEmailPressed);
    on<AuthLogoutPressed>(_onLogoutPressed);
    on<AuthRegisterEmailPressed>(_onRegisterEmailPressed);
    on<AuthAutoLogin>(_onAutoLogin);
    on<_WaitForLogin>(_onWaitForLogin);
    on<_WaitForLogout>(_onWaitForLogout);
  }

  FutureOr<void> _onLoginGooglePressed(
    AuthLoginGooglePressed event,
    Emitter<AuthState> emit,
  ) async {
    try {
      AuthService().signInWithGoogle();
      emit(AuthLoginInProgress());
      add(_WaitForLogin());
      PrefsProvider().prefs.setString("signInMethod", "google");
    } catch (e) {
      emit(AuthLoginFailure());
    }
  }

  FutureOr<void> _onLoginEmailPressed(
    AuthLoginEmailPressed event,
    Emitter<AuthState> emit,
  ) async {
    await AuthService().signInWithEmail(event.email, event.password);
    emit(AuthLoginInProgress());
    add(_WaitForLogin());
  }

  FutureOr<void> _onWaitForLogin(
    _WaitForLogin event,
    Emitter<AuthState> emit,
  ) async {
    loginStream = FirebaseAuth.instance.authStateChanges();
    await for (final user in loginStream) {
      if (user != null) {
        emit(AuthLoginSuccess());
      }
    }
  }

  FutureOr<void> _onLogoutPressed(
    AuthLogoutPressed event,
    Emitter<AuthState> emit,
  ) {
    AuthService().signOut();
    GoogleSignIn().disconnect();
    emit(AuthLogoutInProgress());
    add(_WaitForLogout());
  }

  FutureOr<void> _onWaitForLogout(
    _WaitForLogout event,
    Emitter<AuthState> emit,
  ) async {
    loginStream = FirebaseAuth.instance.authStateChanges();
    await for (final _ in loginStream) {
      emit(AuthLogoutSuccess());
      PrefsProvider().prefs.setString("signInMethod", "");
    }
  }

  FutureOr<void> _onAutoLogin(
    AuthAutoLogin event,
    Emitter<AuthState> emit,
  ) async {
    final method =
        (await PrefsProvider().preferences).getString("signInMethod");
    if (method == "google") {
      emit(AuthAutoLoginInProgress());
      add(const AuthLoginGooglePressed());
    }
  }

  FutureOr<void> _onRegisterEmailPressed(
    AuthRegisterEmailPressed event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await AuthService().signUpWithEmail(event.email, event.password);
      add(AuthLoginEmailPressed(event.email, event.password));
    } catch (e) {
      // TODO: Handle error
    }
  }
}
