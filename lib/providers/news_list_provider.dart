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
    this.news =

        /// `[...?news]` is using the spread operator (`...`) to create a new list with all the
        /// elements of the `news` list, if it is not null. If `news` is null, it will create an
        /// empty list. This is a way to avoid null errors when copying a list.
        [...?news];
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
