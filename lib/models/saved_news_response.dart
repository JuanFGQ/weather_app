// To parse this JSON data, do
//
//     final savedNewsResponse = savedNewsResponseFromJson(jsonString);

import 'dart:convert';

SavedNewsResponse savedNewsResponseFromJson(String str) =>
    SavedNewsResponse.fromJson(json.decode(str));

String savedNewsResponseToJson(SavedNewsResponse data) =>
    json.encode(data.toJson());

class SavedNewsResponse {
  String title;
  String url;
  String urlToImage;

  SavedNewsResponse({
    required this.title,
    required this.url,
    required this.urlToImage,
  });

  factory SavedNewsResponse.fromJson(Map<String, dynamic> json) =>
      SavedNewsResponse(
        title: json["title"],
        url: json["url"],
        urlToImage: json["urlToImage"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "urlToImage": urlToImage,
      };
}
