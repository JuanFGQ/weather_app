// To parse this JSON data, do
//
//     final savedNewsResponse = savedNewsResponseFromJson(jsonString);

import 'dart:convert';

SavedNewsModel savedNewsResponseFromJson(String str) =>
    SavedNewsModel.fromJson(json.decode(str));

String savedNewsResponseToJson(SavedNewsModel data) =>
    json.encode(data.toJson());

class SavedNewsModel {
  int? id;
  String title;
  String url;
  String urlToImage;

  SavedNewsModel({
    this.id,
    required this.title,
    required this.url,
    required this.urlToImage,
  });

  factory SavedNewsModel.fromJson(Map<String, dynamic> json) => SavedNewsModel(
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
