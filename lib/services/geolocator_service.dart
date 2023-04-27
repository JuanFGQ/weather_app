import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorService extends ChangeNotifier {
  GeolocatorService() {
    _checkGpsStatus();
  }

  bool _isPermissionGranted = false;
  bool _gpsEnabled = false;

  bool get isPermissionGranted => _isPermissionGranted;
  set isPermissionGranted(bool value) {
    _isPermissionGranted = value;
    notifyListeners();
  }

  bool get gpsEnabled => _gpsEnabled;
  set gpsEnabled(bool value) {
    _gpsEnabled = value;
    notifyListeners();
  }

  final StreamController<bool> _refreshLocation =
      new StreamController.broadcast();

  Stream<bool> get refreshLocation => this._refreshLocation.stream;

  // void _init() async {
  //   // final gpsEnabled = Provider.of<StateManagment>(context);

  //   final isEnabled = await _checkGpsStatus();
  //   print('isEnabled FROM GEOLOCATOR SERVICE: $isEnabled');
  // }

  void _checkGpsStatus() async {
    //to enable service
    final isEnable = await Geolocator.isLocationServiceEnabled();
    this._refreshLocation.add(isEnable);

//to get the actual status of the locator
    Geolocator.getServiceStatusStream().listen((event) {
      print('service status FROM GEOLOCATOR SERVICE $event');
      //todo:trigger events
    });

    // return (isEnable) ? gpsEnabled = true : gpsEnabled = false;
  }
}
