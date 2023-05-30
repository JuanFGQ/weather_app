import 'dart:convert';

import 'package:flutter/material.dart';

SavedNewsResponse savedNewsResponseFromJson(String str) =>
    SavedNewsResponse.fromJson(json.decode(str));

String savedNewsResponseToJson(SavedNewsResponse data) =>
    json.encode(data.toJson());

class SavedNewsResponse {
  List<SavedNews> saveN;

  SavedNewsResponse({required this.saveN});

  factory SavedNewsResponse.fromJson(Map<String, dynamic> json) =>
      SavedNewsResponse(
        saveN: List<SavedNews>.from(
            json["saveN"].map((x) => SavedNews.assignData(x))),
      );

  Map<String, dynamic> toJson() =>
      {"saveN": List<dynamic>.from(saveN.map((x) => x.toJson()))};
}

class SavedNews {
  String url;
  String title;
  String urlToImage;

  SavedNews({
    required this.title,
    required this.url,
    required this.urlToImage,
  });

  factory SavedNews.assignData(Map<String, dynamic> json) => SavedNews(
        title: json['title'],
        url: json['url'],
        urlToImage: json['urlToImage'],
      );

  Map<String, dynamic> toJson() =>
      {"title": title, "url": url, "urlToImage": urlToImage};
}
