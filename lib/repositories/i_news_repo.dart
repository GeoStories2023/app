import '../bloc/models/news.dart';

abstract class INewsRepo {
  Future<List<News>> getNews();
}
