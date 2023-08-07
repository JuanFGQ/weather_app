import 'package:flutter/material.dart';

class HeaderTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: Colors.deepPurple,
      child: CustomPaint(
        painter: _CustomHeader(Colors.amber), //136
      ),
    );
  }
}

class _CustomHeader extends CustomPainter {
  final Color color;

  _CustomHeader(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect =
        new Rect.fromCircle(center: Offset(150.0, 55.0), radius: 180);
    //
    //
    //
    //

    final Gradient gradiente = new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          color, //136
          color, //136
          color, //136
          // Colors.red,
          // Colors.yellow,
          // Colors.white,

          // *si agrego un nuevo color debo agregar un nuevo STOP
        ],
        stops: [
          0.2,
          0.5,
          1.0,
        ]);

    final lapiz = Paint()..shader = gradiente.createShader(rect);
// propiedades del lapiz
    lapiz.color = color; //Colors.deepPurple; //137
    lapiz.style = PaintingStyle.stroke;
    lapiz.strokeWidth = 25;

    final path = new Path();

// Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.25);

    //las ultimas dos coordenadas apuntan a el lugar donde debe de llegar la linea
    // x1 es e angulo de la curvatura
    // y1 es por donde quiero que pase la curva, la profundida de la misma
    // path.quadraticBezierTo(size.width * 0.2, size.height * 0.40,
    //     size.width * 0.5, size.height * 0.25);
    path.quadraticBezierTo(
      size.width * 0.7, //*por donde va a pasar la curva
      size.height * 0.15, //*profundidad de la curva
      size.width, //*hasta donde llega el trazo cuando no tiene valor es que llega al otro lado
      size.height *
          0.70, //*hasta donde baja la linea estando ya en el lado del width
    );
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(_CustomHeader oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_CustomHeader oldDelegate) => false;
}
