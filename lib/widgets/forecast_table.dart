import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../helpers/weather_icon_build_gift.dart';
import '../models/models.dart';
import '../providers/providers.dart';

class ForeCastTable extends StatelessWidget {
  final Forecastday forecast;
  final LocalizationProvider localeProvider;
  final Size size;

  const ForeCastTable(
      {super.key,
      required this.forecast,
      required this.localeProvider,
      required this.size});

  @override
  Widget build(BuildContext context) {
    final dayFormatName =
        DateFormat('EEEE', (!localeProvider.languageEnglish) ? 'es' : 'en');
    final dayName = dayFormatName.format(forecast.date).toUpperCase();

    final dayFormatNumber =
        DateFormat('MMMMd', (!localeProvider.languageEnglish) ? 'es' : 'en');
    final dayNumber = dayFormatNumber.format(forecast.date);

    return Container(
      margin: const EdgeInsets.all(5),
      width: size.width * 0.50,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 4, left: 10, right: 10),
                    child: Text(
                      dayName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Text(
                      dayNumber,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
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
                Stack(
                  children: [
                    const Text(
                      'AVG',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(width: 5),

                    // const Spacer(),
                    Text(
                      '${forecast.day.avgtempC}º',
                      style: const TextStyle(
                          fontSize: 65, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                RepaintBoundary(
                  child: Container(
                      width: 45,
                      height: 45,
                      margin: const EdgeInsets.only(bottom: 30, right: 10),
                      child: Image(
                          image: AssetImage(
                              WeatherIconBuild(forecast.day.condition.text)
                                  .toString()))),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SubIconsInfo(
                  icon: const FaIcon(FontAwesomeIcons.droplet,
                      color: Colors.blue, size: 20),
                  text: '${forecast.day.avghumidity} %',
                ),
                _SubIconsInfo(
                  icon: const FaIcon(FontAwesomeIcons.wind,
                      color: Colors.cyanAccent, size: 20),
                  text: '${forecast.day.maxwindKph} km/h',
                ),
                _SubIconsInfo(
                  icon: const FaIcon(FontAwesomeIcons.sun,
                      color: Colors.yellow, size: 20),
                  text: '${forecast.day.uv} uv',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SubIconsInfo extends StatelessWidget {
  final Widget icon;
  final String text;

  const _SubIconsInfo({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          icon,
          // const SizedBox(width: 1),
          Text(text),
        ],
      ),
    );
  }
}
