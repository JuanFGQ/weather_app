// To parse this JSON data, do
//
//     final savedNewsResponse = savedNewsResponseFromJson(jsonString);

import 'dart:convert';

SavedNews savedNewsResponseFromJson(String str) =>
    SavedNews.fromJson(json.decode(str));

String savedNewsResponseToJson(SavedNews data) => json.encode(data.toJson());

class SavedNews {
  int id;
  String title;
  String url;
  String urlToImage;

  SavedNews({
    required this.id,
    required this.title,
    required this.url,
    required this.urlToImage,
  });

  factory SavedNews.fromJson(Map<String, dynamic> json) => SavedNews(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        urlToImage: json["urlToImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "urlToImage": urlToImage,
      };
}
