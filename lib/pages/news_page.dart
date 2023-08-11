import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../search/search_delegate_widget.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late NewsService newsService;
  late WeatherApiService weatherServ;
  late LocalizationProvider localizationProvider;

  @override
  void initState() {
    super.initState();
    newsService = Provider.of<NewsService>(context, listen: false);
    weatherServ = Provider.of<WeatherApiService>(context, listen: false);
    localizationProvider =
        Provider.of<LocalizationProvider>(context, listen: false);
  }

  Future _getNews() async {
    final newsData = await newsService.getNewsByFoundedPlace(
        weatherServ.location!.name,
        (!localizationProvider.languageEnglish) ? 'es' : 'en');

    return newsData;
  }

  @override
  Widget build(BuildContext context) {
    print('NEWS PAGE BUILD');

    return FutureBuilder(
        future: newsService.getNewsByFoundedPlace(weatherServ.location!.name,
            (!localizationProvider.languageEnglish) ? 'es' : 'en'),
        builder: (BuildContext context, AsyncSnapshot<NewsResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularIndicator();
          } else if (!newsService.isConnected) {
            return NoDataPage(
              function: () {
                Navigator.pushNamed(context, 'ND');
              },
              icon: const Icon(FontAwesomeIcons.refresh),
              text:
                  'Something went wrong, check your internet conection and try again.',
            );
          } else if (snapshot.hasData && snapshot.data!.articles.isEmpty) {
            return NoDataPage(
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const NewsDesignPage()));
              },
              icon: const Icon(FontAwesomeIcons.refresh),
              text:
                  'Something went wrong, check your internet conection and try again.',
            );
          } else {
            return _NewsViewer(snapshot.data!.articles);
          }
        });
  }
}

class _NewsViewer extends StatefulWidget {
  final List<Article> news;

  const _NewsViewer(this.news);

  @override
  State<_NewsViewer> createState() => _NewsViewerState();
}

class _NewsViewerState extends State<_NewsViewer>
    with TickerProviderStateMixin {
  late NewsListProvider newsListProvider;

  List<Article> orderedNews = []; //store the new ordered list of news
  bool descAsc = false; //flags to show desc or asc list
  bool iconColorForNewsSave =
      false; //save the state of button if news is already saved

  NewsService? newSERV;

  @override
  void initState() {
    super.initState();
    newSERV = Provider.of<NewsService>(context, listen: false);

    newsListProvider = Provider.of<NewsListProvider>(context, listen: false);
    orderedNews = List.from(widget.news);
    //here i match the instanceS of the list created with the list i receive in class arguments

    orderNewsByDate();
    newsListProvider.loadSavedNews(); // load all saved news before widget build
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
  void dispose() {
    super.dispose();
    newSERV;
    newsListProvider;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final weatherAPI = Provider.of<WeatherApiService>(context);
    final apiResp = weatherAPI;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: size.width * 0.6,
                    child: Text(
                      '${AppLocalizations.of(context)!.allnews} ${AppLocalizations.of(context)!.ins} ${apiResp.location?.name}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          overflow: TextOverflow.visible,
                          fontWeight: FontWeight.w900),
                    ),
                  )),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: GestureDetector(
                  onTap: () {
                    orderNewsByDate();
                  },
                  child: Container(
                      margin:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100)),
                        // color: Colors.white,
                        color: Colors.blue[200],
                      ),
                      child: (descAsc)
                          ? const _DescAscButton(
                              icon: Icons.arrow_upward, text: 'Desc')
                          : const _DescAscButton(
                              icon: Icons.arrow_downward, text: 'Asc')),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: size.width * 1,
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: orderedNews.length,
              itemBuilder: (_, i) {
                final selNews = orderedNews[i];
                final newListCopy =
                    Set.from(newsListProvider.news.map((e) => e.title));
                bool isNewSaved = false;

                if (newListCopy.contains(selNews.title)) {
                  isNewSaved = true;
                }

                return DescriptionNewsCard(
                  iconColorForNewsSave: isNewSaved,
                  news: orderedNews[i],
                  index: i,
                  onPressed: () {
                    newsListProvider.selectedItem = i;
                    saveNewsIndex(selNews, i, newsListProvider);
                    setState(() {});
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }

  void saveNewsIndex(
      Article selNews, int i, NewsListProvider savedNewsProvider) async {
    final newListCopy = Set.from(savedNewsProvider.news.map((e) => e.title));

    bool foundMatch = false;

    if (newListCopy.contains(selNews.title)) {
      foundMatch = true;
      showDialog(
        context: context,
        builder: (_) => FadeInUp(
          duration: const Duration(milliseconds: 200),
          child: AlertDialog(
            alignment: Alignment.bottomCenter,
            title: Text(
              AppLocalizations.of(context)!.allreadysave,
              style: const TextStyle(color: Colors.white70),
            ),
            elevation: 24,
            backgroundColor: const Color.fromARGB(130, 0, 108, 196),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      );
    }
    if (!foundMatch) {
      await savedNewsProvider.newSave(
          selNews.url!, selNews.title, selNews.urlToImage, true);

      await savedNewsProvider.loadSavedNews();
    }
  }
}

class _DescAscButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const _DescAscButton({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        Icon(icon, size: 15)
      ],
    );
  }
}
