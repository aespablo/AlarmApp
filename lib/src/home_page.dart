import 'package:flutter/material.dart';
import 'package:alarm/models/alarm.dart';
import 'package:alarm/src/alarm_widget.dart';
import 'package:alarm/utils/timer_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alarm/providers/async_alarm_notifier.dart';

class HomePage extends ConsumerWidget {
  static List<Alarm> alarmList = [];

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onPressed: () => _setupAlarm(context, ref, alarmList),
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
            alarmList = alarms;
            return _alarmListView(context, alarms);
          },
          loading: () => _alarmListView(context, alarmList),
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

        await ref.read(asyncAlarmProvider.notifier).insertAlarm(alarm);
      }
    }
  }
}
