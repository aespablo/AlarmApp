import 'package:flutter/material.dart';
import 'package:alarm/timer_utils.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title: const Text('알람을 설정해주세요'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => TimerUtils.timePicker(context),
              child: const Text('How DateTime!!'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add Alarm'),
            ),
          ],
        ),
      ),
    );
  }
}
