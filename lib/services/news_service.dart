import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/news/articles_info.dart';
import 'package:weather/models/news/news_response.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsService with ChangeNotifier {
  Article? article;

  bool _activeSearch = false;

//flag to change search argument
  bool get activeSearch => _activeSearch;
  set activeSearch(bool value) {
    _activeSearch = value;
    notifyListeners();
  }

  bool _isDisconnected = false;

  bool get isDisconnected => _isDisconnected;

  set isDisconnected(bool value) {
    _isDisconnected = value;
    notifyListeners();
  }

  final String _baseUrl = '';
  final String _apiKey = '';

  Future<void> launcherUrl(Article news) async {
    final uri = Uri.parse(news.url!);

    if (news.url!.startsWith('http')) {
      if (await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {}
    } else {
      debugPrint('news');
    }
  }

  Future<void> launcherUrlString(String news) async {
    final uri = Uri.parse(news);

    if (news.startsWith('http')) {
      if (await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {}
    } else {
      debugPrint('news');
    }
  }

  Future<NewsResponse> getNewsByFoundedPlace(String city, language) async {
    apiParams() {
      return {'apiKey': _apiKey, 'q': city, 'language': language};
    }

    try {
      final uri = Uri.https(_baseUrl, '/v2/everything', apiParams());

      final resp = await http.get(uri);

      isDisconnected = false;

      final newsResp = newsResponseFromJson(resp.body);

      return newsResp;
    } catch (e) {
      isDisconnected = true;
      return NewsResponse(status: 'error', totalResults: 0, articles: []);
    }
  }
}
