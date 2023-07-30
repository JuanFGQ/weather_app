import 'package:flutter/material.dart';
import 'package:weather/models/database/wanted_places_model.dart';
import 'package:weather/providers/db_provider.dart';

class WantedPlacesProvider extends ChangeNotifier {
  List<WantedPlacesModel> places = [];

  Future<WantedPlacesModel> newSave(String placeName, String coord) async {
    final newSave = WantedPlacesModel(placeName: placeName, placeCoords: coord);

    final id = await DBprovider.db.savedPlace(newSave);

    newSave.id = id;
    places.add(newSave);
    notifyListeners();

    return newSave;
  }

  loadSavedPlaces() async {
    final places = await DBprovider.db.getAllPlaces();
    this.places = [...?places];
    notifyListeners();
  }

  deleteSavePlace(int id) async {
    await DBprovider.db.deletePlace(id);
  }
}
