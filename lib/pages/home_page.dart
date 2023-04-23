import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/mapBox_response.dart';
import 'package:weather/search/search_delegate.dart';
import 'package:weather/services/mapBox_Info_Provider.dart';
import 'package:weather/widgets/info_table.dart';
import 'package:weather/widgets/letras.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/widgets/weekly_table.dart';

import '../models/Feature.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          title: Text('Home GeoLocator', style: TextStyle(color: Colors.black))
          //
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          const Words(
            isVisible: true,
            date: 'Friday 20, January',
            wordColor: Colors.blue,
            wordSize: 20,
          ),
          const SizedBox(height: 10),
          FadeInUp(
            from: 50,
            child: const Text(
              'Sunny',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            width: size.width * 0.9,
            child: Stack(
              children: [
                Center(
                  child: ElasticIn(
                    delay: const Duration(milliseconds: 600),
                    child: const Text(
                      '28',
                      style: TextStyle(fontSize: 200),
                    ),
                  ),
                ),
                Positioned(
                  right: 60,
                  top: 40,
                  child: FadeInLeft(
                      from: 50, child: FaIcon(FontAwesomeIcons.circle)),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 50, right: 50),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: FadeInUp(
                    child: const Text(
                      'Daily Summary',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                FadeInUp(
                  delay: Duration(milliseconds: 800),
                  child: Text(
                      ' quis duis mollit excepteur dolore consectetur sint anim ex pariatur. Eiusmod laboris irure ullamco id excepteur. Ad irure ipsum consequat duis aliquip sit elit duis.'),
                )
                // SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const InfoTable(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            FadeIn(
              delay: Duration(milliseconds: 500),
              child: const Text(
                'Weekly forecast',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FadeInLeft(
              from: 200,
              child: IconButton(
                  onPressed: () {
                    // todo: ir al pronostico semanal del tiempo
                  },
                  icon: const FaIcon(FontAwesomeIcons.arrowRight)),
            ),
          ]),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              child: ListView(scrollDirection: Axis.horizontal, children: [
                WeeklyBox(
                    size: size,
                    grades: '11º',
                    icon: FontAwesomeIcons.droplet,
                    date: '17 abr'),
                WeeklyBox(
                    size: size,
                    grades: '18º',
                    icon: FontAwesomeIcons.sun,
                    date: '17 abr'),
                WeeklyBox(
                    size: size,
                    grades: '20º',
                    icon: FontAwesomeIcons.cloud,
                    date: '17 abr'),
                WeeklyBox(
                    size: size,
                    grades: '5º',
                    icon: FontAwesomeIcons.snowflake,
                    date: '17 abr'),
                WeeklyBox(
                    size: size,
                    grades: '30º',
                    icon: FontAwesomeIcons.sun,
                    date: '17 abr'),
              ]),
            ),
          )
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
