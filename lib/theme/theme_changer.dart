import 'package:flutter/material.dart';

// creado desde 133

class ThemeChanger with ChangeNotifier {
  bool _darkTheme = false;
  bool _customTheme = false;

  late ThemeData _currentTheme = ThemeData.light();
  //134

  bool get darkTheme => this._darkTheme;
  bool get customTheme => this._customTheme;
  ThemeData get currentTheme => this._currentTheme; //134

  ThemeChanger(int theme) {
    switch (theme) {
      case 1: //ligh
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light();

        break;

      case 2: //dark
        _darkTheme = true;
        _customTheme = false;
        _currentTheme = ThemeData.dark().copyWith(
          hintColor: Colors.pink,
        );
        break;

      case 3:
        _darkTheme = false;
        _customTheme = true;
        break;

      default:
        _darkTheme = false;
        _currentTheme = ThemeData.light();
    }
  }

  set darkTheme(bool value) {
    _customTheme = false;
    _darkTheme = value;
    if (value) {
      //134
      _currentTheme = ThemeData.dark(); //134
    } else {
      //134
      _currentTheme = ThemeData.light(); //134
    }
    notifyListeners();
  }

  set customTheme(bool value) {
    _customTheme = value;
    _darkTheme = false;

    if (value) {
      //134
      _currentTheme = ThemeData.dark().copyWith(
          // primaryColorLight: Colors.black,
          secondaryHeaderColor: Colors.grey,
          // scaffoldBackgroundColor: Colors.amberAccent,
          textTheme:
              TextTheme(bodyLarge: TextStyle(color: Colors.grey.shade400)),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.yellow)); //134
    } else {
      //134
      _currentTheme = ThemeData.light(); //134
    } //134

    notifyListeners();
  }
}
