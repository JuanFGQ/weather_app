import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsContent extends StatelessWidget {
  const NewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _HeaderInfoNews(size: size),
              _Description(),
              _ImageTitle(size: size),
              SizedBox(height: 30),
              Container(
                width: size.width * 0.9,
                child: Text(
                  'Las autoridades colombianas detuvieron a siete personas que integraban el “Clan Familiar”, un grupo acusado de reclutar a mujeres jóvenes para explotarlas sexualmente en Chile, informó este domingo la Fiscalía' +
                      'Las jóvenes, detalló la institución en un comunicado, eran reclutadas en “sectores marginales” de Manizales, la capital departamental de Caldas, y “con falsas expectativas laborales las convencían de viajar a Chile para someterlas a tratos inhumanos y explotarlas sexualmente”.' +
                      '“Al parecer, les tramitaban los pasaportes, les proporcionaban los tiquetes aéreos para trasladarlas de Pereira a Bogotá, y, posteriormente, a Chile donde les retenían los documentos y las ubicaban en casas de lenocinio en las ciudades de Osorno, Puerto Montt y Temuco”, agregó la información.' +
                      'Operación de la banda'
                          'Según la investigación de las autoridades colombianas, a las víctimas “les fijaban una deuda que iniciaba en cinco millones de pesos (unos mil dólares)” para los gastos de los tiquetes aéreos.' +
                      'Las autoridades colombianas detuvieron a siete personas que integraban el “Clan Familiar”, un grupo acusado de reclutar a mujeres jóvenes para explotarlas sexualmente en Chile, informó este domingo la Fiscalía' +
                      'Las jóvenes, detalló la institución en un comunicado, eran reclutadas en “sectores marginales” de Manizales, la capital departamental de Caldas, y “con falsas expectativas laborales las convencían de viajar a Chile para someterlas a tratos inhumanos y explotarlas sexualmente”.' +
                      '“Al parecer, les tramitaban los pasaportes, les proporcionaban los tiquetes aéreos para trasladarlas de Pereira a Bogotá, y, posteriormente, a Chile donde les retenían los documentos y las ubicaban en casas de lenocinio en las ciudades de Osorno, Puerto Montt y Temuco”, agregó la información.' +
                      'Operación de la banda'
                          'Según la investigación de las autoridades colombianas, a las víctimas “les fijaban una deuda que iniciaba en cinco millones de pesos (unos mil dólares)” para los gastos de los tiquetes aéreos.',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageTitle extends StatelessWidget {
  const _ImageTitle({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: size.width * 1,
          height: size.height * 0.28,
          // decoration: BoxD,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: const Image(
                  // colorBlendMode: BlendMode.colorBurn,

                  // opacity: 2.0,
                  // filterQuality: FilterQuality.medium,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://www.triviantes.com/wp-content/uploads/2021/03/catedral-de-manizales.jpg'))),
        ),
        Container(
          width: size.width * 0.8,
          child: Center(
            child: Text(
              'Desarticulan en Colombia banda que explotaba sexualmente a jóvenes en Chile',
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        'Las jóvenes, detalló la institución en un comunicado, eran reclutadas en \"sectores marginales\" de Manizales, la capital departamental de Caldas, y \"con falsas expectativas laborales las convencían de viajar a Chile para someterlas a tratos inhumanos y explota…',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _HeaderInfoNews extends StatelessWidget {
  const _HeaderInfoNews({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FaIcon(FontAwesomeIcons.solidNewspaper),
          Text('Elcomercio.com'),
          FaIcon(FontAwesomeIcons.dotCircle, size: 8),
          Text('May 08.2023'),
          FaIcon(FontAwesomeIcons.dotCircle, size: 8),
          Text('Manizales'),
        ],
      ),
    );
  }
}
