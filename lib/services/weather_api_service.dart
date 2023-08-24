import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/weather/new_weather_response.dart';
import '../providers/localization_provider.dart';

class WeatherApiService extends ChangeNotifier {
  Location? location;
  Current? current;
  LocalizationProvider? locale;
  List<Forecastday>? forecast;

  final String _baseUrl = 'api.weatherapi.com';
  final String _key = 'a1f73a2fb6cc40c29eb175425232204';
  final String _aqi = 'no';
  final String _days = '7';

//save coord value of other places and get the info
  String _coords = '';

  String get coords => _coords;
  set coords(String value) {
    _coords = value;
    notifyListeners();
  }

  bool _isEnglish = false;

  bool get isEnglish => _isEnglish;

  set isEnglish(bool value) {
    _isEnglish = value;
    notifyListeners();
  }

  bool _isConected = false;

  bool get isConected => _isConected;

  set isConected(bool value) {
    _isConected = value;
    notifyListeners();
  }

  getInfoWeatherLocation(String coordsc) async {
    apiParams() {
      return {
        'key': _key,
        'q': coords,
        'aqi': _aqi,
        'lang': (!isEnglish) ? 'es' : 'en',
        'days': _days
      };
    }

    try {
      //this fails only if detect any internet problem
      final uri = Uri.https(_baseUrl, 'v1/forecast.json', apiParams());

      final resp = await http.get(uri);

      if (resp.statusCode == 200) {
        final weatherResp = weatherResponseFromJson(resp.body);

        location = weatherResp.location;
        current = weatherResp.current;

        forecast = weatherResp.forecast.forecastday;

        return isConected = true;
      } else {
        return;
      }
    } catch (e) {
      return isConected = false;
    }
  }
}
