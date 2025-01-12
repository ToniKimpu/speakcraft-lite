// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TranslationDay _$TranslationDayFromJson(Map<String, dynamic> json) {
  return _TranslationDay.fromJson(json);
}

/// @nodoc
mixin _$TranslationDay {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'day_name')
  String get dayName => throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;

  /// Serializes this TranslationDay to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TranslationDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranslationDayCopyWith<TranslationDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationDayCopyWith<$Res> {
  factory $TranslationDayCopyWith(
          TranslationDay value, $Res Function(TranslationDay) then) =
      _$TranslationDayCopyWithImpl<$Res, TranslationDay>;
  @useResult
  $Res call(
      {int id, @JsonKey(name: 'day_name') String dayName, bool isComplete});
}

/// @nodoc
class _$TranslationDayCopyWithImpl<$Res, $Val extends TranslationDay>
    implements $TranslationDayCopyWith<$Res> {
  _$TranslationDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslationDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dayName = null,
    Object? isComplete = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      dayName: null == dayName
          ? _value.dayName
          : dayName // ignore: cast_nullable_to_non_nullable
              as String,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TranslationDayImplCopyWith<$Res>
    implements $TranslationDayCopyWith<$Res> {
  factory _$$TranslationDayImplCopyWith(_$TranslationDayImpl value,
          $Res Function(_$TranslationDayImpl) then) =
      __$$TranslationDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, @JsonKey(name: 'day_name') String dayName, bool isComplete});
}

/// @nodoc
class __$$TranslationDayImplCopyWithImpl<$Res>
    extends _$TranslationDayCopyWithImpl<$Res, _$TranslationDayImpl>
    implements _$$TranslationDayImplCopyWith<$Res> {
  __$$TranslationDayImplCopyWithImpl(
      _$TranslationDayImpl _value, $Res Function(_$TranslationDayImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dayName = null,
    Object? isComplete = null,
  }) {
    return _then(_$TranslationDayImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      dayName: null == dayName
          ? _value.dayName
          : dayName // ignore: cast_nullable_to_non_nullable
              as String,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TranslationDayImpl implements _TranslationDay {
  const _$TranslationDayImpl(
      {required this.id,
      @JsonKey(name: 'day_name') required this.dayName,
      required this.isComplete});

  factory _$TranslationDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$TranslationDayImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'day_name')
  final String dayName;
  @override
  final bool isComplete;

  @override
  String toString() {
    return 'TranslationDay(id: $id, dayName: $dayName, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationDayImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dayName, dayName) || other.dayName == dayName) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, dayName, isComplete);

  /// Create a copy of TranslationDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationDayImplCopyWith<_$TranslationDayImpl> get copyWith =>
      __$$TranslationDayImplCopyWithImpl<_$TranslationDayImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TranslationDayImplToJson(
      this,
    );
  }
}

abstract class _TranslationDay implements TranslationDay {
  const factory _TranslationDay(
      {required final int id,
      @JsonKey(name: 'day_name') required final String dayName,
      required final bool isComplete}) = _$TranslationDayImpl;

  factory _TranslationDay.fromJson(Map<String, dynamic> json) =
      _$TranslationDayImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'day_name')
  String get dayName;
  @override
  bool get isComplete;

  /// Create a copy of TranslationDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranslationDayImplCopyWith<_$TranslationDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
