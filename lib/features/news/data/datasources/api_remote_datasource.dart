import 'dart:convert';
import 'package:pingolearn/core/appsecrets/app_secrets.dart';
import 'package:pingolearn/core/error/exceptions.dart';
import 'package:pingolearn/features/news/data/article_model/article.dart';
import 'package:http/http.dart' as http;
import 'package:pingolearn/features/news/data/article_model/article_model.dart';

abstract interface class ApiRemoteDataSource {
  Future<List<Article>> fetchNews({required String countryCode});
}

class ApiRemoteDatasourceImpl implements ApiRemoteDataSource {
  @override
  Future<List<Article>> fetchNews({required String countryCode}) async {
    try {
      final response = await http
          .get(Uri.parse(AppSecrets.getUrl(countryCode: countryCode)));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final articleModel = ArticleModel.fromJson(result);
        return articleModel.articles ?? [];
      } else {
        throw Exception("failed");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
