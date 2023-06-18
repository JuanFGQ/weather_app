import 'package:flutter/material.dart';
import 'package:weather/l10n/l10n.dart';

class LocalizationProvider extends ChangeNotifier {
  bool _languageEnglish = true;

  bool get languageEnglish => _languageEnglish;

  set languageEnglish(bool value) {
    _languageEnglish = value;
    notifyListeners();
  }

  bool _languageSpanish = false;

  bool get languageSpanish => _languageSpanish;

  set languageSpanish(bool value) {
    _languageSpanish = value;
    notifyListeners();
  }
}
