import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../search/search_delegate.dart';
import '../services/weather_api_service.dart';
import 'info_table.dart';
import 'letras.dart';

class HomeWidget extends StatelessWidget {
  final String title;
  final String lastUpdateDate;
  final String lastUpdateTime;
  final String locationCountry;
  final String currentCOndition;
  final String currentFeelsLikeNumber;
  final String windData;
  final String humidityData;

  final String dropData;
  final String visibilityData;
  final String windDirectionData;
  final String temperatureData;
  final String feelsLikeData;
  final Color scaffoldColor;
  final Color appBarColors;

  const HomeWidget(
      {super.key,
      required this.title,
      required this.lastUpdateDate,
      required this.lastUpdateTime,
      required this.locationCountry,
      required this.currentCOndition,
      required this.currentFeelsLikeNumber,
      required this.windData,
      required this.humidityData,
      required this.dropData,
      required this.visibilityData,
      required this.windDirectionData,
      required this.temperatureData,
      required this.feelsLikeData,
      required this.scaffoldColor,
      required this.appBarColors});

  @override
  Widget build(BuildContext context) {
    double heighval = MediaQuery.of(context).size.height * 0.01;
    double valMult = 10;
    final weatherAPI = Provider.of<WeatherApiService>(context);
    final apiResp = weatherAPI;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: scaffoldColor,
      // drawer: SafeArea(child: SideMenu()),
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: WeatherSearchDelegate()),
              icon: const FaIcon(FontAwesomeIcons.search)),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: appBarColors,
          elevation: 0,
          centerTitle: true,
          title: Text(title,
              style: const TextStyle(color: Colors.black, fontSize: 40))
          //
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'LastUpdate',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(lastUpdateDate),
          Text(lastUpdateTime),

          const SizedBox(height: 10),
          Words(
            isVisible: true,
            date: locationCountry,
            wordColor: Colors.blue,
            wordSize: 20,
          ),
          const SizedBox(height: 5),
          FadeInUp(
            from: 50,
            child: Text(
              currentCOndition,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: size.width * 0.9,
            child: Stack(
              children: [
                Center(
                  child: ElasticIn(
                    delay: const Duration(milliseconds: 600),
                    child: Expanded(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          feelsLikeData,
                          style: TextStyle(fontSize: valMult * heighval),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // const InfoTable(),
          InfoIcon(image: 'wind.gif', title: 'Wind', percentage: windData),
          InfoIcon(
              image: 'drop.gif', title: 'Humidity', percentage: humidityData),
          InfoIcon(
              image: 'view.gif',
              title: 'Visibility',
              percentage: visibilityData),
          InfoIcon(
              image: 'windy.gif',
              title: 'Wind direction',
              percentage: windDirectionData),
          InfoIcon(
              image: 'temperature.gif',
              title: 'Temperature',
              percentage: temperatureData),
          InfoIcon(
            image: 'hot.gif',
            title: 'Feels like',
            percentage: feelsLikeData,
          ),

          const SizedBox(height: 10),

          // const SizedBox(height: 10),
        ],
      ),
    );
  }
}
