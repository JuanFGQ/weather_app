import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final void Function()? function;
  final bool infinite;
  final Widget icon;
  Widget? text;

  RoundedButton({
    super.key,
    this.function,
    required this.infinite,
    required this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeIn(
          delay: const Duration(milliseconds: 1000),
          child: RawMaterialButton(
            hoverColor: Colors.white38,
            highlightColor: const Color.fromARGB(188, 96, 125, 139),
            shape: const CircleBorder(),
            onPressed: function,
            fillColor: Colors.white,
            elevation: 5,
            child: icon,
          ),
        ),
        ZoomIn(delay: Duration(milliseconds: 1000), child: text!)
      ],
    );
  }
}
