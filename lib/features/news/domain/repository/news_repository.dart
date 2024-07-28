import 'package:fpdart/fpdart.dart';
import 'package:pingolearn/core/error/failures.dart';
import 'package:pingolearn/features/news/data/article_model/article.dart';

abstract interface class NewsRepository {
  Future<Either<Failure, List<Article>>> fetchNews(
      {required String countryCode});
}
