// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Alarm _$AlarmFromJson(Map<String, dynamic> json) {
  return _Alarm.fromJson(json);
}

/// @nodoc
mixin _$Alarm {
  int get idx => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get timeOfDay => throw _privateConstructorUsedError;
  int get isAlive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlarmCopyWith<Alarm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmCopyWith<$Res> {
  factory $AlarmCopyWith(Alarm value, $Res Function(Alarm) then) =
      _$AlarmCopyWithImpl<$Res, Alarm>;
  @useResult
  $Res call({int idx, String label, String timeOfDay, int isAlive});
}

/// @nodoc
class _$AlarmCopyWithImpl<$Res, $Val extends Alarm>
    implements $AlarmCopyWith<$Res> {
  _$AlarmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? label = null,
    Object? timeOfDay = null,
    Object? isAlive = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      timeOfDay: null == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String,
      isAlive: null == isAlive
          ? _value.isAlive
          : isAlive // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AlarmCopyWith<$Res> implements $AlarmCopyWith<$Res> {
  factory _$$_AlarmCopyWith(_$_Alarm value, $Res Function(_$_Alarm) then) =
      __$$_AlarmCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idx, String label, String timeOfDay, int isAlive});
}

/// @nodoc
class __$$_AlarmCopyWithImpl<$Res> extends _$AlarmCopyWithImpl<$Res, _$_Alarm>
    implements _$$_AlarmCopyWith<$Res> {
  __$$_AlarmCopyWithImpl(_$_Alarm _value, $Res Function(_$_Alarm) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? label = null,
    Object? timeOfDay = null,
    Object? isAlive = null,
  }) {
    return _then(_$_Alarm(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      timeOfDay: null == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String,
      isAlive: null == isAlive
          ? _value.isAlive
          : isAlive // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Alarm implements _Alarm {
  const _$_Alarm(
      {required this.idx,
      required this.label,
      required this.timeOfDay,
      required this.isAlive});

  factory _$_Alarm.fromJson(Map<String, dynamic> json) =>
      _$$_AlarmFromJson(json);

  @override
  final int idx;
  @override
  final String label;
  @override
  final String timeOfDay;
  @override
  final int isAlive;

  @override
  String toString() {
    return 'Alarm(idx: $idx, label: $label, timeOfDay: $timeOfDay, isAlive: $isAlive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Alarm &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            (identical(other.isAlive, isAlive) || other.isAlive == isAlive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idx, label, timeOfDay, isAlive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AlarmCopyWith<_$_Alarm> get copyWith =>
      __$$_AlarmCopyWithImpl<_$_Alarm>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AlarmToJson(
      this,
    );
  }
}

abstract class _Alarm implements Alarm {
  const factory _Alarm(
      {required final int idx,
      required final String label,
      required final String timeOfDay,
      required final int isAlive}) = _$_Alarm;

  factory _Alarm.fromJson(Map<String, dynamic> json) = _$_Alarm.fromJson;

  @override
  int get idx;
  @override
  String get label;
  @override
  String get timeOfDay;
  @override
  int get isAlive;
  @override
  @JsonKey(ignore: true)
  _$$_AlarmCopyWith<_$_Alarm> get copyWith =>
      throw _privateConstructorUsedError;
}
