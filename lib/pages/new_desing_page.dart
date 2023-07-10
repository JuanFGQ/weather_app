import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/news_page.dart';
import 'package:weather/widgets/forecast_table.dart';
import 'package:weather/widgets/info_table.dart';

import '../models/saved_cities_model.dart';
import '../models/saved_news_model.dart';
import '../providers/cities_list_provider.dart';
import '../providers/localization_provider.dart';
import '../providers/news_list_provider.dart';
import '../services/image_service.dart';
import '../services/news_service.dart';
import '../services/weather_api_service.dart';
import '../theme/theme_changer.dart';
import '../widgets/gradient_text_widget.dart';
import '../widgets/rounded_button.dart';

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
  final Color scaffoldColor;
  final Color appBarColors;
  final Color locCountryColor;
  final void Function()? newsButton;
  final void Function()? saveLocationButton;

  final void Function()? refreshButton;

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
      required this.scaffoldColor,
      required this.appBarColors,
      required this.locCountryColor,
      this.newsButton,
      this.saveLocationButton,
      this.refreshButton,
      required this.isVisibleButton});

  @override
  State<NewsDesignPage> createState() => _NewsDesignPageState();
}

class _NewsDesignPageState extends State<NewsDesignPage>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<String> popularPhotos = [];
  String searchText = '';

  ImageService? imageService;
  WeatherApiService? weatherServ;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsListProvider = Provider.of<NewsListProvider>(context);
    final newsListP = newsListProvider.news;
    final citiesListProvider = Provider.of<CitiesListProvider>(context);
    final citiesListP = citiesListProvider.cities;
    final localeProvider = Provider.of<LocalizationProvider>(context);
    final appTheme = Provider.of<ThemeChanger>(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
        key: _globalKey,
        drawer: Drawer(
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
                    leading: const FaIcon(FontAwesomeIcons.paintRoller),
                    title: Text(AppLocalizations.of(context)!.themes),
                    children: [
                      ListTile(
                          leading: const Icon(Icons.format_paint_outlined),
                          title: Text(AppLocalizations.of(context)!.darktheme),
                          onTap: () {},
                          trailing: Switch.adaptive(
                              value: appTheme.darkTheme,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                appTheme.darkTheme = value;
                              })),
                      ListTile(
                          leading: const Icon(Icons.format_paint_outlined),
                          title: Text(AppLocalizations.of(context)!.lighttheme),
                          onTap: () {},
                          trailing: Switch.adaptive(
                              value: appTheme.customTheme,
                              activeColor: Colors.red,
                              onChanged: (value) {
                                appTheme.customTheme = value;
                              })),
                    ]),
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
                            if (!localeProvider.languageEnglish) {
                              localeProvider.languageSpanish = true;
                            }
                          }),
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
                            localeProvider.languageEnglish = false;
                            if (!localeProvider.languageSpanish) {
                              localeProvider.languageEnglish = true;
                            }
                          }),
                    ),
                  ],
                ),

                // const Spacer(),
                SizedBox(height: size.height * 0.5),
                const ListTile(
                  title:
                      Center(child: Text('Designed and programed by Juan F.')),
                  subtitle: Center(child: Text('All rights reserved @')),
                ),
              ],
            ),
          ]),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                const _Background(),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _HeaderWidget(
                      onpressed: () {
                        _globalKey.currentState!.openDrawer();
                      },
                      location: widget.locationCountry,
                    ),
                    _TemperatureNumber(
                      tempNumber: widget.temperatureData,
                    ),
                    SizedBox(height: 20),
                    _WeatherState(
                      weatherState: widget.currentCOndition,
                    ),
                    // SizedBox(height: 100),
                    _ActionButtons(
                      saveLocation: widget.saveLocationButton,
                      newsButton: widget.newsButton,
                      refreshPage: widget.refreshButton,
                    ),
                    SizedBox(height: 20),
                    _InfoTableList(
                      size: size,
                      feelsLikeData: widget.feelsLikeData,
                      humidityData: widget.humidityData,
                      temperatureData: widget.temperatureData,
                      visibilityData: widget.visibilityData,
                      windData: widget.windData,
                      windDirectionData: widget.windDirectionData,
                    ),
                    // _ForeCastTable()
                  ],
                ),
              ],
            ),
            _ForeCastTable()
          ],
        ));
  }
}

