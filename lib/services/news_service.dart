import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/news/articles_info.dart';
import 'package:weather/models/news/news_response.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsService with ChangeNotifier {
  Article? article;

  bool _activeSearch = false;

  bool get activeSearch => _activeSearch;
  set activeSearch(bool value) {
    _activeSearch = value;
    notifyListeners();
  }

  final String _baseUrl = 'newsapi.org';
  final String _apiKey = '2a9b8b7fb27348e8a959c3d43b8fc3e1';

  Future<void> launcherUrl(BuildContext context, Article news) async {
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

  Future<void> launcherUrlString(BuildContext context, String news) async {
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

      if (resp.statusCode == 200) {
        final newsResp = newsResponseFromJson(resp.body);
        return newsResp;
      } else {
        throw Exception('Failed to load data,try again later');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
