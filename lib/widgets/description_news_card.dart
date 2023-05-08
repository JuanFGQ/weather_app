import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DescriptionNewsCard extends StatelessWidget {
  const DescriptionNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: size.width * 0.35,
          height: size.height * 0.18,
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
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: size.height * 0.16,
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Source news/Authors'),
                Container(
                    // width: size.width * 0.5,
                    // margin: EdgeInsets.all(10),
                    // color: Colors.red,
                    child: Text(
                  'US debt ceiling: A simple guide to the crisis.',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                )),
                Text('May 05.2023')
              ],
            ),
          ),
        )
      ],
    );
  }
}
