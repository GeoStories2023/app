import 'package:geostories/bloc/models/story.dart';

abstract class IStoryRepo {
  /// Get all available [Story].
  Future<List<Story>> getStories();

  /// Get all stories in a [continent].
  /// Optionally get a list of [Story] in a specific [country].
  /// Will return a empty list, if it is not a existing [continent] or [country]
  Future<List<Story>> getStoriesInContinent(String continent, String? country);
}
