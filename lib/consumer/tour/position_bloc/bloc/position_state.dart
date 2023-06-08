part of 'position_bloc.dart';

abstract class PositionState {
  const PositionState();

  List<Object> get properties => [];
}

class PositionInitial extends PositionState {}

class NewPlayerPosition extends PositionState {
  final LatLng position;
  const NewPlayerPosition({required this.position});

  @override
  List<Object> get properties => [position];
}

class StreamStarted extends PositionState {
  final Stream<Position> positionStream;
  const StreamStarted({required this.positionStream});

  @override
  List<Object> get properties => [positionStream];
}
