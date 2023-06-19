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
      _currentTheme = ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.blue,
          appBarTheme: AppBarTheme(color: Colors.blue),
          textTheme: TextTheme(
            titleLarge: TextStyle(color: Colors.white10),
            bodyLarge: TextStyle(color: Colors.white10),
            displayLarge: TextStyle(color: Colors.white10),
          )
          // primaryColor: Colors.red,
          // colorScheme: ColorScheme(
          //     brightness: Brightness.dark,
          //     primary: Colors.blue,
          //     onPrimary: Colors.red,
          //     secondary: Colors.yellow,
          //     onSecondary: Colors.green,
          //     error: Colors.blue,
          //     onError: Colors.orange,
          //     background: Colors.amberAccent,
          //     onBackground: Colors.cyan,
          //     surface: Colors.tealAccent,
          //     onSurface: Colors.lime,
          //     primaryContainer: Colors.white),
          // // iconButtonTheme: IconButtonThemeData(
          // //     style: ButtonStyle(
          // //         backgroundColor: MaterialStatePropertyAll(Colors.brown))),
          // // iconTheme: IconThemeData(color: Colors.yellow),
          // filledButtonTheme: FilledButtonThemeData(
          //     style: ButtonStyle(
          //         backgroundColor: MaterialStatePropertyAll(Colors.green))),
          // primaryIconTheme: IconThemeData(color: Colors.blue),
          // typography: Typography(
          //     dense:
          //         TextTheme(bodyLarge: TextStyle(fontStyle: FontStyle.italic))),
          ); //134
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
      _currentTheme = ThemeData.light().copyWith(
          // primaryColorLight: Colors.black,
          // secondaryHeaderColor: Colors.blue,
          // scaffoldBackgroundColor: Colors.amberAccent,
          // textTheme:
          //     TextTheme(bodyLarge: TextStyle(color: Colors.grey.shade400)),
          // colorScheme: ColorScheme.fromSwatch()
          //     .copyWith(secondary: Colors.yellow)
          //
          ); //134
    } else {
      //134
      _currentTheme = ThemeData.light(); //134
    } //134

    notifyListeners();
  }
}
