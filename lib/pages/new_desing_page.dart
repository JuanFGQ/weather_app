import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/wanted_places_provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../search/search_delegate_widget.dart';
import '../services/services.dart';
import '../widgets/modal_bottomsheet.dart';
import '../widgets/widgets.dart';

class NewsDesignPage extends StatefulWidget {
  const NewsDesignPage({
    super.key,
  });

  @override
  State<NewsDesignPage> createState() => _NewsDesignPageState();
}

class _NewsDesignPageState extends State<NewsDesignPage>
    with TickerProviderStateMixin {
  NewsService? newsServ;
  WeatherApiService? weatherServ;
  GeolocatorService? geolocatorService;
  CitiesListProvider? citiesListProvider;
  NewsListProvider? newsListProvider;
  WantedPlacesProvider? wantedPlaces;

  @override
  void initState() {
    super.initState();
    newsServ = Provider.of<NewsService>(context, listen: false);
    citiesListProvider =
        Provider.of<CitiesListProvider>(context, listen: false);
    weatherServ = Provider.of<WeatherApiService>(context, listen: false);
    geolocatorService = Provider.of<GeolocatorService>(context, listen: false);
    newsListProvider = Provider.of<NewsListProvider>(context, listen: false);
    wantedPlaces = Provider.of<WantedPlacesProvider>(context, listen: false);

    newsListProvider!.loadSavedNews();
    citiesListProvider!.loadSavedCities();
    wantedPlaces!.loadSavedPlaces();
    _superSearchInfo();
  }

  @override
  void dispose() {
    super.dispose();
    newsServ;
    weatherServ;
    geolocatorService;
    citiesListProvider;
    newsListProvider;
    citiesListProvider;
  }

  Future _superSearchInfo() async {
    String actualLocationCoords = await geolocatorService!.getCurrentLocation();

    final searhCityCoords = weatherServ!.coords;

    final coords =
        (!newsServ!.activeSearch) ? actualLocationCoords : searhCityCoords;

    final hasData = await weatherServ!.getInfoWeatherLocation(coords);

    return hasData;
  }

  @override
  Widget build(BuildContext context) {
    print('NEW DESIGN PAGE BUILD');

    return FutureBuilder(
        future: _superSearchInfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularIndicator();
          } else {
            return _WeatherWidget();
          }
        });
  }
}

class _WeatherWidget extends StatefulWidget {
  @override
  State<_WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<_WeatherWidget> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String locationName = '';
  String feelsLikeData = '';
  String humidityData = '';
  String temperatureData = '';
  String visibilityData = '';
  String windData = '';
  String windDirectionData = '';
  String precipitation = '';
  String pressure = '';
  String uvRays = '';
  String condition = '';
  String lastUpdated = '';
  String countryName = '';
  String regionName = '';

  WeatherApiService? weatherAPI;
  CitiesListProvider? saveCitiesProvider;
  NewsService? newService;
  GeolocatorService? geolocatorService;
  @override
  void initState() {
    super.initState();
    weatherAPI = Provider.of<WeatherApiService>(context, listen: false);
    saveCitiesProvider =
        Provider.of<CitiesListProvider>(context, listen: false);
    newService = Provider.of<NewsService>(context, listen: false);
    geolocatorService = Provider.of<GeolocatorService>(context, listen: false);

    locationName = weatherAPI!.location!.name;
    countryName = weatherAPI!.location!.country;
    regionName = weatherAPI!.location!.region;
    feelsLikeData = '${weatherAPI!.current?.feelslikeC.toString()}º';
    humidityData = '${weatherAPI!.current?.humidity ?? '?'}%';
    temperatureData = '${weatherAPI!.current?.tempC ?? '?'} º';
    visibilityData = '${weatherAPI!.current?.visKm ?? '?'} km/h';
    windData = '${weatherAPI!.current?.windKph ?? '?'} km/h';
    windDirectionData = weatherAPI!.current?.windDir ?? '?';
    precipitation = '${weatherAPI!.current?.precipIn ?? '?'}%';
    pressure = '${weatherAPI!.current?.pressureMb ?? '?'} mb';
    uvRays = '${weatherAPI!.current?.uv ?? '?'}';
    condition = weatherAPI!.current!.condition.text;
    lastUpdated = weatherAPI!.current!.lastUpdated;
  }

