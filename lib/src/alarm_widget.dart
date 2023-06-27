import 'package:alarm/models/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../providers/async_alarm_notifier.dart';
import '../utils/timer_utils.dart';

class AlarmWidget extends ConsumerWidget {
  final Alarm alarm;

  const AlarmWidget({
    super.key,
    required this.alarm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => _deleteAlarm(ref),
        ),
        children: [
          SlidableAction(
            onPressed: (context) => _deleteAlarm(ref),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: "삭제",
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _editAlarm(context, ref),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alarm.timeOfDay,
                        style: TextStyle(
                          fontSize: 35,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      if (alarm.label.isNotEmpty)
                        Text(
                          alarm.label,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w100,
                          ),
                        )
                      else
                        Container(),
                    ],
                  ),
                  const Spacer(),
                  Switch(
                    value: alarm.isAlive == 1,
                    onChanged: (check) => _switchAction(ref, check),
                  ),
                ],
              ),
            ),
            const Divider(height: 0),
          ],
        ),
      ),
    );
  }

  Future<void> _editAlarm(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final timer = await TimerUtils.timePicker(
      context,
      timeOfDay: TimerUtils.stringToTimeOfDay(alarm.timeOfDay),
    );
    if (timer == null) {
      return;
    }

    if (context.mounted) {
      final memo = await TimerUtils.inputMemo(context);
      if (memo == null) {
        return;
      }

      if (context.mounted) {
        Alarm newAlarm = Alarm(
          idx: alarm.idx,
          label: memo,
          timeOfDay: timer.format(context),
          isAlive: alarm.isAlive,
        );

        await ref.read(asyncAlarmProvider.notifier).updateAlarm(newAlarm);
      }
    }
  }

  Future<void> _deleteAlarm(
    WidgetRef ref,
  ) async {
    await ref.read(asyncAlarmProvider.notifier).deleteAlarm(alarm.idx);
  }

  Future<void> _switchAction(
    WidgetRef ref,
    bool check,
  ) async {
    final newAlarm = alarm.copyWith(isAlive: check ? 1 : 0);
    await ref.read(asyncAlarmProvider.notifier).updateAlarm(newAlarm);
  }
}
