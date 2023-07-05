import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsDesignPage extends StatelessWidget {
  const NewsDesignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            child: ListTile(
              leading: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.locationDot,
                    color: Colors.white,
                  ),
                  Text(
                    'Manizales',
                    style: TextStyle(
                        color: Colors.white,
                        decorationStyle: TextDecorationStyle.dotted),
                  )
                ],
              ),
              trailing: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
