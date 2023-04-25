import 'package:flutter/material.dart';

class StateManagment extends ChangeNotifier {
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
}
