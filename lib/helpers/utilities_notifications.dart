import 'package:flutter/material.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime(this.timeOfDay);
}

Future<NotificationWeekAndTime?> pickSchedule(
  BuildContext context,
) async {
  TimeOfDay? timeOfDay;
  DateTime now = DateTime.now();

  timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        now.add(
          const Duration(minutes: 1),
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Colors.teal,
            ),
          ),
          child: child!,
        );
      });

  if (timeOfDay != null) {
    return NotificationWeekAndTime(
        // selectedDay!,
        timeOfDay);
  }
  return null;
}
