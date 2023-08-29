import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:weather/helpers/utilities_notifications.dart';

Future<void> createWeatherScheduleNotifications(
    NotificationWeekAndTime notificationSchedule) async {
  try {
    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        preciseAlarm: true,
        allowWhileIdle: true,
        hour: notificationSchedule.timeOfDay.hour,
        minute: notificationSchedule.timeOfDay.minute,
      ),
      content: NotificationContent(
        displayOnBackground: true,

        autoDismissible: true,
        wakeUpScreen: true,
        id: Random().nextInt(100),
        channelKey: 'schedule_notification',
        title: 'Weather News App${Emojis.wheater_thermometer}',
        body:
            'Check weather forecast for the day and week ${Emojis.sky_cloud_with_rain} ${Emojis.sun} ${Emojis.sky_rainbow} ',
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
}



// Future<void> cancelScheduleNotifications() async {
//   await AwesomeNotifications().cancelAllSchedules();
// }
