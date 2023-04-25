import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/state_management.dart';
import 'package:weather/pages/gps_access_page.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/pages/loading_page.dart';
import 'package:weather/pages/testpage.dart';
import 'package:weather/services/mapBox_Info_Provider.dart';
import 'package:weather/services/weather_api_service.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MapBoxInfoProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
            create: (_) => WeatherApiService(query: 'manizales'), lazy: false),
        ChangeNotifierProvider(create: (_) => StateManagment())
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
      initialRoute: 'gps',
      routes: {
        'home': (_) => HomePage(),
        'test': (_) => TestPage(),
        'loading': (_) => LoadingPage(),
        'gps': (_) => GpsAccessScreen(),
      },
    );
  }
}
