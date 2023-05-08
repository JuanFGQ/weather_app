import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/notifications/local_notifications.dart';

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

  final String visibilityData;
  final String windDirectionData;
  final String temperatureData;
  final String feelsLikeData;
  final Color scaffoldColor;
  final Color appBarColors;
  final Color locCountryColor;

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
      required this.visibilityData,
      required this.windDirectionData,
      required this.temperatureData,
      required this.feelsLikeData,
      required this.scaffoldColor,
      required this.appBarColors,
      required this.locCountryColor});

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
          actions: [
            FittedBox(
              fit: BoxFit.values[5],
              child: RawMaterialButton(
                onPressed: () {
                  showNotifications();
                },
                shape: CircleBorder(),
                fillColor: Colors.white,
                child: Spin(
                  duration: Duration(milliseconds: 5000),
                  infinite: true,
                  child: const FaIcon(
                    FontAwesomeIcons.refresh,
                    size: 18,
                  ),
                ),
                // constraints: ,
              ),
            )
          ],
          leading: IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: WeatherSearchDelegate()),
              icon: const FaIcon(FontAwesomeIcons.search)),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: appBarColors,
          elevation: 0,
          centerTitle: true,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(title,
                style: const TextStyle(color: Colors.black, fontSize: 40)),
          )
          //
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const Text(
          //   'LastUpdate',
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          // ),
          // Text(lastUpdateDate),
          // Text(lastUpdateTime),

          const SizedBox(height: 10),
          Words(
            date: locationCountry,
            wordColor: locCountryColor,
            // wordSize: 20,
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

          NewsPaperButton(),
          FadeIn(
              delay: Duration(milliseconds: 1000),
              child: Text('News in $title')),

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

class NewsPaperButton extends StatelessWidget {
  const NewsPaperButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: Duration(milliseconds: 1000),
      child: Bounce(
        delay: Duration(milliseconds: 800),
        from: 6,
        infinite: true,
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: () {
            Navigator.pushNamed(context, 'news');
          },
          fillColor: Colors.white,
          child: FaIcon(FontAwesomeIcons.solidNewspaper),
          elevation: 5,
        ),
      ),
    );
  }
}
