import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import 'pages.dart';

class GpsAccessScreen extends StatefulWidget {
  const GpsAccessScreen({super.key});

  @override
  State<GpsAccessScreen> createState() => _GpsAccessScreenState();
}

class _GpsAccessScreenState extends State<GpsAccessScreen> {
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
          const Text('Es necesario el acceso a gps'),
          MaterialButton(
            onPressed: () {
              final gpsAccess =
                  Provider.of<GeolocatorService>(context, listen: false);
              gpsAccess.askGpsAccess();
            },
            elevation: 5,
            color: Colors.amber[100],
            splashColor: Colors.amber[200],
            child: const Text('Solicitar acceso'),
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
    return const Center(child: Text('Debe habilitar la ubicacion'));
  }
}
