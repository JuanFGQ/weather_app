import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';

import '../models/mapbox/Feature.dart';
import '../models/mapBox_response.dart';
import '../services/mapBox_Info_service.dart';

class WeatherSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar ciudad';

  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  Widget _emptyContainer() {
    return const Center(
      child: FaIcon(FontAwesomeIcons.search, color: Colors.blue, size: 50),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final mapBoxSearch = Provider.of<MapBoxService>(context, listen: false);

    mapBoxSearch.getSuggestionByQuery(query);

    return StreamBuilder(
      stream: mapBoxSearch.suggestedCity,
      builder: (_, AsyncSnapshot<List<Feature>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final featureMethod = snapshot.data!;

        print('FEATURE METHOD SIDE MENU $featureMethod[index]');

        return ListView.builder(
          itemCount: featureMethod.length,
          itemBuilder: (_, int index) => _CityItem(featureMethod[index]),
        );
      },
    );
  }
}

class _CityItem extends StatelessWidget {
  final Feature city;

  const _CityItem(this.city);

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherApiService>(context);

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

        // final activeSearch = Provider.of<NewsService>(context, listen: false);
        // activeSearch.activeSearch = true;
//todo: crear codicion que cuando seleccione una ciudad ponga un valor en true

        Navigator.pushNamed(context, 'founded', arguments: city);
      },
    );
  }
}
