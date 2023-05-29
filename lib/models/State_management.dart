import 'package:flutter/material.dart';
import 'package:weather/models/mapbox/Feature.dart';

class StateManagement extends ChangeNotifier {
  bool _hearthButton = false;

  bool get hearthButton => _hearthButton;

  set hearthButton(bool value) {
    _hearthButton = value;
    notifyListeners();
  }

  Feature? _selectedCity;

  Feature? get selectedCity => _selectedCity;

  set selectedCity(Feature? value) {
    _selectedCity = value;
    notifyListeners();
  }

  int _actualCity = 0;

  int get actualCity => _actualCity;

  set actualCity(int value) {
    _actualCity = value;
    notifyListeners();
  }
}
