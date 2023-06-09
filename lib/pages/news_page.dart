import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/news/articles_info.dart';
import 'package:weather/models/news/news_response.dart';
import 'package:weather/pages/no_data_page.dart';
import 'package:weather/providers/news_list_provider.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';
import 'package:weather/widgets/circular_progress_indicator.dart';

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
    super.initState();
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
  NewsListProvider? newsProvider;

  List<Article> orderedNews = []; //store the new ordered list of news
  bool descAsc = false; //flags to show desc or asc list

  @override
  void initState() {
    super.initState();
    newsProvider = Provider.of<NewsListProvider>(context, listen: false);
    orderedNews = List.from(widget
        .news); //here i match the instanceS of the list created with the list i receive in class arguments

    orderNewsByDate();
  }

  void orderNewsByDate() {
    setState(() {
      if (descAsc) {
        orderedNews.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
      } else {
        orderedNews.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
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
                          news: orderedNews[i],
                          index: i,
                          onPressed: () {
                            newsProvider!.selectedItem = i;

                            getSelectedNewsIndex(selNews, i);

                            setState(() {});
                          },
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

  void getSelectedNewsIndex(Article selNews, int i) async {
    final savedNewsProvider =
        Provider.of<NewsListProvider>(context, listen: false);
    final text = selNews.title;
    savedNewsProvider.news.where((element) {
      if (element.title == text) {
        // todo: establecer variable en true que muestre el showDialog
        return true;
      } else {
        savedNewsProvider.newSave(
            selNews.url!, selNews.title, selNews.urlToImage);

        savedNewsProvider.loadSavedNews();
        return false;
      }
    });

    (existentSavedNews) async {
      await savedNewsProvider.newSave(
          selNews.url!, selNews.title, selNews.urlToImage);

      await savedNewsProvider.loadSavedNews();
    };
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
