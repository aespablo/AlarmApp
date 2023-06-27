import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class TimerUtils {
  static Future<TimeOfDay?> timePicker(
    BuildContext context, {
    TimeOfDay? timeOfDay,
  }) async {
    // 시간 선택한 후, TimeOfDay 형식으로 저장
    final picker = await showTimePicker(
      context: context,
      initialTime: timeOfDay ?? TimeOfDay.now(),
    );

    if (context.mounted && picker != null) {
      Logger().i('picker: ${picker.format(context)}');
    }

    // 위에서 선택한 값 반환
    return picker;
  }

  static Future<String?> inputMemo(
    BuildContext context,
  ) async {
    // 메모 저장용 변수 (null 형식일 시, 취소됨)
    String? inputText = '';
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
              onChanged: (text) => inputText = text,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                inputText = null;
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

  static TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm();
    return TimeOfDay.fromDateTime(format.parse(tod));
  }
}
