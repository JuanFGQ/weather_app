import 'package:flutter/material.dart';
import 'package:weather/models/saved_news_response.dart';
import 'package:weather/providers/db_provider.dart';

class NewsListProvider extends ChangeNotifier {
  List<SavedNewsModel> news = [];
  bool selectedNews = false;

  Future<SavedNewsModel> newSave(String url, title, urlToImage) async {
    final newSave =
        new SavedNewsModel(title: title, url: url, urlToImage: urlToImage);

    final id = await DBprovider.db.newSave(newSave);

    newSave.id = id;
    if (this.selectedNews == true) {
      this.news.add(newSave);
      notifyListeners();
    }
    return newSave;
  }

  loadSavedNews() async {
    final news = await DBprovider.db.getAllNews();
    this.news = [...?news];
    notifyListeners();
  }

  deleteAllSavedNews() async {
    await DBprovider.db.deleteAllNews();
    this.news = [];
    notifyListeners();
  }
}
