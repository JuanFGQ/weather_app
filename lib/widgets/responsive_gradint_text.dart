import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final double minFontSize;
  final double maxFontSize;

  const ResponsiveText({
    Key? key,
    required this.text,
    this.minFontSize = 12,
    this.maxFontSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        return FittedBox(
          fit: BoxFit.contain,
          child: Text(
            text,
            style: TextStyle(
              fontSize: calculateFontSize(maxWidth),
            ),
          ),
        );
      },
    );
  }

  double calculateFontSize(double maxWidth) {
    final scaleFactor = maxWidth / 2000;
    final fontSize = maxFontSize * scaleFactor;

    return fontSize.clamp(minFontSize, maxFontSize);
  }
}
