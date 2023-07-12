import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/new_weather_response.dart';
// import 'package:weather/models/weather/currten_weather_api.dart';
// import 'package:weather/models/weather/location_weather.dart';
// import 'package:weather/models/weather/weather_api_response.dart';

class WeatherApiService extends ChangeNotifier {
  Location? location;
  Current? current;
  Location? foundLocation;
  Current? foundCurrent;

  final String _baseUrl = 'api.weatherapi.com';
  final String _key = 'a1f73a2fb6cc40c29eb175425232204';
  final String _aqi = 'no';
  final String _days = '7';
  // final String
  //     _language; //todo: this parameter is to change the search language dinamically

  String _coords = '';

  WeatherApiService(
      // this._language
      );
  String get coords => _coords;
  set coords(String value) {
    _coords = value;
    notifyListeners();
  }

  // final StreamController<dynamic> _foundPlaces =
  //     StreamController<dynamic>.broadcast();

  // Stream get foundPlaces => _foundPlaces.stream;

  getFoundPlacesInfo(String coords) async {
    _apiParams() {
      return {
        'key': _key,
        'q': coords,
        'aqi': _aqi,
        'days': _days,
        'lang': 'es',
      };
    }

    final uri = Uri.https(_baseUrl, 'v1/forecast.json', _apiParams());
    final resp = await http.get(uri);

    if (resp.statusCode == 200) {
      final weatherResp = weatherResponseFromJson(resp.body);

      foundCurrent = weatherResp.current;
      foundLocation = weatherResp.location;

      return true;
    } else {
      return false;
    }
  }

  getInfoWeatherLocation(String coords) async {
    _apiParams() {
      return {'key': _key, 'q': coords, 'aqi': _aqi, 'lang': 'es'};
    }

    final uri = Uri.https(_baseUrl, 'v1/forecast.json', _apiParams());

    final resp = await http.get(uri);

    if (resp.statusCode == 200) {
      final weatherResp = weatherResponseFromJson(resp.body);

      location = weatherResp.location;
      current = weatherResp.current;

      print(weatherResp.forecast.forecastday);

      return true;
    } else {
      return false;
    }
  }
}
