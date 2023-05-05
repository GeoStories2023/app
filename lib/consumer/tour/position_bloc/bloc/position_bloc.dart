import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  PositionBloc() : super(PositionInitial()) {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    on<InitialPositionRequested>(
      (event, emit) async {
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
          if (position != null) {
            emit(NewPlayerPosition(
                position: LatLng(position.latitude, position.longitude)));
          }
          print(position == null
              ? 'Unknown'
              : '${position.latitude.toString()}, ${position.longitude.toString()}');
        });
        Position pos = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true);
        emit(NewPlayerPosition(position: LatLng(pos.latitude, pos.longitude)));
      },
    );
    add(InitialPositionRequested());
  }
}
