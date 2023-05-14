import 'package:weather/models/news/news_response.dart';

class Article {
  Source source;
  String? author;
  String title;
  String description;
  String? url;
  String? urlToImage;
  DateTime publishedAt;
  String? content;

  Article({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: (json["author"] != null) ? json["author"] : '',
        title: (json["title"] != null) ? json["title"] : '',
        description: (json["description"] != null) ? json["description"] : '',
        url: (json["url"] != null) ? json["url"] : '',
        urlToImage: (json["urlToImage"] != null) ? json["urlToImage"] : '',
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: (json["content"] != null) ? json["content"] : '',
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}
