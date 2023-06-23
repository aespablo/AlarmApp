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
    );
  }
}
