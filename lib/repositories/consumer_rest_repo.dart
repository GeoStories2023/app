import 'dart:convert';

import 'package:http/http.dart' as http;

import '../bloc/models/achievement.dart';
import '../bloc/models/consumer_statistics.dart';
import 'i_consumer_repo.dart';

class ConsumerRestRepo extends IConsumerRepo {
  final String url;
  final String _consumerStatisticsUrl = '/consumer/statistics';
  final String _achievementsUrl = '/consumer/achievements';

  ConsumerRestRepo(this.url);

  @override
  Future<List<Achievement>> getAchievements() {
    return http.get(Uri.parse(url + _achievementsUrl)).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> achivementsJson = jsonDecode(response.body);
        List<Achievement> achievements = [];
        for (var achievementJson in achivementsJson) {
          achievements.add(Achievement.fromJson(achievementJson));
        }
        return achievements;
      } else {
        throw Exception('Failed to load achievements');
      }
    });
  }

  @override
  Future<ConsumerStatistics> getConsumerStatistics() {
    return http.get(Uri.parse(url + _consumerStatisticsUrl)).then((response) {
      if (response.statusCode == 200) {
        return ConsumerStatistics.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load consumer statistics');
      }
    });
  }
}
