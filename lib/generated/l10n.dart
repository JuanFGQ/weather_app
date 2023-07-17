// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Español`
  String get language {
    return Intl.message(
      'Español',
      name: 'language',
      desc: 'Lenguage actual',
      args: [],
    );
  }

  /// `Noticias`
  String get news {
    return Intl.message(
      'Noticias',
      name: 'news',
      desc: 'Noticias',
      args: [],
    );
  }

  /// `Guardar ubicacion`
  String get savelocation {
    return Intl.message(
      'Guardar ubicacion',
      name: 'savelocation',
      desc: 'Guardar ubicacion',
      args: [],
    );
  }

  /// `Refrescar`
  String get refresh {
    return Intl.message(
      'Refrescar',
      name: 'refresh',
      desc: 'Refrescar pagina',
      args: [],
    );
  }

  /// `Buscar ciudad`
  String get searchcity {
    return Intl.message(
      'Buscar ciudad',
      name: 'searchcity',
      desc: 'Buscar ciudad',
      args: [],
    );
  }

  /// `Noticias por leer`
  String get newsforread {
    return Intl.message(
      'Noticias por leer',
      name: 'newsforread',
      desc: 'Noticias por leer',
      args: [],
    );
  }

  /// `Lugares favoritos`
  String get favouriteplaces {
    return Intl.message(
      'Lugares favoritos',
      name: 'favouriteplaces',
      desc: 'Lugares favoritos',
      args: [],
    );
  }

  /// `Temas`
  String get themes {
    return Intl.message(
      'Temas',
      name: 'themes',
      desc: 'Temas',
      args: [],
    );
  }

  /// `Viento`
  String get wind {
    return Intl.message(
      'Viento',
      name: 'wind',
      desc: 'viento',
      args: [],
    );
  }

  /// `Humedad`
  String get humidity {
    return Intl.message(
      'Humedad',
      name: 'humidity',
      desc: 'Humedad',
      args: [],
    );
  }

  /// `Visibilidad`
  String get visibility {
    return Intl.message(
      'Visibilidad',
      name: 'visibility',
      desc: 'Visibilidad',
      args: [],
    );
  }

  /// `Direccion del viento`
  String get winddirection {
    return Intl.message(
      'Direccion del viento',
      name: 'winddirection',
      desc: 'Direccion del viento',
      args: [],
    );
  }

  /// `Temperatura`
  String get temperature {
    return Intl.message(
      'Temperatura',
      name: 'temperature',
      desc: 'Temperatura',
      args: [],
    );
  }

  /// `Sensacion termica`
  String get feelslike {
    return Intl.message(
      'Sensacion termica',
      name: 'feelslike',
      desc: 'Sensacion termica',
      args: [],
    );
  }

  /// `Inglés`
  String get english {
    return Intl.message(
      'Inglés',
      name: 'english',
      desc: 'Inglés',
      args: [],
    );
  }

  /// `Español`
  String get spanish {
    return Intl.message(
      'Español',
      name: 'spanish',
      desc: 'Español',
      args: [],
    );
  }

  /// `Todas las noticias`
  String get allnews {
    return Intl.message(
      'Todas las noticias',
      name: 'allnews',
      desc: 'Todas las noticias',
      args: [],
    );
  }

  /// `Descendiente`
  String get descending {
    return Intl.message(
      'Descendiente',
      name: 'descending',
      desc: 'Descendiente',
      args: [],
    );
  }

  /// `Ascendente`
  String get ascending {
    return Intl.message(
      'Ascendente',
      name: 'ascending',
      desc: 'Ascendente',
      args: [],
    );
  }

  /// `Tema oscuro`
  String get darktheme {
    return Intl.message(
      'Tema oscuro',
      name: 'darktheme',
      desc: 'Tema oscuro',
      args: [],
    );
  }

  /// `Tema ligero`
  String get lighttheme {
    return Intl.message(
      'Tema ligero',
      name: 'lighttheme',
      desc: 'Tema ligero',
      args: [],
    );
  }

  /// `Pagina principal`
  String get home {
    return Intl.message(
      'Pagina principal',
      name: 'home',
      desc: 'Pagina principal',
      args: [],
    );
  }

  /// `Noticias recientes`
  String get recentsnews {
    return Intl.message(
      'Noticias recientes',
      name: 'recentsnews',
      desc: 'Noticias recientes',
      args: [],
    );
  }

  /// `Noticias antiguas`
  String get oldnews {
    return Intl.message(
      'Noticias antiguas',
      name: 'oldnews',
      desc: 'Noticias antiguas',
      args: [],
    );
  }

  /// `Ya esta guardado!`
  String get allreadysave {
    return Intl.message(
      'Ya esta guardado!',
      name: 'allreadysave',
      desc: 'Ya esta guardado!',
      args: [],
    );
  }

  /// `Nubosidad`
  String get cloud {
    return Intl.message(
      'Nubosidad',
      name: 'cloud',
      desc: 'Nubosidad',
      args: [],
    );
  }

  /// `Presion`
  String get pressure {
    return Intl.message(
      'Presion',
      name: 'pressure',
      desc: 'Presion',
      args: [],
    );
  }

  /// `Precipitacion`
  String get precipitation {
    return Intl.message(
      'Precipitacion',
      name: 'precipitation',
      desc: 'Precipitacion',
      args: [],
    );
  }

  /// `Rayos UV`
  String get uvrays {
    return Intl.message(
      'Rayos UV',
      name: 'uvrays',
      desc: 'Rayos UV',
      args: [],
    );
  }

  /// `Pronostico Semanal`
  String get weeklyforecast {
    return Intl.message(
      'Pronostico Semanal',
      name: 'weeklyforecast',
      desc: 'Pronostico Semanal',
      args: [],
    );
  }

  /// `No hay noticias para esta ciudad, busca otra!`
  String get nonews {
    return Intl.message(
      'No hay noticias para esta ciudad, busca otra!',
      name: 'nonews',
      desc: 'No hay noticias para esta ciudad, busca otra!',
      args: [],
    );
  }

  /// `en`
  String get ins {
    return Intl.message(
      'en',
      name: 'ins',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
