import '../models/started_tour_data.dart';
import '../models/tour_data.dart';

abstract class IMapRepo {
  Future<TourData> getTour(String id);
  Future<StartedTour> getStartedTour(String id);
  Future<List<StartedTour>> getStartedTours();
  Future<StartedTour> setTourpointVisited(
      String startedTourId, String tourPointId);
  Future<StartedTour> startTour(String id);
}
