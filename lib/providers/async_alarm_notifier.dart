import 'package:alarm/db/alarm_db_helper.dart';
import 'package:alarm/models/alarm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncAlarmProvider =
    AsyncNotifierProvider<AsyncAlarmNotifier, List<Alarm>>(
  AsyncAlarmNotifier.new,
);

class AsyncAlarmNotifier extends AsyncNotifier<List<Alarm>> {
  Future<List<Alarm>> _fetchAlarm() async {
    final alarms = await AlarmDBHelper.getItems();
    return alarms ?? [];
  }

  @override
  Future<List<Alarm>> build() async {
    return _fetchAlarm();
  }

  Future<void> insertAlarm(Alarm alarm) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await AlarmDBHelper.insertItem(alarm);
      return _fetchAlarm();
    });
  }

  Future<void> deleteAlarm(int idx) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await AlarmDBHelper.deleteItem(idx);
      return _fetchAlarm();
    });
  }

  Future<void> updateAlarm(Alarm alarm) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await AlarmDBHelper.updateItem(alarm: alarm);
      return _fetchAlarm();
    });
  }
}
