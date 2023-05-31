import 'dart:convert';

import 'package:geostories/bloc/models/story.dart';
import 'package:geostories/repositories/i_story_repo.dart';
import 'package:http/http.dart' as http;

class StoryRestRepo extends IStoryRepo {
  final String url;
  final String _storiesEndpoint = '/stories';

  StoryRestRepo(this.url);

  @override
  Future<List<Story>> getStories() async {
    var response = await http.get(Uri.parse(url + _storiesEndpoint));
    if (response.statusCode == 200) {
      List<dynamic> storiesJson = jsonDecode(response.body);
      List<Story> stories = [];
      for (var element in storiesJson) {
        stories.add(Story.fromJson(element));
      }
      return stories;
    } else {
      return [];
    }
  }

  @override
  Future<List<Story>> getStoriesInContinent(
    String continent,
    String? country,
  ) async {
    var endpoint = "$url/$_storiesEndpoint/$continent";
    if (country != null) {
      endpoint += "/$country";
    }
    var response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> storiesJson = jsonDecode(response.body);
      List<Story> stories = [];
      for (var element in storiesJson) {
        stories.add(Story.fromJson(element));
      }
      return stories;
    } else {
      return [];
    }
  }
}
