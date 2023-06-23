import 'package:alarm/models/alarm.dart';
import 'package:flutter/material.dart';

class AlarmWidget extends StatefulWidget {
  final Alarm alarm;
  const AlarmWidget({
    super.key,
    required this.alarm,
  });

  @override
  State<AlarmWidget> createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends State<AlarmWidget> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
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
                  '3:50',
                  style: TextStyle(
                    fontSize: 35,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Text(
                  '알람 메모',
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w100,
                  ),
                ),
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
    );
  }
}
