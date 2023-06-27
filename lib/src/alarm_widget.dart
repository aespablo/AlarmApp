import 'package:alarm/models/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../providers/async_alarm_notifier.dart';
import '../utils/timer_utils.dart';

class AlarmWidget extends ConsumerStatefulWidget {
  final Alarm alarm;

  const AlarmWidget({
    super.key,
    required this.alarm,
  });

  @override
  ConsumerState<AlarmWidget> createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends ConsumerState<AlarmWidget> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: _deleteAlarm,
        ),
        children: [
          SlidableAction(
            onPressed: (context) => _deleteAlarm(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: "삭제",
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _editAlarm(widget.alarm),
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
                        widget.alarm.timeOfDay,
                        style: TextStyle(
                          fontSize: 35,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      if (widget.alarm.label.isNotEmpty)
                        Text(
                          widget.alarm.label,
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
                    value: isCheck,
                    onChanged: (check) {
                      isCheck = check;
                      setState(() {});
                    },
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

  Future<void> _editAlarm(Alarm origin) async {
    final timer = await TimerUtils.timePicker(
      context,
      timeOfDay: TimerUtils.stringToTimeOfDay(origin.timeOfDay),
    );
    if (timer == null || !mounted) {
      return;
    }

    final memo = await TimerUtils.inputMemo(context);
    if (memo == null || !mounted) {
      return;
    }

    Alarm alarm = Alarm(
      idx: origin.idx,
      label: memo,
      timeOfDay: timer.format(context),
      isAlive: 1,
    );

    await ref.read(asyncAlarmProvider.notifier).updateAlarm(alarm);
  }

  Future<void> _deleteAlarm() async {
    await ref.read(asyncAlarmProvider.notifier).deleteAlarm(widget.alarm.idx);
  }
}
