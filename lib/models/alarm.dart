import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm.freezed.dart';
part 'alarm.g.dart';

@freezed
class Alarm with _$Alarm {
  const factory Alarm({
    required int idx,
    required String label,
    required String timeOfDay,
    required int isAlive, // 0: dead, 1: alive
  }) = _Alarm;

  factory Alarm.fromJson(Map<String, Object?> json) => _$AlarmFromJson(json);
}
