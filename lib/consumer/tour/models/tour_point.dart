import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

enum TourPointType { waypoint, shop }

class TourPoint {
  final String id;
  final TourPointType type;
  final LatLng pos;
  final String description;
  final Marker marker;
  TourPoint({
    required this.id,
    required this.type,
    required this.pos,
    required this.description,
    required this.marker,
  });

  factory TourPoint.fromJson(Map<String, dynamic> json) {
    String id = json["id"];
    double latitude = double.parse(json["latitude"].toString());
    double longitude = double.parse(json["longitude"].toString());
    LatLng position = LatLng(latitude, longitude);
    String description = json["description"];

    Marker marker = Marker(
      width: 30,
      height: 30,
      point: position,
      anchorPos: AnchorPos.align(AnchorAlign.center),
      builder: (ctx) => const Icon(
        Icons.house,
        size: 30,
      ),
    );

    return TourPoint(
      id: id,
      type: TourPointType.shop,
      pos: LatLng(latitude, longitude),
      description: description,
      marker: marker,
    );
  }
}
