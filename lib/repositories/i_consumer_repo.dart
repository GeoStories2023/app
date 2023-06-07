import 'package:geostories/bloc/models/achievement.dart';
import 'package:geostories/bloc/models/consumer_friend.dart';
import 'package:geostories/bloc/models/consumer_statistics.dart';
import 'package:geostories/bloc/models/story.dart';

abstract class IConsumerRepo {
  /// Get [ConsumerStats] for the current user.
  /// If [uid] is passed it will get the statistics of that user.
  /// otherwise will get stats of current user.
  Future<ConsumerStats> getConsumerStatistics({String? uid});

  /// Get a list of [Achievement] for the current user.
  /// If [uid] is passed it will get the achievements of that user.
  /// otherwise will get achievements of current user.
  Future<List<Achievement>> getAchievements({String? uid});

  /// Get the name for the current user.
  Future<String> getName();

  /// Check wether or not the user has to change their name.
  Future<bool> hasToChangeName();

  /// Set the current users name to [name].
  Future changeName(String name);

  /// Get a list of [ConsumerFriend] for the current user.
  Future<List<ConsumerFriend>> getFriends();

  /// Get a list of [StartedStory] for the current user.
  Future<List<StartedStory>> getStartedStories();

  /// Add [username] as a friend for the current user.
  Future addFriend(String username);

  /// [true] if the user is premium [false] if not.
  /// If [uid] is passed it will check the premium status of the corresponding user.
  /// otherwise will check premium status of current user.
  Future<bool> isPremium({String? uid});

  /// Get the level of the user.
  /// If [uid] is set, will return the level of that user,
  /// otherwise will check premium status of current user.
  Future<int> getLevel({String? uid});
}
