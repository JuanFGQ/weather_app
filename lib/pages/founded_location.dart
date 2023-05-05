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

class _FoundedLocationState extends State<FoundedLocation> with PostFrameMixin {
  final stream = StreamController<dynamic>();

  WeatherApiService? weatherAPI;
  GeolocatorService? geolocSERV;

  @override
  void initState() {
    super.initState();
    weatherAPI = Provider.of<WeatherApiService>(context, listen: false);
    geolocSERV = Provider.of<GeolocatorService>(context, listen: false);
    _loadWeatherFounded();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _loadWeatherFounded();
  }

  void _loadWeatherFounded() async {
    final Feature feature =
        ModalRoute.of(context)!.settings.arguments as Feature;

    final newCoords = feature.center;

    final cord1 = newCoords[1].toString();
    final cord0 = newCoords[0].toString();

    final defCoord = cord1 + ',' + cord0;

    weatherAPI!.getFoundPlacesInfo(defCoord);
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherApiService>(context);
    // final Feature feature =
    //     ModalRoute.of(context)!.settings.arguments as Feature;

    // final newCoords = feature.center;

    // final cord1 = newCoords[1].toString();
    // final cord0 = newCoords[0].toString();

    // final defCoord = cord1 + ',' + cord0;

    // weatherData.getFoundPlacesInfo(defCoord);
    final apiResp = weatherData;

    return Scaffold(body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else {
        return HomeWidget(
          appBarColors: Colors.yellow,
          scaffoldColor: Colors.yellow,
          title: apiResp.foundLocation?.name ?? '?',
          lastUpdateDate:
              apiResp.foundCurrent?.lastUpdated.substring(0, 10) ?? '?',
          lastUpdateTime:
              apiResp.foundCurrent?.lastUpdated.substring(10, 16) ?? '?',
          locationCountry: apiResp.foundLocation?.country ?? '?',
          currentCOndition: apiResp.foundCurrent?.condition.text ?? '?',
          currentFeelsLikeNumber:
              '${apiResp.foundCurrent?.feelslikeC.toString()}º',
          windData: '${apiResp.foundCurrent?.windKph ?? '?'} km/h',
          dropData: '${apiResp.foundCurrent?.humidity ?? '?'}%',
          visibilityData: '${apiResp.foundCurrent?.visKm ?? '?'} km/h ',
          windDirectionData: apiResp.foundCurrent?.windDir ?? '?',
          temperatureData: '${apiResp.foundCurrent?.tempC ?? '?'} º',
          feelsLikeData: '${apiResp.foundCurrent?.feelslikeC ?? '?'} º',
          humidityData: '${apiResp.foundCurrent?.humidity ?? '?'}',
        );
      }
    }));
  }
}

mixin PostFrameMixin<T extends StatefulWidget> on State<T> {
  void postFrame(void Function() callback) =>
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) {
          // Execute callback if page is mounted
          if (mounted) callback();
        },
      );
}



//  final Feature feature =
//         ModalRoute.of(context)!.settings.arguments as Feature;
// Text(
//         feature.center.toString().replaceAll('[', '').replaceAll(']', ''),














