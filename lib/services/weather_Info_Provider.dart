import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather_response.dart';

class WeatherInfoProvider with ChangeNotifier {
  String _baseUrl = 'api.openweathermap.org';
  String _appId = 'f369635965b00ad16ced5da4da4b9f3b';
  String _units = 'metric';
  String _lang = 'es';
  // final String lat;
  // final String lon;

  WeatherInfoProvider(
      // required this.lat, required this.lon
      ) {
    print('Weather Info Initialized');

    getWeatherInfo(
        // lat, lon
        );
  }

  weatherParams() {
    return {
      'appid': _appId,
      'units': _units,
      'lang': _lang,
    };
  }

  getWeatherInfo(
      // String lat, lon
      ) async {
    final uri = Uri.https(
        _baseUrl, '/data/2.5/weather' '5.066891' '-75.506666', weatherParams());

    final resp = await http.get(uri);

    final weatherResp = weatherResponseFromJson(resp.body);

    // print(weatherResp.weather.map((e) => {e.description}));
    print(weatherResp);
  }
}
