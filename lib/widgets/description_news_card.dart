import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/news_list_provider.dart';
import 'package:weather/services/news_service.dart';

import '../models/news/articles_info.dart';

class DescriptionNewsCard extends StatelessWidget {
  final Article news;
  final int index;
  final void Function()? onPressed;
  final bool iconColorForNewsSave;
  // final bool pressedBoolean;

  const DescriptionNewsCard({
    super.key,
    required this.news,
    required this.index,
    this.onPressed,
    required this.iconColorForNewsSave,
    // required this.pressedBoolean,
  });

  @override
  Widget build(BuildContext context) {
    final newsListProvider = Provider.of<NewsListProvider>(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        final urlNewsLauncher =
            Provider.of<NewsService>(context, listen: false);

        urlNewsLauncher.launcherUrl(context, news);
      },
      child: Row(
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
            width: size.width * 0.35,
            height: size.height * 0.18,
            child:
                (news.urlToImage != null && news.urlToImage!.startsWith('http'))
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: FadeInImage(
                            fit: BoxFit.fill,
                            placeholder:
                                const AssetImage('assets/barra_colores.gif'),
                            image: NetworkImage(news.urlToImage!)),
                      )
                    : const Image(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/no-image.png')),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              height: size.height * 0.17,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    news.author ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    news.title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                          '${news.publishedAt.toString().substring(0, 10)}   ${news.publishedAt.toString().substring(10, 16)}'),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: FadeIn(
                          delay: const Duration(milliseconds: 200),
                          child: RawMaterialButton(
                              shape: const CircleBorder(),
                              onPressed: onPressed,
                              fillColor: Colors.white,
                              elevation: 5,
                              child: iconColorForNewsSave ||
                                      index == newsListProvider.selectedItem
                                  ? const FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Colors.red,
                                    )
                                  : const FaIcon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.black,
                                    )),
                        ),
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