  @override
  void dispose() {
    super.dispose();
    weatherAPI;
    saveCitiesProvider;
    newService;
    geolocatorService;
  }

  @override
  Widget build(BuildContext context) {
    final apiResp = weatherAPI;

    return Scaffold(
        key: _globalKey,
        drawer: _MenuDrawer(),
        body: Column(
          children: [
            Stack(
              children: [
                _Background(
                  condition: condition,
                ),
                Column(
                  children: [
                    _HeaderWidget(
                      onpressed: () {
                        _globalKey.currentState!.openDrawer();
                      },
                      location: locationName,
                    ),
                    _TemperatureNumber(
                      tempNumber: feelsLikeData,
                    ),
                    const SizedBox(height: 20),
                    _WeatherState(
                      weatherState: condition,
                    ),
                    _ActionButtons(
                      saveLocation: () {
                        saveInFavouritePlaces(apiResp!);
                        saveCitiesProvider!.isPressedSaveButton = true;
                      },
                      newsButton: () {
                        ShowModalBottomSheet(context);
                      },
                      refreshPage: () {
                        newService!.activeSearch = false;
                        Navigator.pushNamed(context, 'ND');
                      },
                    ),
                    const SizedBox(height: 20),
                    _InfoTableList(
                      feelsLikeData: feelsLikeData,
                      humidityData: humidityData,
                      temperatureData: temperatureData,
                      visibilityData: visibilityData,
                      windData: windData,
                      windDirectionData: windDirectionData,
                      precipitation: precipitation,
                      pressure: pressure,
                      uvRays: uvRays,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context)!.weekelyforecast,
                    style: const TextStyle(
                        // decoration: TextDecoration.underline,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const FaIcon(FontAwesomeIcons.arrowRight)
                ],
              ),
            ),
            _ForeCastTable(
              forecast: weatherAPI!.forecast!,
            )
          ],
        ));
  }

  void saveInFavouritePlaces(WeatherApiService apiResp) async {
    final cityListCopy =
        Set.from(saveCitiesProvider!.cities.map((e) => e.title));

    final comparisonText = locationName;

    bool foundMatch = false;

    if (cityListCopy.contains(comparisonText)) {
      foundMatch = true;
      saveCitiesProvider!.isPressedSaveButton = true;
      showDialog(
        context: context,
        builder: (_) => FadeInUp(
          duration: const Duration(milliseconds: 200),
          child: AlertDialog(
            alignment: Alignment.bottomCenter,
            title: Text(
              AppLocalizations.of(context)!.allreadysave,
              style: const TextStyle(color: Colors.white70),
            ),
            elevation: 24,
            backgroundColor: const Color.fromARGB(130, 0, 108, 196),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      );
    }

    if (!foundMatch) {
      //this variable comes from weatherApi service
      final String currentCoords =
          await geolocatorService!.getCurrentLocation();
      final selectedCoord =
          (!newService!.activeSearch) ? currentCoords : apiResp.coords;

      await saveCitiesProvider!.saveCity(
        countryName,
        locationName,
        regionName,
        condition,
        selectedCoord,
      );

      await saveCitiesProvider!.loadSavedCities();
    }
  }
}

class _MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context, listen: false);
    final newsListProvider = Provider.of<NewsListProvider>(context);
    final newsListP = newsListProvider.news;
    final citiesListProvider = Provider.of<CitiesListProvider>(context);
    final citiesListP = citiesListProvider.cities;
    final localeProvider = Provider.of<LocalizationProvider>(context);

    final size = MediaQuery.of(context).size;
    final weatherApi = Provider.of<WeatherApiService>(context);

    final deleteNewsListItemButton =
        List.generate(newsListP.length, (index) => ValueNotifier<bool>(false));
    final deleteCityListItemButton = List.generate(
        citiesListP.length, (index) => ValueNotifier<bool>(false));

    // final deleteNews = ValueNotifier(false);

    return Drawer(
      child: ListView(children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(AppLocalizations.of(context)!.home,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30))),
            ),

            ExpansionTile(
                leading: const FaIcon(FontAwesomeIcons.heartCircleCheck),
                title: Text(AppLocalizations.of(context)!.favouriteplaces),
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: size.height * 0.55,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: citiesListP.length,
                      itemBuilder: (BuildContext context, int index) {
                        final cityList = citiesListP[index];

                        return ValueListenableBuilder(
                          valueListenable: deleteCityListItemButton[index],
                          builder: (context, value, _) {
                            return SavedCardMenuDrawer(
                              // deleteNews: deleteNews.value = true,
                              subtitle:
                                  Center(child: Text(cityList.temperature)),
                              title: cityList.title,
                              goToAction: () {
                                newsService.activeSearch = true;
                                weatherApi.coords = cityList.coords;
                                Navigator.pushNamed(context, 'ND');
                              },
                              trailing: value
                                  ? DeleteTrashCanWidgetDrawer(
                                      ontTapCheck: () {
                                        citiesListProvider
                                            .deleteSavedCitiesById(
                                                citiesListP[index].id!);
                                        citiesListProvider.loadSavedCities();
                                        deleteCityListItemButton[index].value =
                                            false;
                                      },
                                      ontTapX: () {
                                        deleteCityListItemButton[index].value =
                                            false;
                                      },
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        deleteCityListItemButton[index].value =
                                            true;
                                      },
                                      child: FadeIn(
                                        delay:
                                            const Duration(milliseconds: 100),
                                        child: const FaIcon(
                                          FontAwesomeIcons.trashCan,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ]),
            ExpansionTile(
              leading: const FaIcon(FontAwesomeIcons.newspaper),
              title: Text(AppLocalizations.of(context)!.newsforread),
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: size.height * 0.55,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: newsListP.length,
                    itemBuilder: (BuildContext context, int index) {
                      final newsList = newsListP[index];
                      return ValueListenableBuilder(
                        valueListenable: deleteNewsListItemButton[index],
                        builder: (context, value, _) {
                          return SavedCardMenuDrawer(
                              leading: SizedBox(
                                height: 50,
                                width: 50,
                                child: (newsList.urlToImage.isNotEmpty &&
                                        newsList.urlToImage.startsWith('http'))
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: FadeInImage(
                                              placeholder: const AssetImage(
                                                  'assets/barra_colores.gif'),
                                              image: NetworkImage(
                                                  newsList.urlToImage)),
                                        ),
                                      )
                                    : const Image(
                                        image:
                                            AssetImage('assets/no-image.png')),
                              ),
                              title: newsList.title,
                              goToAction: () {
                                newsService.launcherUrlString(
                                    context, newsList.url);
                              },
                              trailing: value
                                  ? DeleteTrashCanWidgetDrawer(
                                      ontTapCheck: () {
                                        newsListProvider.deleteNewsById(
                                            newsListP[index].id!);
                                        newsListProvider.loadSavedNews();
                                        deleteNewsListItemButton[index].value =
                                            false;
                                      },
                                      ontTapX: () {
                                        deleteNewsListItemButton[index].value =
                                            false;
                                      },
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        deleteNewsListItemButton[index].value =
                                            true;
                                      },
                                      child: FadeIn(
                                        delay:
                                            const Duration(milliseconds: 100),
                                        child: const FaIcon(
                                          FontAwesomeIcons.trashCan,
                                          size: 20,
                                        ),
                                      )));
                        },
                      );
                    },
                  ),
                )
              ],
            ),

