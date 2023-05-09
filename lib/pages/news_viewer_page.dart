import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
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

class _NewsPageState extends State<NewsPage> {
  final stream = StreamController<dynamic>();

  NewsService? newsService;
  WeatherApiService? weatherServ;

  @override
  void initState() {
    newsService = Provider.of<NewsService>(context, listen: false);
    weatherServ = Provider.of<WeatherApiService>(context, listen: false);

    _getNewsData();
  }

  _getNewsData() async {
    final countryName = await weatherServ?.location?.region ?? '?';
    final locationName = await weatherServ?.location?.name ?? '?';

    final wholeName = countryName + ' ' + locationName;
    print(wholeName);

    final hasData = await newsService!.getNewsByQuery(wholeName);

    (hasData) ? true : false;

    stream.sink.add(hasData);
  }

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context).listArticles;

    return StreamBuilder(
      stream: stream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularIndicator();
        } else {
          return _NewsViewer(newsService);
        }
      },
    );
  }
}

class _NewsViewer extends StatelessWidget {
  final List<Article> news;

  const _NewsViewer(this.news);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Breaking News',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Divider(
            //   thickness: 2,
            //   indent: 10,
            //   endIndent: 10,
            // ),
            NewsCard(),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'All news',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),

            Expanded(
              child: Container(
                width: size.width * 1,
                // color: Colors.red,
                child: ListView.builder(
                    itemCount: news.length,
                    itemBuilder: (_, i) => ElasticIn(
                        delay: Duration(milliseconds: 500),
                        duration: Duration(milliseconds: 500),
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
