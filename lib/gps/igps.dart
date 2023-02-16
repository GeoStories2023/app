import 'package:geolocator/geolocator.dart';

/// Interface for all classes providing GPS access.
abstract class IGps {
  /// Get the [Position] [Stream]
  Stream<Position> get gpsStream;

  /// Start a gps listener which adds [Position] every [int] meterDistance traveled.
  void startDistanceStream({int meterDistance});

  /// Start a gps listener which adds [Position] every [Duration] duration.
  void startTimedStream(Duration duration);

  /// Get the current [Position].
  Future<Position> get currentPosition;
}
