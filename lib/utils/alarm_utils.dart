import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../services/notification.dart';

Future<void> showNotification(int id) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('채널 ID', '채널 이름',
          channelDescription: '채널 설명',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin
      .show(id, '일반 제목', '일반 바디', notificationDetails, payload: 'item x');
}

Future<void> scheduleDailyNotification(int id, TimeOfDay tod) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'daily scheduled notification title',
      'daily scheduled notification body',
      _setupTimer(tod),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily notification channel id',
          'daily notification channel name',
          channelDescription: 'daily notification description',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

tz.TZDateTime _setupTimer(TimeOfDay tod) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    tod.hour,
    tod.minute,
  );
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}
