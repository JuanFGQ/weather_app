import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/new_weather_response.dart';

class ForeCastTable extends StatelessWidget {
  final Forecastday forecast;

  ForeCastTable({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final forecastDate = forecast.date;
    final dayFormat = DateFormat('EEEE');
    final dayName = dayFormat.format(forecastDate);

    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(5),
      width: size.width * 0.50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 19, 86, 140),
              Color.fromARGB(255, 85, 194, 245),
              Color.fromARGB(255, 56, 172, 172)
            ]),
        borderRadius: BorderRadius.circular(30),
        color: Colors.amber,

//
      ),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                margin: const EdgeInsets.all(10),
                child: Text(
                  dayName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  // color: Colors.red,
                  margin: EdgeInsets.only(left: 20),
                  child: Stack(
                    children: [
                      const Positioned(
                          top: -4,
                          child: Text(
                            'AVG',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic),
                          )),
                      const Spacer(),
                      Text(
                        forecast.day.avgtempC.toString(),
                        style: const TextStyle(
                            fontSize: 65, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                    margin: const EdgeInsets.only(bottom: 30, right: 20),
                    child: const FaIcon(
                      FontAwesomeIcons.cloud,
                      size: 30,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SubIconsInfo(
                  icon: const FaIcon(FontAwesomeIcons.droplet, size: 20),
                  text: forecast.day.avghumidity.toString(),
                ),
                _SubIconsInfo(
                  icon: const FaIcon(FontAwesomeIcons.wind, size: 20),
                  text: forecast.day.maxwindKph.toString(),
                ),
                _SubIconsInfo(
                  icon: const FaIcon(FontAwesomeIcons.sun, size: 20),
                  text: forecast.day.uv.toString(),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class _SubIconsInfo extends StatelessWidget {
  final Widget icon;
  final String text;

  const _SubIconsInfo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 2,
          ),
          Text(text)
        ],
      ),
    );
  }
}
