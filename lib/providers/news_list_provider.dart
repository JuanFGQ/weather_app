import 'package:flutter/material.dart';
import 'package:weather/models/saved_news_model.dart';
import 'package:weather/providers/db_provider.dart';

class NewsListProvider extends ChangeNotifier {
  List<SavedNewsModel> news = [];
  Map<int, bool> buttonStates =
      {}; //map to store the states of button was pressed and saved

  // int _selectedItem = -1;

  // int get selectedItem => _selectedItem;

  // set selectedItem(int value) {
  //   _selectedItem = value;
  //   notifyListeners();
  // }

  Future<SavedNewsModel> newSave(
      String url, title, urlToImage, bool isButtonPressed) async {
    final newSave = SavedNewsModel(
        title: title, url: url, urlToImage: urlToImage, isButtonPressed: false);

    final id = await DBprovider.db.newSave(newSave);

    newSave.id = id;
    news.add(newSave);
    buttonStates[id] = isButtonPressed; //save state of button into the map
    notifyListeners();

    return newSave;
  }

  loadSavedNews() async {
    final news = await DBprovider.db.getAllNews();
    this.news = [...?news];
    notifyListeners();
  }

  deleteAllSavedNews() async {
    await DBprovider.db.deleteAllNews();
    news = [];
    notifyListeners();
  }

  deleteNewsById(int id) async {
    await DBprovider.db.deleteNews(id);
  }
}
