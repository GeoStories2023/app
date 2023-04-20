import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/auth.dart';
import '../prefs/prefs.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoginInProgress extends SplashState {}

class SplashLoginFailiure extends SplashState {}

class SplashLoginSuccess extends SplashState {}

class SplashAutologinFalse extends SplashState {}

abstract class SplashEvent {}

class SplashStart extends SplashEvent {}

class _Login extends SplashEvent {}

/// Start connecting to the server
class _ConnectToServer extends SplashEvent {}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthBloc authBloc;

  SplashBloc(super.initialState, this.authBloc) {
    on<SplashStart>(_onStart);
    on<_ConnectToServer>(_connectToServer);
    on<_Login>(_onLogin);
  }

  FutureOr<void> _connectToServer(
    _ConnectToServer event,
    Emitter<SplashState> emit,
  ) {}

  FutureOr<void> _onLogin(
    _Login event,
    Emitter<SplashState> emit,
  ) async {
    try {
      emit(SplashLoginInProgress());
      authBloc.add(AuthAutoLogin());
      await for (var state in authBloc.stream) {
        if (state is AuthLoginSuccess) {
          emit(SplashLoginSuccess());
        } else if (state is AuthLoginFailure) {
          emit(SplashLoginFailiure());
        }
      }
    } catch (e) {
      emit(SplashAutologinFalse());
    }
  }

  FutureOr<void> _onStart(
    SplashStart event,
    Emitter<SplashState> emit,
  ) async {
    final method =
        (await PrefsProvider().preferences).getString("signInMethod");
    if (method == "" || method == null) {
      emit(SplashAutologinFalse());
    } else {
      add(_Login());
    }
  }
}
