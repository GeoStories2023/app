library rhm_gps;

import 'dart:async';
import 'package:geolocator/geolocator.dart';

import 'igps.dart';

class RhmGps implements IGps {
  static final RhmGps _rhmGps = RhmGps._internal();
  final StreamController<Position> _gpsController =
      StreamController.broadcast(sync: false);
  bool distanceStreamStarted = false;

  /// Get access to the GPS Singleton.
  ///
  /// Before using make sure you have the required permissions.
  /// You can use [RhmDevicePermissionManager] for that.
  factory RhmGps() {
    return _rhmGps;
  }

  RhmGps._internal();

  @override
  void startDistanceStream({int meterDistance = 10}) async {
    if (!distanceStreamStarted) {
      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: meterDistance,
      );

      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position position) {
        _gpsController.sink.add(position);
      });
    }
  }

  @override
  Future<Position> get currentPosition async =>
      await Geolocator.getCurrentPosition();

  /// Awaits the current device [Position] and adds it to the gpsPositionStream.
  Future<void> addCurrentPositionToStream() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _gpsController.sink.add(position);
  }

  @override
  Stream<Position> get gpsStream => _gpsController.stream;

  @override
  void startTimedStream(Duration duration) {
    Timer.periodic(duration, (timer) async {
      _gpsController.sink.add(await Geolocator.getCurrentPosition());
    });
  }
}
