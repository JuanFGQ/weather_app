import 'package:flutter/material.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime(
    this.dayOfTheWeek,
    this.timeOfDay,
  );
}

// Future<NotificationWeekAndTime?> pickSchedule(BuildContext context) async {
//   List<String> weekDays = [
//     'Mon',
//     'Tue',
//     'Wed',
//     'Thu',
//     'Fri',
//     'Sat',
//     'Sun',
//   ];
//   TimeOfDay? timeOfDay;
//   DateTime now = DateTime.now();
//   int? selectedDay;


//   await showDialog(context: context, builder: builder)
// }
