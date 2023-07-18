import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../search/search_delegate_widget.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({super.key});

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
            const Text('There is no news for this city,look for other city.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Pulse(
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 2000),
              infinite: true,
              child: RawMaterialButton(
                  elevation: 10,
                  fillColor: Colors.yellow,
                  shape: const CircleBorder(),
                  child: const FaIcon(FontAwesomeIcons.magnifyingGlassLocation),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const WeatherSearchCity()));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
