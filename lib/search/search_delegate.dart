import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';

import '../models/mapbox/Feature.dart';
import '../services/mapBox_service.dart';

class WeatherSearchDelegate extends SearchDelegate {
  List<String> recentHistory = [];
  String selectedItem = '';

  // Feature? city;

  WeatherSearchDelegate() {
    loadRecentHistory();
  }
  Future<void> loadRecentHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? history = prefs.getStringList('recentHistory');
    if (history != null) {
      recentHistory = history;
    }
    selectedItem = (recentHistory.isNotEmpty ? recentHistory.first : null)!;
  }

  Future<void> saveRecentQuery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recentHistory', recentHistory);
  }

  Future<void> saveSelectedData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!recentHistory.contains(data)) {
      recentHistory.add(data);
      await prefs.setStringList('recentHistory', recentHistory);
    }
  }

  @override
  String get searchFieldLabel => 'Search city';

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
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
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

  void getInfoSelectedCIty(Feature item) {
    selectedItem = item.placeName;
    saveSelectedData(item.placeName);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = selectedItem.isEmpty
        ? recentHistory
        : recentHistory
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    if (selectedItem != null && query.isEmpty) {
      suggestions.insert(0, selectedItem);
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (_, int index) {
        final suggestion = suggestions[index];
        return ListTile(
          leading: FaIcon(FontAwesomeIcons.clockRotateLeft),
          title: Text(suggestion),
          trailing: IconButton(
              splashColor: Colors.red,
              splashRadius: 5,
              onPressed: () {
                //todo: eliminar del historial
              },
              icon: Icon(Icons.clear)),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    super.showResults(context);
    if (!recentHistory.contains(query)) {
      recentHistory.add(query);
      saveRecentQuery();
    }
  }

  void deleteData(String data) {}
}

// class CityItem extends StatelessWidget {
//   final Feature? city;

//   const CityItem({
//     required this.city,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final weather = Provider.of<WeatherApiService>(context);

//     return ListTile(
//       leading: const CircleAvatar(
//         child: FaIcon(FontAwesomeIcons.mountainCity),
//       ),
//       title: Text(city!.placeName),
//       onTap: () {
//         final newCoords = city!.center;

//         final cord1 = newCoords[1].toString();
//         final cord0 = newCoords[0].toString();

//         final defCoord = cord1 + ',' + cord0;
//         weather.coords = defCoord;

//         Navigator.pushNamed(context, 'founded', arguments: city);
//         getInfoSelectedCIty(city!);
//       },
//     );
//   }

//   void getInfoSelectedCIty(Feature item) {
//     print('ELEMENTO SELECCIONADO ${item.placeName}');
//   }
// }
