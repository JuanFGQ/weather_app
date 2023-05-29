import 'package:flutter/material.dart';

class SavedNews {
  String url;
  String title;
  String urlToImage;

  SavedNews({required this.title, required this.url, required this.urlToImage});

  List<String> getSavedNewsInfo() {
    return [url, title, urlToImage];
  }
}