            ExpansionTile(
              childrenPadding: const EdgeInsets.only(left: 30),
              leading: const FaIcon(FontAwesomeIcons.language),
              title: Text(AppLocalizations.of(context)!.language),
              children: [
                ListTile(
                  leading: const Image(
                      image: AssetImage('assets/usa2.png'),
                      width: 25,
                      height: 25),
                  title: Text(AppLocalizations.of(context)!.english),
                  trailing: Switch.adaptive(
                    value: localeProvider.languageEnglish,
                    activeColor: Colors.amber,
                    onChanged: (value) {
                      localeProvider.languageEnglish = value;
                      localeProvider.languageSpanish = false;
                      weatherApi.isEnglish = true;

                      if (!localeProvider.languageEnglish) {
                        localeProvider.languageSpanish = true;
                      }
                      Navigator.pushNamed(context, 'ND');
                    },
                  ),
                ),
                ListTile(
                  leading: const Image(
                      image: AssetImage('assets/spain.png'),
                      width: 25,
                      height: 25),
                  title: Text(AppLocalizations.of(context)!.spanish),
                  trailing: Switch.adaptive(
                    value: localeProvider.languageSpanish,
                    onChanged: (value) {
                      localeProvider.languageSpanish = value;
                      weatherApi.isEnglish = false;
                      localeProvider.languageEnglish = false;
                      if (!localeProvider.languageSpanish) {
                        localeProvider.languageEnglish = true;
                      }
                      Navigator.pushNamed(context, 'ND');
                    },
                  ),
                ),
              ],
            ),

