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
    final weatherCondition = forecast.day.condition.text;

    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(5),
      width: size.width * 0.50,
      decoration: BoxDecoration(
        // gradient: const LinearGradient(
        //     begin: Alignment.bottomLeft,
        //     end: Alignment.bottomRight,
        //     colors: [
        //       Color.fromARGB(255, 19, 86, 140),
        //       Color.fromARGB(255, 85, 194, 245),
        //       Color.fromARGB(255, 56, 172, 172)
        //     ]),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1, 1.5),
            spreadRadius: 3,
            blurRadius: 0.2,
            // blurStyle: BlurStyle.outer,
          )
        ],

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
            Container(
              margin: const EdgeInsets.all(5),
              child: Text(
                forecast.day.condition.text,
                style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  // color: Colors.red,
                  margin: const EdgeInsets.only(left: 20),
                  child: Stack(
                    children: [
                      Positioned(
                          top: -4,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              'AVG',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          )),
                      const Spacer(),
                      Text(
                        forecast.day.avgtempC.toString() + 'º',
                        style: const TextStyle(
                            fontSize: 65, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                    width: 45,
                    height: 45,
                    margin: const EdgeInsets.only(bottom: 30, right: 10),
                    child: _buildWeatherIcon())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SubIconsInfo(
                  icon: const FaIcon(FontAwesomeIcons.droplet,
                      color: Colors.blue, size: 20),
                  text: forecast.day.avghumidity.toString(),
                ),
                _SubIconsInfo(
                  icon: const FaIcon(FontAwesomeIcons.wind,
                      color: Colors.cyanAccent, size: 20),
                  text: forecast.day.maxwindKph.toString(),
                ),
                _SubIconsInfo(
                  icon: const FaIcon(FontAwesomeIcons.sun,
                      color: Colors.yellow, size: 20),
                  text: forecast.day.uv.toString(),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildWeatherIcon() {
    final weatherCondition = forecast.day.condition.text;
    switch (weatherCondition) {
      case 'Partly cloudy':
        return Image(image: AssetImage('assets/clouds (1).gif'));

      // Icon(
      //   Icons.wb_cloudy,
      //   size: 30,
      // );
      case 'Heavy rain':
        return Image(image: AssetImage('assets/storm.gif'));

      case 'Light rain shower':
        return Image(image: AssetImage('assets/rain.gif'));

      case 'Patchy rain possible':
      case 'Moderate rain':
        return Image(image: AssetImage('assets/rain (1).gif'));
      case 'Moderate or heavy rain shower':
        return const Icon(Icons.beach_access, size: 30);
      case 'Sunny':
        return Image(image: AssetImage('assets/sun.gif'));

      case 'Clear':
        return Image(image: AssetImage('assets/rainbow.gif'));

      default:
        return Image(image: AssetImage('assets/clouds (1).gif'));
    }
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
          const SizedBox(
            width: 2,
          ),
          Text(text)
        ],
      ),
    );
  }
}
