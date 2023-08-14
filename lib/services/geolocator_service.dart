import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GeolocatorService extends ChangeNotifier {
  GeolocatorService() {
    _init();
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

//********************************************* */
  final StreamController<bool> _loadingData =
      StreamController<bool>.broadcast();

  Stream get loadingData => _loadingData.stream;

//********************************************* */
  bool get isAllGranted => gpsEnabled && isPermissionGranted;
//********************************************* */

  Future getCurrentLocation() async {
    if (!gpsEnabled && isPermissionGranted) {
      return;
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final coordinates = '${position.latitude},${position.longitude}';

      return coordinates;
    }
  }

  Future<bool> _checkGpsStatus() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    final locationServiceEnabled = (isEnabled) ? true : false;
    _gpsEnabled = locationServiceEnabled;
    print('LOCATION IS ENABLED STREAM $locationServiceEnabled');
    _loadingData.sink.add(locationServiceEnabled);

    Geolocator.getServiceStatusStream().listen(
      (event) {
        final statusStream = (event.index == 1) ? true : false;
        gpsEnabled = statusStream;
        print('STATUS STREAM $statusStream');

        _loadingData.sink.add(statusStream);
      },
    );

    return locationServiceEnabled;
  }

  Future askGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        isPermissionGranted = true;

        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        isPermissionGranted = false;
        openAppSettings();
        break;
      case PermissionStatus.provisional:
        break;
    }
  }

  Future<bool> _isPermissionGrant() async {
    final isGranted = await Permission.location.isGranted;
    _isPermissionGranted = isGranted;

    return isGranted;
  }

  Future<void> _init() async {
    await Future.wait(
      [
        _checkGpsStatus(),
        _isPermissionGrant(),
      ],
    );
  }
}
