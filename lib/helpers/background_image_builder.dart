class BackGroundImageBuilder {
  final String weatherCondition;

  final Map<String, String> backGrounds = {
    'Partly cloudy': 'assets/red-lighthouse-g1933290b4_640.jpg',
    'Parcialmente nublado': 'assets/red-lighthouse-g1933290b4_640.jpg',
    'niebla moderada': 'assets/fog-g23cb2c869_640.jpg',
    'Heavy rain': 'assets/mountains-g809c71b53_640.jpg',
    'Overcast': 'assets/red-lighthouse-g1933290b4_640.jpg',
    'Fuertes lluvias': 'assets/mountains-g809c71b53_640.jpg',
    'Light rain shower': 'assets/railing-g65bea1cfd_640.jpg',
    'Light rain': 'assets/railing-g65bea1cfd_640.jpg',
    'Lluvia ligera': 'assets/railing-g65bea1cfd_640.jpg',
    'Patchy rain possible': 'assets/railing-g65bea1cfd_640.jpg',
    'Moderate rain': 'assets/railing-g65bea1cfd_640.jpg',
    'Moderate or heavy rain shower': 'assets/mountains-g809c71b53_640.jpg',
    'Lluvia moderada a intervalos': 'assets/heavy-rain-g4ec8672ac_1280.jpg',
    'Lluvia fuerte o moderada': 'assets/railing-g65bea1cfd_640.jpg',
    'Sunny': 'assets/ocean-g87e883915_640.jpg',
    'Soleado': 'assets/ocean-g87e883915_640.jpg',
    'Clear': 'assets/phang-nga-bay-g3332dcc82_640.jpg',
    'Despejado': 'assets/phang-nga-bay-g3332dcc82_640.jpg',
  };

  BackGroundImageBuilder(this.weatherCondition);
  String buildBackGroundImage(String weatherCondition) {
    return backGrounds.containsKey(weatherCondition)
        ? backGrounds[weatherCondition]!
        : 'assets/phang-nga-bay-g3332dcc82_640.jpg';
  }
}
