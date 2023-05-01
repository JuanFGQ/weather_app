import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/geolocator_service.dart';

class GpsAccessScreen extends StatefulWidget {
  const GpsAccessScreen({super.key});

  @override
  State<GpsAccessScreen> createState() => _GpsAccessScreenState();
}

class _GpsAccessScreenState extends State<GpsAccessScreen> {
  @override
  Widget build(BuildContext context) {
    final locationService = Provider.of<GeolocatorService>(context);

    return Scaffold(
      body: StreamBuilder(
        stream: locationService.refreshLocation,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return _DisableGpsMessage();
          } else if (snapshot.data!) {
            // `!` is used to mark `data` as non-null
            return _AccessButton(); // Show this widget when the data is `true`
          } else {
            return _EnableGpsMessage(); // Show this widget when the data is `false`
          }
        },
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Es necesario el acceso a gps'),
          MaterialButton(
            onPressed: () {
              final gpsAccess =
                  Provider.of<GeolocatorService>(context, listen: false);
              gpsAccess.askGpsAccess();
            },
            child: Text('Solicitar acceso'),
            elevation: 5,
            color: Colors.amber[100],
            splashColor: Colors.amber[200],
          )
        ],
      ),
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Debe habilitar la ubicacion'));
  }
}

class _DisableGpsMessage extends StatelessWidget {
  const _DisableGpsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('disable gps'),
    );
  }
}
