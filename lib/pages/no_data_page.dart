import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final void Function()? function;
  final Icon icon;
  final Icon bigIcon;

  const NoDataPage(
      {super.key,
      required this.text,
      this.function,
      required this.icon,
      required this.bigIcon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bigIcon,
            const SizedBox(height: 30),
            Text(text,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Pulse(
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 2000),
              infinite: true,
              child: RawMaterialButton(
                elevation: 10,
                fillColor: Colors.yellow,
                shape: const CircleBorder(),
                onPressed: function,
                child: icon,
              ),
            )
          ],
        ),
      ),
    );
  }
}
