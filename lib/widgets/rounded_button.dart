import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final void Function()? function;
  final bool infinite;
  final Widget icon;

  const RoundedButton({
    super.key,
    this.function,
    required this.infinite,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 1000),
      child: Bounce(
        delay: const Duration(milliseconds: 800),
        from: 6,
        infinite: infinite,
        child: RawMaterialButton(
          shape: const CircleBorder(),
          onPressed: function,
          fillColor: Colors.white,
          child: icon,
          elevation: 5,
        ),
      ),
    );
  }
}
