import 'dart:convert';

import 'package:geostories/auth/auth.dart';
import 'package:geostories/bloc/models/consumer_friend.dart';
import 'package:http/http.dart' as http;

import '../bloc/models/achievement.dart';
import '../bloc/models/consumer_statistics.dart';
import 'i_consumer_repo.dart';

class ConsumerRestRepo extends IConsumerRepo {
  final String url;
  final String _consumerStatisticsUrl = '/consumer/statistics';
  final String _achievementsUrl = '/consumer/achievements';
  final String _nameUrl = '/consumer/name';
  final String _friendsUrl = '/consumer/friends';

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

  @override
  Future changeName(String name) {
    final String uid = AuthService().currentUser?.uid ?? '';
    return http
        .put(Uri.parse('$url$_nameUrl?uid=$uid&name=$name'))
        .then((response) {
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to change name');
      }
    });
  }

  @override
  Future<String> getName() {
    return http.get(Uri.parse(url + _consumerStatisticsUrl)).then((response) {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load consumer statistics');
      }
    });
  }

  @override
  Future<List<ConsumerFriend>> getFriends() {
    return http.get(Uri.parse(url + _friendsUrl)).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> friendsJson = jsonDecode(response.body);
        List<ConsumerFriend> friends = [];
        for (var friendJson in friendsJson) {
          friends.add(ConsumerFriend.fromJson(friendJson));
        }
        return friends;
      } else {
        throw Exception('Failed to load friends');
      }
    });
  }

}
