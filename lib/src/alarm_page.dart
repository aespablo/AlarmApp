import 'package:flutter/material.dart';

class AlarmPage extends StatelessWidget {
  final String? payload;

  const AlarmPage({
    super.key,
    this.payload,
  });

  @override
  Widget build(BuildContext context) {
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
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('payload ${payload ?? ''}'),
          ),
        ),
      ),
    );
  }
}
