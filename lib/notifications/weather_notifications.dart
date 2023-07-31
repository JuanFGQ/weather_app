import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:weather/helpers/utilities_notifications.dart';

Future<void> createWeatherNotifications() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title:
            '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
        body: 'Florist at 123 Main St. has 2 in stock.',
        bigPicture: 'assets://noti-sun.png',
        notificationLayout: NotificationLayout.BigPicture,
      ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done')
      ],
      schedule: NotificationCalendar(
        weekday: 7,
        hour: 5,
      ));
}

Future<void> cancelScheduleNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}
