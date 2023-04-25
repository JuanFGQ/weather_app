import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorService extends ChangeNotifier {
  GeolocatorService() {
    _init();
  }

  Future<void> _init() async {
    final isEnabled = await _checkGpsStatus();
    print('isEnabled: $isEnabled');
  }

  Future<bool> _checkGpsStatus() async {
    //to enable service
    final isEnable = await Geolocator.isLocationServiceEnabled();

//to get the actual status of the locator
    Geolocator.getServiceStatusStream().listen((event) {
      print('service status $event');
      //todo:trigger events
    });

    return isEnable;
  }
}
