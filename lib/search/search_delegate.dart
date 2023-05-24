// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:weather/preferences/share_prefs.dart';
// import 'package:weather/services/news_service.dart';
// import 'package:weather/services/weather_api_service.dart';

// import '../models/mapbox/Feature.dart';
// import '../services/mapBox_service.dart';

// class WeatherSearchDelegate extends SearchDelegate {
//   // Feature? city;

//   @override
//   String get searchFieldLabel => 'Search city';

//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             query = '';
//           },
//           icon: Icon(Icons.clear))
//     ];
//   }

//   Widget _emptyContainer() {
//     return const Center(
//       child: FaIcon(FontAwesomeIcons.search, color: Colors.blue, size: 50),
//     );
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         icon: Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     if (query.isEmpty) {
//       //todo: if query is empty then show recent city history, otherwhise show empty container
//       return _emptyContainer();
//     }

//     final mapBoxSearch = Provider.of<MapBoxService>(context, listen: false);
//     final weather = Provider.of<WeatherApiService>(context);

//     mapBoxSearch.getSuggestionByQuery(query);

//     return StreamBuilder(
//       stream: mapBoxSearch.suggestedCity,
//       builder: (_, AsyncSnapshot<List<Feature>> snapshot) {
//         if (!snapshot.hasData) return _emptyContainer();

//         final featureMethod = snapshot.data!;

//         return ListView.builder(
//           itemCount: featureMethod.length,
//           itemBuilder: (_, int index) {
//             final city = featureMethod[index];
//             return ListTile(
//               leading: const CircleAvatar(
//                 child: FaIcon(FontAwesomeIcons.mountainCity),
//               ),
//               title: Text(city.placeName),
//               onTap: () {
//                 final newCoords = city.center;

//                 final cord1 = newCoords[1].toString();
//                 final cord0 = newCoords[0].toString();

//                 final defCoord = cord1 + ',' + cord0;
//                 weather.coords = defCoord;

//                 Navigator.pushNamed(context, 'founded', arguments: city);
//                 getInfoSelectedCIty(city);
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   void getInfoSelectedCIty(Feature item) {
//     //guardo valor presionado-
//     Preferences.placeName = item.placeName;
//     Preferences.history.insert(0, Preferences.placeName);
//   }




//   //modified with stateFull builder

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return StatefulBuilder(
//       builder: (BuildContext context, setState) {
//         return ListView.builder(
//             itemCount: Preferences.history.length,
//             itemBuilder: (context, int index) {
//               final placeName = Preferences.history[index];
//               return ListTile(
//                 leading: const FaIcon(FontAwesomeIcons.clockRotateLeft),
//                 title: Text(placeName),
//                 trailing: IconButton(
//                     onPressed: () {
//                       Preferences.history.removeAt(index);
//                       setState({});
//                     },
//                     icon: const Icon(Icons.clear)),
//                 onTap: () {},
//               );
//             });
//       },
//     );
//   }
// }
