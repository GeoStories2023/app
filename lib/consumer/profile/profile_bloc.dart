import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geostories/bloc/models/consumer_friend.dart';
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

class ProfileFriendsLoaded extends ProfileEvent {}

class ProfileLevelLoaded extends ProfileEvent {}

class ProfileFriendsAdded extends ProfileEvent {
  final String username;

  ProfileFriendsAdded(this.username);
}

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

class ProfileLevelLoadSuccess extends ProfileState {
  final int level;

  ProfileLevelLoadSuccess(this.level);
}

class ProfileLevelLoadInProgress extends ProfileState {}

class ProfileLevelLoadInError extends ProfileState {}

class ProfileFriendsLoadInProgress extends ProfileState {}

class ProfileFriendsLoadSuccess extends ProfileState {
  final List<ConsumerFriend> friends;

  ProfileFriendsLoadSuccess(this.friends);
}

class ProfileFriendsLoadError extends ProfileState {}

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
    on<ProfileFriendsLoaded>(_onFriendsLoaded);
    on<ProfileFriendsAdded>(_onFriendsAdded);
    on<ProfileLevelLoaded>(_onLevelLoaded);
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

  FutureOr<void> _onFriendsLoaded(
    ProfileFriendsLoaded event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileFriendsLoadInProgress());
      final friends = await consumerRepo.getFriends();
      emit(ProfileFriendsLoadSuccess(friends));
    } catch (e) {
      emit(ProfileFriendsLoadError());
    }
  }

  FutureOr<void> _onFriendsAdded(
    ProfileFriendsAdded event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await consumerRepo.addFriend(event.username);
    } catch (e) {
      emit(ProfileFriendsLoadError());
    }
  }

  FutureOr<void> _onLevelLoaded(
    ProfileLevelLoaded event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLevelLoadInProgress());
      var level = await consumerRepo.getLevel();
      emit(ProfileLevelLoadSuccess(level));
    } catch (e) {
      emit(ProfileFriendsLoadError());
    }
  }
}
