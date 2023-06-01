import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/news/articles_info.dart';
import 'package:weather/models/news/news_response.dart';
import 'package:weather/models/save_news_class.dart';
import 'package:weather/pages/no_data_page.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';
import 'package:weather/widgets/circular_progress_indicator.dart';
import 'package:weather/widgets/news_card.dart';

import '../widgets/description_news_card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsService? newsService;
  WeatherApiService? weatherServ;

  @override
  void initState() {
    newsService = Provider.of<NewsService>(context, listen: false);
    weatherServ = Provider.of<WeatherApiService>(context, listen: false);

    argumentSelector();
  }

  String argumentSelector() {
/*
simplemente al iniciar verifica el estado de la variable si es verdadera me retorna el argumento 
cargado en la pantalla de busqueda . otherwhise carga el argumento de la pantalla home 
*/

    if (!newsService!.activeSearch) {
      final homeArg = '${weatherServ!.location!.name}';
      return homeArg;
    } else {
      final foundArg = '${weatherServ!.foundLocation!.name}';
      return foundArg;
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return FutureBuilder(
        future: newsService.getNewsByFoundedPlace(argumentSelector()),
        builder: (BuildContext context, AsyncSnapshot<NewsResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularIndicator();
          } else if (snapshot.hasData && snapshot.data!.articles.isEmpty) {
            return NoDataPage();
          } else {
            return _NewsViewer(snapshot.data!.articles);
          }
        });
  }
}

class _NewsViewer extends StatefulWidget {
  final List<Article> news;

  _NewsViewer(this.news);

  @override
  State<_NewsViewer> createState() => _NewsViewerState();
}

class _NewsViewerState extends State<_NewsViewer>
    with TickerProviderStateMixin {
  List<Article> orderedNews = []; //store the new ordered list of news
  bool descAsc = false; //flags to show desc or asc list
  late Animation<double> _myAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    orderedNews = List.from(widget
        .news); //here i match the instanceS of the list created with the list i receive in class arguments

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _myAnimation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    orderNewsByDate();
  }

  void orderNewsByDate() {
    setState(() {
      if (descAsc) {
        orderedNews.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
        _controller.forward();
      } else {
        orderedNews.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
        _controller.reverse();
      }
      descAsc = !descAsc;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
                  ),
                  margin: EdgeInsets.only(left: 10),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'All news',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    orderNewsByDate();
                  },
                  child: Container(
                      margin: EdgeInsets.all(10),
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber),
                      child: (descAsc)
                          ? const _DescAscButton(
                              icon: Icons.arrow_upward, text: 'Desc')
                          : const _DescAscButton(
                              icon: Icons.arrow_downward, text: 'Asc')),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                width: size.width * 1,
                // color: Colors.red,
                child: ListView.builder(
                    shrinkWrap: false,
                    itemCount: orderedNews.length,
                    itemBuilder: (_, i) {
                      final selNews = orderedNews[i];

                      return ElasticIn(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 500),
                        child: DescriptionNewsCard(
                          onPressed: () {
                            getSelectedNews(selNews);
                          },
                          news: orderedNews[i],
                          index: i,
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getSelectedNews(Article selNews) {
    // List<SavedNews> saveNewsList = [];

    // final newsList =
    //     Provider.of<NewsService>(context, listen: false).savedNewsList;

    // SavedNews saveN = SavedNews(
    //     title: selNews.title,
    //     url: selNews.url!,
    //     urlToImage: selNews.urlToImage!);

    // newsList.insert(0, saveN);

    // setState(() {});
  }
}

class _DescAscButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const _DescAscButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
        Icon(icon, size: 15)
      ],
    );
  }
}
