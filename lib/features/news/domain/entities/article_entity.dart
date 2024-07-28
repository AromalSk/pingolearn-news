class ArticleEntity {
  final SourceEntity? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  ArticleEntity({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });
}

class SourceEntity {
  final String? id;
  final String? name;

  SourceEntity({this.id, this.name});
}

class ArticleModelEntity {
  final List<ArticleEntity>? articles;

  ArticleModelEntity({this.articles});
}
