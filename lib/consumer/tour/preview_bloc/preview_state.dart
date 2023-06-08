part of 'preview_bloc.dart';

@immutable
abstract class PreviewState {
  const PreviewState();

  List<Object> get properties => [];
}

class PreviewInitial extends PreviewState {}

class PreviewLoaded extends PreviewState {
  final TourData data;
  const PreviewLoaded({required this.data});

  @override
  List<Object> get properties => [data];
}
