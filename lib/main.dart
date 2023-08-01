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
import 'package:weather/notifications/flutter_notifications.dart';

import 'pages/pages.dart';
import 'providers/providers.dart';
import 'services/services.dart';

void main() async {
  //making sure the process can pass
  WidgetsFlutterBinding.ensureInitialized();
//initialing notifications
  print('INITIALIZING NOTIS ');

  // await initNotifications();
  // AwesomeNotifications().initialize(
  //   'resource://drawable/defaulticon',
  //   [
  //     NotificationChannel(
  //       channelKey: 'scheduled_channel',
  //       channelName: 'Weather Notifications',
  //       defaultColor: Colors.amber,
  //       importance: NotificationImportance.High,
  //       channelShowBadge: true,
  //     )
  //   ],
  // );
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/defaulticon',
      [
        NotificationChannel(
          // channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          locked: true,
          // ledColor: Colors.white,
          importance: NotificationImportance.High,
        ),
        // Channel groups are only visual and are not required
        // channelGroups: [
        //   NotificationChannelGroup(
        //     channelGroupkey: 'basic_channel_group',
        //     channelGroupName: 'Basic group'
        //   )
        // ],
        // debug: true
      ]);

  //      AwesomeNotifications().isNotificationAllowed().then(
  //   (isAllowed) {
  //     if (!isAllowed) {
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text('Allow Notifications'),
  //           content:
  //               const Text('Our app would like to send you notifications'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text(
  //                 'Don\'t Allow',
  //                 style: TextStyle(color: Colors.grey, fontSize: 18),
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () {},
  //               // => AwesomeNotifications()
  //               //     .requestPermissionToSendNotifications(),
  //               // .then((_) => Navigator.pop(context)),
  //               child: const Text(
  //                 'Allow',
  //                 style: TextStyle(
  //                   color: Colors.teal,
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //   },
  // );

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
      locale: (localeProvider.languageEnglish)
          ? const Locale('en')
          : const Locale('es'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
