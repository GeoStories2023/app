import 'dart:convert';

import 'package:http/http.dart' as http;
import '../bloc/models/news.dart';
import 'i_news_repo.dart';

class NewsRestRepo extends INewsRepo {
  final String url;
  final String _newsEndpoint = '/news';

  NewsRestRepo(this.url);

  @override
  Future<List<News>> getNews() async {
    var response = await http.get(Uri.parse(url + _newsEndpoint));
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
