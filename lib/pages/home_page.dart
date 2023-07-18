import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/localization_provider.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../widgets/modal_bottomsheet.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

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
  CitiesListProvider? citiesListProvider;

  @override
  void initState() {
    super.initState();
    weatherApi = Provider.of<WeatherApiService>(context, listen: false);
    geolocatorService = Provider.of<GeolocatorService>(context, listen: false);
    newsService = Provider.of<NewsService>(context, listen: false);
    imageService = Provider.of<ImageService>(context, listen: false);
    citiesListProvider =
        Provider.of<CitiesListProvider>(context, listen: false);

    _loadWeatherData();
    // citiesListProvider!.loadSavedCities();
    // _isSavedLocation();
  }

  void _loadWeatherData() async {
    String coords = await geolocatorService!.getCurrentLocation();

    final hasData = await weatherApi!.getInfoWeatherLocation(coords);

    (hasData) ? true : false;

//flag to select argument according to the page
    // imageService!.searchText = false;

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

  // void _isSavedLocation() async {
  //   final listCitiesCopy = List.from(citiesListProvider!.cities);
  //   final comparisonText = await weatherApi!.location!.name;

  //   for (var element in listCitiesCopy) {
  //     if (element.title == comparisonText) {
  //       citiesListProvider!.isPressedSaveButton = true;
  //       break;
  //     }
  //   }
  //   citiesListProvider!.isPressedSaveButton = false;
  // }

  @override
  Widget build(BuildContext context) {
    final weatherAPI = Provider.of<WeatherApiService>(context);
    final apiResp = weatherAPI;
    final localeProvider = Provider.of<LocalizationProvider>(context);

    return StreamBuilder(
      stream: stream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularIndicator();
        } else {
          return NewsDesignPage(
            onChangedEnglish: (value) {
              _refreshWeatherData();
              localeProvider.languageEnglish = value;
              localeProvider.languageSpanish = false;
              weatherApi!.isEnglish = true;

              if (!localeProvider.languageEnglish) {
                localeProvider.languageSpanish = true;
              }
            },
            onChangedSpanish: (value) {
              _refreshWeatherData();
              localeProvider.languageSpanish = value;
              weatherApi!.isEnglish = false;

              localeProvider.languageEnglish = false;
              if (!localeProvider.languageSpanish) {
                localeProvider.languageEnglish = true;
              }
            },
            isVisibleButton: true,
            saveLocationButton: () {
              saveInFavouritePlaces(apiResp);
              setState(() {
                citiesListProvider!.isPressedSaveButton = true;
              });
            },
            refreshButton: _refreshWeatherData,
            newsButton: () {
              setState(() {
                newsService!.activeSearch = false;
              });
              ShowModalBottomSheet(context);
            },

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
            precipitation: '${apiResp.current?.precipIn ?? '?'}%',
            pressure: '${apiResp.current?.pressureMb ?? '?'}mb',
            uvRays: '${apiResp.current?.uv ?? '?'}',
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

    bool foundMatch = false;

    for (var element in cityListCopy) {
      if (element.title == comparisonText) {
        foundMatch = true;
        saveCitiesProvider.isPressedSaveButton = true;
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

      // saveCitiesProvider.isPressedSaveButton = false;
    }
  }

  @override
  void dispose() {
    stream.close();
    super.dispose();
  }
}
