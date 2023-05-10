import 'dart:convert';

import 'package:geostories/bloc/models/story.dart';
import 'package:geostories/repositories/i_story_repo.dart';
import 'package:http/http.dart' as http;

class StoryRestRepo extends IStoryRepo {
  final String url;
  final String _storiesEndpoint = '/stories';

  StoryRestRepo(this.url);

  @override
  Future<List<Story>> getStories() {
    return http.get(Uri.parse(url + _storiesEndpoint)).then((response) {
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
    });
  }

  @override
  Future<List<Story>> getStoriesInContinent(String continent, String? country) {
    var endpoint = "$url/$_storiesEndpoint/$continent";
    if (country != null) {
      endpoint += "/$country";
    }
    return http.get(Uri.parse(endpoint)).then((response) {
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
    });
  }
}
