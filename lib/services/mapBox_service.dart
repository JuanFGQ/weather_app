import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/helpers/debouncer.dart';
import 'package:weather/models/mapBox_response.dart';

import '../models/mapbox/Feature.dart';

class MapBoxService extends ChangeNotifier {
  Feature? feature;

  String _apiKey =
      'pk.eyJ1IjoianVhbmZncSIsImEiOiJjbGVsMzN2cTUwcmR3M3JucHlzcXk2OXMyIn0.OQG_aEvEIl2zT9pQ50OEHg';
  String _baseUrl = 'api.mapbox.com';
  String _language = 'es';
  String _limit = '5';

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
    // onValue:  ()
  );

  final StreamController<List<Feature>> _suggestedCityStreamController =
      new StreamController.broadcast();

  Stream<List<Feature>> get suggestedCity =>
      this._suggestedCityStreamController.stream;

  weatherHeader() {
    return {'access_token': _apiKey, 'limit': _limit, 'language': _language};
  }

  Future<List<Feature>> getPlaces(String cityName) async {
    final uri = Uri.https(_baseUrl,
        '/geocoding/v5/mapbox.places/' + cityName + '.json', weatherHeader());
//
    final resp = await http.get(uri);

    final mapBoxResp = mapBoxResponseFromMap(resp.body);

    return mapBoxResp.features;
  }

  void getSuggestionByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      // print('Hay valor : $value');

      final results = await this.getPlaces(value);
      this._suggestedCityStreamController.add(results);
    };
    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }
}
