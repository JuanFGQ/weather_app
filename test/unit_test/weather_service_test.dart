import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/models/models.dart';
import 'package:weather/services/weather_api_service.dart';
import 'package:http/http.dart' as http;

class MockWeatherService extends Mock implements WeatherApiService {
  final String _baseUrl = 'api.weatherapi.com';

  @override
  getInfoWeatherLocation(String coords, http.Client http) async {
    apiParams() {
      return {
        'q': coords,
      };
    }

    try {
      final uri = Uri.https(_baseUrl, 'v1/forecast.json', apiParams());

      final resp = await http.get(uri);

      if (resp.statusCode == 200) {
        final weatherResp = weatherResponseFromJson(resp.body);

        location = weatherResp.location;
        current = weatherResp.current;

        forecast = weatherResp.forecast.forecastday;

        return isConected = true;
      }
    } catch (e) {
      return isConected = false;
    }
  }
}

class MockClient extends Mock implements HttpClient {}

void main() {
  // final mockWeatherApi = MockWeatherService();

  late WeatherApiService weatherApiService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    weatherApiService = WeatherApiService();
    weatherApiService = MockClient() as WeatherApiService;
  });

  test('getInfoWeatherLocation', () {});
}
