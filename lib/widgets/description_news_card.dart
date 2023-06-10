import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/news_list_provider.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/widgets/rounded_button.dart';

import '../models/news/articles_info.dart';

class DescriptionNewsCard extends StatelessWidget {
  final Article news;
  final int index;
  final void Function()? onPressed;
  const DescriptionNewsCard(
      {super.key, required this.news, required this.index, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final newsListProvider = Provider.of<NewsListProvider>(context);
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
                            placeholder: const AssetImage('assets/barra_colores.gif'),
                            image: NetworkImage(news.urlToImage!)),
                      ),
                    )
                  : const FittedBox(
                      fit: BoxFit.fill,
                      child: Image(image: AssetImage('assets/no-image.png'))),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              height: size.height * 0.16,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(news.author ?? ''),
                  const SizedBox(height: 5),
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
                  Row(
                    children: [
                      Text(
                          '${news.publishedAt.toString().substring(0, 10)}   ${news.publishedAt.toString().substring(10, 16)}'),
                      const SizedBox(
                        width: 40,
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: RoundedButton(
                            icon: index == newsListProvider.selectedItem
                                ? const FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    color: Colors.red,
                                  )
                                : const FaIcon(FontAwesomeIcons.heart,
                                    color: Colors.black),
                            infinite: false,
                            function: onPressed),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
