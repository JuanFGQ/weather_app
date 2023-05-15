import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/news/articles_info.dart';
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

class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin {
  final controller = TextEditingController();
  final stream = StreamController<dynamic>();

  NewsService? newsService;
  WeatherApiService? weatherServ;

  @override
  void initState() {
    newsService = Provider.of<NewsService>(context, listen: false);
    weatherServ = Provider.of<WeatherApiService>(context, listen: false);

    _init();
    // _getNewsData();
  }

  void _init() async {
    (newsService!.activeSearch) ? _getNewDataFounded() : _getNewsData();
  }

  _getNewDataFounded() async {
    final countryName = '${weatherServ?.foundLocation?.country}'
        ' ${weatherServ?.foundLocation?.name}';

    final hasData = await newsService!.getNewsByFoundedPlace(countryName);

    (hasData) ? true : false;

    stream.sink.add(hasData);
  }

  _getNewsData() async {
    final countryName =
        '${weatherServ?.location?.region}' '${weatherServ?.location?.name}';

    final hasData = await newsService!.getNewsByQuery(countryName);

    (hasData) ? true : false;

    stream.sink.add(hasData);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);

    return StreamBuilder(
      stream: stream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularIndicator();
        } else {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);

              return true;
            },
            child: _NewsViewer(
                //if active search is true return listarticles 2 , an instance of Articles otherwhise listArticle
                (newsService.activeSearch)
                    ? newsService.listArticles2
                    : newsService.listArticles,
                controller),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    stream.close();
    super.dispose();
  }
}

class _NewsViewer extends StatelessWidget {
  final TextEditingController controller;
  final List<Article> news;

  _NewsViewer(this.news, this.controller);

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
