import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/async_alarm_notifier.dart';
import '../services/notification.dart';
import '../services/permission.dart';
import '../utils/alarm_utils.dart';
import '../utils/timer_utils.dart';
import '../models/alarm.dart';
import 'alarm_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  static List<Alarm> alarmList = [];
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    isAndroidPermissionGranted();
    requestPermissions();
    configureDidReceiveLocalNotificationSubject(context);
    configureSelectNotificationSubject(context);
    super.initState();
  }

  @override
  void dispose() {
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncAlarms = ref.watch(asyncAlarmProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          '알람',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            onPressed: normalAlert,
            icon: Icon(
              Icons.lock_person_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: () => _setupAlarm(context, ref, HomePage.alarmList),
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: asyncAlarms.when(
          data: (alarms) {
            HomePage.alarmList = alarms;
            return _alarmListView(context, alarms);
          },
          loading: () => _alarmListView(context, HomePage.alarmList),
          error: (err, stack) => const CircularProgressIndicator(),
        ),
      ),
    );
  }

  ListView _alarmListView(
    BuildContext context,
    List<Alarm> alarms,
  ) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            '목록',
            style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(height: 0),
        for (final alarm in alarms) AlarmWidget(alarm: alarm),
      ],
    );
  }

  Future<void> _setupAlarm(
    BuildContext context,
    WidgetRef ref,
    List<Alarm> alarms,
  ) async {
    final timer = await TimerUtils.timePicker(context);
    if (timer == null) {
      return;
    }

    if (context.mounted) {
      final memo = await TimerUtils.inputMemo(context);
      if (memo == null) {
        return;
      }

      if (context.mounted) {
        Alarm alarm = Alarm(
          idx: alarms.length,
          label: memo,
          timeOfDay: timer.format(context),
          isAlive: 1,
        );

        await scheduleDailyNotification(
          alarms.length,
          alarm.timeOfDay,
          alarm.label == '' ? null : alarm.label,
          TimeOfDay(hour: timer.hour, minute: timer.minute),
        );

        await ref.read(asyncAlarmProvider.notifier).insertAlarm(alarm);
      }
    }
  }

  Future<void> _setPermission() async {
    await requestPermissions();
    setState(() {});
  }
}
