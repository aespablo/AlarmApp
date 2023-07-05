import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../src/alarm_page.dart';
import 'notification.dart';

Future<bool?> isAndroidPermissionGranted() async {
  if (Platform.isAndroid) {
    final bool granted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;

    return granted;
  }

  return null;
}

Future<bool?> requestPermissions() async {
  if (Platform.isIOS || Platform.isMacOS) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  } else if (Platform.isAndroid) {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final bool? granted = await androidImplementation?.requestPermission();
    return granted ?? false;
  }

  return null;
}

void configureDidReceiveLocalNotificationSubject(
  BuildContext context,
) {
  didReceiveLocalNotificationStream.stream.listen((
    ReceivedNotification receivedNotification,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: receivedNotification.title != null
            ? Text(receivedNotification.title!)
            : null,
        content: receivedNotification.body != null
            ? Text(receivedNotification.body!)
            : null,
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => AlarmPage(
                    payload: receivedNotification.payload,
                  ),
                ),
              );
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  });
}

void configureSelectNotificationSubject(
  BuildContext context,
) {
  selectNotificationStream.stream.listen((String? payload) async {
    await Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => AlarmPage(payload: payload),
    ));
  });
}
