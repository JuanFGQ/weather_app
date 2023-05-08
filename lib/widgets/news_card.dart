import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: size.width * 1,
          height: size.height * 0.35,
          // decoration: BoxD,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: const Image(
                // colorBlendMode: BlendMode.colorBurn,

                // opacity: 2.0,
                // filterQuality: FilterQuality.medium,
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://www.triviantes.com/wp-content/uploads/2021/03/catedral-de-manizales.jpg')),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          height: size.height * 0.35,
          width: size.width * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xCC000000),
                const Color(0x00000000),
                const Color(0x00000000),
                const Color(0xCC000000),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: size.width * 1,
                    // color: Colors.red,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'News Source',
                      style: TextStyle(
                          backgroundColor: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Color.fromARGB(43, 0, 0, 0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 2,
                          offset: Offset(1, 1),
                          spreadRadius: 1.0,
                          blurStyle: BlurStyle.outer,
                        )
                      ]),
                  child: Text(
                    'La alcaldía de Manizales, Colombia, informó que al menos 28 personas resultaron heridas en los disturbios ocurridos luego de que algunos asistentes al partido de fútbol entre Once Caldas y Alianza Petrolera ingresaron a la cancha.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
