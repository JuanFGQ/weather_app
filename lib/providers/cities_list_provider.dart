import 'package:flutter/material.dart';
import 'package:weather/models/saved_cities_model.dart';
import 'package:weather/providers/db_provider.dart';

class CitiesListProvider extends ChangeNotifier {
  List<SavedCitiesModel> cities = [];
  int _selectedItem = -1;

  int get selectedItem => _selectedItem;

  set selectedItem(int value) {
    _selectedItem = value;
    notifyListeners();
  }

  Future<SavedCitiesModel> newSave(
      String title, temperature, updated, wind) async {
    final newsSave = SavedCitiesModel(
        title: title, temperature: temperature, updated: updated, wind: wind);

        final id = await DBprovider.db.newSave(newSave)
  }
}
