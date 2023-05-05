part of 'position_bloc.dart';

abstract class PositionEvent {
  const PositionEvent();
}

class NewPosition extends PositionEvent {
  const NewPosition();
}

class InitialPositionRequested extends PositionEvent {
  const InitialPositionRequested();
}
