import 'package:flutter/material.dart';
import 'package:weather/models/database/saved_cities_model.dart';
import 'package:weather/providers/db_provider.dart';

class CitiesListProvider extends ChangeNotifier {
  List<SavedCitiesModel> cities = [];

  bool _isPressedSaveButton = false;

  bool get isPressedSaveButton => _isPressedSaveButton;

  set isPressedSaveButton(bool value) {
    _isPressedSaveButton = value;
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
