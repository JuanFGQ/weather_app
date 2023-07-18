import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../search/search_delegate_widget.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class NewsDesignPage extends StatefulWidget {
  final String title;
  final String lastUpdateDate;
  final String lastUpdateTime;
  final String locationCountry;
  final String currentCOndition;
  final String currentFeelsLikeNumber;
  final String windData;
  final String humidityData;

  final String visibilityData;
  final String windDirectionData;
  final String temperatureData;
  final String feelsLikeData;
  final String precipitation;
  final String pressure;
  final String uvRays;

  final void Function()? newsButton;
  final void Function()? saveLocationButton;

  final void Function()? refreshButton;

  final void Function(bool)? onChangedEnglish;
  final void Function(bool)? onChangedSpanish;

  final bool isVisibleButton;
  const NewsDesignPage(
      {super.key,
      required this.title,
      required this.lastUpdateDate,
      required this.lastUpdateTime,
      required this.locationCountry,
      required this.currentCOndition,
      required this.currentFeelsLikeNumber,
      required this.windData,
      required this.humidityData,
      required this.visibilityData,
      required this.windDirectionData,
      required this.temperatureData,
      required this.feelsLikeData,
      // required this.scaffoldColor,
      // required this.appBarColors,
      // required this.locCountryColor,
      this.newsButton,
      this.saveLocationButton,
      this.refreshButton,
      required this.isVisibleButton,
      this.onChangedEnglish,
      this.onChangedSpanish,
      required this.precipitation,
      required this.pressure,
      required this.uvRays});

  @override
  State<NewsDesignPage> createState() => _NewsDesignPageState();
}

