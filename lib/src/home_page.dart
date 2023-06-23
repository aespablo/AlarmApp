import 'package:alarm/models/alarm.dart';
import 'package:alarm/providers/async_alarm_notifier.dart';
import 'package:flutter/material.dart';
import 'package:alarm/src/alarm_widget.dart';
import 'package:alarm/utils/timer_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<Alarm> alarmList = [];

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
            onPressed: _setupAlarm,
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
            child: asyncAlarms.when(
          data: (alarms) => ListView(
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
              const Divider(height: 0),
            ],
          ),
          error: (err, stack) => Container(),
          loading: () => Container(),
        )),
      ),
    );
  }

  Future<void> _setupAlarm() async {
    final timer = await TimerUtils.timePicker(context);
    if (timer == null || !mounted) {
      return;
    }

    final memo = await TimerUtils.inputMemo(context);

    if (memo == null) {
      return;
    }

    // Alarm alarm = Alarm(idx: idx, label: label, timeOfDay: timeOfDay, isAlive: isAlive)
  }
}
