import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/news/articles_info.dart';
import 'package:weather/models/news/news_response.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/models/save_news_class.dart';

class NewsService with ChangeNotifier {
  List<SavedNews> savedNewsList = [];

  Article? article;

  bool _activeSearch = false;

  bool get activeSearch => _activeSearch;
  set activeSearch(bool value) {
    _activeSearch = value;
    notifyListeners();
  }

  //*********************************************************** */

  final StreamController<dynamic> _streamHomePage =
      StreamController<dynamic>.broadcast();

  Stream get streamHomePage => _streamHomePage.stream;
  //*********************************************************** */

  final StreamController<dynamic> _streamFoundPage =
      StreamController<dynamic>.broadcast();

  Stream get streamFoundPage => _streamFoundPage.stream;
  //*********************************************************** */

  final String _baseUrl = 'newsapi.org';
  final String _apiKey = '2a9b8b7fb27348e8a959c3d43b8fc3e1';

  Future<void> launcherUrl(BuildContext context, Article news) async {
    final uri = Uri.parse(news.url!);

    if (news.url!.startsWith('http')) {
      if (await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) ;
    } else {
      debugPrint('news');
    }
  }

  Future<NewsResponse> getNewsByFoundedPlace(String city) async {
    _apiParams() {
      return {'apiKey': _apiKey, 'q': city, 'language': 'es'};
    }

    final uri = Uri.https(_baseUrl, '/v2/everything', _apiParams());

    final resp = await http.get(uri);

    final newsResp = newsResponseFromJson(resp.body);

    return newsResp;
  }
}
