// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> initNotifications() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('defaulticon');

//   const InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);

//   await flutterLocalNotificationPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.requestPermission();

//   await flutterLocalNotificationPlugin.initialize(initializationSettings);
// }

// Future<void> showNotifications() async {
//   const AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails('channelId', 'channelName',
//           visibility: NotificationVisibility.public,
//           enableVibration: true,
//           audioAttributesUsage: AudioAttributesUsage.voiceCommunication,
//           enableLights: true,
//           subText: 'informacion Adicional',
//             colorized: true,
//           color: Colors.amber,
//           importance: Importance.max,
//           priority: Priority.high);

//   const NotificationDetails notificationDetail =
//       NotificationDetails(android: androidNotificationDetails);

//   await flutterLocalNotificationPlugin.show(
//       1, 'Weather app', 'actual weather info', notificationDetail);
// }
