import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/save_news_class.dart';
import 'package:weather/preferences/share_prefs.dart';
import 'package:weather/search/search_delegate_widget.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/widgets/rounded_button.dart';

import '../services/weather_api_service.dart';
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
  final void Function()? function;
  final void Function()? refreshButton;
  final bool showRefreshButton;

  const HomeWidget(
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
      this.function,
      this.refreshButton,
      required this.showRefreshButton});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
<<<<<<< HEAD
=======
  List<SavedNews> saveNewsList = [];

  NewsService? newsService;

  @override
  void initState() {
    super.initState();
    newsService = Provider.of<NewsService>(context, listen: false);

    newsService!.getSavedNewsList().then((list) {
      setState(() {
        saveNewsList = list;
      });
    });
  }

>>>>>>> 2c9805188b2f2fbdac1f1bd08dc982f347d6b0e8
  @override
  Widget build(BuildContext context) {
    double heighval = MediaQuery.of(context).size.height * 0.01;
    double valMult = 10;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: widget.scaffoldColor,
      drawer: Drawer(
        child: ListView(children: [
          Column(
            // padding: EdgeInsets.zero,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Home',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30))),
              ),
              const _ListTileItemContent(
                  widget: CircleAvatar(
                child: Image(image: AssetImage('assets/horus-eye.png')),
              )),
              // const DrawerHeader(
              //     decoration: BoxDecoration(color: Colors.blue),
              //     child: Text('hola')),
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
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return _ListTileItemContent(
                              widget: FaIcon(FontAwesomeIcons.locationDot));
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
                        itemCount: saveNewsList.length,
                        // savedNews.length,
                        itemBuilder: (BuildContext context, int index) {
                          final saveN = saveNewsList[index];
                          return _ListNewsItemContent(saveNews: saveN);
                        },
                      ),
                    )
                  ]),
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
                  // ListTile(
                  //     leading: Image(
                  //         image: AssetImage('assets/spain.png'),
                  //         width: 25,
                  //         height: 25),
                  //     title: Text('Ruso')),
                ],
              ),

              // const Spacer(),
              SizedBox(height: size.height * 0.5),
              const ListTile(
                title: Center(child: Text('Designed and programed by Juan F.')),
                subtitle: Center(child: Text('All rights reserved @')),
              ),
            ],
            // prototypeItem: ,
          ),
        ]),
      ),
      appBar: AppBar(
          actions: [
            // Visibility(
            //   visible: showRefreshButton,
            //   child: FittedBox(
            //     fit: BoxFit.values[5],
            //     child: RawMaterialButton(
            //       elevation: 10,
            //       onPressed: refreshButton,
            //       shape: CircleBorder(),
            //       fillColor: Colors.white,
            //       child: Spin(
            //         duration: Duration(milliseconds: 5000),
            //         infinite: true,
            //         child: const FaIcon(
            //           FontAwesomeIcons.refresh,
            //           size: 18,
            //         ),
            //       ),
            //       // constraints: ,
            //     ),
            //   ),
            // )
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const WeatherSearchCity())),
                icon: const FaIcon(FontAwesomeIcons.search)),
          ],
          // leading: IconButton(
          //     onPressed: () => Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (BuildContext context) => WeatherSearchCity())),

          //     // showSearch(
          //     //     context: context, delegate: WeatherSearchDelegate()),
          //     icon: const FaIcon(FontAwesomeIcons.search)),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const Text(
          //   'LastUpdate',
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          // ),
          // Text(lastUpdateDate),
          // Text(lastUpdateTime),

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
                  infinite: true,
                  icon: FaIcon(FontAwesomeIcons.newspaper),
                  function: widget.function,
                ),
                Text('News')
              ]),
              Column(
                children: [
                  RoundedButton(
                    infinite: true,
                    icon: FaIcon(FontAwesomeIcons.locationDot),
                    function: widget.function,
                  ),
                  Text('Save')
                ],
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

class _ListTileItemContent extends StatelessWidget {
  final Widget widget;
  const _ListTileItemContent({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.amber),
      child: ListTile(
        leading: widget,
        title: Text('Name city'),
        subtitle: Text('weather state'),
        trailing: Text('20º'),
      ),
    );
  }
}

class _ListNewsItemContent extends StatelessWidget {
  final SavedNews saveNews;

  const _ListNewsItemContent({super.key, required this.saveNews});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.amber),
      child: ListTile(
        leading: CircleAvatar(
          child: (saveNews.urlToImage.isNotEmpty &&
                  saveNews.urlToImage.startsWith('http'))
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: FadeInImage(
                        placeholder:
                            const AssetImage('assets/barra_colores.gif'),
                        image: NetworkImage(saveNews.urlToImage)),
                  ),
                )
              : const FittedBox(
                  fit: BoxFit.fill,
                  child: Image(image: AssetImage('assets/no-image.png'))),
        ),
        title: Text(saveNews.title),
        onTap: () {
          //todo: launcher url
          print(saveNews.url);
        },
      ),
    );
  }
}
