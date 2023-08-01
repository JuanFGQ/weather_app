import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:weather/helpers/utilities_notifications.dart';

Future<void> createWeatherNotifications(
    // NotificationWeekAndTime notificationSchedule
    ) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: '${Emojis.sun + Emojis.sky_cloud} Buy Plant Food!!!',
      body: 'Florist at 123 Main St. has 2 in stock. asdasdasdasdasdadadasdsad',
      // largeIcon: 'assets://noti-sun.png',
      // bigPicture: 'assets://noti-sun',
      //
      // notificationLayout: NotificationLayout.BigPicture,
    ),
    // actionButtons: [5
    //   NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done')
    // ],
    // schedule: NotificationCalendar(
    //   weekday: notificationSchedule.dayOfTheWeek,
    //   hour: notificationSchedule.timeOfDay.hour,
    //   minute: notificationSchedule.timeOfDay.minute,
    //   second: 0,
    //   millisecond: 0,
    //   repeats: true,
    // ),
  );
}

Future<void> createWeatherScheduleNotifications(
    NotificationWeekAndTime notificationSchedule) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: '${Emojis.wheater_droplet} Add some water to your plant!',
      body: 'Water your plant regularly to keep it healthy.',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      )
    ],
    schedule: NotificationCalendar(
      weekday: notificationSchedule.dayOfTheWeek,
      hour: notificationSchedule.timeOfDay.hour,
      minute: notificationSchedule.timeOfDay.minute,
      second: 0,
      millisecond: 0,
    ),
  );
}

Future<void> cancelScheduleNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}
