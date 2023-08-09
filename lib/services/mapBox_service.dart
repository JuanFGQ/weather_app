import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/helpers/debouncer.dart';
import 'package:weather/models/mapbox/mapbox_response.dart';

import '../models/mapbox/Feature.dart';

class MapBoxService extends ChangeNotifier {
  Feature? feature;

  bool _isConnected = false;

  bool get isConnected => _isConnected;

  set isConnected(bool value) {
    _isConnected = value;
    notifyListeners();
  }

  final String _apiKey =
      'pk.eyJ1IjoianVhbmZncSIsImEiOiJjbGVsMzN2cTUwcmR3M3JucHlzcXk2OXMyIn0.OQG_aEvEIl2zT9pQ50OEHg';
  final String _baseUrl = 'api.mapbox.com';
  final String _language = 'es';
  final String _limit = '8';

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Feature>> _suggestedCityStreamController =
      StreamController.broadcast();

  Stream<List<Feature>> get suggestedCity =>
      _suggestedCityStreamController.stream;

  weatherHeader() {
    return {
      'access_token': _apiKey,
      'limit': _limit,
      'language': _language,
      'types': 'place,country'
    };
  }

  Future<List<Feature>> getPlaces(String cityName) async {
    try {
      final uri = Uri.https(_baseUrl,
          '/geocoding/v5/mapbox.places/$cityName.json', weatherHeader());
//
      final resp = await http.get(uri);

      final mapBoxResp = mapBoxResponseFromMap(resp.body);
      isConnected = true;

      return mapBoxResp.features;
    } catch (e) {
      isConnected = false;
      return [];
    }
  }

  void getSuggestionByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await getPlaces(value);
      _suggestedCityStreamController.add(results);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(const Duration(milliseconds: 50))
        .then((_) => timer.cancel());
  }
}
