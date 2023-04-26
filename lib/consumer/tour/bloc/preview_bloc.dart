import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../models/tour_data.dart';
import '../repositories/i_map_repo.dart';
part 'preview_event.dart';
part 'preview_state.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  final IMapRepo repo;
  PreviewBloc(this.repo) : super(PreviewInitial()) {
    on<LoadPreview>((event, emit) async {
      TourData data =
          await repo.getTour('4e4be34b-6b96-4af0-8e2b-f26d8276e558');
      emit(PreviewLoaded(data: data));
    });
    add(const LoadPreview());
  }
}
