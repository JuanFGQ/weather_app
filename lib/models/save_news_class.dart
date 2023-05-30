import 'dart:convert';

import 'package:flutter/material.dart';

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
}
