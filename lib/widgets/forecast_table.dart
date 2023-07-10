import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForeCastTable extends StatelessWidget {
  const ForeCastTable({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(5),
      width: size.width * 0.50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.amber,
      ),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Lunes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  // color: Colors.red,
                  margin: EdgeInsets.only(left: 20),
                  child: Stack(
                    children: [
                      Positioned(
                          top: -4,
                          child: Text(
                            'AVG',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic),
                          )),
                      Spacer(),
                      Text(
                        '20º',
                        style: TextStyle(
                            fontSize: 65, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Container(
                    margin: EdgeInsets.only(bottom: 30, right: 20),
                    child: FaIcon(
                      FontAwesomeIcons.cloud,
                      size: 30,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SubIconsInfo(
                  icon: FaIcon(FontAwesomeIcons.droplet, size: 20),
                  text: '10%',
                ),
                _SubIconsInfo(
                  icon: FaIcon(FontAwesomeIcons.wind, size: 20),
                  text: '20km/h',
                ),
                _SubIconsInfo(
                  icon: FaIcon(FontAwesomeIcons.sun, size: 20),
                  text: 'low',
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class _SubIconsInfo extends StatelessWidget {
  final Widget icon;
  final String text;

  const _SubIconsInfo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 2,
          ),
          Text(text)
        ],
      ),
    );
  }
}
