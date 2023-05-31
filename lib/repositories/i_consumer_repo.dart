import 'package:geostories/bloc/models/achievement.dart';
import 'package:geostories/bloc/models/consumer_friend.dart';
import 'package:geostories/bloc/models/consumer_statistics.dart';
import 'package:geostories/bloc/models/story.dart';

abstract class IConsumerRepo {
  /// Get [ConsumerStats] for the current user.
  /// NOTE: Implementation will be responsible for getting the current user.
  Future<ConsumerStats> getConsumerStatistics();

  /// Get a list of [Achievement] for the current user.
  /// NOTE: Implementation will be responsible for getting the current user.
  Future<List<Achievement>> getAchievements();

  /// Get the name for the current user.
  /// NOTE: Implementation will be responsible for getting the current user.
  Future<String> getName();

  /// Set the current users name to [name].
  Future changeName(String name);

  /// Get a list of [ConsumerFriend] for the current user.
  Future<List<ConsumerFriend>> getFriends();

  /// Get a list of [StartedStory] for the current user.
  Future<List<StartedStory>> getStartedStories();
}
