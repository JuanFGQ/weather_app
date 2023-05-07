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
          height: size.height * 0.28,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: const Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://www.triviantes.com/wp-content/uploads/2021/03/catedral-de-manizales.jpg')),
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
                    color: Colors.red,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Text('News Source')),
                Container(
                  width: size.width * 1,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                      'La alcaldía de Manizales, Colombia, informó que al menos 28 personas resultaron heridas en los disturbios ocurridos luego de que algunos asistentes al partido de fútbol entre Once Caldas y Alianza Petrolera ingresaron a la cancha'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
