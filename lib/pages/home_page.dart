import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/cities_list_provider.dart';
import 'package:weather/services/geolocator_service.dart';
import 'package:weather/services/image_service.dart';
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
  ImageService? imageService;

  @override
  void initState() {
    super.initState();
    weatherApi = Provider.of<WeatherApiService>(context, listen: false);
    geolocatorService = Provider.of<GeolocatorService>(context, listen: false);
    newsService = Provider.of<NewsService>(context, listen: false);
    imageService = Provider.of<ImageService>(context, listen: false);

    _loadWeatherData();
  }

  void _loadWeatherData() async {
    String coords = await geolocatorService!.getCurrentLocation();

    final hasData = await weatherApi!.getInfoWeatherLocation(coords);

    (hasData) ? true : false;

//flag to select argument according to the page
    imageService!.searchText = false;

    stream.sink.add(hasData);
  }

//refresh the current location and all the information on it
  void _refreshWeatherData() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CircularIndicator()));
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
            isVisibleButton: true,
            saveLocationButton: () {
              saveInFavouritePlaces(apiResp);
            },
            refreshButton: _refreshWeatherData,
            newsButton: () {
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

  void saveInFavouritePlaces(WeatherApiService apiResp) async {
    final saveCitiesProvider =
        Provider.of<CitiesListProvider>(context, listen: false);

    // final imagesProvider = Provider.of<ImageService>(context, listen: false);

    await saveCitiesProvider.loadSavedCities();

    final cityListCopy = List.from(saveCitiesProvider.cities);

    final comparisonText = apiResp.location?.name ?? '?';

    // final city = '${apiResp.location?.name} ${apiResp.location?.country}';

    // final respTest = await imagesProvider.findPhotos(city);

    // print('city ARG ${city} IMAGES PROVIDER ${respTest}');

    bool foundMatch = false;

    for (var element in cityListCopy) {
      if (element.title == comparisonText) {
        foundMatch = true;
// ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (_) => FadeInUp(
            child: AlertDialog(
              alignment: Alignment.bottomCenter,
              title: const Text(
                'Already saved',
                style: TextStyle(color: Colors.white70),
              ),
              elevation: 24,
              backgroundColor: const Color.fromARGB(130, 0, 108, 196),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        );
        break;
      }
    }

    if (!foundMatch) {
      String coords = await geolocatorService!.getCurrentLocation();

      await saveCitiesProvider.saveCity(
        '${apiResp.current!.feelslikeC}º',
        apiResp.location!.name,
        apiResp.current!.lastUpdated,
        apiResp.current!.condition.text,
        coords,
      );

      await saveCitiesProvider.loadSavedCities();
    }
  }

  @override
  void dispose() {
    stream.close();
    super.dispose();
  }
}
