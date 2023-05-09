import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/weather/weather_api_response.dart';
import 'package:weather/services/news_service.dart';

import '../models/news/articles_info.dart';

class NewsContent extends StatelessWidget {
  const NewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<NewsService>(context).onlyArticles;

    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _HeaderInfoNews(news: news, size: size),
                _Description(news: news),
                _ImageTitle(news: news, size: size),
                SizedBox(height: 30),
                Container(
                  width: size.width * 0.9,
                  child: Text(news!.content!, style: TextStyle(fontSize: 18)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageTitle extends StatelessWidget {
  final Article? news;

  const _ImageTitle({
    super.key,
    required this.size,
    this.news,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: size.width * 1,
          height: size.height * 0.28,
          // decoration: BoxD,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: const Image(
                  // colorBlendMode: BlendMode.colorBurn,

                  // opacity: 2.0,
                  // filterQuality: FilterQuality.medium,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://www.triviantes.com/wp-content/uploads/2021/03/catedral-de-manizales.jpg'))),
        ),
        Container(
          width: size.width * 0.8,
          child: Center(
            child: Text(
              news!.title,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}

class _Description extends StatelessWidget {
  final Article? news;

  const _Description({
    super.key,
    this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        news!.description,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _HeaderInfoNews extends StatelessWidget {
  final Article? news;

  const _HeaderInfoNews({
    super.key,
    required this.size,
    this.news,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final cityName = Provider.of<WeatherApi>(context);

    return Container(
      margin: EdgeInsets.all(10),
      width: size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FaIcon(FontAwesomeIcons.solidNewspaper),
          Text(news!.source.name),
          FaIcon(FontAwesomeIcons.dotCircle, size: 8),
          Text(news!.publishedAt.toString()),
          FaIcon(FontAwesomeIcons.dotCircle, size: 8),
          Text(cityName.location.name),
        ],
      ),
    );
  }
}
