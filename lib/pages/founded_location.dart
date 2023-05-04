import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/geolocator_service.dart';
import 'package:weather/services/weather_api_service.dart';
import 'package:weather/widgets/home_widget.dart';

import '../models/mapbox/Feature.dart';

class FoundedLocation extends StatefulWidget {
  const FoundedLocation({super.key});

  @override
  State<FoundedLocation> createState() => _FoundedLocationState();
}

class _FoundedLocationState extends State<FoundedLocation> {
  final stream = StreamController<dynamic>();

  WeatherApiService? weatherAPI;
  GeolocatorService? geolocSERV;

  @override
  void initState() {
    super.initState();
    final Feature feature =
        ModalRoute.of(context)!.settings.arguments as Feature;
    weatherAPI = Provider.of<WeatherApiService>(context, listen: false);
    geolocSERV = Provider.of<GeolocatorService>(context, listen: false);
    // _loadWeatherFounded();
  }

  void _loadWeatherFounded() async {
    final Feature feature =
        ModalRoute.of(context)!.settings.arguments as Feature;

    final newCoords =
        feature.center.toString().replaceAll('[', '').replaceAll(']', '');

    final hasData = await weatherAPI!.getInfoWeatherLocation(newCoords);
    (hasData) ? true : false;

    stream.sink.add(hasData);
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherApiService>(context);
    final Feature feature =
        ModalRoute.of(context)!.settings.arguments as Feature;

    final newCoords =
        feature.center.toString().replaceAll('[', '').replaceAll(']', '');

    weatherData.getInfoWeatherLocation(newCoords);
    final wData = weatherData;

    return Scaffold(body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else {
        return HomeWidget(
            title: '${wData.foundLocation?.name ?? '?'}',
            lastUpdateDate:
                wData.foundCurrent?.lastUpdated.substring(0, 10) ?? '?',
            lastUpdateTime:
                wData.foundCurrent?.lastUpdated.substring(10, 16) ?? '?',
            locationCountry: wData.foundLocation?.country ?? '?',
            currentCOndition: wData.foundCurrent?.condition.text ?? '?',
            currentFeelsLikeNumber:
                '${wData.foundCurrent?.feelslikeC.toString()}º',
            windData: '${wData.foundCurrent?.windKph ?? '?'} km/h',
            humidityData: '${wData.foundCurrent?.humidity ?? '?'}',
            dropData: '${wData.foundCurrent?.humidity ?? '?'}%',
            visibilityData: '${wData.foundCurrent?.visKm ?? '?'} km/h ',
            windDirectionData: '${wData.foundCurrent?.windDir ?? '?'}',
            temperatureData: '${wData.foundCurrent?.tempC ?? '?'} º',
            feelsLikeData: '${wData.foundCurrent?.feelslikeC ?? '?'} º');
      }
    }));
  }
}


//  final Feature feature =
//         ModalRoute.of(context)!.settings.arguments as Feature;
// Text(
//         feature.center.toString().replaceAll('[', '').replaceAll(']', ''),














