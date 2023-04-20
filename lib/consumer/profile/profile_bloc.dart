import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProfileEvent {}

class ProfileCitySelected extends ProfileEvent {
  final String name;
  final String imageUrl;

  ProfileCitySelected(this.name, this.imageUrl);
}

class ProfileCityClosed extends ProfileEvent {}

abstract class ProfileState {}

class ProfileViewCityDetails extends ProfileState {
  final String name;
  final String imageUrl;

  ProfileViewCityDetails(this.name, this.imageUrl);
}

class ProfileHideCityDetails extends ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileCitySelected>(_onCitySelected);
    on<ProfileCityClosed>(_onCityClosed);
  }

  FutureOr<void> _onCitySelected(
    ProfileCitySelected event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileViewCityDetails(event.name, event.imageUrl));
  }

  FutureOr<void> _onCityClosed(
    ProfileCityClosed event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileHideCityDetails());
  }
}
