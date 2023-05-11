import 'dart:convert';

import 'package:geostories/auth/auth.dart';
import 'package:http/http.dart' as http;

import '../bloc/models/achievement.dart';
import '../bloc/models/consumer_statistics.dart';
import 'i_consumer_repo.dart';

class ConsumerRestRepo extends IConsumerRepo {
  final String url;
  final String _consumerStatisticsUrl = '/consumer/statistics';
  final String _achievementsUrl = '/consumer/achievements';
  final String _changeNameUrl = '/consumer/changeName';

  ConsumerRestRepo(this.url);

  @override
  Future<List<Achievement>> getAchievements() async {
    var response = await http.get(Uri.parse(url + _achievementsUrl));
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
  }

  @override
  Future<ConsumerStatistics> getConsumerStatistics() async {
    var response = await http.get(Uri.parse(url + _consumerStatisticsUrl));
    if (response.statusCode == 200) {
      return ConsumerStatistics.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load consumer statistics');
    }
  }

  @override
  Future changeName(String name) async {
    final String uid = AuthService().currentUser?.uid ?? '';
    var response =
        await http.put(Uri.parse('$url$_changeNameUrl?uid=$uid&name=$name'));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to change name');
    }
  }
}
