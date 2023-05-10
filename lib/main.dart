import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather/notifications/local_notifications.dart';
import 'package:weather/pages/founded_location.dart';
import 'package:weather/pages/gps_access_page.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/pages/loading_page.dart';
import 'package:weather/pages/news_content_page.dart';
import 'package:weather/pages/news_viewer_page.dart';
import 'package:weather/services/geolocator_service.dart';
import 'package:weather/services/mapBox_Info_service.dart';
import 'package:weather/services/news_service.dart';
import 'package:weather/services/weather_api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initNotifications();

  ByteData data =
      await PlatformAssetBundle().load('assets/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(AppState());
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
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MyApp(),
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
        'home': (_) => HomePage(),
        'founded': (_) => FoundedLocation(),
        'loading': (_) => LoadingPage(),
        'gps': (_) => GpsAccessScreen(),
        'news': (_) => NewsPage(),
        // 'newsC': (_) => NewsContent(),
      },
    );
  }
}
