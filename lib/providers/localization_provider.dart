import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  bool _languageEnglish = false;

  bool get languageEnglish => _languageEnglish;

  set languageEnglish(bool value) {
    _languageEnglish = value;
    notifyListeners();
  }

  bool _languageSpanish = true;

  bool get languageSpanish => _languageSpanish;

  set languageSpanish(bool value) {
    _languageSpanish = value;
    notifyListeners();
  }
}
