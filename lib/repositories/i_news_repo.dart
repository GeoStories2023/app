import '../bloc/models/news.dart';

abstract class INewsRepo {
  /// Get a list of [News].
  Future<List<News>> getNews();
}
