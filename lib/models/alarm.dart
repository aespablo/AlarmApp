import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm.freezed.dart';
part 'alarm.g.dart';

@freezed
class Alarm with _$Alarm {
  const factory Alarm({
    required int idx,
    required String label,
    required String timeOfDay,
  }) = _Alarm;

  factory Alarm.fromJson(Map<String, Object?> json) => _$AlarmFromJson(json);
}
