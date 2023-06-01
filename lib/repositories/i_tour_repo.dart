import '../consumer/tour/models/tour_info.dart';

abstract class ITourRepo {
  /// Get a list of all available [TourInfo] tours.
  Future<List<TourInfo>> getTours();

  /// Get a list of available tours in the [continent].
  /// Receives optional parameters [country] & [city] which specify the location further.
  Future<List<TourInfo>> getToursForLocation(
    String continent, {
    String? country,
    String? city,
  });

  /// Get a list of all started tours.
  Future<List<TourInfo>> getStarted();
}
