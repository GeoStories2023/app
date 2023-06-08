part of 'position_bloc.dart';

abstract class PositionEvent {
  const PositionEvent();
}

class NewPosition extends PositionEvent {
  final LatLng position;
  const NewPosition(this.position);
}

class InitialPositionRequested extends PositionEvent {
  const InitialPositionRequested();
}
