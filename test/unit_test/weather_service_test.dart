import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/services/weather_api_service.dart';

class MockWeatherService extends Mock implements WeatherApiService {}

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

  test('getInfoWeatherLocation', () {
    when(() => mockWeatherApi.getInfoWeatherLocation('4.554545, 5.545454'));
  });
}
