import 'package:flutter/material.dart';

class SavedNews {
  String url;
  String title;
  String urlToImage;

  SavedNews({required this.title, required this.url, required this.urlToImage});

  factory SavedNews.assignData(Map jsonMap) {
    return SavedNews(
        title: jsonMap['title'],
        url: jsonMap['url'],
        urlToImage: jsonMap['urlToImage']);
  }
}
