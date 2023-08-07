import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:weather/helpers/utilities_notifications.dart';
import 'package:weather/models/models.dart';

import '../services/services.dart';

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
        displayOnBackground: true,
        // category: ,

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
        notificationLayout: NotificationLayout.BigText,
      ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done'),
        NotificationActionButton(key: 'SHOW_WEATHER', label: 'Show Weather')
      ],
    );
  } catch (e) {}
  ;
}



// Future<void> cancelScheduleNotifications() async {
//   await AwesomeNotifications().cancelAllSchedules();
// }
