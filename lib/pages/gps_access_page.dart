import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/state_management.dart';
import 'package:weather/services/geolocator_service.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gpsManagement = Provider.of<GeolocatorService>(context);

    return Scaffold(body: StreamBuilder(builder: (_, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) return 
    })

        // Center(
        //     child: !gpsManagement.gpsEnabled
        //         ? _EnableGpsMessage()
        //         : _AccessButton()),
        );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Es necesario el acceso a gps'),
        MaterialButton(
          onPressed: () {},
          child: Text('Solicitar acceso'),
          elevation: 5,
          color: Colors.amber[100],
          splashColor: Colors.amber[200],
        )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('Debe habilitar la ubicacion');
  }
}
