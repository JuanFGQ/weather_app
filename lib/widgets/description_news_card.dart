import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/news_service.dart';

import '../models/news/articles_info.dart';

class DescriptionNewsCard extends StatelessWidget {
  final Article news;
  final int index;
  const DescriptionNewsCard(
      {super.key, required this.news, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        final urlNewsLauncher =
            Provider.of<NewsService>(context, listen: false);

        urlNewsLauncher.launcherUrl(context, news);
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Container(
              margin: const EdgeInsets.all(10),
              width: size.width * 0.35,
              height: size.height * 0.18,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(60), color: Colors.amber),
              child: (news.urlToImage != null &&
                      news.urlToImage!.startsWith('http'))
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: FadeInImage(
                            placeholder: AssetImage('assets/barra_colores.gif'),
                            image: NetworkImage(news.urlToImage!)),
                      ),
                    )
                  : FittedBox(
                      fit: BoxFit.fill,
                      child: const Image(
                          image: AssetImage('assets/no-image.png'))),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              height: size.height * 0.16,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(news.author ?? ''),
                  SizedBox(height: 5),
                  Flexible(
                    child: Text(
                      news.title,
                      style: const TextStyle(
                          overflow: TextOverflow.visible,
                          // fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(news.publishedAt.toString())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
