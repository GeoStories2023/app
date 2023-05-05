import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

enum TourPointType { waypoint, shop }

class TourPoint {
  final String id;
  final String name;
  final TourPointType type;
  final LatLng pos;
  final String description;
  final Marker marker;
  TourPoint({
    required this.id,
    required this.name,
    required this.type,
    required this.pos,
    required this.description,
    required this.marker,
  });

  factory TourPoint.fromJson(Map<String, dynamic> json) {
    const double markerSize = 30;

    String id = json["id"];
    String name = "test";
    TourPointType type = TourPointType.shop;
    String description = json["description"];

    double latitude = double.parse(json["latitude"].toString());
    double longitude = double.parse(json["longitude"].toString());
    LatLng position = LatLng(latitude, longitude);

    IconData icon;
    switch (type) {
      case TourPointType.shop:
        icon = Icons.house;
        break;
      case TourPointType.waypoint:
        icon = Icons.pin_drop;
        break;
      default:
        icon = Icons.push_pin;
    }

    Marker marker = Marker(
      width: markerSize,
      height: markerSize,
      point: position,
      anchorPos: AnchorPos.align(AnchorAlign.center),
      builder: (ctx) => Icon(
        icon,
        size: markerSize,
      ),
    );

    return TourPoint(
      id: id,
      name: name,
      type: TourPointType.shop,
      pos: LatLng(latitude, longitude),
      description: description,
      marker: marker,
    );
  }
}
