import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather_api_response.dart';

class WeatherApiService extends ChangeNotifier {
  final String _baseUrl = 'api.weatherapi.com';
  final String _key = 'a1f73a2fb6cc40c29eb175425232204';
  final String _aqi = 'no';

  final String query;

  WeatherApiService({required this.query}) {
    print('Weather New Api On');

    getInfoWeatherLocation(query);
  }

  apiParams() {
    return {'key': _key, 'q': query, 'aqi': _aqi};
  }

  getInfoWeatherLocation(String city) async {
    final uri = Uri.https(_baseUrl, '/v1/current.json', apiParams());

    final resp = await http.get(uri);

    final weatherResp = weatherApiFromJson(resp.body);

    // print(weatherResp.location);
    return weatherResp.location;
  }

  getInfoWeatherCurrent(String city) async {
    final uri = Uri.https(_baseUrl, '/v1/current.json', apiParams());

    final resp = await http.get(uri);

    final weatherResp = weatherApiFromJson(resp.body);

    // print(weatherResp.location);
    return weatherResp.current;
  }
}
