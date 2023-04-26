import 'package:flutter_map/flutter_map.dart';

import 'tour_point.dart';

class TourData {
  final String id;
  final String name;
  final String description;
  final int xp;
  final String city;
  final List<TourPoint> tourPoints;
  TourData({
    required this.id,
    required this.name,
    required this.description,
    required this.xp,
    required this.city,
    required this.tourPoints,
  });

  factory TourData.fromJson(Map<String, dynamic> json) {
    List<TourPoint> tourPoints = [];
    for (var tourPointData in json["tourPoints"]) {
      tourPoints.add(TourPoint.fromJson(tourPointData));
    }

    String tourId = json["id"];
    String tourName = json["name"];
    int tourXp = json["xp"];
    String tourDescription = json["description"];

    return TourData(
      id: tourId,
      name: tourName,
      description: tourDescription,
      xp: tourXp,
      city: "city",
      tourPoints: tourPoints,
    );
  }
}
