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

  static Future<String?> inputMemo(
    BuildContext context,
  ) async {
    String inputText = '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('메모 입력'),
          content: Card(
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: '라벨',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                inputText = text;
                Logger().i('memo: $inputText');
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                inputText = '';
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );

    Logger().i('memo: $inputText');
    return inputText;
  }
}
