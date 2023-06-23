import 'package:alarm/alarm_widget.dart';
import 'package:flutter/material.dart';
import 'package:alarm/timer_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          '알람',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => TimerUtils.timePicker(context),
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                'Alarm',
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: 0),
            const AlarmWidget(),
            const Divider(height: 0),
            const AlarmWidget(),
            const Divider(height: 0),
            const AlarmWidget(),
            const Divider(height: 0),
            const AlarmWidget(),
            const Divider(height: 0),
            const AlarmWidget(),
            const Divider(height: 0),
            const AlarmWidget(),
            const Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
