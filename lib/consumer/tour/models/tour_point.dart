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
  static Marker createMarker(LatLng position, TourPointType type, Color color) {
    const double markerSize = 30;

    IconData icon;
    switch (type) {
      case TourPointType.shop:
        icon = Icons.location_on;
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
        color: color,
        size: markerSize,
      ),
    );
    return marker;
  }

  factory TourPoint.fromJson(Map<String, dynamic> json) {
    const double markerSize = 30;

    String id = json["id"];
    String name = json["name"];
    TourPointType type =
        json["typeId"] == "84cb833e-77ff-4a60-8a9a-5fa4e743a05a"
            ? TourPointType.shop
            : TourPointType.waypoint;
    print(json);
    String description = json["description"];

    double latitude = double.parse(json["latitude"].toString());
    double longitude = double.parse(json["longitude"].toString());
    LatLng position = LatLng(latitude, longitude);

    Marker marker = createMarker(position, type, Colors.black);

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
