import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GeolocatorService extends ChangeNotifier {
  GeolocatorService() {
    _init();
    // _checkGpsStatus();
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

  final StreamController<bool> _refreshLocation =
      StreamController<bool>.broadcast();

  Stream get refreshLocation => _refreshLocation.stream;
//********************************************* */
  final StreamController<bool> _loadingData =
      StreamController<bool>.broadcast();

  Stream get loadingData => _loadingData.stream;

//********************************************* */
  bool get isAllGranted => gpsEnabled && isPermissionGranted;

  Future getCurrentLocation() async {
    if (!gpsEnabled && isPermissionGranted) {
      return;
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final coordinates = '${position.latitude},${position.longitude}';
      print('COORDS FROM GEOLOCATOR SERVICE $coordinates');

      return coordinates;
    }
  }

  Future<bool> _checkGpsStatus() async {
    //to enable service
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    final locationServiceEnabled = (isEnabled) ? true : false;
    _gpsEnabled = locationServiceEnabled;
    _loadingData.sink.add(locationServiceEnabled);

//to get the actual status of the locator
    Geolocator.getServiceStatusStream().listen(
      (event) {
        final statusStream = (event.index == 1) ? true : false;
        gpsEnabled = statusStream;

        print(statusStream);
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
    }
  }

  Future<bool> _isPermissionGrant() async {
    final isGranted = await Permission.location.isGranted;
    _isPermissionGranted = isGranted;

    // this._loadingData.sink.add(isGranted);
    return isGranted;
  }

  Future<void> _init() async {
    final generalLocatioState = await Future.wait(
      [
        _checkGpsStatus(),
        _isPermissionGrant(),
      ],
    );

    // _gpsEnabled = generalLocatioState[0];
    // _isPermissionGranted = generalLocatioState[1];
  }
}
