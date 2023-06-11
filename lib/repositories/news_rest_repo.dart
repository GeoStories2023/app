import 'dart:convert';

import 'package:http/http.dart' as http;
import '../auth/auth_service.dart';
import '../bloc/models/news.dart';
import 'i_news_repo.dart';

class NewsRestRepo extends INewsRepo {
  final String url;
  final String _apiUrl = "/api/v1";
  final String _newsEndpoint = '/news';

  NewsRestRepo(this.url);

  @override
  Future<List<News>> getNews() async {
    var uri = Uri.parse(url + _apiUrl + _newsEndpoint);
    var auth = await AuthService().currentUser!.getIdToken();
    var response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth'
    });
    if (response.statusCode == 200) {
      List<dynamic> newsJson = jsonDecode(response.body);
      List<News> news = [];
      for (var element in newsJson) {
        news.add(News.fromJson(element));
      }
      return news;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
