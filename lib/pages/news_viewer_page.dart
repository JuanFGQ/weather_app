import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/mapbox/Feature.dart';
import 'package:weather/services/mapBox_Info_service.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';
import 'package:weather/widgets/news_card.dart';

import '../widgets/description_news_card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsService? newsService;
  MapBoxInfoProvider? mapBoxService;

  @override
  void initState() {
    newsService = Provider.of<NewsService>(context, listen: false);
    mapBoxService = Provider.of<MapBoxInfoProvider>(context, listen: false);

    _getNewsData();
  }

  _getNewsData() async {
    final placeName = mapBoxService!.mapbox!.placeName;

    final hasData = await newsService!.getNewsByQuery(placeName);

    (hasData) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<NewsService>(context);
    final newsResp = news;

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
                    itemCount: 10,
                    itemBuilder: (_, i) => ElasticIn(
                        delay: Duration(milliseconds: 500),
                        duration: Duration(milliseconds: 500),
                        child: DescriptionNewsCard())),
              ),
            )
          ],
        ),
      ),
    );
  }
}
