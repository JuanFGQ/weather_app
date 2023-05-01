import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/weather_api_service.dart';

import '../models/mapbox/Feature.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final weatherProvider = Provider.of<WeatherApiService>(context);

    final Feature feature =
        ModalRoute.of(context)!.settings.arguments as Feature;
    return Scaffold(
      body: Center(
          child: Text(
        feature.center.toString().replaceAll('[', '').replaceAll(']', ''),
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}

// return StreamBuilder(
//       stream: mapBoxSearch.suggestedCity,
//       builder: (_, AsyncSnapshot<List<Feature>> snapshot) {
//         if (!snapshot.hasData) return _emptyContainer();

//         final featureMethod = snapshot.data!;
//         print('FEATURE METHOD SIDE MENU $featureMethod');

//         return ListView.builder(
//           itemCount: featureMethod.length,
//           itemBuilder: (_, int index) => _CityItem(featureMethod[index]),
//         );
//       },
//     );












