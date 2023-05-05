part of 'preview_bloc.dart';

abstract class PreviewEvent {
  const PreviewEvent();
}

class LoadPreview extends PreviewEvent {
  const LoadPreview();
}

class NewPosition extends PreviewEvent {
  final Position position;
  const NewPosition({required this.position});
}
