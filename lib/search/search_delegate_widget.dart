import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/wanted_places_provider.dart';
import 'package:weather/services/mapbox_service.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';

import '../models/mapbox/Feature.dart';

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
    final savePlace = Provider.of<WantedPlacesProvider>(context);

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
              onTap: () async {
                newsService.activeSearch = true;
                final newCoords = city.center;
                final defCoord =
                    '${newCoords[1].toString()},${newCoords[0].toString()}';

                weather.coords = defCoord;

                Navigator.pushNamed(context, 'ND');

                await savePlace.newSave(city.placeName, defCoord);
              },
            );
          },
        );
      },
    );
  }
}

class _BuildSuggestions extends StatefulWidget {
  const _BuildSuggestions();

  @override
  State<_BuildSuggestions> createState() => __BuildSuggestionsState();
}

class __BuildSuggestionsState extends State<_BuildSuggestions> {
  WantedPlacesProvider? wantedPlaces;
  WeatherApiService? weather;
  NewsService? newsService;
  @override
  void initState() {
    wantedPlaces = Provider.of(context, listen: false);
    weather = Provider.of<WeatherApiService>(context, listen: false);
    newsService = Provider.of<NewsService>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    wantedPlaces;
    weather;
    newsService;
  }

  @override
  Widget build(BuildContext context) {
    final placesList = Provider.of<WantedPlacesProvider>(context);
//*SHOW SAVED PLACES
    if (placesList.places.isEmpty) {
      return const EmptyContainer();
    }
    final weather = Provider.of<WeatherApiService>(context);
    final newsService = Provider.of<NewsService>(context);

    return ListView.builder(
      itemCount: placesList.places.length,
      itemBuilder: (context, int index) {
        final wantedPlace = placesList.places[index];
        return ListTile(
          leading: const FaIcon(FontAwesomeIcons.clockRotateLeft),
          title: Text(wantedPlace.placeName),
          trailing: IconButton(
              onPressed: () {
                placesList.deleteSavePlace(placesList.places[index].id!);
                placesList.loadSavedPlaces();
              },
              icon: const Icon(Icons.clear)),
          onTap: () {
            newsService.activeSearch = true;
            weather.coords = wantedPlace.placeCoords;
            Navigator.pushNamed(context, 'ND');
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