class _NewsDesignPageState extends State<NewsDesignPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<String> popularPhotos = [];
  String searchText = '';

  ImageService? imageService;
  WeatherApiService? weatherServ;

  @override
  void initState() {
    super.initState();
    weatherServ = Provider.of<WeatherApiService>(context, listen: false);

    final loadNews = Provider.of<NewsListProvider>(context, listen: false);
    final loadCities = Provider.of<CitiesListProvider>(context, listen: false);
// load saved cities and news list before homewidget was build, this to see list in expansionTile widget
    loadCities.loadSavedCities();
    loadNews.loadSavedNews();
  }

  @override
  Widget build(BuildContext context) {
    final newsListProvider = Provider.of<NewsListProvider>(context);
    final newsListP = newsListProvider.news;
    final citiesListProvider = Provider.of<CitiesListProvider>(context);
    final citiesListP = citiesListProvider.cities;
    final localeProvider = Provider.of<LocalizationProvider>(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 198, 199, 172),
        key: _globalKey,
        drawer: _MenuDrawer(
          onChangedEnglish: widget.onChangedEnglish,
          onChangedSpanish: widget.onChangedSpanish,
          size: size,
          citiesListP: citiesListP,
          newsListP: newsListP,
          localeProvider: localeProvider,
        ),
        body: Column(
          children: [
            Stack(
              children: [
                _Background(
                  forecast: widget.currentCOndition,
                ),
                Column(
                  children: [
                    _HeaderWidget(
                      onpressed: () {
                        _globalKey.currentState!.openDrawer();
                      },
                      location: widget.title,
                    ),
                    _TemperatureNumber(
                      tempNumber: widget.temperatureData,
                    ),
                    const SizedBox(height: 20),
                    _WeatherState(
                      weatherState: widget.currentCOndition,
                    ),
                    // SizedBox(height: 100),
                    _ActionButtons(
                      saveLocation: widget.saveLocationButton,
                      newsButton: widget.newsButton,
                      refreshPage: widget.refreshButton,
                    ),
                    const SizedBox(height: 20),
                    _InfoTableList(
                      size: size,
                      feelsLikeData: widget.feelsLikeData,
                      humidityData: widget.humidityData,
                      temperatureData: widget.temperatureData,
                      visibilityData: widget.visibilityData,
                      windData: widget.windData,
                      windDirectionData: widget.windDirectionData,
                      precipitation: widget.precipitation,
                      pressure: widget.pressure,
                      uvRays: widget.uvRays,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Weekly Forecast',
                    style: TextStyle(
                        // decoration: TextDecoration.underline,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  FaIcon(FontAwesomeIcons.arrowRight)
                ],
              ),
            ),
            _ForeCastTable(
              forecast: weatherServ!.forecast!,
            )
          ],
        ));
  }
}

class _MenuDrawer extends StatelessWidget {
  const _MenuDrawer({
    required this.size,
    required this.citiesListP,
    required this.newsListP,
    required this.localeProvider,
    this.onChangedEnglish,
    this.onChangedSpanish,
  });

  final Size size;
  final List<SavedCitiesModel> citiesListP;
  final List<SavedNewsModel> newsListP;
  final LocalizationProvider localeProvider;
  final void Function(bool)? onChangedEnglish;
  final void Function(bool)? onChangedSpanish;

  @override
  Widget build(BuildContext context) {
    // final weatherServ = Provider.of<WeatherApiService>(context);

    return Drawer(
      // shape: ShapeBorder.c,
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
                        return _SavedCitiesCard(
                          selectedDelete: citiesListP[index].id,
                          savedCities: cityList,
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
                      return _SavedNewsCard(
                        selectedDelete: newsListP[index].id,
                        saveNews: newsList,
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
                      onChanged: onChangedEnglish),
                ),
                ListTile(
                  leading: const Image(
                      image: AssetImage('assets/spain.png'),
                      width: 25,
                      height: 25),
                  title: Text(AppLocalizations.of(context)!.spanish),
                  trailing: Switch.adaptive(
                      value: localeProvider.languageSpanish,
                      onChanged: onChangedSpanish),
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

  const _InfoTableList({
    required this.size,
    required this.windData,
    required this.humidityData,
    required this.visibilityData,
    required this.windDirectionData,
    required this.temperatureData,
    required this.feelsLikeData,
    required this.precipitation,
    required this.pressure,
    required this.uvRays,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      // color: Colors.red,
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
              icon: Spin(
                // animate: saveCitiesProvider.isPressedSaveButton,
                // controller: ,
                child: const FaIcon(
                  FontAwesomeIcons.locationDot,
                ),
              ),
              //         color: Colors.red),
              // (!saveCitiesProvider.isPressedSaveButton)
              //     ? const FaIcon(FontAwesomeIcons.locationDot,
              //         color: Colors.black)
              //     : const FaIcon(FontAwesomeIcons.locationDot,
              //         color: Colors.red),
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
            function: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const WeatherSearchCity())),
          ),
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
  final String forecast;
  const _Background({required this.forecast});

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
    final weatherCondition = forecast;

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

class _SavedCitiesCard extends StatefulWidget {
  final SavedCitiesModel savedCities;
  final int? selectedDelete;
  const _SavedCitiesCard({
    required this.savedCities,
    this.selectedDelete,
  });

  @override
  State<_SavedCitiesCard> createState() => _SavedCitiesCardState();
}

class _SavedCitiesCardState extends State<_SavedCitiesCard> {
  CitiesListProvider? citiesListProvider;
  @override
  void initState() {
    citiesListProvider =
        Provider.of<CitiesListProvider>(context, listen: false);

    super.initState();
  }

  bool deleteNews = false;

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherApiService>(context);

    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 6.0)
          ]),
      child: ListTile(
        // leading: Text(widget.savedCities.temperature),
        title: GestureDetector(
          onTap: () {
            weather.coords = widget.savedCities.coords;
            Navigator.pushNamed(context, 'founded');
          },
          child: Center(
            child: Bounce(
              delay: const Duration(milliseconds: 200),
              infinite: true,
              from: 2,
              child: Text(
                widget.savedCities.title,
              ),
            ),
          ),
        ),
        // subtitle: Column(
        //   children: [
        //     Text(widget.savedCities.wind, style: TextStyle(fontSize: 15)),
        //     Text(widget.savedCities.updated, style: TextStyle(fontSize: 10)),
        //   ],
        // ),
        trailing: (!deleteNews)
            ? GestureDetector(
                onTap: () {
                  deleteNews = true;
                  setState(() {});
                },
                child: FadeIn(
                  delay: const Duration(milliseconds: 200),
                  child: const FaIcon(
                    FontAwesomeIcons.trashCan,
                    size: 20,
                  ),
                ))
            : FadeIn(
                delay: const Duration(milliseconds: 100),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[200],
                      boxShadow: const [
                        BoxShadow(offset: Offset(0.0, 1.0), blurRadius: 3.0)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            citiesListProvider!
                                .deleteSavedCitiesById(widget.selectedDelete!);

                            // newsListProvider!.deleteAllSavedNews();

                            citiesListProvider!.loadSavedCities();
                            deleteNews = false;
                            setState(() {});
                          },
                          child: FadeInUp(
                            from: 15,
                            // delay: const Duration(milliseconds: 100),
                            child: const FaIcon(
                              FontAwesomeIcons.check,
                              size: 15,
                              color: Colors.white54,
                            ),
                          )),
                      const SizedBox(height: 6),
                      GestureDetector(
                          onTap: () {
                            deleteNews = false;
                            setState(() {});
                          },
                          child: FadeInDown(
                            from: 15,
                            // delay: const Duration(milliseconds: 100),
                            child: const FaIcon(FontAwesomeIcons.x,
                                size: 15, color: Colors.white54),
                          ))
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _SavedNewsCard extends StatefulWidget {
  final SavedNewsModel saveNews;
  final int? selectedDelete;

  const _SavedNewsCard({
    required this.saveNews,
    this.selectedDelete,
  });

  @override
  State<_SavedNewsCard> createState() => _SavedNewsCardState();
}

class _SavedNewsCardState extends State<_SavedNewsCard> {
  NewsListProvider? newsListProvider;

  @override
  void initState() {
    super.initState();
    newsListProvider = Provider.of<NewsListProvider>(context, listen: false);
  }

  bool deleteNews = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 6.0)
          ]),
      child: ListTile(
        leading: SizedBox(
          height: 50,
          width: 50,
          child: (widget.saveNews.urlToImage.isNotEmpty &&
                  widget.saveNews.urlToImage.startsWith('http'))
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: FadeInImage(
                        placeholder:
                            const AssetImage('assets/barra_colores.gif'),
                        image: NetworkImage(widget.saveNews.urlToImage)),
                  ),
                )
              : const Image(image: AssetImage('assets/no-image.png')),
        ),
        title: GestureDetector(
            onTap: () {
              final newsService =
                  Provider.of<NewsService>(context, listen: false);
              newsService.launcherUrlString(context, widget.saveNews.url);
            },
            child: Text(widget.saveNews.title)),
        trailing: (!deleteNews)
            ? GestureDetector(
                onTap: () {
                  deleteNews = true;
                  setState(() {});
                },
                child: FadeIn(
                  delay: const Duration(milliseconds: 200),
                  child: const FaIcon(
                    FontAwesomeIcons.trashCan,
                    size: 20,
                  ),
                ))
            : FadeIn(
                delay: const Duration(milliseconds: 100),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[200],
                      boxShadow: const [
                        BoxShadow(offset: Offset(0.0, 1.0), blurRadius: 3.0)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            newsListProvider!
                                .deleteNewsById(widget.selectedDelete!);

                            // newsListProvider!.deleteAllSavedNews();

                            newsListProvider!.loadSavedNews();
                            deleteNews = false;
                            setState(() {});
                          },
                          child: FadeInUp(
                            from: 15,
                            delay: const Duration(milliseconds: 150),
                            child: const FaIcon(
                              FontAwesomeIcons.check,
                              size: 15,
                              color: Colors.white54,
                            ),
                          )),
                      const SizedBox(height: 6),
                      GestureDetector(
                          onTap: () {
                            deleteNews = false;
                            setState(() {});
                          },
                          child: FadeInDown(
                            from: 15,
                            delay: const Duration(milliseconds: 150),
                            child: const FaIcon(FontAwesomeIcons.x,
                                size: 15, color: Colors.white54),
                          ))
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
