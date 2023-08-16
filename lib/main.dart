import 'dart:io';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/wanted_places_provider.dart';

import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/pages.dart';
import 'providers/providers.dart';
import 'services/services.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  //making sure the process can pass
  WidgetsFlutterBinding.ensureInitialized();
//initialing notifications

  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/defaulticon',
      [
        NotificationChannel(
          // channelGroupKey: 'basic_channel_group',
          channelKey: 'schedule_notification',
          channelName: 'Schedule Notification',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          // locked: true,
          // ledColor: Colors.white,
          channelShowBadge: true,
          importance: NotificationImportance.High,
        ),
      ]);

  //get data certifycate for secure conexition SSL

  ByteData data =
      await PlatformAssetBundle().load('assets/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

//run Application

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeolocatorService()),
        ChangeNotifierProvider(create: (_) => MapBoxService()),
        ChangeNotifierProvider(create: (_) => WeatherApiService()),
        ChangeNotifierProvider(create: (_) => NewsService()),
        ChangeNotifierProvider(create: (_) => NewsListProvider()),
        ChangeNotifierProvider(create: (_) => CitiesListProvider()),
        ChangeNotifierProvider(create: (_) => WantedPlacesProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocalizationProvider>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'loading',
        routes: {
          'loading': (_) => const LoadingPage(),
          'ND': (_) => const NewsDesignPage(),
        },
        // theme: appTheme,
        supportedLocales: L10n.all,
        locale: (!localeProvider.languageEnglish)
            ? const Locale('es')
            : const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ]);
  }
}
