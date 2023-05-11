import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/geolocator_service.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';

import '../widgets/circular_progress_indicator.dart';
import '../widgets/home_widget.dart';

class HomePage extends StatefulWidget {
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

    // await weatherApi!.getInfoWeatherCurrent(coords);
    final hasData = await weatherApi!.getInfoWeatherLocation(coords);

    (hasData) ? true : false;

    stream.sink.add(hasData);

    setState(() {
      newsService!.activeSearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherAPI = Provider.of<WeatherApiService>(context);
    final apiResp = weatherAPI;

    return StreamBuilder(
      stream: stream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularIndicator();
        } else {
          return HomeWidget(
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
}



// class _HeaderCityName extends StatelessWidget {
//   final Feature feature;

//   const _HeaderCityName(this.feature);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       feature.placeName,
//       style: TextStyle(
//           color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
//     );
//   }
// }
