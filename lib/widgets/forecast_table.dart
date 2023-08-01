import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/weather/new_weather_response.dart';
import 'package:weather/services/weather_api_service.dart';

class ForeCastTable extends StatelessWidget {
  final Forecastday forecast;

  const ForeCastTable({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final weatherLanguage = Provider.of<WeatherApiService>(context);
    final size = MediaQuery.of(context).size;
    final forecastDate = forecast.date;
    final dayFormatName =
        DateFormat('EEEE', (weatherLanguage.isEnglish == false) ? 'es' : 'en');
    final dayName = dayFormatName.format(forecastDate).toUpperCase();
    final dayFormatNumber =
        DateFormat('MMMMd', (weatherLanguage.isEnglish == false) ? 'es' : 'en');
    final dayNumber = dayFormatNumber.format(forecastDate);

    return Container(
      margin: const EdgeInsets.all(5),
      width: size.width * 0.50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1, 1.5),
            spreadRadius: 0.5,
            blurRadius: 0.2,
            // blurStyle: BlurStyle.outer,
          )
        ],

//
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
                      child: _BuildWeatherIcon(
                        weatherCondition: forecast.day.condition.text,
                      )),
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
      margin: const EdgeInsets.all(5),
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

class _BuildWeatherIcon extends StatelessWidget {
  final String weatherCondition;
  const _BuildWeatherIcon({required this.weatherCondition});

  @override
  Widget build(BuildContext context) {
    final Map<String, Image> weatherIcons = {
      'Partly cloudy': const Image(image: AssetImage('assets/clouds (1).gif')),
      'Heavy rain': const Image(image: AssetImage('assets/storm.gif')),
      'Fuertes lluvias': const Image(image: AssetImage('assets/storm.gif')),
      'Light rain shower': const Image(image: AssetImage('assets/rain.gif')),
      'Lluvia ligera': const Image(image: AssetImage('assets/rain.gif')),
      'Parcialmente nublado':
          const Image(image: AssetImage('assets/clouds (1).gif')),
      'Patchy rain possible':
          const Image(image: AssetImage('assets/rain (1).gif')),
      'Lluvia moderada a intervalos':
          const Image(image: AssetImage('assets/rain (1).gif')),
      'Moderate or heavy rain shower':
          const Image(image: AssetImage('assets/rain (1).gif')),
      'Lluvia fuerte o moderada':
          const Image(image: AssetImage('assets/rain (1).gif')),
      'Sunny': const Image(image: AssetImage('assets/sun.gif')),
      'Soleado': const Image(image: AssetImage('assets/sun.gif')),
      'Clear': const Image(image: AssetImage('assets/rainbow.gif')),
      'Despejado': const Image(image: AssetImage('assets/rainbow.gif')),
    };

    return weatherIcons.containsKey(weatherCondition)
        ? weatherIcons[weatherCondition]!
        : const Image(image: AssetImage('assets/clouds (1).gif'));
  }
}