            // const Spacer(),
            SizedBox(height: size.height * 0.5),
            const ListTile(
              title: Center(child: Text('Designed and programed by Juan F.')),
              subtitle: Center(child: Text('All rights reserved @')),
            ),
          ],
        ),
      ]),
    );

    // child:
    // );
  }
}

class _ForeCastTable extends StatelessWidget {
  final List<Forecastday> forecast;
  const _ForeCastTable({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 2, left: 10, right: 10, bottom: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: forecast.length,
          itemBuilder: (BuildContext contex, int index) {
            final fore = forecast[index];
            return ForeCastTable(
              forecast: fore,
            );
          },
          // children: const [
          // ],
        ),
      ),
    );
  }
}

class _InfoTableList extends StatelessWidget {
  final String windData;
  final String humidityData;
  final String visibilityData;
  final String windDirectionData;
  final String temperatureData;
  final String feelsLikeData;
  final String precipitation;
  final String pressure;
  final String uvRays;

  const _InfoTableList(
      {super.key,
      required this.windData,
      required this.humidityData,
      required this.visibilityData,
      required this.windDirectionData,
      required this.temperatureData,
      required this.feelsLikeData,
      required this.precipitation,
      required this.pressure,
      required this.uvRays});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: size.height * 0.18,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          InfoTable(
              image: 'wind.gif',
              title: (AppLocalizations.of(context)!.wind),
              percentage: windData),
          const SizedBox(width: 10),
          InfoTable(
              image: 'drop.gif',
              title: (AppLocalizations.of(context)!.humidity),
              percentage: humidityData),
          const SizedBox(width: 10),
          InfoTable(
              image: 'view.gif',
              title: (AppLocalizations.of(context)!.visibility),
              percentage: visibilityData),
          const SizedBox(width: 10),
          InfoTable(
              image: 'windy.gif',
              title: (AppLocalizations.of(context)!.winddirection),
              percentage: windDirectionData),
          const SizedBox(width: 10),
          InfoTable(
              image: 'temperature.gif',
              title: (AppLocalizations.of(context)!.temperature),
              percentage: temperatureData),
          const SizedBox(width: 10),
          InfoTable(
              image: 'hot.gif',
              title: (AppLocalizations.of(context)!.feelslike),
              percentage: feelsLikeData),
          const SizedBox(width: 10),
          InfoTable(
              image: 'drizzle.gif',
              title: (AppLocalizations.of(context)!.precipitation),
              percentage: precipitation),
          const SizedBox(width: 10),
          InfoTable(
              image: 'gauge.gif',
              title: (AppLocalizations.of(context)!.pressure),
              percentage: pressure),
          const SizedBox(width: 10),
          InfoTable(
              image: 'sun (1).gif',
              title: (AppLocalizations.of(context)!.uvrays),
              percentage: uvRays),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final void Function()? saveLocation;
  final void Function()? refreshPage;
  final void Function()? newsButton;
  const _ActionButtons({
    this.saveLocation,
    this.refreshPage,
    this.newsButton,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedButton(
            text: Text(AppLocalizations.of(context)!.news,
                style: const TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.white)),
            infinite: true,
            icon: const FaIcon(FontAwesomeIcons.newspaper),
            function: newsButton,
          ),
          RoundedButton(
              text: Text(AppLocalizations.of(context)!.savelocation,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.white)),
              infinite: true,
              icon: const FaIcon(
                FontAwesomeIcons.locationDot,
              ),
              function: saveLocation),
          RoundedButton(
            text: Text(AppLocalizations.of(context)!.refresh,
                style: const TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.white)),
            infinite: true,
            // ignore: deprecated_member_use
            icon: const FaIcon(FontAwesomeIcons.refresh),
            function: refreshPage,
          ),
          RoundedButton(
              text: Text(AppLocalizations.of(context)!.searchcity,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.white)),
              infinite: true,
              // ignore: deprecated_member_use
              icon: const FaIcon(FontAwesomeIcons.search),
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const WeatherSearchCity()));
              }),
        ],
      ),
    );
  }
}

