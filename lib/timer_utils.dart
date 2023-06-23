import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TimerUtils {
  static Future<TimeOfDay?> timePicker(
    BuildContext context,
  ) async {
    final picker = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (context.mounted && picker != null) {
      Logger().i('picker: ${picker.format(context)}');
    }

    return picker;
  }
}
