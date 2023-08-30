import 'package:flutter/material.dart';

import '../pages/news_page.dart';

void ShowModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.25,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: Colors.black12,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(child: NewsPage()),
          ],
        ),
      );
    },
  );
}
