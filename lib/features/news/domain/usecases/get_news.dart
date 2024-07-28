// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:pingolearn/core/error/failures.dart';
import 'package:pingolearn/core/usecase/usecase.dart';
import 'package:pingolearn/features/news/data/article_model/article.dart';
import 'package:pingolearn/features/news/domain/repository/news_repository.dart';

class GetNews implements UseCase<List<Article>, GetNewsParams> {
  final NewsRepository newsRepository;
  GetNews(this.newsRepository);
  @override
  Future<Either<Failure, List<Article>>> call(GetNewsParams params) async {
    return await newsRepository.fetchNews(countryCode: params.countryCode);
  }
}

class GetNewsParams {
  final String countryCode;
  GetNewsParams({
    required this.countryCode,
  });
}
