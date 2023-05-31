import 'dart:convert';
import 'dart:developer';

import 'package:geostories/auth/auth.dart';
import 'package:geostories/bloc/models/consumer_friend.dart';
import 'package:geostories/bloc/models/story.dart';
import 'package:http/http.dart' as http;

import '../bloc/models/achievement.dart';
import '../bloc/models/consumer_statistics.dart';
import 'i_consumer_repo.dart';

class ConsumerRestRepo extends IConsumerRepo {
  final String url;
  final String _consumerStatisticsUrl = '/users/statistics';
  final String _achievementsUrl = '/consumer/achievements';
  final String _nameUrl = '/users';
  final String _friendsUrl = '/consumer/friends';
  final String _startedStoriesUrl = "/consumer/stories/started";

  ConsumerRestRepo(this.url);

  @override
  Future<List<Achievement>> getAchievements() async {
    var uri = Uri.parse(url + _achievementsUrl);
    var resp = await http.get(uri, headers: {
      'Authorization': 'Bearer ${await AuthService().currentUser!.getIdToken()}'
    });
    if (resp.statusCode == 200) {
      List<dynamic> achivementsJson = jsonDecode(resp.body);
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
  Future<ConsumerStats> getConsumerStatistics() async {
    var uid = AuthService().currentUser!.uid;
    var uri = Uri.parse("$url$_consumerStatisticsUrl/$uid");
    var resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await AuthService().currentUser!.getIdToken()}'
    });
    if (resp.statusCode == 200) {
      return ConsumerStats.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to load consumer statistics');
    }
  }

  @override
  Future changeName(String name) async {
    final String uid = AuthService().currentUser?.uid ?? '';
    var uri = Uri.parse('$url$_nameUrl?uid=$uid&name=$name');
    var resp = await http.put(uri, headers: {
      'Authorization': 'Bearer ${await AuthService().currentUser!.getIdToken()}'
    });
    if (resp.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to change name');
    }
  }

  @override
  Future<String> getName() async {
    var uid = AuthService().currentUser!.uid;
    var uri = Uri.parse("$url$_nameUrl/$uid");
    var auth = await AuthService().currentUser!.getIdToken();
    log(auth);
    var resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth'
    });
    if (resp.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(resp.body);
      return json['username'];
    } else {
      throw Exception('Failed to load consumer name');
    }
  }

  @override
  Future<List<ConsumerFriend>> getFriends() async {
    var uri = Uri.parse(url + _friendsUrl);
    var resp = await http.get(uri, headers: {
      'Authorization': 'Bearer ${await AuthService().currentUser!.getIdToken()}'
    });
    if (resp.statusCode == 200) {
      List<dynamic> friendsJson = jsonDecode(resp.body);
      List<ConsumerFriend> friends = [];
      for (var friendJson in friendsJson) {
        friends.add(ConsumerFriend.fromJson(friendJson));
      }
      return friends;
    } else {
      throw Exception('Failed to load friends');
    }
  }

  @override
  Future<List<StartedStory>> getStartedStories() async {
    var uri = Uri.parse(url + _startedStoriesUrl);
    var resp = await http.get(uri, headers: {
      'Authorization': 'Bearer ${await AuthService().currentUser!.getIdToken()}'
    });
    if (resp.statusCode == 200) {
      List<dynamic> json = jsonDecode(resp.body);
      List<StartedStory> stories = [];
      for (var j in json) {
        stories.add(StartedStory.fromJson(j));
      }
      return stories;
    } else {
      throw Exception('Failed to load friends');
    }
  }
}
