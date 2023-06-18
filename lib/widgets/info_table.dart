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
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return FadeInUp(
      child: Container(
          padding: const EdgeInsets.all(5),
          width: size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          margin: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            children: [
              ListTile(
                leading: Image(image: AssetImage('assets/$image')),
                title: Text(title),
                trailing: Text(percentage),
              ),
            ],
          )),
    );
  }
}
