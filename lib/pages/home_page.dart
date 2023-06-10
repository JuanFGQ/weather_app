import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/geolocator_service.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';

import '../widgets/circular_progress_indicator.dart';
import '../widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final stream = StreamController<dynamic>();

  WeatherApiService? weatherApi;
  GeolocatorService? geolocatorService;
  NewsService? newsService;

  @override
  void initState() {
    super.initState();
    weatherApi = Provider.of<WeatherApiService>(context, listen: false);
    geolocatorService = Provider.of<GeolocatorService>(context, listen: false);
    newsService = Provider.of<NewsService>(context, listen: false);

    _loadWeatherData();
  }

  void _loadWeatherData() async {
    String coords = await geolocatorService!.getCurrentLocation();

    final hasData = await weatherApi!.getInfoWeatherLocation(coords);

    (hasData) ? true : false;

    stream.sink.add(hasData);
  }

  void _refreshWeatherData() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CircularIndicator()));
    _loadWeatherData();
    Navigator.pushNamed(context, 'home');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final weatherAPI = Provider.of<WeatherApiService>(context);
    final apiResp = weatherAPI;

    return StreamBuilder(
      stream: stream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularIndicator();
        } else {
          return HomeWidget(
            showRefreshButton: true,
            refreshButton: _refreshWeatherData,
            function: () {
              setState(() {
                newsService!.activeSearch = false;
              });

              Navigator.pushNamed(context, 'news');
            },
            locCountryColor: Colors.blue,
            appBarColors: Colors.blue,
            scaffoldColor: Colors.blue,
            title: apiResp.location?.name ?? '?',

            lastUpdateDate:
                apiResp.current?.lastUpdated.substring(0, 10) ?? '?',
            lastUpdateTime:
                apiResp.current?.lastUpdated.substring(10, 16) ?? '?',
            locationCountry: apiResp.location?.country ?? '?',
            currentCOndition: apiResp.current?.condition.text ?? '?',
            currentFeelsLikeNumber:
                '${apiResp.current?.feelslikeC.toString()}º',
            windData: '${apiResp.current?.windKph ?? '?'} km/h',
            // dropData: '${apiResp.current?.humidity ?? '?'}%',
            visibilityData: '${apiResp.current?.visKm ?? '?'} km/h ',
            windDirectionData: apiResp.current?.windDir ?? '?',
            temperatureData: '${apiResp.current?.tempC ?? '?'} º',
            feelsLikeData: '${apiResp.current?.feelslikeC ?? '?'} º',
            humidityData: '${apiResp.current?.humidity ?? '?'}%',
          );
        }
      },
    );
  }

  @override
  void dispose() {
    stream.close();
    super.dispose();
  }
}
