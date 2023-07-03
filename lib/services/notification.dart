import 'dart:async';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:logger/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// 앱이 알림 관련 이벤트에 응답할 수 있도록 스트림이 생성됩니다.
/// 플러그인은 'main' 함수에서 초기화되므로
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform = MethodChannel('stelsi.org/alarm_app');

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

/// URL 실행 이벤트를 트리거하는 알림 액션
const String urlLaunchActionId = 'id_1';

/// 앱 탐색 이벤트를 트리거하는 알림 액션
const String navigationActionId = 'id_3';

/// 텍스트 입력 동작에 대한 iOS/MacOS 알림 카테고리를 정의합니다.
const String darwinNotificationCategoryText = 'textCategory';

/// 일반 작업에 대한 iOS/MacOS 알림 카테고리를 정의합니다.
const String darwinNotificationCategoryPlain = 'plainCategory';

Future<void> configNotification() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
    Logger().d('알람을 직접 눌러서 들어온 상황...');
  }

  final InitializationSettings initializationSettings = InitializationSettings(
    android: _androidInitSetup(),
    iOS: _darwinInitSetup(),
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      switch (response.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(response.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (response.actionId == navigationActionId) {
            selectNotificationStream.add(response.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: _notificationTapBackground,
  );
}

@pragma('vm:entry-point')
void _notificationTapBackground(
  NotificationResponse response,
) {
  // ignore: avoid_print
  print('notification(${response.id}) action tapped: '
      '${response.actionId} with'
      ' payload: ${response.payload}');
  if (response.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print('입력으로 탭한 알림 동작: ${response.input}');
  }
}

AndroidInitializationSettings _androidInitSetup() {
  return const AndroidInitializationSettings('ic_launcher');
}

DarwinInitializationSettings _darwinInitSetup() {
  return DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: (
      int id,
      String? title,
      String? body,
      String? payload,
    ) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: _darwinNotifyCategories(),
  );
}

List<DarwinNotificationCategory> _darwinNotifyCategories() {
  return <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];
}
