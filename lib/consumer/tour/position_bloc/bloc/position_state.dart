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
