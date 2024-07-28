import 'package:fpdart/fpdart.dart';
import 'package:pingolearn/core/error/exceptions.dart';
import 'package:pingolearn/core/error/failures.dart';
import 'package:pingolearn/features/news/data/article_model/article.dart';
import 'package:pingolearn/features/news/data/datasources/api_remote_datasource.dart';
import 'package:pingolearn/features/news/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ApiRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Article>>> fetchNews(
      {required String countryCode}) async {
    try {
      final news = await remoteDataSource.fetchNews(countryCode: countryCode);

      return right(news);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
