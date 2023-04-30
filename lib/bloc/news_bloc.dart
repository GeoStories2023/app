import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geostories/repositories/i_news_repo.dart';

import 'models/news.dart';

abstract class NewsEvent {}

class NewsLoad extends NewsEvent {}

abstract class NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> news;

  NewsLoaded(this.news);
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final INewsRepo newsRepo;

  NewsBloc(this.newsRepo) : super(NewsLoading()) {
    on<NewsLoad>(_onLoad);
  }

  FutureOr<void> _onLoad(NewsLoad event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final news = await newsRepo.getNews();
    emit(NewsLoaded(news));
  }
}
