import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geostories/repositories/i_consumer_repo.dart';

abstract class SettingsEvent {}

class SettingsLanguageChangeSelected extends SettingsEvent {}

class SettingsLanguageChanged extends SettingsEvent {}

class SettingsPrivacyOptInSelected extends SettingsEvent {}

class SettingsPrivacyOptInFinished extends SettingsEvent {}

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsShowLanguageChange extends SettingsState {}

class SettingsHideLanguageChange extends SettingsState {}

class SettingsShowPrivacyOptIn extends SettingsState {}

class SettingsHidePrivacyOptIn extends SettingsState {}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final IConsumerRepo consumerRepo;

  SettingsBloc(this.consumerRepo) : super(SettingsInitial()) {
    on<SettingsLanguageChangeSelected>(_onLanguageChangeSelected);
    on<SettingsLanguageChanged>(_onLanguageChanged);
    on<SettingsPrivacyOptInSelected>(_onPrivacyOptInSelected);
    on<SettingsPrivacyOptInFinished>(_onPrivacyOptInFinished);
  }

  FutureOr<void> _onLanguageChangeSelected(
    SettingsLanguageChangeSelected event,
    Emitter<SettingsState> emit,
  ) {
    emit(SettingsShowLanguageChange());
  }

  FutureOr<void> _onLanguageChanged(
    SettingsLanguageChanged event,
    Emitter<SettingsState> emit,
  ) {
    emit(SettingsHideLanguageChange());
  }

  FutureOr<void> _onPrivacyOptInFinished(
    SettingsPrivacyOptInFinished event,
    Emitter<SettingsState> emit,
  ) {
    emit(SettingsHideLanguageChange());
  }

  FutureOr<void> _onPrivacyOptInSelected(
    SettingsPrivacyOptInSelected event,
    Emitter<SettingsState> emit,
  ) {
    emit(SettingsShowPrivacyOptIn());
  }
}
