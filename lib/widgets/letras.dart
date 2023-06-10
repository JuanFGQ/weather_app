import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class Words extends StatelessWidget {
  final String date;
  final double? wordSize;
  final FontWeight? fontWeight;
  final Color? wordColor;

  const Words({
    super.key,
    required this.date,
    this.wordSize,
    this.fontWeight,
    this.wordColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        width: size.width * 0.6,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            shape: BoxShape.rectangle,
            color: Colors.black),
        child: FadeInUp(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              date,
              style: TextStyle(
                  fontSize: wordSize, fontWeight: fontWeight, color: wordColor),
            ),
          ),
        ),
      ),
    );
  }
}
