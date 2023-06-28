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

  Future<SavedCitiesModel> saveCity(String temperature, String title,
      String updated, String wind, String coords) async {
    final citySave = SavedCitiesModel(
        title: title,
        temperature: temperature,
        updated: updated,
        wind: wind,
        coords: coords);

    final id = await DBprovider.db.citySave(citySave);

    citySave.id = id;

    cities.add(citySave);

    notifyListeners();
    return citySave;
  }

  loadSavedCities() async {
    final cities = await DBprovider.db.getAllCities();
    this.cities = [...?cities];
    notifyListeners();
  }

  deleteSavedCitiesById(int id) async {
    await DBprovider.db.deleteCities(id);
  }
}
