import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/geolocator_service.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';
import 'package:weather/widgets/circular_progress_indicator.dart';
import 'package:weather/widgets/home_widget.dart';

import '../models/mapbox/Feature.dart';

class FoundedLocation extends StatefulWidget {
  const FoundedLocation({super.key});

  @override
  State<FoundedLocation> createState() => _FoundedLocationState();
}

class _FoundedLocationState extends State<FoundedLocation> {
  final streamFound = StreamController<dynamic>();

  WeatherApiService? weatherAPI;
  GeolocatorService? geolocSERV;
  NewsService? newSERV;

  @override
  void initState() {
    super.initState();
    weatherAPI = Provider.of<WeatherApiService>(context, listen: false);
    geolocSERV = Provider.of<GeolocatorService>(context, listen: false);
    newSERV = Provider.of<NewsService>(context, listen: false);

    _loadDataFounded();
  }

  void _loadDataFounded() async {
    final coords = weatherAPI!.coords;

    final hasData = await weatherAPI!.getFoundPlacesInfo(coords);

    await (hasData) ? true : false;
    streamFound.sink.add(hasData);
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherApiService>(context);

    final apiResp = weatherData;

    return Scaffold(
        body: StreamBuilder(
            stream: streamFound.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularIndicator();
              } else {
                return WillPopScope(
                  onWillPop: () async {
                    Navigator.pushNamed(context, 'home');
                    newSERV!.activeSearch = false;

                    return true;
                  },
                  child: HomeWidget(
                    showRefreshButton: false,
                    function: () {
                      Navigator.pushNamed(context, 'news');
                      setState(() {
                        newSERV!.activeSearch = true;
                      });
                      final searchName =
                          '${weatherAPI!.foundLocation!.country} ${weatherAPI!.foundLocation!.name}';

                      newSERV!.getNewsByFoundedPlace(searchName);
                    },
                    locCountryColor: Colors.yellow,
                    appBarColors: Colors.yellow,
                    scaffoldColor: Colors.yellow,
                    title: apiResp.foundLocation?.name ?? '?',
                    lastUpdateDate:
                        apiResp.foundCurrent?.lastUpdated.substring(0, 10) ??
                            '?',
                    lastUpdateTime:
                        apiResp.foundCurrent?.lastUpdated.substring(10, 16) ??
                            '?',
                    locationCountry: apiResp.foundLocation?.country ?? '?',
                    currentCOndition:
                        apiResp.foundCurrent?.condition.text ?? '?',
                    currentFeelsLikeNumber:
                        '${apiResp.foundCurrent?.feelslikeC.toString()}º',
                    windData: '${apiResp.foundCurrent?.windKph ?? '?'} km/h',
                    visibilityData:
                        '${apiResp.foundCurrent?.visKm ?? '?'} km/h ',
                    windDirectionData: apiResp.foundCurrent?.windDir ?? '?',
                    temperatureData: '${apiResp.foundCurrent?.tempC ?? '?'} º',
                    feelsLikeData:
                        '${apiResp.foundCurrent?.feelslikeC ?? '?'} º',
                    humidityData: '${apiResp.foundCurrent?.humidity ?? '?'}',
                  ),
                );
              }
            }));
  }

  @override
  void dispose() {
    _loadDataFounded();
    newSERV!.listArticles2.clear();
    super.dispose();
  }
}
