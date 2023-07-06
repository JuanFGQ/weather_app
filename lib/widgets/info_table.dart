import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/theme/theme_changer.dart';

class InfoIcon extends StatelessWidget {
  final String image;
  final String title;
  final String percentage;

  const InfoIcon(
      {super.key,
      required this.image,
      required this.title,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appTheme = Provider.of<ThemeChanger>(context);

    return FadeInUp(
      child: Opacity(
        opacity: (appTheme.darkTheme) ? 0.5 : 1,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 98),
              child: Text(title,
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.white)),
            ),
            Container(
                height: 50,
                // padding: const EdgeInsets.all(5),
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(left: 110),
                child: ListTile(
                  leading:
                      Text(percentage, style: TextStyle(color: Colors.black)),

                  // title: Text(
                  //   title,
                  //   style: TextStyle(color: Colors.black),
                  // ),
                  trailing: Container(
                      height: 30,
                      width: 30,
                      child: Image(image: AssetImage('assets/$image'))),
                )),
          ],
        ),
      ),
    );
  }
}
