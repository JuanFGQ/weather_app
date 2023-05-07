import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weather/widgets/news_card.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'News in manizales',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            NewsCard(),
          ],
        ),
      ),
    );
  }
}
