import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/mapBox_service.dart';
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
          title: TextField(
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            decoration: InputDecoration(hintText: 'Search city'),
          ),
        ),
        body: query.isEmpty
            ? _BuildSuggestions()
            : _BuildResults(
                query: query,
              ));
  }
}

class _BuildResults extends StatelessWidget {
  final String query;

  const _BuildResults({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      //todo: if query is empty then show recent city history, otherwhise show empty container
      return _emptyContainer();
    }

    final mapBoxSearch = Provider.of<MapBoxService>(context, listen: false);
    final weather = Provider.of<WeatherApiService>(context);

    mapBoxSearch.getSuggestionByQuery(query);

    return StreamBuilder(
      stream: mapBoxSearch.suggestedCity,
      builder: (_, AsyncSnapshot<List<Feature>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final featureMethod = snapshot.data!;

        return ListView.builder(
          itemCount: featureMethod.length,
          itemBuilder: (_, int index) {
            final city = featureMethod[index];
            return ListTile(
              leading: const CircleAvatar(
                child: FaIcon(FontAwesomeIcons.mountainCity),
              ),
              title: Text(city.placeName),
              onTap: () {
                final newCoords = city.center;

                final cord1 = newCoords[1].toString();
                final cord0 = newCoords[0].toString();

                final defCoord = cord1 + ',' + cord0;
                weather.coords = defCoord;

                Navigator.pushNamed(context, 'founded', arguments: city);
                getInfoSelectedCIty(city);
              },
            );
          },
        );
      },
    );
  }
}

Widget _emptyContainer() {
  return const Center(
    child: FaIcon(FontAwesomeIcons.search, color: Colors.blue, size: 50),
  );
}

void getInfoSelectedCIty(Feature item) {
  //guardo valor presionado-
  Preferences.placeName = item.placeName;
  Preferences.history.insert(0, Preferences.placeName);
}

class _BuildSuggestions extends StatefulWidget {
  const _BuildSuggestions({super.key});

  @override
  State<_BuildSuggestions> createState() => __BuildSuggestionsState();
}

class __BuildSuggestionsState extends State<_BuildSuggestions> {
  @override
  Widget build(BuildContext context) {
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
                  setState(() {});
                },
                icon: const Icon(Icons.clear)),
            onTap: () {},
          );
        });
  }
}
