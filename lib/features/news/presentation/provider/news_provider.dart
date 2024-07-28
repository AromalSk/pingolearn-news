import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pingolearn/core/error/failures.dart';
import 'package:pingolearn/features/news/data/article_model/article.dart';
import 'package:pingolearn/features/news/domain/usecases/get_news.dart';

enum NewsState {
  initial,
  loading,
  success,
  failure,
}

class NewsProvider with ChangeNotifier {
  final GetNews _getNews;

  NewsProvider({required GetNews getNews}) : _getNews = getNews;

  NewsState _state = NewsState.initial;
  NewsState get state => _state;

  List<Article>? _news;
  List<Article>? get news => _news;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchNews({required String countryCode}) async {
    _state = NewsState.loading;
    notifyListeners();

    final Either<Failure, List<Article>> res =
        await _getNews(GetNewsParams(countryCode: countryCode));

    res.fold(
      (failure) {
        _state = NewsState.failure;
        _errorMessage = failure.message;
      },
      (news) {
        _state = NewsState.success;
        _news = news;
      },
    );

    notifyListeners();
  }
}
