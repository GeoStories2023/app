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
  final String _apiUrl = "/api/v1";
  final String _consumerStatisticsUrl = '/users/statistics';
  final String _achievementsUrl = '/consumer/achievements';
  final String _nameUrl = '/users';
  final String _nameChangeUrl = '/users/setUsername';
  final String _premiumCheckUrl = '/users';
  final String _levelUrl = '/users';
  final String _nameChangeRequiredUrl = '/users';
  final String _friendsUrl = '/users';
  final String _frienAddUrl = '/users/friends';
  final String _friendRemoveUrl = '/users/friends';
  final String _startedStoriesUrl = "/consumer/stories/started";

  ConsumerRestRepo(this.url);

  @override
  Future<List<Achievement>> getAchievements({String? uid}) async {
    var uri = Uri.parse(url + _apiUrl + _achievementsUrl);
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
  Future<ConsumerStats> getConsumerStatistics({String? uid}) async {
    var uid_ = uid ?? AuthService().currentUser!.uid;
    var uri = Uri.parse("$url$_apiUrl$_consumerStatisticsUrl/$uid_");
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
    final String uid = AuthService().currentUser!.uid;
    var uri = Uri.parse('$url$_apiUrl$_nameChangeUrl/$uid');
    var resp = await http.put(uri, headers: {
      'Authorization': 'Bearer ${await AuthService().currentUser!.getIdToken()}'
    }, body: {
      'username': name,
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
    var uri = Uri.parse("$url$_apiUrl$_nameUrl/$uid");
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
    var uid = AuthService().currentUser!.uid;
    var uri = Uri.parse("$url$_apiUrl$_friendsUrl/$uid");
    var auth = await AuthService().currentUser!.getIdToken();
    log(auth);
    var resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth'
    });
    if (resp.statusCode == 200) {
      var json = jsonDecode(resp.body);
      List<dynamic> friendsJson = json['friends'];
      List<ConsumerFriend> friends = [];
      for (var j in friendsJson) {
        friends.add(ConsumerFriend.fromJson(j['friendUser']));
      }
      return friends;
    } else {
      throw Exception('Failed to load friends');
    }
  }

  @override
  Future<List<StartedStory>> getStartedStories() async {
    var uri = Uri.parse(url + _apiUrl + _startedStoriesUrl);
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

  @override
  Future addFriend(String username) async {
    var uri = Uri.parse(url + _apiUrl + _frienAddUrl);
    await http.post(uri, headers: {
      'Authorization': 'Bearer ${await AuthService().currentUser!.getIdToken()}'
    }, body: {
      'friendName': username,
    });
  }

  @override
  Future<bool> isPremium({String? uid}) async {
    var uri = Uri.parse(url + _apiUrl + _premiumCheckUrl);
    var resp = await http.get(uri, headers: {
      'Authorization': 'Bearer ${await AuthService().currentUser!.getIdToken()}'
    });
    if (resp.statusCode == 200) {
      var json = jsonDecode(resp.body);
      return json['isPremium'];
    } else {
      throw Exception('Failed to premium status');
    }
  }

  @override
  Future<int> getLevel({String? uid}) async {
    var uri = Uri.parse(url + _apiUrl + _levelUrl);
    var resp = await http.get(uri, headers: {
      'Authorization': 'Bearer ${await AuthService().currentUser!.getIdToken()}'
    });
    if (resp.statusCode == 200) {
      var json = jsonDecode(resp.body);
      return json['xp'];
    } else {
      throw Exception('Failed to premium status');
    }
  }

  @override
  Future<bool> hasToChangeName() async {
    var uri = Uri.parse(url + _apiUrl + _nameChangeRequiredUrl);
    var resp = await http.get(uri, headers: {
      'Authorization': 'Bearer ${await AuthService().currentUser!.getIdToken()}'
    });
    if (resp.statusCode == 200) {
      var json = jsonDecode(resp.body);
      return json['askUsername'];
    } else {
      throw Exception('Failed to check name change');
    }
  }

  @override
  Future removeFriend(String uid) async {
    var uri = Uri.parse("$url$_apiUrl$_friendRemoveUrl/$uid");
    await http.delete(uri, headers: {
      'Authorization': 'Bearer ${await AuthService().currentUser!.getIdToken()}'
    });
  }
}
