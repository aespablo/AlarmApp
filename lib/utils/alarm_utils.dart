import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../services/notification.dart';

const soundPath = 'assets/raw/ateapill.wav';

Future<void> normalAlert() async {
  const androidNotificationDetails = AndroidNotificationDetails(
    'AlarmId',
    'AlarmChannel',
    channelDescription: 'Main alalrm description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    playSound: true,
    sound: RawResourceAndroidNotificationSound('ateapill'),
  );

  const darwinNotificationDetails = DarwinNotificationDetails(
    presentSound: true,
    sound: soundPath,
  );

  await flutterLocalNotificationsPlugin.show(
    99,
    '일반 제목',
    '일반 바디',
    const NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    ),
    payload: 'item x',
  );
}

Future<void> scheduleDailyNotification(
  int id,
  String? title,
  String? body,
  TimeOfDay tod,
) async {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'AlarmId',
    'AlarmChannel',
    channelDescription: 'Main alalrm description',
    vibrationPattern: Int64List.fromList([0, 1000, 500, 2000]),
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    _setupTimer(tod),
    NotificationDetails(android: androidNotificationDetails),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
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
