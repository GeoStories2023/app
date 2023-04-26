import '../models/tour_data.dart';

abstract class IMapRepo {
  Future<TourData> getTour(String id);
}
