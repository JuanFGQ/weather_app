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
  bool isButtonPressed;

  SavedNewsModel(
      {this.id,
      required this.title,
      required this.url,
      required this.urlToImage,
      required this.isButtonPressed});

  factory SavedNewsModel.fromJson(Map<String, dynamic> json) => SavedNewsModel(
      id: json["id"],
      title: json["title"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      isButtonPressed: json["isButtonPressed"] == 1 ? true : false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "urlToImage": urlToImage,
        "isButtonPressed": isButtonPressed
      };
}