class _ForeCastTable extends StatelessWidget {
  const _ForeCastTable({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        // color: Colors.red,
        // height: size.height * 0.3,
        // width: size.width * 0.3,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            ForeCastTable(),
            ForeCastTable(),
            ForeCastTable(),
            ForeCastTable(),
            ForeCastTable(),
            ForeCastTable(),
            ForeCastTable(),
          ],
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

  const _InfoTableList({
    super.key,
    required this.size,
    required this.windData,
    required this.humidityData,
    required this.visibilityData,
    required this.windDirectionData,
    required this.temperatureData,
    required this.feelsLikeData,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      // color: Colors.red,
      width: double.infinity,
      height: size.height * 0.18,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          InfoTable(
              image: 'wind.gif',
              title: (AppLocalizations.of(context)!.humidity),
              percentage: windData),
          SizedBox(width: 10),
          InfoTable(
              image: 'drop.gif',
              title: (AppLocalizations.of(context)!.humidity),
              percentage: humidityData),
          SizedBox(width: 10),
          InfoTable(
              image: 'view.gif',
              title: (AppLocalizations.of(context)!.humidity),
              percentage: visibilityData),
          SizedBox(width: 10),
          InfoTable(
              image: 'windy.gif',
              title: (AppLocalizations.of(context)!.humidity),
              percentage: windDirectionData),
          SizedBox(width: 10),
          InfoTable(
              image: 'temperature.gif',
              title: (AppLocalizations.of(context)!.humidity),
              percentage: temperatureData),
          SizedBox(width: 10),
          InfoTable(
              image: 'hot.gif',
              title: (AppLocalizations.of(context)!.humidity),
              percentage: feelsLikeData),
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
    super.key,
    this.saveLocation,
    this.refreshPage,
    this.newsButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.white,
        margin: EdgeInsets.all(20),
        // color: Colors.white,
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
                icon: const FaIcon(FontAwesomeIcons.locationDot),
                function: saveLocation),
            RoundedButton(
              text: Text(AppLocalizations.of(context)!.refresh,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.white)),
              infinite: true,
              icon: const FaIcon(FontAwesomeIcons.refresh),
              function: refreshPage,
            ),
          ],
        ));
  }
}

class _WeatherState extends StatelessWidget {
  final String weatherState;
  const _WeatherState({
    super.key,
    required this.weatherState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20),
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

  const _TemperatureNumber({super.key, required this.tempNumber});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20),
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
  const _Background({
    super.key,
  });

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
                Color.fromARGB(207, 0, 0, 0),
              ],
              stops: [
                0.0,
                3.0,
              ],
              tileMode: TileMode.repeated,
            ).createShader(bounds);
          },
          blendMode: BlendMode.darken,
          child: Container(
            height: size.height * 0.75,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                image: DecorationImage(
                    image: AssetImage('assets/field-gdc2e8bedd_1280.jpg'),
                    fit: BoxFit.fill)),
          ),
        ),
      ),
    ]);
  }
}

class _HeaderWidget extends StatelessWidget {
  final String location;

  final void Function()? onpressed;

  const _HeaderWidget({this.onpressed, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
      child: Row(
        children: [
          const FaIcon(FontAwesomeIcons.locationDot, color: Colors.white),
          const SizedBox(width: 18),
          Text(location,
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  // textBaseline: TextBaseline.alphabetic,
                  fontSize: 25,
                  color: Colors.white)),
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
      margin: EdgeInsets.all(6),
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
                  margin: EdgeInsets.all(2),
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
        leading: Container(
          // color: Colors.blue,
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
            ? Container(
                // color: Colors.red,
                child: GestureDetector(
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
                    )),
              )
            : FadeIn(
                delay: const Duration(milliseconds: 100),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[200],
                      boxShadow: [
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
