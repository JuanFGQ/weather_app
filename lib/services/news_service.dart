import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/news/articles_info.dart';
import 'package:weather/models/news/news_response.dart';

class NewsService with ChangeNotifier {
  Article? articles;
  List<Article> listArticles = [];

  final String _baseUrl = 'https://newsapi.org';
  final String _apiKey = '2a9b8b7fb27348e8a959c3d43b8fc3e1';

  // String _selectedCathegory = 'general';

//   List<Article> headLines = [];

//   List<NewsCategory> categories = [
//     NewsCategory(FontAwesomeIcons.building, 'business'),
//     NewsCategory(FontAwesomeIcons.tv, 'entertainment'),
//     NewsCategory(FontAwesomeIcons.addressCard, 'general'),
//     NewsCategory(FontAwesomeIcons.headSideVirus, 'health'),
//     NewsCategory(FontAwesomeIcons.vials, 'science'),
//     NewsCategory(FontAwesomeIcons.volleyball, 'sports'),
//     NewsCategory(FontAwesomeIcons.memory, 'technology'),
//   ];
//   Map<String, List<Article>> categotyArticles = {};

// //constructor
//   NewsService();

//   get selectCategory => this._selectedCathegory;
//   set selectedCathegory(value) {
//     _selectedCathegory = value;
//   }

//   List<Article>? get getArticlesBySelectedCategory =>
//       categotyArticles[selectCategory];

//       getTopHeadLines() async {

//       }

  getNoticeByQuert(String city) async {
    _apiParams() {
      return {'apiKey': _apiKey, 'q': city};
    }

    final uri = Uri.https(_baseUrl, '/v2/everything', _apiParams());

    final resp = await http.get(uri);

    if (resp.statusCode == 200) {
      final newsResp = newsResponseFromJson(resp.body);

      listArticles.addAll(newsResp.articles);

      return true;
    } else {
      return false;
    }
  }
}
