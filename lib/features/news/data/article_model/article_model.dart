import 'package:json_annotation/json_annotation.dart';

import 'article.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  List<Article>? articles;

  ArticleModel({this.articles});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return _$ArticleModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
