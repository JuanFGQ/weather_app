import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather/widgets/info_table.dart';

import '../models/saved_cities_model.dart';
import '../models/saved_news_model.dart';
import '../providers/cities_list_provider.dart';
import '../providers/localization_provider.dart';
import '../providers/news_list_provider.dart';
import '../services/news_service.dart';
import '../services/weather_api_service.dart';
import '../theme/theme_changer.dart';
import '../widgets/gradient_text_widget.dart';
import '../widgets/rounded_button.dart';

class NewsDesignPage extends StatefulWidget {
  // final String title;
  // final String lastUpdateDate;
  // final String lastUpdateTime;
  // final String locationCountry;
  // final String currentCOndition;
  // final String currentFeelsLikeNumber;
  // final String windData;
  // final String humidityData;

  // final String visibilityData;
  // final String windDirectionData;
  // final String temperatureData;
  // final String feelsLikeData;
  // final Color scaffoldColor;
  // final Color appBarColors;
  // final Color locCountryColor;
  // final void Function()? newsButton;
  // final void Function()? saveLocationButton;

  // final void Function()? refreshButton;

  // final bool isVisibleButton;
  const NewsDesignPage({
    super.key,
    // required this.title,
    // required this.lastUpdateDate,
    // required this.lastUpdateTime,
    // required this.locationCountry,
    // required this.currentCOndition,
    // required this.currentFeelsLikeNumber,
    // required this.windData,
    // required this.humidityData,
    // required this.visibilityData,
    // required this.windDirectionData,
    // required this.temperatureData,
    // required this.feelsLikeData,
    // required this.scaffoldColor,
    // required this.appBarColors,
    // required this.locCountryColor,
    // this.newsButton,
    // this.saveLocationButton,
    // this.refreshButton,
    // required this.isVisibleButton
  });

  @override
  State<NewsDesignPage> createState() => _NewsDesignPageState();
}

class _NewsDesignPageState extends State<NewsDesignPage>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController;
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
        body: Stack(
          children: [
            const _Background(),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _HeaderWidget(
                  globalKey: _globalKey,
                  animationcontroller: _animationController,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    // margin: EdgeInsets.only(top: 100, left: 20),
                    margin: EdgeInsets.only(left: 20),
                    child: GradientText('10º',
                        style: TextStyle(fontSize: 150),
                        gradient: LinearGradient(
                            colors: [Colors.white, Colors.white.withAlpha(0)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter))),
                SizedBox(height: 20),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text('Parcialmente nublado',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Colors.white))),
                SizedBox(height: 100),
                Row(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                RoundedButton(
                                  text: Text(AppLocalizations.of(context)!.news,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white)),
                                  infinite: true,
                                  icon: FaIcon(FontAwesomeIcons.newspaper),
                                  // function: widget.newsButton
                                ),
                                RoundedButton(
                                  text: Text(
                                      AppLocalizations.of(context)!
                                          .savelocation,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white)),
                                  infinite: true,
                                  icon: FaIcon(FontAwesomeIcons.locationDot),
                                  // function: widget.saveLocationButton
                                ),
                                RoundedButton(
                                  text: Text(
                                      AppLocalizations.of(context)!.refresh,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white)),
                                  infinite: true,
                                  icon: FaIcon(FontAwesomeIcons.refresh),
                                  // function: widget.refreshButton,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              InfoIcon(
                                  image: 'wind.gif',
                                  title: 'Wind Dir ',
                                  percentage: '10º'),
                              SizedBox(height: 5),
                              InfoIcon(
                                  image: 'drop.gif',
                                  title: 'Humidity ',
                                  percentage: '10º'),
                              SizedBox(height: 5),
                              InfoIcon(
                                  image: 'view.gif',
                                  title: 'Visibility ',
                                  percentage: '10º'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}

class _Background extends StatelessWidget {
  const _Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/car-lights-g37625adef_1280.jpg'),
              fit: BoxFit.fill)),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  final AnimationController animationcontroller;

  const _HeaderWidget({
    super.key,
    required GlobalKey<ScaffoldState> globalKey,
    required this.animationcontroller,
    // required this.animation,
  }) : _globalKey = globalKey;

  final GlobalKey<ScaffoldState> _globalKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          // Drawer(),

          FaIcon(FontAwesomeIcons.locationDot, color: Colors.white),
          SizedBox(width: 18),
          Text('Guadalajara',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  color: Colors.white)),
          Spacer(),

          // AnimatedIcon(icon: AnimatedIconData.

          // , progress: progress),

          IconButton(
              onPressed: () {
                _globalKey.currentState!.openDrawer();
                animationcontroller.forward();
              },
              icon: AnimatedIcon(
                  icon: AnimatedIcons.arrow_menu, progress: animationcontroller)

              // FaIcon(FontAwesomeIcons.caretDown, color: Colors.white)
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
