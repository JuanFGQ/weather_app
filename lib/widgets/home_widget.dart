import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/saved_cities_model.dart';
import 'package:weather/providers/cities_list_provider.dart';

import 'package:weather/providers/news_list_provider.dart';
import 'package:weather/search/search_delegate_widget.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/widgets/rounded_button.dart';

import '../models/saved_news_model.dart';
import 'info_table.dart';
import 'letras.dart';

class HomeWidget extends StatefulWidget {
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

  const HomeWidget({
    super.key,
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
    this.refreshButton,
    this.saveLocationButton,
    required this.isVisibleButton,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();

    final loadNews = Provider.of<NewsListProvider>(context, listen: false);
    final loadCities = Provider.of<CitiesListProvider>(context, listen: false);
// load saved cities and news list before homewidget was build, this to see list in expansionTile widget
    loadCities.loadSavedCities();
    loadNews.loadSavedNews();
  }

  @override
  Widget build(BuildContext context) {
    double heighval = MediaQuery.of(context).size.height * 0.01;
    double valMult = 10;
    final newsListProvider = Provider.of<NewsListProvider>(context);
    final newsListP = newsListProvider.news;
    final citiesListProvider = Provider.of<CitiesListProvider>(context);
    final citiesListP = citiesListProvider.cities;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const WeatherSearchCity())),
                icon: const FaIcon(FontAwesomeIcons.search)),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: widget.appBarColors,
          elevation: 0,
          centerTitle: true,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 40)),
          )
          //
          ),
      backgroundColor: widget.scaffoldColor,
      drawer: Drawer(
        child: ListView(children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Home',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30))),
              ),

              ExpansionTile(
                  leading: const FaIcon(FontAwesomeIcons.heartCircleCheck),
                  title: const Text('Favorites places'),
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
                title: const Text('News for read'),
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
                  title: const Text('Themes'),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.format_paint_outlined),
                      title: const Text('Dark Theme'),
                      onTap: () {},
                      trailing: const CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.format_paint_outlined),
                      title: const Text('Light Theme'),
                      onTap: () {},
                      trailing: const CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ]),
              const ExpansionTile(
                childrenPadding: EdgeInsets.only(left: 30),
                leading: FaIcon(FontAwesomeIcons.language),
                title: Text('Language'),
                children: [
                  ListTile(
                      leading: Image(
                          image: AssetImage('assets/usa2.png'),
                          width: 25,
                          height: 25),
                      title: Text('English')),
                  ListTile(
                      leading: Image(
                          image: AssetImage('assets/spain.png'),
                          width: 25,
                          height: 25),
                      title: Text('Castellano')),
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          Words(
            date: widget.locationCountry,
            wordColor: widget.locCountryColor,
            // wordSize: 20,
          ),
          const SizedBox(height: 5),
          FadeInUp(
            from: 50,
            child: Text(
              widget.currentCOndition,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: size.width * 0.9,
            child: Stack(
              children: [
                Center(
                  child: ElasticIn(
                    delay: const Duration(milliseconds: 600),
                    child: Expanded(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          widget.feelsLikeData,
                          style: TextStyle(fontSize: valMult * heighval),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                RoundedButton(
                  text: Text('News'),
                  infinite: true,
                  icon: FaIcon(FontAwesomeIcons.newspaper),
                  function: widget.newsButton,
                ),
              ]),
              Column(
                children: [
                  RoundedButton(
                    text: Text('Save location'),
                    infinite: true,
                    icon: FaIcon(FontAwesomeIcons.locationDot),
                    function: widget.saveLocationButton,
                  ),
                ],
              ),
              Visibility(
                visible: widget.isVisibleButton,
                child: Column(
                  children: [
                    RoundedButton(
                      text: Text('Refresh'),
                      infinite: true,
                      icon: FaIcon(FontAwesomeIcons.refresh),
                      function: widget.refreshButton,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          // const InfoTable(),
          InfoIcon(
              image: 'wind.gif', title: 'Wind', percentage: widget.windData),
          InfoIcon(
              image: 'drop.gif',
              title: 'Humidity',
              percentage: widget.humidityData),
          InfoIcon(
              image: 'view.gif',
              title: 'Visibility',
              percentage: widget.visibilityData),
          InfoIcon(
              image: 'windy.gif',
              title: 'Wind direction',
              percentage: widget.windDirectionData),
          InfoIcon(
              image: 'temperature.gif',
              title: 'Temperature',
              percentage: widget.temperatureData),
          InfoIcon(
            image: 'hot.gif',
            title: 'Feels like',
            percentage: widget.feelsLikeData,
          ),

          const SizedBox(height: 10),

          // const SizedBox(height: 10),
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
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.amber),
      child: ListTile(
        leading: Text(widget.savedCities.temperature),
        title: Center(child: Text(widget.savedCities.title)),
        subtitle: Column(
          children: [
            Text(widget.savedCities.wind, style: TextStyle(fontSize: 15)),
            Text(widget.savedCities.updated, style: TextStyle(fontSize: 10)),
          ],
        ),
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
                    color: Colors.red,
                  ),
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
          borderRadius: BorderRadius.circular(30), color: Colors.amber),
      child: ListTile(
        leading: CircleAvatar(
          child: (widget.saveNews.urlToImage.isNotEmpty &&
                  widget.saveNews.urlToImage.startsWith('http'))
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: FadeInImage(
                      placeholder: const AssetImage('assets/barra_colores.gif'),
                      image: NetworkImage(widget.saveNews.urlToImage)),
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
                    color: Colors.red,
                  ),
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
