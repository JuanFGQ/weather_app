import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import 'pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  //converte to stless widget

  @override
  Widget build(BuildContext context) {
    final locationService = Provider.of<GeolocatorService>(context);

    return Scaffold(
        body: (!locationService.gpsEnabled)
            ? const _EnableGpsMessage()
            : (!locationService.isPermissionGranted)
                ? const _AccessButton()
                : const NewsDesignPage());
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          left: 50,
          // top: 10,
          child: FaIcon(FontAwesomeIcons.gear,
              size: 450, color: Color.fromARGB(75, 158, 158, 158)),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.activegps,
                style:
                    const TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
              ),
              MaterialButton(
                  shape: const RoundedRectangleBorder(),
                  onPressed: () {
                    final gpsAccess =
                        Provider.of<GeolocatorService>(context, listen: false);
                    gpsAccess.askGpsAccess();
                  },
                  elevation: 5,
                  color: Colors.blueAccent,
                  splashColor: Colors.blue,
                  child: Text(
                    AppLocalizations.of(context)!.requestaccess,
                    style: const TextStyle(
                        fontSize: 15, fontStyle: FontStyle.italic),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
            bottom: 10,
            right: 100,
            child: FaIcon(FontAwesomeIcons.locationDot,
                size: 450, color: Color.fromARGB(75, 158, 158, 158))),
        Center(
            child: Text(AppLocalizations.of(context)!.mustEnbledlocation,
                style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}