class _WeatherState extends StatelessWidget {
  final String weatherState;
  const _WeatherState({
    required this.weatherState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Text(weatherState,
            style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
                color: Colors.white)));
  }
}

class _TemperatureNumber extends StatelessWidget {
  final String tempNumber;

  const _TemperatureNumber({required this.tempNumber});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 20),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = constraints.maxWidth;
          // final screenHeight = constraints.maxHeight;

          double? fontSize;

          if (screenWidth < 768) {
            fontSize = 115;
          } else if (screenWidth < 1024) {
            fontSize = 1;
          }
          return GradientText(tempNumber,
              style: TextStyle(fontSize: fontSize),
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.white.withOpacity(0.5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter));
        },
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final String condition;
  const _Background({required this.condition});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              // transform: GradientTransform,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color.fromARGB(127, 0, 0, 0),
              ],
              stops: [
                0.0,
                1.0,
              ],
              tileMode: TileMode.repeated,
            ).createShader(bounds);
          },
          blendMode: BlendMode.darken,
          child: Container(
            height: size.height * 0.75,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                image: DecorationImage(
                    image: AssetImage(_builBackGroundImage()
                        // _builBackGroundImage()
                        ),
                    fit: BoxFit.fill)),
          ),
        ),
      ),
    ]);
  }

  String _builBackGroundImage() {
    final weatherCondition = condition;

    final Map<String, String> backGrounds = {
      'Partly cloudy': 'assets/red-lighthouse-g1933290b4_640.jpg',
      'Parcialmente nublado': 'assets/red-lighthouse-g1933290b4_640.jpg',
      'niebla moderada': 'assets/fog-g23cb2c869_640.jpg',
      'Heavy rain': 'assets/mountains-g809c71b53_640.jpg',
      'Overcast': 'assets/red-lighthouse-g1933290b4_640.jpg',
      'Fuertes lluvias': 'assets/mountains-g809c71b53_640.jpg',
      'Light rain shower': 'assets/railing-g65bea1cfd_640.jpg',
      'Light rain': 'assets/railing-g65bea1cfd_640.jpg',
      'Lluvia ligera': 'assets/railing-g65bea1cfd_640.jpg',
      'Patchy rain possible': 'assets/railing-g65bea1cfd_640.jpg',
      'Moderate rain': 'assets/railing-g65bea1cfd_640.jpg',
      'Moderate or heavy rain shower': 'assets/mountains-g809c71b53_640.jpg',
      'Lluvia moderada a intervalos': 'assets/heavy-rain-g4ec8672ac_1280.jpg',
      'Lluvia fuerte o moderada': 'assets/railing-g65bea1cfd_640.jpg',
      'Sunny': 'assets/ocean-g87e883915_640.jpg',
      'Soleado': 'assets/ocean-g87e883915_640.jpg',
      'Clear': 'assets/phang-nga-bay-g3332dcc82_640.jpg',
      'Despejado': 'assets/phang-nga-bay-g3332dcc82_640.jpg',
    };
    return backGrounds.containsKey(weatherCondition)
        ? backGrounds[weatherCondition]!
        : 'assets/phang-nga-bay-g3332dcc82_640.jpg';
  }
}

class _HeaderWidget extends StatelessWidget {
  final String location;

  final void Function()? onpressed;

  const _HeaderWidget({this.onpressed, required this.location});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
      child: Row(
        children: [
          const FaIcon(FontAwesomeIcons.locationDot, color: Colors.white),
          const SizedBox(width: 18),
          SizedBox(
            width: size.width * 0.65,
            child: Text(location,
                textScaleFactor: 1,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    // textBaseline: TextBaseline.alphabetic,
                    fontSize: 25,
                    color: Colors.white)),
          ),
          const Spacer(),
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.bars,
              color: Colors.white,
            ),
            onPressed: onpressed,
          )
        ],
      ),
    );
  }
}
