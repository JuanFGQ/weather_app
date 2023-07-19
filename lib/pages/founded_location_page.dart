import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../services/services.dart';
import '../widgets/modal_bottomsheet.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class FoundedLocation extends StatefulWidget {
  const FoundedLocation({super.key});

  @override
  State<FoundedLocation> createState() => _FoundedLocationState();
}

class _FoundedLocationState extends State<FoundedLocation> {
  final streamFound = StreamController<dynamic>();

  WeatherApiService? weatherAPI;
  NewsService? newSERV;

  @override
  void initState() {
    super.initState();
    weatherAPI = Provider.of<WeatherApiService>(context, listen: false);
    newSERV = Provider.of<NewsService>(context, listen: false);

    _loadDataFounded();
  }

  void _loadDataFounded() async {
    final coords = weatherAPI!.coords;

    final hasData = await weatherAPI!.getFoundPlacesInfo(coords);

    await (hasData) ? true : false;

//flag to select argument according to the page

    streamFound.sink.add(hasData);
  }

  void _refreshWeatherData() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CircularIndicator()));
    _loadDataFounded();
    Navigator.pushNamed(context, 'founded');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('FOUNDED LOCATION BUILD');
    final weatherData = Provider.of<WeatherApiService>(context);

    final apiResp = weatherData;
    final localeProvider = Provider.of<LocalizationProvider>(context);

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
                  child: NewsDesignPage(
                    onChangedEnglish: (value) {
                      _refreshWeatherData();
                      localeProvider.languageEnglish = value;
                      localeProvider.languageSpanish = false;

                      if (!localeProvider.languageEnglish) {
                        localeProvider.languageSpanish = true;
                        weatherAPI!.isEnglish = false;
                      }
                      //
                    },
                    onChangedSpanish: (value) {
                      _refreshWeatherData();
                      localeProvider.languageSpanish = value;
                      // weatherAPI!.isEnglish = false;
                      localeProvider.languageEnglish = false;
                      if (!localeProvider.languageSpanish) {
                        localeProvider.languageEnglish = true;
                        weatherAPI!.isEnglish = true;
                      }
                    },
                    isVisibleButton: false,
                    saveLocationButton: () {
                      saveInFavouritePlaces(apiResp);
                    },
                    newsButton: () {
                      setState(() {
                        newSERV!.activeSearch = true;
                      });
                      ShowModalBottomSheet(context);
                    },
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
                    precipitation: '${apiResp.foundCurrent?.precipIn ?? '?'}%',
                    pressure: '${apiResp.foundCurrent?.pressureMb ?? '?'}mb',
                    uvRays: '${apiResp.foundCurrent?.uv ?? '?'}',
                  ),
                );
              }
            }));
  }

  void saveInFavouritePlaces(WeatherApiService apiResp) async {
    final saveCitiesProvider =
        Provider.of<CitiesListProvider>(context, listen: false);
    // final imagesProvider = Provider.of<ImageService>(context, listen: false);

    await saveCitiesProvider.loadSavedCities();

    final cityListCopy = List.from(saveCitiesProvider.cities);

    final comparisonText = apiResp.foundLocation?.name ?? '?';

    // final city =
    //     '${apiResp.foundLocation?.name} ${apiResp.foundLocation?.country}';

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
      await saveCitiesProvider.saveCity(
          '${apiResp.foundCurrent!.feelslikeC}º',
          apiResp.foundLocation!.name,
          apiResp.foundCurrent!.lastUpdated,
          apiResp.foundCurrent!.condition.text,
          weatherAPI!.coords);

      await saveCitiesProvider.loadSavedCities();
    }
  }

  @override
  void dispose() {
    _loadDataFounded();
    streamFound.close();
    super.dispose();
  }
}
