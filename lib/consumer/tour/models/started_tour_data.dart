import 'package:geostories/consumer/tour/models/tour_data.dart';

class StartedTour {
  final String id;
  final bool isCompleted;
  final String dateStarted;
  final String dateEnded;
  final TourData tourData;
  final List<String> visitedTourPointIds;

  StartedTour({
    required this.id,
    required this.isCompleted,
    required this.dateStarted,
    required this.dateEnded,
    required this.tourData,
    required this.visitedTourPointIds,
  });

  factory StartedTour.fromJson(Map<String, dynamic> json) {
    String startedTourId = json["id"];
    bool isCompleted = json["isCompleted"];
    String dateStarted = json["dateStarted"];
    //String dateEnded = json["dateEnded"];
    TourData tourData = TourData.fromJson(json["tour"]);
    List<String> visitedTourPointIds = [];
    if (json.keys.contains("visitedTourPoints")) {
      visitedTourPointIds = (json["visitedTourPoints"] as List)
          .map(
            (e) => e["tourPointId"].toString(),
          )
          .toList();
    }

    //visitedTourPoints = json["visitedTourPoints"]
    return StartedTour(
        id: startedTourId,
        isCompleted: isCompleted,
        dateStarted: dateStarted,
        dateEnded: dateStarted,
        tourData: tourData,
        visitedTourPointIds: visitedTourPointIds);
  }
}
