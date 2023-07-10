import 'package:flutter/material.dart';

import '../pages/news_page.dart';

void ShowModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => NewsEmergentWindow());
}

class NewsEmergentWindow extends StatelessWidget {
  const NewsEmergentWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.8,
        initialChildSize: 0.6,
        minChildSize: 0.6,
        builder: (BuildContext context, ScrollController controller) {
          return Container(
            width: 50,
            height: 50,
            color: Colors.red,
            child: NewsPage(),
          );
        });
  }
}
