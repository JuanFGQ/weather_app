import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:weather/services/weather_api_service.dart';

import '../models/news/articles_info.dart';

class NewsContent extends StatelessWidget {
  final Article news;

  const NewsContent({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    // final news = Provider.of<NewsService>(context).onlyArticles;

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
                const SizedBox(height: 30),
                SizedBox(
                  width: size.width * 0.9,
                  child: Text(news.content!, style: const TextStyle(fontSize: 18)),
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
    required this.size,
    this.news,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
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
        SizedBox(
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
    this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Text(
        news!.description,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _HeaderInfoNews extends StatelessWidget {
  final Article? news;

  const _HeaderInfoNews({
    required this.size,
    this.news,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final cityName = Provider.of<WeatherApiService>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      width: size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FaIcon(FontAwesomeIcons.solidNewspaper),
          Text(news!.source.name),
          FaIcon(FontAwesomeIcons.dotCircle, size: 8),
          Text(news!.publishedAt.toString()),
          FaIcon(FontAwesomeIcons.dotCircle, size: 8),
          Text(cityName.location!.name),
        ],
      ),
    );
  }
}
