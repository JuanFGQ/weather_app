import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../search/search_delegate_widget.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final void Function()? function;
  final Icon icon;
  const NoDataPage(
      {super.key, required this.text, this.function, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(FontAwesomeIcons.faceSadCry,
                size: 80, color: Color.fromARGB(220, 158, 158, 158)),
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
