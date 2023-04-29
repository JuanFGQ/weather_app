import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

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
      new StreamController<bool>.broadcast();

  Stream get refreshLocation => this._refreshLocation.stream;

  // void _init() async {
  //   // final gpsEnabled = Provider.of<StateManagment>(context);

  //   final isEnabled = await _checkGpsStatus();
  //   print('isEnabled FROM GEOLOCATOR SERVICE: $isEnabled');
  // }

  _checkGpsStatus() async {
    //to enable service
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    print('FROM GEOLOCATOR SERVICE $isEnabled');
    // this._refreshLocation.sink.add(isEnabled);
    final locationServiceEnabled = (isEnabled) ? true : false;
    gpsEnabled = locationServiceEnabled;
    this._refreshLocation.sink.add(locationServiceEnabled);

//to get the actual status of the locator
    Geolocator.getServiceStatusStream().listen(
      (event) {
        final statusStream = (event.index == 1) ? true : false;

        print('Geolocator SERVICE !!!!! $gpsEnabled');

        this._refreshLocation.sink.add(statusStream);
      },
    );
    // return (!isEnabled) ? gpsEnabled = false : gpsEnabled = true;
  }

  // Future<void> askGpsAccess() async {

  //   final status = await Permission.location.request();

  //   switch (status) {
  //     case PermissionStatus.granted:
  //       break;
  //     case PermissionStatus.denied:
  //     case PermissionStatus.restricted:
  //     case PermissionStatus.limited:
  //     case PermissionStatus.permanentlyDenied:
  //       openAppSettings();

  //     default:
  //   }
  // }
}
