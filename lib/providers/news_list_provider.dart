import 'package:flutter/material.dart';
import 'package:weather/models/saved_news_model.dart';
import 'package:weather/providers/db_provider.dart';

class NewsListProvider extends ChangeNotifier {
  List<SavedNewsModel> news = [];
  int _selectedItem = -1;

  int get selectedItem => _selectedItem;

  set selectedItem(int value) {
    _selectedItem = value;
    notifyListeners();
  }

  Future<SavedNewsModel> newSave(String url, title, urlToImage) async {
    final newSave =
        SavedNewsModel(title: title, url: url, urlToImage: urlToImage);

    final id = await DBprovider.db.newSave(newSave);

    newSave.id = id;
    // if (isPressedHeart == true) {
    //   news.add(newSave);
    //   notifyListeners();
    // }
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

  deleteNewsById(int id) async {
    await DBprovider.db.deleteNews(id);
    notifyListeners();
  }
}
