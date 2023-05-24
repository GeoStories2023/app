import 'package:geostories/bloc/models/achievement.dart';
import 'package:geostories/bloc/models/consumer_statistics.dart';

abstract class IConsumerRepo {
  Future<ConsumerStatistics> getConsumerStatistics();

  Future<List<Achievement>> getAchievements();

  Future changeName(String name);
}
