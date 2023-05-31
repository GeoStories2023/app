import 'package:geostories/bloc/models/consumer_statistics.dart';
import 'package:geostories/bloc/models/consumer_friend.dart';
import 'package:geostories/bloc/models/achievement.dart';
import 'package:geostories/bloc/models/story.dart';
import 'package:geostories/repositories/i_consumer_repo.dart';

class RuntimeConsumerRepo extends IConsumerRepo {
  String name = "";
  List<Achievement> achievements = [
    const Achievement(name: "nils", description: "something nice"),
    const Achievement(name: "Sterz", description: "something else"),
  ];

  List<StartedStory> startedStories = [
    StartedStory(
      chapterName: "Julius",
      progress: 42,
      storyName: "Justus Ewert",
      storyPictureUrl:
          "https://www.handwerk.com/sites/default/files/styles/max_1300x1300/public/2017-08/hide-pain-harold-title-red%20-web.jpg?itok=xCzsBOrJ",
    ),
    StartedStory(
      chapterName: "Nils",
      progress: 80,
      storyName: "Nils Sterz",
      storyPictureUrl:
          "https://www.handwerk.com/sites/default/files/styles/max_1300x1300/public/2017-08/hide-pain-harold-title-red%20-web.jpg?itok=xCzsBOrJ",
    ),
  ];

  List<ConsumerFriend> friends = [
    const ConsumerFriend(
      uid: "1",
      name: "foo",
      profilePictureUrl:
          "https://www.handwerk.com/sites/default/files/styles/max_1300x1300/public/2017-08/hide-pain-harold-title-red%20-web.jpg?itok=xCzsBOrJ",
    ),
    const ConsumerFriend(
      uid: "2",
      name: "bar",
      profilePictureUrl:
          "https://www.handwerk.com/sites/default/files/styles/max_1300x1300/public/2017-08/hide-pain-harold-title-red%20-web.jpg?itok=xCzsBOrJ",
    ),
  ];

  ConsumerStats statistics = const ConsumerStats(
    gamesPlayed: 12,
    visitedCities: [],
    visitedCountries: [],
    visitedContinents: [],
    collectedDiscounts: 2,
  );

  @override
  Future changeName(String name) async {
    this.name = name;
  }

  @override
  Future<List<Achievement>> getAchievements() async {
    return achievements;
  }

  @override
  Future<ConsumerStats> getConsumerStatistics() async {
    return statistics;
  }

  @override
  Future<List<ConsumerFriend>> getFriends() async {
    return friends;
  }

  @override
  Future<String> getName() async {
    return name;
  }

  @override
  Future<List<StartedStory>> getStartedStories() async {
    return startedStories;
  }

  @override
  Future addFriend(String username) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isPremium({String? uid}) async {
    return false;
  }
}
