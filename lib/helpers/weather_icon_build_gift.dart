class WeatherIconBuild {
  final String weatherCondition;

  final Map<String, String> weatherIcons = {
    'Partly cloudy': 'assets/clouds (1).gif',
    'Heavy rain': 'assets/storm.gif',
    'Fuertes lluvias': 'assets/storm.gif',
    'Light rain shower': 'assets/rain.gif',
    'Lluvia ligera': 'assets/rain.gif',
    'Parcialmente nublado': 'assets/clouds (1).gif',
    'Patchy rain possible': 'assets/rain (1).gif',
    'Lluvia moderada a intervalos': 'assets/rain (1).gif',
    'Moderate or heavy rain shower': 'assets/rain (1).gif',
    'Lluvia fuerte o moderada': 'assets/rain (1).gif',
    'Sunny': 'assets/sun.gif',
    'Soleado': 'assets/sun.gif',
    'Clear': 'assets/rainbow.gif',
    'Despejado': 'assets/rainbow.gif',
  };

  WeatherIconBuild(this.weatherCondition);

  String getWeatherIcon(String weatherCondition) {
    return weatherIcons.containsKey(weatherCondition)
        ? weatherIcons[weatherCondition]!
        : 'assets/clouds (1).gif';
  }
}
