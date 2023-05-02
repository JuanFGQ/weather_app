import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/search/search_delegate.dart';
import 'package:weather/services/geolocator_service.dart';
import 'package:weather/services/weather_api_service.dart';
import 'package:weather/widgets/info_table.dart';
import 'package:weather/widgets/letras.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/widgets/weekly_table.dart';

import '../models/mapbox/Feature.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final stream = StreamController<dynamic>();

  WeatherApiService? weatherApi;
  GeolocatorService? geolocatorService;

  @override
  void initState() {
    super.initState();
    weatherApi = Provider.of<WeatherApiService>(context, listen: false);
    geolocatorService = Provider.of<GeolocatorService>(context, listen: false);

    _loadWeatherData();
  }

  void _loadWeatherData() async {
    String coords = await geolocatorService!.getCurrentLocation();

    // await weatherApi!.getInfoWeatherCurrent(coords);
    final hasData = await weatherApi!.getInfoWeatherLocation(coords);

    (hasData) ? true : false;

    stream.sink.add(hasData);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _CircularIndicator();
        } else {
          return _HomeWidget();
        }
      },
    );
  }
}

class _CircularIndicator extends StatelessWidget {
  const _CircularIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              'Loading Data, Please wait...',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

class _HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double heighval = MediaQuery.of(context).size.height * 0.01;
    double valMult = 10;
    final weatherAPI = Provider.of<WeatherApiService>(context);
    final apiResp = weatherAPI;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      // drawer: SafeArea(child: SideMenu()),
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: WeatherSearchDelegate()),
              icon: FaIcon(FontAwesomeIcons.search)),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
          title: Text(apiResp.location?.name ?? '?',
              style: TextStyle(color: Colors.black, fontSize: 40))
          //
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'LastUpdate',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(apiResp.current?.lastUpdated.substring(0, 10) ?? '?'),
          Text(apiResp.current?.lastUpdated.substring(10, 16) ?? '?'),

          const SizedBox(height: 10),
          Words(
            isVisible: true,
            date: apiResp.location?.country ?? '?',
            wordColor: Colors.blue,
            wordSize: 20,
          ),
          const SizedBox(height: 5),
          FadeInUp(
            from: 50,
            child: Text(
              apiResp.current?.condition.text ?? '?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                          '${apiResp.current?.feelslikeC.toString()}º' ?? '?',
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
          InfoIcon(
              image: 'wind.gif',
              title: 'Wind',
              percentage: '${apiResp.current?.windKph ?? '?'} km/h'),
          InfoIcon(
              image: 'drop.gif',
              title: 'Humidity',
              percentage: '${apiResp.current?.humidity ?? '?'}%'),
          InfoIcon(
              image: 'view.gif',
              title: 'Visibility',
              percentage: '${apiResp.current?.visKm ?? '?'} km/h'),
          InfoIcon(
              image: 'windy.gif',
              title: 'Wind direction',
              percentage: '${apiResp.current?.windDir ?? '?'}'),
          InfoIcon(
              image: 'temperature.gif',
              title: 'Temperature',
              percentage: '${apiResp.current?.tempC ?? '?'} º'),
          InfoIcon(
              image: 'hot.gif',
              title: 'Feels like',
              percentage: '${apiResp.current?.feelslikeC ?? '?'} º'),

          const SizedBox(height: 10),

          // const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _HeaderCityName extends StatelessWidget {
  final Feature feature;

  const _HeaderCityName(this.feature);

  @override
  Widget build(BuildContext context) {
    return Text(
      feature.placeName,
      style: TextStyle(
          color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
    );
  }
}
