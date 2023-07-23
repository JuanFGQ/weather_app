import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/mapbox_service.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';

import '../models/mapbox/Feature.dart';
import '../preferences/share_prefs.dart';

class WeatherSearchCity extends StatefulWidget {
  const WeatherSearchCity({super.key});

  @override
  State<WeatherSearchCity> createState() => _WeatherSearchCityState();
}

class _WeatherSearchCityState extends State<WeatherSearchCity> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: TextField(
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            decoration: const InputDecoration(
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                label: Text('Search city'),
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder()),
          ),
        ),
        body: query.isEmpty
            ? const _BuildSuggestions()
            : _BuildResults(query: query));
  }
}

class _BuildResults extends StatelessWidget {
  final String query;

  const _BuildResults({required this.query});

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      return const EmptyContainer();
    }

    final mapBoxSearch = Provider.of<MapBoxService>(context, listen: false);
    final weather = Provider.of<WeatherApiService>(context);
    final newsService = Provider.of<NewsService>(context);

    mapBoxSearch.getSuggestionByQuery(query);

    return StreamBuilder(
      stream: mapBoxSearch.suggestedCity,
      builder: (_, AsyncSnapshot<List<Feature>> snapshot) {
        if (!snapshot.hasData) return const EmptyContainer();

        final featureMethod = snapshot.data!;

        return ListView.builder(
          itemCount: featureMethod.length,
          itemBuilder: (_, int index) {
            final city = featureMethod[index];

            return ListTile(
              leading: const FaIcon(FontAwesomeIcons.mountainCity,
                  color: Color.fromARGB(197, 158, 158, 158)),
              title: Text(city.placeName),
              onTap: () {
                newsService.activeSearch = true;
                final newCoords = city.center;

                final cord1 = newCoords[1].toString();
                final cord0 = newCoords[0].toString();

                final defCoord = '$cord1,$cord0';
                weather.coords = defCoord;

                Navigator.pushNamed(
                  context,
                  'ND',
                );
                getInfoSelectedCIty(city);
              },
            );
          },
        );
      },
    );
  }
}

void getInfoSelectedCIty(Feature item) {
  //save selected value
  Preferences.placeName = item.placeName;
  //insert selected value to the list
  Preferences.history.insert(0, Preferences.placeName);
}

class _BuildSuggestions extends StatefulWidget {
  const _BuildSuggestions();

  @override
  State<_BuildSuggestions> createState() => __BuildSuggestionsState();
}

class __BuildSuggestionsState extends State<_BuildSuggestions> {
  @override
  Widget build(BuildContext context) {
    if (Preferences.history.isEmpty) {
      return const EmptyContainer();
    }
    final weather = Provider.of<WeatherApiService>(context);
    final newsService = Provider.of<NewsService>(context);

    return ListView.builder(
      itemCount: Preferences.history.length,
      itemBuilder: (context, int index) {
        final placeName = Preferences.history[index];
        return ListTile(
          leading: const FaIcon(FontAwesomeIcons.clockRotateLeft),
          title: Text(placeName),
          trailing: IconButton(
              onPressed: () {
                Preferences.history.removeAt(index);
                // setState(() {});
              },
              icon: const Icon(Icons.clear)),
          onTap: () {
            newsService.activeSearch = true;
            final arg = Preferences.history[index];
            weather.coords = arg;
            // Navigator.pushNamed(context, 'founded');

            //todo: activeSearch en true para hacer el cambio de argumentos en el NewDesignPage

            //lo que tengo que hacer aqui es hacer otra llamada a la API  enviando el argumento guardado
          },
        );
      },
    );
  }
}

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // ignore: deprecated_member_use
      child: FaIcon(FontAwesomeIcons.search, color: Colors.blue, size: 50),
    );
  }
}
