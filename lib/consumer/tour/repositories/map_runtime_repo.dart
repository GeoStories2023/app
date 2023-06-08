import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geostories/consumer/tour/models/started_tour_data.dart';
import 'package:geostories/consumer/tour/models/tour_data.dart';
import 'package:geostories/consumer/tour/repositories/i_map_repo.dart';
import 'package:latlong2/latlong.dart';

import '../models/tour_point.dart';
import '../models/tour_data.dart';

class RuntimeRepo implements IMapRepo {
  @override
  Future<TourData> getTour(String id) async {
    return TourData(
        id: "123",
        tourPoints: [
          TourPoint(
              id: "5",
              name: "Yeet",
              type: TourPointType.shop,
              pos: LatLng(10, 50),
              description:
                  "descrisssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss ssssssssssssption",
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
  }

  @override
  Future<StartedTour> startTour(String id) {
    // TODO: implement startTour
    throw UnimplementedError();
  }

  @override
  Future<StartedTour> setTourpointVisited(
      String startedTourId, String tourPointId) {
    // TODO: implement setTourpointVisited
    throw UnimplementedError();
  }

  @override
  Future<StartedTour> getStartedTour(String id) {
    // TODO: implement getStartedTour
    throw UnimplementedError();
  }

  @override
  Future<List<StartedTour>> getStartedTours() {
    // TODO: implement getStartedTours
    throw UnimplementedError();
  }
}
