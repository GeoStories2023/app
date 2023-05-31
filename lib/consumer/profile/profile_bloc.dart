import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geostories/bloc/models/consumer_statistics.dart';

import '../../repositories/i_consumer_repo.dart';

abstract class ProfileEvent {}

class ProfileCitySelected extends ProfileEvent {
  final String name;
  final String imageUrl;

  ProfileCitySelected(this.name, this.imageUrl);
}

class ProfileCityClosed extends ProfileEvent {}

class ProfileStatisticsLoaded extends ProfileEvent {}

class ProfileNameLoaded extends ProfileEvent {}

abstract class ProfileState {}

class ProfileViewCityDetails extends ProfileState {
  final String name;
  final String imageUrl;

  ProfileViewCityDetails(this.name, this.imageUrl);
}

class ProfileHideCityDetails extends ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileStatisticsLoadInProgress extends ProfileState {}

class ProfileNameLoadSuccess extends ProfileState {
  final String name;

  ProfileNameLoadSuccess(this.name);
}

class ProfileStatisticsLoadError extends ProfileState {}

class ProfileNameLoadError extends ProfileState {}

class ProfileStatisticsLoadSuccess extends ProfileState {
  final ConsumerStats statistics;

  ProfileStatisticsLoadSuccess(this.statistics);
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IConsumerRepo consumerRepo;
  ProfileBloc(this.consumerRepo) : super(ProfileInitial()) {
    on<ProfileCitySelected>(_onCitySelected);
    on<ProfileCityClosed>(_onCityClosed);
    on<ProfileStatisticsLoaded>(_onStatisticsLoaded);
    on<ProfileNameLoaded>(_onNameLoaded);
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

  FutureOr<void> _onStatisticsLoaded(
    ProfileStatisticsLoaded event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileStatisticsLoadInProgress());
      final stats = await consumerRepo.getConsumerStatistics();
      emit(ProfileStatisticsLoadSuccess(stats));
    } catch (e) {
      emit(ProfileStatisticsLoadError());
    }
  }

  FutureOr<void> _onNameLoaded(
    ProfileNameLoaded event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final name = await consumerRepo.getName();
      emit(ProfileNameLoadSuccess(name));
    } catch (e) {
      emit(ProfileNameLoadError());
    }
  }
}
