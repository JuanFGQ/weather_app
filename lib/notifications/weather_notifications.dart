import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather/helpers/utilities_notifications.dart';
import 'package:weather/models/models.dart';

import '../services/services.dart';

// Future<void> createWeatherNotifications(
//     // NotificationWeekAndTime notificationSchedule
//     ) async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: createUniqueId(),
//       channelKey: 'schedule_notification',
//       title: '${Emojis.sun + Emojis.sky_cloud} Buy Plant Food!!!',
//       body: 'Florist at 123 Main St. has 2 in stock. asdasdasdasdasdadadasdsad',
//     ),
//   );
// }

class _ApiData {
  final GeolocatorService currentCoords;
  final WeatherApiService prevision;

  _ApiData(this.currentCoords, this.prevision);
}

Future<Forecastday> notificationData() async {
  final geolocatorService = GeolocatorService();
  final weatherService = WeatherApiService();

  String actualLocationCoords = await geolocatorService.getCurrentLocation();

  print('ACTUAL NOTI TEMP$actualLocationCoords');

  await weatherService.getInfoWeatherLocation(actualLocationCoords);

  print('INFORMACION ${weatherService.forecast![0]}');

  return weatherService.forecast![0];
}

Future<void> createWeatherScheduleNotifications(
    NotificationWeekAndTime notificationSchedule) async {
  try {
    final forecast = await notificationData();

    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        // weekday: notificationSchedule.dayOfTheWeek,
        hour: notificationSchedule.timeOfDay.hour,
        minute: notificationSchedule.timeOfDay.minute,
        // repeats: true,
      ),
      content: NotificationContent(
        // payload: ,
        autoDismissible: true,
        wakeUpScreen: true,
        id: Random().nextInt(100),
        channelKey: 'schedule_notification',
        title:
            '${Emojis.wheater_droplet} ${forecast.day.maxtempC} ${forecast.day.mintempC} ${forecast.day.condition.text} ${forecast.day.totalprecipIn} ',
        body:
            'Water your plant regularly to keep it healthy.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        // notificationLayout: NotificationLayout.BigPicture,
        // bigPicture: 'assets://noti-sun.png',
      ),
      // actionButtons: [
      //   NotificationActionButton(
      //     key: 'MARK_DONE',
      //     label: 'Mark Done',
      //   )
      // ],
    );
  } catch (e) {}
  ;
}

// Future<bool> scheduleNotifications() async {
//   final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
//   return await awesomeNotifications.createNotification(
//       schedule: NotificationCalendar(
//         preciseAlarm: true,
//         allowWhileIdle: true,
//         day: 1,
//         month: 8,
//         year: 2023,
//         hour: 16,
//         minute: 54,
//       ),
//       content: NotificationContent(
//           wakeUpScreen: true,
//           id: Random().nextInt(100),
//           title: "la prevision para hoy en Guadalajara España es",
//           body: "Notificacion programada Funcionando!!!!",
//           channelKey: "schedule_notification"));
// }

// Future<void> cancelScheduleNotifications() async {
//   await AwesomeNotifications().cancelAllSchedules();
// }
