import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Words extends StatelessWidget {
  final String date;
  final double? wordSize;
  final FontWeight? fontWeight;
  final Color? wordColor;
  final bool isVisible;

  const Words(
      {super.key,
      required this.date,
      this.wordSize,
      this.fontWeight,
      this.wordColor,
      required this.isVisible});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: Visibility(
            visible: isVisible,
            child: Container(
              width: size.width * 0.6,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  shape: BoxShape.rectangle,
                  color: Colors.black),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: FadeInUp(
            child: Text(
              date,
              style: TextStyle(
                  fontSize: wordSize, fontWeight: fontWeight, color: wordColor),
            ),
          ),
        )
      ],
    );
  }
}
