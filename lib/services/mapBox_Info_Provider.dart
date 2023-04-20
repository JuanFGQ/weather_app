import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/model_info_Provider.dart';

class MapBoxInfoProvider extends ChangeNotifier {
  String _apiKey =
      'pk.eyJ1IjoianVhbmZncSIsImEiOiJjbGVsMzN2cTUwcmR3M3JucHlzcXk2OXMyIn0.OQG_aEvEIl2zT9pQ50OEHg';
  String _baseUrl = 'api.mapbox.com';
  String _language = 'es';
  String _limit = '1';

  // double _limit = 5;
  final String cityName;

  MapBoxInfoProvider(this.cityName) {
    print('MapBox Info Initialized');

    getWeatherInfo(cityName);
  }

  weatherHeader() {
    return {'access_token': _apiKey, 'limit': _limit, 'language': _language};
  }

  getWeatherInfo(String cityName) async {
    final uri = Uri.https(_baseUrl,
        '/geocoding/v5/mapbox.places/' + cityName + '.json', weatherHeader());

    final resp = await http.get(uri);
    // final Map<String, dynamic> decodedData = jsonDecode(resp.body);

    final mapBoxResp = mapBoxResponseFromMap(resp.body);

    // return mapBoxResp.features.map((e) =>
    //     ({'nombre': e.placeName, 'lng': e.center[0], 'lat': e.center[1]}));

    print(mapBoxResp.features.map((e) =>
        ({'nombre': e.placeName, 'lng': e.center[0], 'lat': e.center[1]})));
  }
}
