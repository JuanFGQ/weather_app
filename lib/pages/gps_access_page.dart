import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import 'pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  //converte to stless widget

  @override
  Widget build(BuildContext context) {
    //aqui tambien deberia tener un stream por que tengo que estar atento a si el usuario desactiva la ubicacion
    //que no este limitado solo cuando la app inicia
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)!.activegps),
          MaterialButton(
            onPressed: () {
              final gpsAccess =
                  Provider.of<GeolocatorService>(context, listen: false);
              gpsAccess.askGpsAccess();
            },
            elevation: 5,
            color: Colors.amber[100],
            splashColor: Colors.amber[200],
            child: Text(AppLocalizations.of(context)!.requestaccess),
          )
        ],
      ),
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(AppLocalizations.of(context)!.mustEnbledlocation));
  }
}
