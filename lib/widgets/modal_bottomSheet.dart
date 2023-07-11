import 'dart:ui';

import 'package:flutter/material.dart';

import '../pages/news_page.dart';

void ShowModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    builder: (context) {
      return Container(
        margin: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 8.0,
              sigmaY: 8.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: Colors.black26,
                  width: 0.5,
                ),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.black12,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: NewsPage()),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
