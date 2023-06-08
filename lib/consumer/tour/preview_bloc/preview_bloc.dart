import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geostories/consumer/tour/models/tour_point.dart';
import 'package:latlong2/latlong.dart';

import '../models/tour_data.dart';
import '../repositories/i_map_repo.dart';
part 'preview_event.dart';
part 'preview_state.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  final IMapRepo repo;
  late LatLng position;
  final PopupController popupLayerController = PopupController();

  PreviewBloc(this.repo) : super(PreviewInitial()) {
    on<LoadPreview>(_onLoadPreview);
  }

  FutureOr<void> _onLoadPreview(
    LoadPreview event,
    Emitter<PreviewState> emit,
  ) async {
    //TourData data = await repo.getTour('4e4be34b-6b96-4af0-8e2b-f26d8276e558');
    TourData data = TourData(
        id: "123",
        tourPoints: [
          TourPoint(
              id: "5",
              name: "Yeet",
              type: TourPointType.shop,
              pos: LatLng(10, 50),
              description: "description",
              marker: Marker(
                width: 20,
                height: 20,
                point: LatLng(10, 50),
                anchorPos: AnchorPos.align(AnchorAlign.center),
                builder: (ctx) => const Icon(
                  Icons.abc,
                  size: 20,
                ),
              )),
          TourPoint(
              id: "3",
              name: "Yeet2",
              type: TourPointType.shop,
              pos: LatLng(50, 8),
              description: "description",
              marker: Marker(
                width: 20,
                height: 20,
                point: LatLng(50, 8),
                anchorPos: AnchorPos.align(AnchorAlign.center),
                builder: (ctx) => const Icon(
                  Icons.abc,
                  size: 20,
                ),
              ))
        ],
        name: "test",
        description: "test",
        xp: 1,
        city: "bremen");
    emit(
      PreviewLoaded(
        data: data,
      ),
    );
  }
}
