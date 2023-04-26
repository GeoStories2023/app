part of 'preview_bloc.dart';

abstract class PreviewEvent {
  const PreviewEvent();
}

class LoadPreview extends PreviewEvent {
  const LoadPreview();
}
