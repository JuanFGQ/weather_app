import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/news/articles_info.dart';
import 'package:weather/models/news/news_response.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsService with ChangeNotifier {
  Article? onlyArticles;
  Article? foundedArticle;
  List<Article> listArticles = [];

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

  getNewsByQuery(String city) async {
    _apiParams() {
      return {'apiKey': _apiKey, 'q': city};
    }

    final uri = Uri.https(_baseUrl, '/v2/everything', _apiParams());

    final resp = await http.get(uri);

    if (resp.statusCode == 200) {
      final newsResp = newsResponseFromJson(resp.body);

      listArticles.addAll(newsResp.articles);

      // newsResp.;
      return true;
    } else {
      return false;
    }
  }

  getNewsByFoundedPlace(String city) async {
    _apiParams() {
      return {'apiKey': _apiKey, 'q': city};
    }

    final uri = Uri.https(_baseUrl, '/v2/everything', _apiParams());

    final resp = await http.get(uri);

    if (resp.statusCode == 200) {
      final newsResp = newsResponseFromJson(resp.body);

      // listArticles.addAll(newsResp.articles);

      newsResp.articles;
      return true;
    } else {
      return false;
    }
  }
}
