import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/State_management.dart';
import 'package:weather/notifications/local_notifications.dart';
import 'package:weather/pages/founded_location_page.dart';
import 'package:weather/pages/gps_access_page.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/pages/loading_page.dart';
import 'package:weather/pages/news_page.dart';
import 'package:weather/preferences/share_prefs.dart';
import 'package:weather/providers/cities_list_provider.dart';
import 'package:weather/providers/news_list_provider.dart';
import 'package:weather/services/geolocator_service.dart';
import 'package:weather/services/mapBox_service.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';

void main() async {
  //making sure the process can pass
  WidgetsFlutterBinding.ensureInitialized();
  //initialating sharePreferences
  await Preferences.init();

//initialing notificationa

  await initNotifications();

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
        ChangeNotifierProvider(create: (_) => MapBoxService()),
        ChangeNotifierProvider(create: (_) => GeolocatorService(), lazy: false),
        ChangeNotifierProvider(create: (_) => WeatherApiService()),
        ChangeNotifierProvider(create: (_) => NewsService(), lazy: false),
        ChangeNotifierProvider(create: (_) => StateManagement()),
        ChangeNotifierProvider(create: (_) => NewsListProvider()),
        ChangeNotifierProvider(create: (_) => CitiesListProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'loading',
      routes: {
        'home': (_) => const HomePage(),
        'founded': (_) => const FoundedLocation(),
        'loading': (_) => const LoadingPage(),
        'gps': (_) => const GpsAccessScreen(),
        'news': (_) => const NewsPage(),
      },
    );
  }
}
