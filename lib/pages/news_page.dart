import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/news/articles_info.dart';
import 'package:weather/models/news/news_response.dart';
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
  final controller = TextEditingController();
  final stream = StreamController<dynamic>();

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

class _NewsViewer extends StatelessWidget {
  final List<Article> news;

  _NewsViewer(this.news);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'All news',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: size.width * 1,
                // color: Colors.red,
                child: ListView.builder(
                    shrinkWrap: false,
                    itemCount: news.length,
                    itemBuilder: (_, i) => ElasticIn(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 500),
                        child: DescriptionNewsCard(
                          news: news[i],
                          index: i,
                        ))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
